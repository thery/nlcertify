module type T = sig
  type interval 
  type positive
  type pol
  type fw_pol
  type num_i
  type rt 
  type bound
  val nvars : int ref
  val fw_vars_tbl : (fw_pol, int * interval) Hashtbl.t
  val fw_nvars_tbl : (fw_pol, int) Hashtbl.t
  val fw_cvars_tbl : (fw_pol, int) Hashtbl.t
  val vot_aux : (int -> fw_pol -> int) -> fw_pol -> int -> int
  val vot_aux2 : (int -> fw_pol -> int) -> fw_pol -> fw_pol -> int -> int
  val vars_of_tree_aux : rt -> fw_pol -> unit
  (*val novt_aux : int -> fw_pol -> rt -> int * (int * interval) list
  val norm_2 : (fw_pol -> bool) -> fw_pol -> fw_pol -> int -> int -> rt -> int * (int * interval) list*)
  val norm_vars_of_tree : unit -> (int * interval) list
  val norm_constraints_of_tree :  (int * interval) list -> int -> (positive, num_i * num_i) Hashtbl.t -> bound list
  val ineq_cstr_list : pol list ref
  val eq_cstr_list : pol list ref
  val ineq_cstr_tbl : pol list ref
  val eq_cstr_tbl : pol list ref
  val constraints_of_tree : fw_pol -> bool -> int -> rt -> pol
end

module Make 
  (N: Numeric.T)  
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval) 
  (Fu: Fw_utils.T with type num_i = N.t and type fw_pol = P.fw_pol and type interval = I.interval) 
  (O: Oracle.T with type num_i = N.t and type pol = P.pol) = struct

(* number of auxiliary lifting variables that will be used to write the POP.
* Some of them will be normalized to avoid numerical problems *)
    type interval = I.interval
    type positive = P.positive 
    type pol = P.pol
    type fw_pol = P.fw_pol
    type num_i = N.t
    type rt = Fu.relax_type
    type bound = O.bound

  let nvars = ref 0                           
  let fw_vars_tbl = Hashtbl.create 10 
  let fw_nvars_tbl : (fw_pol, int) Hashtbl.t = Hashtbl.create 10 
  let fw_cvars_tbl : (fw_pol, int) Hashtbl.t = Hashtbl.create 10

  let vot_aux f p n = 
    match p with
      | P.Pw _ -> n + 1
      | _ -> f n p

  let vot_aux2 f p1 p2 n = 
    match p1, p2 with
      | P.Pw _, P.Pw _ -> n + 3 
      | P.Pw _, _ -> f (n + 1) p2 + 1
      | _, P.Pw _ -> (f n p2) + 2
      | _ -> f (f n p1) p2 + 1 

(*
    let find_comp tbl = function
      |  P.Comp ((a, p), i) -> 
          begin            
            let keys =  U.hashtbl_keys tbl in
            let pol_of_comp_eq = function 
              | P.Comp ((_, p'),_) when P.fw_eq p p' -> true | _ -> false
            in
            let n, _ = try let k = List.find pol_of_comp_eq keys in Hashtbl.find tbl k
            with Not_found -> -1, I.Void_i in
              n
          end
      | _ -> -1
 *)
    let rec vars_of_tree_aux rt p : unit = 
      let add p n i = Hashtbl.add fw_vars_tbl p (n, i) in
      let vars p func = if Hashtbl.mem fw_vars_tbl p then () else func p in
      let rec f_aux f = match f with
        | P.Pw (p, i, _) -> add f 0 i
        | P.Fw ((p1, p2), i, _) -> (* add a case considering high degree pol p1 and/or p2 *) vars p1 f_aux; vars p2 f_aux; incr nvars; add f !nvars i;
        | P.Plus ((p1, p2), i, _) |  P.Mult ((p1, p2), i, _) ->  vars p1 f_aux; vars p2 f_aux; add f 0 i; 
        | P.Minus (p, i) -> vars p f_aux; add f 0 i;
        | P.Sqrt (p, i) -> vars p f_aux; incr nvars; add f !nvars i;
        | P.Max (fw_l, i, _) | P.Min (fw_l, i, _) -> List.iter (fun p -> vars p f_aux) fw_l; incr nvars; add f !nvars i;
        | P.MaxMin ( (P.Max (l1, i1, _), P.Min (l2, i2, _)), i, _) -> List.iter (fun p -> vars p f_aux) l1; List.iter (fun p -> vars p f_aux) l2; incr nvars; add f !nvars i;
        | P.MaxMin ((f1, f2), i, _) -> vars f1 f_aux; vars f2 f_aux;  incr nvars; add f !nvars i;
        | P.Comp ((a, p), i, _) -> 
            if P.is_Pol p then 
            begin
              let max_deg = Config.Config.max_degree_pol in
              let deg =  (P.degree_approx a) * (P.degree_pol (P.pol_of_fw p)) in
              let is_deg_low = deg <= max_deg (*|| P.degree_pol (P.pol_of_fw p) <= max_deg *)in
                if is_deg_low then (vars p f_aux; add f 0 i)
                else if Hashtbl.mem fw_vars_tbl p then add f 0 i
              (*if Hashtbl.mem fw_vars_tbl p || is_deg_low then add f 0 i*)
                else (incr nvars; add p !nvars (Fu.interval_of_fw p); add f 0 i)
            end
          else (vars p f_aux; add f 0 i)              
      in
        f_aux p

    let norm_vars_of_tree () : (int * interval) list = Hashtbl.fold 
(fun _ v acc -> if fst v > 0 then v :: acc else acc) fw_vars_tbl []

    let print_fw_vars_tbl () =
     U._pr_ "Printing fw_vars_tbl" true true; 
      let pr k v = U._pr_ (Fu.string_of_fw k) true true; U._pr_ ((string_of_int (fst v)) ^ " " ^ (I.string_I (snd v))) true true; in
      Hashtbl.iter (fun k v -> pr k v) fw_vars_tbl;
     U._pr_ "End of Printing" true true

(* normalizing some auxiliary variables *)
let norm_constraints_of_tree norm_vars_intervals n_box tbl_scaling : bound list =    
  let rec f_aux = function
    | (n, interval)::tl ->
        begin
          try
            let f1, f2 = I.tuple_of_I interval in
            let singleton = N.eq_i f1 f2 in
            let var = O.gen_varname n n_box in
            let lo_up_fx = if singleton then O.fix_var var f1 tbl_scaling else O.bound_var var f1 f2 tbl_scaling in
              lo_up_fx :: (f_aux tl)
          with Failure _ -> U._pr_ ((string_of_int n) ^ " " ^ (I.string_I interval)) true true; failwith "Problem in Bounding Function 2"
        end
    | [] -> []
  in
    f_aux norm_vars_intervals

    let ineq_cstr_list, eq_cstr_list = (ref [] : pol list ref) , 
                                       (ref [] : pol list ref)
    let eq_cstr_tbl = ref []
    let ineq_cstr_tbl = ref []

    let constraints_of_tree fw is_min n_box relax_type  =
      let zero_P = P.Pc N.zero_i in
      let add_eq p = if List.mem p !eq_cstr_tbl then () else eq_cstr_tbl := !eq_cstr_tbl @ [p]; () in
      let add_ineq p = if List.mem p !ineq_cstr_tbl then () else ineq_cstr_tbl := !ineq_cstr_tbl @ [p]; () in

      let find p = 
        try Hashtbl.find fw_vars_tbl p 
        with Not_found -> 
          begin
            U._pr_ "error in find" true true;
            let mess = Fu.string_of_fw p ^ "Not found in fw_vars_tbl" in
              U._pr_ mess true true;
              failwith "Stop find"
          end in

      let approx_equation a zf = 
        match a with 
          | P.Tan (r, p) -> O.tan_equation r p zf 
          | P.Par (c2, c1, c0, x0) -> O.par_equation c2 c1 c0 (P.Pc x0) zf
          | P.Cub (c3, c2, c1, c0, x0) -> O.cubic_equation c3 c2 c1 c0 (P.Pc x0) zf
          | P.Minimax l -> O.minimax_equation l zf in

      let gen_cstr (f:fw_pol) (p:pol) : pol = 
        let n, _ = find f in 
          if n = 0 then p 
          else 
            begin
              let varpol = O.gen_varname n n_box in
                if P.is_Pol f then (add_eq (P.p_sub (P.pol_of_fw f) varpol); varpol)
                else varpol
            end in

      let rec cstr f = match f with
        | P.Pw (p, _, _) -> gen_cstr f p
        | P.Plus ((p1, p2), _, _) -> P.p_add (cstr p1) (cstr p2)
        | P.Mult ((p1, p2), _, _) -> P.p_mul (cstr p1) (cstr p2)
        | P.Minus (p, _) -> P.p_opp (cstr p)
        | P.Sqrt (p, _) -> 
            begin
              let c = cstr p in
              let z = gen_cstr f zero_P in (* z should not be generated with n = 0 *)
              let eq_cstr = P.p_sub (P.p_square z) c in
                (*add_eq eq_cstr;*)  add_ineq eq_cstr;  add_ineq (P.p_opp eq_cstr); z
            end
        | P.Fw ((f1, f2), _, _) -> 
            begin
              (* add a case considering condition if f1 or f2 is a high degree polynomial and we
               * are not in approx_minimax case *)
              let c1, c2 = cstr f1, cstr f2 in
              let z = gen_cstr f zero_P in (* z should not be generated with n = 0 *)
              let eq_cstr = P.p_sub c1 (P.p_mul z c2) in
                (*add_eq eq_cstr;*) add_ineq (P.p_opp eq_cstr);  add_ineq eq_cstr; z
            end
        | P.Max (fw_l, _, _) | P.Min (fw_l, _, _) ->
            begin
              let func p = if P.is_Max f then p else P.p_opp p in
              let c_list = List.map cstr fw_l in
              let z = gen_cstr f zero_P in (* z should not be generated with n = 0 *)
              let ineq_cstr_list = List.map (fun c -> func (P.p_sub z c)) c_list in
                List.iter (fun c -> add_ineq c) ineq_cstr_list;
                z
            end
        | P.MaxMin ( (P.Max (l1, _, _), P.Min (l2, _, _)), _, _) -> 
            begin
              let c_list1, c_list2 = List.map cstr l1, List.map cstr l2 in
              let z = gen_cstr f zero_P in (* z should not be generated with n = 0 *)
              let ineq_cstr_list1 = List.map (fun c -> P.p_sub z c) c_list1 in
              let ineq_cstr_list2 = List.map (fun c -> P.p_sub c z) c_list2 in
                List.iter (fun c -> add_ineq c) (ineq_cstr_list1 @ ineq_cstr_list2);
                z
            end
        | P.MaxMin ((f1, f2), _, _) -> 
            begin
              let c1, c2 = cstr f1, cstr f2 in
              let z = gen_cstr f zero_P in
              let ineq_cstr1 = P.p_sub z c1 in
              let ineq_cstr2 = P.p_sub c2 z in
                add_ineq ineq_cstr1; add_ineq ineq_cstr2;
                z
            end
        | P.Comp ((a, f), _, _) ->
            begin
              let c = cstr f in
                (*
              let max_deg = Config.Config.max_degree_pol in
              let deg = P.degree_approx a in
              let is_deg_low = deg <= max_deg in
                if is_deg_low (* degree of Comp(a, f) or degree of f is low enough *)
                then approx_equation a c
                else begin (* degree of is too high, hence writing the equality cstr: f = z *)
                  let z = gen_cstr f zero_P in  (* z should not be generated with n = 0 *)
                  let approx = approx_equation a c in
                  let eq_cstr = P.p_sub z approx in
                    add_eq eq_cstr; approx
                end
                 *)
                approx_equation a c 
            end
      in
        cstr fw
end
