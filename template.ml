module type T =
sig
  type num_i 
  type positive 
  type interval
  type fold_poly_tree 
  type algo_semi_alg 
  type fw_pol 
  type taylor_model
  type poly_interval
  type eval_tbl 
  type rewrite_tbl 
  type x0_cmp

  module H :
  sig
    type key = fold_poly_tree * int
    type 'a t
    val create : int -> 'a t
    val clear : 'a t -> unit
    val reset : 'a t -> unit
    val copy : 'a t -> 'a t
    val add : 'a t -> key -> 'a -> unit
    val remove : 'a t -> key -> unit
    val find : 'a t -> key -> 'a
    val find_all : 'a t -> key -> 'a list
    val replace : 'a t -> key -> 'a -> unit
    val mem : 'a t -> key -> bool
    val iter : (key -> 'a -> unit) -> 'a t -> unit
    val fold :(key -> 'a -> 'b -> 'b) ->'a t -> 'b -> 'b
    val length : 'a t -> int
    val stats : 'a t -> Hashtbl.statistics
  end
  val tbl_hess_I :(taylor_model, interval array array) Hashtbl.t
  val main_tbl : poly_interval H.t
  val add_cuts_algo :algo_semi_alg -> eval_tbl -> rewrite_tbl -> (fold_poly_tree, taylor_model * x0_cmp * num_i * num_i * fw_pol list * fw_pol list) Hashtbl.t -> fold_poly_tree -> num_i list -> positive array ->
(num_i * num_i) list -> int -> bool -> unit
  val recut : algo_semi_alg -> num_i list list -> fold_poly_tree -> eval_tbl -> rewrite_tbl -> (fold_poly_tree, taylor_model * x0_cmp * num_i * num_i * fw_pol list * fw_pol list) Hashtbl.t -> positive array -> (num_i * num_i) list -> int -> bool -> poly_interval
end

module Make
  (N: Numeric.T) (Fun: Functions.T with type num_i = N.t) (U: Tutils.T with
  type t = N.t) (I: Interval.T with type num_i = N.t and type f = Fun.f)
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval)
  (Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol
  = P.fw_pol and type interval = I.interval)
  (F:Flyspeck_types.T with type
  num_i = N.t and type inter_mut = I.inter_mut) 
  (Ty: Algo_types.T with type
  num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node
  = F.node and type inter_mut = I.inter_mut and type interval = I.interval)
  (Tb: Algo_tables.T with type num_i = N.t and type p = P.positive and type
  eval_tbl = Ty.eval_tbl and type fw_tbl = Ty.fw_tbl) 
  (O: Operations.T with
  type num_i = N.t and type pol = P.pol and type eval_tbl = Tb.eval_tbl and
  type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive
  and type rewrite_tbl = Ty.rewrite_tbl) 
  (Approx : Approx_func.T with type
  num_i = N.t and type positive = P.positive and type f = Fun.f and type
  interval = I.interval and type fw_pol = P.fw_pol) 
  (Ia : Interval_arith.T
  with type num_i = N.t and type positive = P.positive and type interval =
  I.interval and type eval_tbl = Ty.eval_tbl and type fold_poly_tree =
  Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type
  algo_semi_alg = Ty.algo_semi_alg) 
  (Tm : Taylor_cut.T with type num_i = N.t and type interval = I.interval and type positive = P.positive and type fw_pol = P.fw_pol and type
  eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type
  algo_semi_alg = Ty.algo_semi_alg and type fold_poly_tree = Ty.fold_poly_tree)

  = struct

    type num_i = N.t
    type positive = P.positive
    type interval = I.interval
    type fold_poly_tree = Ty.fold_poly_tree
    type algo_semi_alg = Ty.algo_semi_alg
    type fw_pol = P.fw_pol
    type taylor_model = Tm.taylor_model
    type poly_interval = Ty.poly_interval
    type eval_tbl = Ty.eval_tbl
    type rewrite_tbl = Ty.rewrite_tbl
    type x0_cmp = Tm.x0_cmp


    module H = Hashtbl.Make
      (struct
         type t = fold_poly_tree * int
         let equal (t1, i1) (t2, i2)  = let b = O.eq_T t1 t2 (*&& i1 = i2*) in
           (*
           if not b then U._pr_ (Ty.string_T (find_diff_T t1 t2)) true true;
            *)
           b
         let hash = Hashtbl.hash
         let iter = Hashtbl.iter
       end)

    let tbl_hess_I = Hashtbl.create 3
    let main_tbl = H.create 10 
    let is_L1 = false
    let get_tm2 =  if Config.Config.linear_tm2 then Tm.lin_pol_of_tm2 else if Config.Config.minor_tm2 then Tm.quadr_pol_of_tm2 else Tm.pol_of_tm2 

    (*get_x0_cmp:  *)
    let get_x0_cmp lambda_min_method t tm2 tbl tbl_loc  ?(var_list=[]) vars t ?(bounds=[]) x0 lmin lmax =
      let x0_cmp = Tm.compute_grad_hess vars tbl tbl_loc t tm2 x0 N.zero_i N.zero_i in
      let time_start =  Unix.gettimeofday () in 
      let new_lmin, new_lmax = if Config.Config.minor_lambda_min then
        begin
          let lmin_hx0 = Tm.lambda_min_of_hess  (Tm.hess_of_x0_cmp x0_cmp) in
          let lmax_hx0 = Tm.lambda_max_of_hess  (Tm.hess_of_x0_cmp x0_cmp) in
            N.sub_i lmin lmax_hx0, N.sub_i lmax lmin_hx0
        end
          (*
      else if Config.Config.minor_lambda_min && Config.Config.approx_lambda_min then
        try let hessian_I = find hess_I_tbl t 
        extract values of hessian_I (A_ij + a_ij) /2 
           and compute lmin' = lambda_min ((A_ij + a_ij) /2 + hx0_ij)
          N.sub_i lmin (center_hess_I) lmin'

           with Not_found -> compute_lambda_min (add a field hess_I_tbl and add the hess_I in the table inside the function)
           *)
      else Tm.compute_lambda_min lambda_min_method tbl tbl_loc tbl_hess_I tm2 x0_cmp  ~var_list:var_list (Array.to_list vars) ~sub_box:bounds false 
      in  
        let time_end = Unix.gettimeofday () in 
        let final_mess = Printf.sprintf "Total Cmp lambda min time: %f" (time_end -. time_start) in
          U._pr_ final_mess true true;
          let final_mess = Printf.sprintf "New lmin: %s, New lmax: %s" (N.string_of_i new_lmin) (N.string_of_i new_lmax) in
            U._pr_ final_mess true true;
          let x0_cmp = Tm.assign_lmin new_lmin x0_cmp in
          let x0_cmp = Tm.assign_lmax new_lmax x0_cmp in
            x0_cmp
    (* End of get_x0_cmp *)

    let mem main_tbl = H.mem main_tbl 
    let check_keys main_tbl = 
      let keys = H.fold (fun k _ acc -> k :: acc) main_tbl [] in
        List.iter (fun k -> U._pr_ (Ty.string_T (fst k)) true true) keys;
        try
          let bad_key = List.find (fun k -> not (mem main_tbl k)) keys in
            U._pr_ (Ty.string_T (fst bad_key)) true true; ()
        with Not_found -> U._pr_ "No problem in main_tbl" true true;  ()

(* add a cut defined by the tm2 at xc *)
    let add_quadr_cuts get_semialg_min t tm2 tbl (*main_tbl*) ?(var_list=[]) vars t ?(bounds=[]) xc lmin lmax ellips_nb : fw_pol * fw_pol = 
      let tbl_loc = Hashtbl.create 2 in
      let time_start = Unix.gettimeofday () in 

      let x0_cmp = get_x0_cmp get_semialg_min t tm2 tbl tbl_loc  ~var_list:var_list vars t ~bounds:bounds xc lmin lmax in 

        let time_end = Unix.gettimeofday () in 
        let final_mess = Printf.sprintf "Total x0_cmp min time: %f" (time_end -. time_start) in
          U._pr_ final_mess true true; 


      let f_min, f_max, _, _ = get_tm2 get_semialg_min tbl tm2 x0_cmp (Array.to_list vars) [||] true in
     (* if we'd like to check either or not a tm2 polynomial approx f_min is valid, we
     * compute a lower bound l of the difference fw_min - f_min where fw_min is
     * the semialgebraic translation of t; we do the same for an upper bound u of
     * f_max - fw_max. Finally, we return lower samp = f_min + l and upper samp
     * = f_max - u *) 
        if Config.Config.check_samp || Config.Config.check_templates then
          begin
            try
              begin
                let fw_min, fw_max = match t with | Ty.Pol (p, _) -> Fu.mk_Pw p, Fu.mk_Pw p 
                  | _ -> begin let poly_interval = H.find main_tbl (t, ellips_nb) in
                      Ty.get_pmin poly_interval, Ty.get_pmax poly_interval end
                in
                let minor_fw, major_fw = if Config.Config.check_templates then Fu.fw_sub fw_min f_min, Fu.fw_sub fw_max f_max else  Fu.fw_sub fw_min f_min, Fu.fw_sub f_max fw_max in
                U._pr_ (Printf.sprintf "%s >= %s" (Fu.string_of_fw fw_min) (Fu.string_of_fw f_min)) true false;
U._pr_ (Printf.sprintf "%s <= %s" (Fu.string_of_fw fw_max) (Fu.string_of_fw f_max)) true false;
                let min_bound = U.fst_fst_fst (get_semialg_min tbl minor_fw [] [] [] true ~relax_order:Config.Config.relax_order true is_L1) in
                let max_bound = U.fst_fst_fst (get_semialg_min tbl major_fw [] [] [] false ~relax_order:Config.Config.relax_order true is_L1) in
                  U._pr_ (Printf.sprintf "Check f_min: %s f_max: %s" (N.string_of_i min_bound) (N.string_of_i max_bound)) true true; 
                 if Config.Config.check_templates then  Fu.fw_add f_min (Fu.mk_Pw (P.Pc min_bound)), Fu.fw_add f_max (Fu.mk_Pw (P.Pc max_bound)) else Fu.fw_add f_min (Fu.mk_Pw (P.Pc min_bound)), Fu.fw_sub f_max (Fu.mk_Pw (P.Pc max_bound))              
              end
            with Not_found -> (U._pr_ (Ty.string_T t) true true; failwith "Couldn't find the tree in
      main table")
          end
        else f_min, f_max


  let add_cuts_algo get_semialg_min tbl tbl_loc tm2_tbl tree xc vars bounds ellips_nb rnd_bool : unit =
    U._pr_ "Adding cuts to polynomials" true true;
    let tm2, x0_cmp, lmin, lmax, samp_min, samp_max = try Hashtbl.find tm2_tbl tree
    with Not_found -> 
     (* If the tm2 of the tree does not exist, compute it wrt xc then compute
     * the first lambda_min and add the tree in the tm2_tbl *) 
      begin
        let time_start = Unix.gettimeofday () in 
        (*let keys = U.hashtbl_keys tm2_tbl in
          List.iter (fun t -> U._pr_ (Ty.string_T t) false false;) keys;*)
          let tm2 = Tm.initiate_tm2 vars tree O.zero_T Config.Config.xconvert_variables in
          let x0_cmp = Tm.compute_grad_hess vars tbl tbl_loc tree tm2 xc N.zero_i N.zero_i in
            U._pr_ ("First cmp: " ^ (Tm.string_of_cmp x0_cmp)) true true;
          let lmin, lmax = Tm.compute_lambda_min get_semialg_min tbl tbl_loc tbl_hess_I tm2 x0_cmp ~sub_box:bounds (Array.to_list vars) false in
          let time_end = Unix.gettimeofday () in 
          let final_mess = Printf.sprintf "1 - Add time: %f" (time_end -. time_start) in
          U._pr_ final_mess true true; 
            Hashtbl.add tm2_tbl tree (tm2, x0_cmp, lmin, lmax, [], []); tm2, x0_cmp, lmin, lmax, [], []
      end
    in
      try
        begin 
          let time_start = Unix.gettimeofday () in 
          let f_min, f_max = add_quadr_cuts get_semialg_min tree tm2 tbl (*main_tbl*) vars tree xc lmin lmax ~bounds:(if Config.Config.lambda_min_heuristic then bounds else []) ellips_nb in 
          (* If no cuts have been added yet, we compute anyway a coarse bound using the
           * first cut (= tm2 at the first xc ). Otherwise if we want to refine
           * the bounds of the cuts we compute it. Otherwise we get the one of tm2 and do
           * not refine it*)
          let i = 
            if (not (List.length samp_min = 0 || Config.Config.refine_bounds_cuts)) then Ty.ipi (H.find main_tbl (tree, ellips_nb)) 
            else
              begin
                let min_bound = U.fst_fst_fst (get_semialg_min tbl f_min [] [] [] true true is_L1) in
                let max_bound = U.fst_fst_fst (get_semialg_min tbl f_max [] [] [] false true is_L1) in
                  I.mk_I (min_bound, max_bound) 
              end
          in
          let new_i = 
            begin
              try let old_i = Ty.ipi (H.find main_tbl (tree, ellips_nb)) in 
                I.intersection_I i old_i
              with Not_found -> i
            end 
          in
            (* If it is the first iteration and random cuts have to be added, then pick
             * several points in the box, compute the list of the cuts: several
             * tm2 polynomials at these points *)
          let samp_min, samp_max = 
            if rnd_bool then
              begin
                let x0_list = U.pick_rnd_in_box Config.Config.rnd_cuts bounds in
                let samp_min_max_list = List.map (fun x -> add_quadr_cuts get_semialg_min tree tm2 tbl (*main_tbl*) vars tree x lmin lmax ~bounds:(if Config.Config.lambda_min_heuristic then bounds else []) ellips_nb) x0_list in 
                  List.split samp_min_max_list
              end
            else samp_min, samp_max in
          let time_end = Unix.gettimeofday () in 
          let final_mess = Printf.sprintf "2 - Add time: %f" (time_end -. time_start) in
            U._pr_ final_mess true true; 
            let samp_min, samp_max = (Fu.ai new_i f_min)::samp_min, (Fu.ai new_i f_max)::samp_max in
              (*
            let new_samp_min, new_samp_max = Fu.ai new_i (Fu.assign_max samp_min), Fu.ai new_i (Fu.assign_min samp_max) in
               *)
              Hashtbl.replace tm2_tbl tree (tm2, x0_cmp, lmin, lmax, samp_min, samp_max); ()
                (* H.replace main_tbl (tree, ellips_nb) result;  
                 * we add new results only in tm2_tbl. main_tbl contains only the first set of cuts *)
        end
      with Not_found -> (U._pr_ (Ty.string_T tree) true true; failwith "Couldn't find this tree in
      main table when dfs")

    (* Given a result = Poly_Int (samp_min, samp_max) with samp_min = Sup of
     * quadratic forms and samp_max = inf of quadratic forms, recut returns new
     * quadratic forms q_xc^- and q_xc^+ at each point xc of the x0 list. They satisfy the following
     * properties : q_xc^- <= samp_min, q_xc^+ >= samp_max. The q_xc forms depend on
     * less variables than samp_min/samp_max and are coarser under/over estimators
     * of tree. There are two steps to compute the forms e.g. q_xc^-:
     * 1) use the lambda_min heuristic method to get a first quadratic approx q_xc of tree 
     * 2) compute the min m of (samp_min - q_xc) by POP hence samp_min >= q_xc + m = q_xc^- *)

    let recut get_semialg_min x0 tree tbl tbl_loc tm2_tbl vars bounds ellips_nb rnd_bool = 
      (*let vars, bounds, x0 =  tree in*)
      
      let new_vars = O.vars_T tree in
      let bounds = Tb.project_vars (Array.to_list vars) bounds new_vars in
      let x0 = List.map (fun xc -> Tb.project_vars (Array.to_list vars) xc new_vars) x0 in
      let vars = new_vars in
      List.iter (fun xc -> add_cuts_algo get_semialg_min tbl tbl_loc tm2_tbl tree xc (Array.of_list vars) bounds ellips_nb rnd_bool) x0;
      try
        let _, _, _, _, samp_min, samp_max = Hashtbl.find tm2_tbl tree in
          Ty.get_result (Fu.assign_max samp_min, Fu.assign_min samp_max)
      with Not_found -> invalid_arg ("Recut impossible, this key is not binded in tm2_tbl: " ^ (Ty.string_T tree))

end
