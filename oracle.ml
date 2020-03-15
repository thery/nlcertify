module type T =
sig
  type num_i
  type positive
  type term 
  type pol
  type fw_pol 
  type val_tbl
  type bound = Fx of pol * num_i | LoUp of pol * (num_i * num_i) | Bin of pol | Dummy of pol
  val fix_var : pol -> num_i -> (positive, num_i * num_i) Hashtbl.t -> bound 
  val bound_var : pol -> num_i -> num_i -> (positive, num_i * num_i) Hashtbl.t -> bound 
  val objvar : term
  val times_op : term -> term -> term
  val plus_op : term -> term -> term
  val sqr_op : term -> term
  val minus_op : term -> term
  val moins_op : term -> term -> term
  val plus_op_list : term list -> term
  val times_op_list : term list -> term
  val id_op : term -> term
  val tan_equation : num_i -> num_i -> pol -> pol
  val par_equation : num_i -> num_i -> num_i -> pol -> pol -> pol
  val cubic_equation : num_i -> num_i -> num_i -> num_i -> pol -> pol -> pol
  val minimax_equation : num_i list -> pol -> pol
  val gen_cstrname : int -> string
  val gen_cstr : string -> term -> string -> string
  val var_hashitem_to_pol : string * val_tbl -> pol
  val init_matlab : unit -> in_channel * out_channel * in_channel
  val stop_matlab : in_channel -> out_channel -> in_channel -> unit
  val init_sollya : unit ->  in_channel * out_channel * in_channel
  val stop_sollya : in_channel -> out_channel -> in_channel -> unit
  val gen_output_s : string -> int -> string
  val gen_varname : int -> int -> pol
  val gen_variables_names : int -> int -> pol list
  val gen_constraints_names : int -> string -> string list
  val norm_meth01 : pol -> num_i -> num_i -> pol
  val norm_meth1 : pol -> num_i -> num_i -> pol
  val interval_of_box_item : string * val_tbl -> num_i * num_i
  val divide_hashtbl : (string, val_tbl) Hashtbl.t -> fw_pol list -> (string * val_tbl) list
  val bound_of_interval : string * val_tbl -> (positive, num_i * num_i) Hashtbl.t -> bound 
  val oracle_var_index : pol -> int list
  val varpol_index : (string * val_tbl) list -> positive list
  val var_idx_list : (positive * (num_i * num_i)) list -> int list
  val variables_string : (*int -> (string * val_tbl) list*) (positive * (num_i * num_i)) list -> string -> string -> string
  val binary_variables_string : (string * val_tbl) list -> string -> string -> string
  val get_bound_poly : (fw_pol -> (string, val_tbl) Hashtbl.t -> bool -> 'c -> string -> int -> num_i * num_i * num_i list * num_i list) -> fw_pol -> (string, val_tbl) Hashtbl.t  -> bool -> 'c -> string -> int -> num_i * num_i * num_i list * num_i list
end


module Make
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval) 
  (A: Algo_types.T with type num_i = N.t and type fw_pol = P.fw_pol)  = struct

    type num_i = N.t
    type positive = P.positive
    type term = P.term
    type pol = P.pol
    type fw_pol = P.fw_pol
    type val_tbl = A.val_tbl
    type bound = Fx of pol * num_i | LoUp of pol * (num_i * num_i) | Bin of pol | Dummy of pol
    let verb = Config.Config.pop_verb
    let debug s = if verb then U.debug s else ()

    let fix_var var value tbl_scaling : bound = 
      if Config.Config.fix_vars then 
        let lo, up = Hashtbl.find tbl_scaling (P.idx_of_varpol var) in
        let value = N.div_i (N.sub_i value lo) up in
          Fx (var, value)
          else Dummy var

    let bound_var var v1 v2 tbl_scaling : bound = 
      let lo, up = Hashtbl.find tbl_scaling (P.idx_of_varpol var) in
      (*let value1, value2 = N.div_i (N.sub_i v1 lo) up, N.div_i (N.sub_i v2 lo) up in*)
      let value1, value2 = N.div_i (N.sub_i v1 lo) (N.sub_i up lo), N.div_i (N.sub_i v2 lo) (N.sub_i up lo) in
      let value1 = if N.eq_i (N.abs_i value1) N.infty then (*N.num_of_float (-1000000.)*)  N.minus_i (N.infty) else value1 in
      let value2 = if  N.eq_i (N.abs_i value2) N.infty  then (*N.num_of_float 20000.*) N.infty else value2 in
        LoUp (var, (value1, value2))



    let objvar = P.Var ("objvar")
    let times_op c1 c2 = P.mul_term c1 c2

    let plus_op c1 c2 : term = P.add_term c1 c2

    let sqr_op c : term = P.Pow (c, 2)
    let minus_op c : term = P.opp_term c
    let moins_op c1 c2 : term = plus_op c1 (minus_op c2)
    let plus_op_list c_l : term = List.fold_left plus_op P.Zero c_l
    let times_op_list c_l :term = List.fold_left times_op (P.Const (N.one_i)) c_l

    let id_op c = c
    let tan_equation r p z : pol = 
      let r, p = P.Pc r, P.Pc p in
        P.p_add (P.p_mul r z) p

    let par_equation c2 c1 c0 x0 z : pol = 
      let c2, c1, c0 = P.Pc c2, P.Pc c1, P.Pc c0 in
      let t2 = P.p_mul c2 (P.p_square (P.p_sub z x0)) in
      let t1 = P.p_mul c1 (P.p_sub z x0) in
        P.p_add t2 (P.p_add t1 c0)

    let cubic_equation c3 c2 c1 c0 x0 z : pol = 
      let c3, c2, c1, c0 = P.Pc c3, P.Pc c2, P.Pc c1, P.Pc c0 in
      let delta = P.p_sub z x0 in
      let t3 = P.p_mul c3 (P.p_mul (P.p_square delta) delta)in
      let t2 = P.p_mul c2 (P.p_square (P.p_sub z x0)) in
      let t1 = P.p_mul c1 (P.p_sub z x0) in
        P.p_add t3 (P.p_add t2 (P.p_add t1 c0))

    let minimax_equation l z : pol = 
      let n = List.length l in
      let mon_idx = U.int_to_list n in
      let mon_list = List.map (P.p_pow z) mon_idx in
      let summands = List.map2 P.pmulC mon_list l in
       List.fold_left P.p_add (P.Pc N.zero_i) summands

    let gen_cstrname n = "c" ^ (string_of_int (n + 1))

    (**val gen_cstr : term -> string -> string**)
    let gen_cstr s1 (c : term) s2 = 
      s1 ^ (P.string_of_term c (fun i -> string_of_float (N.float_of_num i))) ^ s2

    let var_hashitem_to_pol : (string * val_tbl) -> pol = function
      | _, ((p, p'), _) -> 
          if (not (P.fw_eq p p')) then failwith "Error in Variables Hashtable"
          else P.pol_of_fw p

    let init_matlab () = 
      let oc_in, oc_out, oc_err = Unix.open_process_full "matlab -nodesktop -nosplash" (Unix.environment ()) in
        U._pr_ "Launching Matlab..." true false ;
        flush oc_out;
        oc_in, oc_out, oc_err

    let stop_matlab oc_in oc_out oc_err = 
      let _ = Unix.close_process_full (oc_in, oc_out, oc_err) in
        U._pr_ "Exit of Matlab" true false ;
        ()

    let init_sollya () = 
      let oc_in, oc_out, oc_err = if Config.Config.use_sollya then (U._pr_ "Launching Sollya..." true true; Unix.open_process_full "sollya --flush" (Unix.environment ()) )else stdin, stdout, stdin in
        flush oc_out; 
        oc_in, oc_out, oc_err

    let stop_sollya oc_in oc_out oc_err = 
      let _ = Unix.close_process_full (oc_in, oc_out, oc_err) in
        U._pr_ "Exit of Sollya" true false ;
        ()

    let gen_output_s input_s ext =  (String.sub input_s 0 (String.length input_s - ext)) ^ ".out"

    (* n_box: number of box variables: 5 or 6 for complex flyspeck inequalities *)
    let gen_varname n n_box = P.mkX_i (n + n_box)

    let gen_variables_names n_eq n_box : pol list = 
      let index_list = U.int_to_list n_eq in
      List.map (fun i -> gen_varname (i+1) n_box) index_list

    let gen_constraints_names n_cstr letter : string list = 
      let index_list = U.int_to_list n_cstr in
        List.map (fun c -> letter ^ string_of_int (c + 1)) index_list

    let norm_meth01 norm_var f1 f2 : pol = 
      let c1 = N.sub_i f2 f1 and c2 = f1 in
      let cs1 = P.Pc c1 and cs2 = P.Pc c2 in
        P.p_add (P.p_mul cs1 norm_var) cs2

    let norm_meth1 norm_var f1 f2 : pol =
      let c1 = N.div_i (N.sub_i f2 f1) N.two_i and c2 = N.div_i (N.add_i f2 f1) N.two_i in
      let cs1 = P.Pc c1 and cs2 = P.Pc c2 in
        P.p_add (P.p_mul cs1 norm_var) cs2

    let interval_of_box_item = function
      | _ , ((_ , _) ,(f1, f2)) -> f1, f2

    let is_binary_variable = function
      |  _ , ((_ , _) ,(f1, f2)) -> Config.Config.binary && (*N.eq_i f1 f2 &&*) N.eq_i f1 N.zero_i && N.eq_i f2 N.one_i

    let divide_hashtbl var_hashtbl p_list = 
      let module Fu = Fw_utils.Make (N)(U)(I)(P) in
      let vars_list = List.map Fu.vars_of_fw p_list in        
      let vars = U.avoid_duplicata  Numbers.T.Pos.compare_int (List.concat vars_list) in
      let vars_to_strings = List.map (fun v -> P.string_of_pol (P.mk_X v)) vars in
        List.map (fun x -> x, Hashtbl.find var_hashtbl x) vars_to_strings 

    let bound_of_interval box_item tbl_scaling =
      let f1, f2 = interval_of_box_item box_item in
      let singleton = N.eq_i f1 f2 in
      let binary = is_binary_variable box_item in
      let var = var_hashitem_to_pol box_item in
      let lo_up_fx = if binary then Bin var else if singleton then fix_var var f1 tbl_scaling else bound_var var f1 f2 tbl_scaling in
        lo_up_fx

    let oracle_var_index p =
      let vars = P.vars_of_pol p in
        (*
        List.map idx_of_varpol ((List.map var_hashitem_to_pol) box) 
         *)
      let n = List.length vars in
        U.int_to_list n

    let varpol_index tbl : positive list = 
      let varpol_list = List.map var_hashitem_to_pol tbl in
        List.map P.idx_of_varpol varpol_list 

    let var_idx_list var_num_list = 
      let pos_list = List.map fst var_num_list in
        List.sort compare (List.map Numbers.T.Translation.positive pos_list)

    let variables_string var_num_list var_type concat_s : string  =
      let pos_list = List.map fst var_num_list in
      let idx_list =  List.sort compare (List.map Numbers.T.Translation.positive pos_list) in
      let var_list =  List.map (fun i -> gen_varname i 0) idx_list in 
        List.iter (fun p -> U._pr_ (P.string_of_pol p) false false;) var_list;     
        let variables_list = List.map P.string_of_pol var_list in
          var_type ^ (U.concat_string_with_string (variables_list) concat_s) ^ ";\n" 

    let binary_variables_string box var_type concat_s =
      let variables_list = List.map fst (List.filter is_binary_variable box) in
      let variables_string = var_type ^ (U.concat_string_with_string (variables_list) concat_s) ^ ";\n" in
        if List.length variables_list = 0 then "" else variables_string

    let get_bound_poly get_bound_poly_conj fw var_hashtbl bound_transc oc_out  relax_order = 
      if bound_transc then
        begin
          match fw with 
            (*  | Min (fw_l, _) -> min_list (List.map (fun p -> get_bound_poly_conj p
             *  var_hashtbl bound_transc oc_out ) fw_l)*)
            | _ -> get_bound_poly_conj fw var_hashtbl bound_transc oc_out  relax_order
        end
      else 
        begin
          match fw with
            (*        | Max (fw_l, _) -> max_list (List.map (fun p -> get_bound_poly_conj p
             *        var_hashtbl bound_transc oc_out ) fw_l)*)
            | _ -> get_bound_poly_conj fw var_hashtbl bound_transc oc_out  relax_order
        end
  end
