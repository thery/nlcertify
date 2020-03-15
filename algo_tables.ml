module type T = sig
  type num_i 
  type interval
  type fw_pol
  type p
  type pol
  type poly_interval
  type eval_tbl
  type fw_tbl
  val is_singleton : string * (num_i * num_i) -> bool
  val var_fw_interv_hash_entry : string * (num_i * num_i) -> p -> string * ((fw_pol * fw_pol) * (num_i * num_i))
  val var_poly_hash_entry : string * (num_i * num_i) -> p -> string * pol
  val main_tbl_hash_entry : int -> num_i * num_i -> p -> (fw_pol * int) * poly_interval
  val var_single_hash_entry : string * (num_i * num_i) -> string * pol
  val pos_indexes : int -> p list
  val array_indexes : int -> p array
  val get_fold_tbl : (string * (num_i * num_i)) list -> (string * (num_i * num_i)) list -> (string, pol) Hashtbl.t
  val get_tbl : string list -> (num_i * num_i) list -> p list -> eval_tbl
  val get_tbl_pol : p list -> num_i list -> (p, num_i) Hashtbl.t
  val project_vars : p list -> 'a list -> p list  -> 'a list 
end


module Make
(N: Numeric.T) 
(U: Tutils.T with type t = N.t) 
(I: Interval.T with type num_i = N.t) 
(P: Polynomial.T with type num_i = N.t and type interval = I.interval) 
(Fu: Fw_utils.T with type num_i = N.t and type fw_pol = P.fw_pol and type pol = P.pol and type interval = I.interval) 
(A: Algo_types.T with type num_i = N.t and type fw_pol = P.fw_pol) = struct 

  type num_i = N.t 
  type interval = I.interval
  type fw_pol = P.fw_pol
  type p = P.positive
  type pol = P.pol
  type poly_interval = A.poly_interval
  type eval_tbl = A.eval_tbl
  type fw_tbl = A.fw_tbl

  let is_singleton = function
    | _, (i1, i2) when N.eq_i i1 i2 -> true
    | _ -> false
  (*
   let filter_vars var_map = 
   let new_var_map = filter (fun b -> not (is_singleton b)) var_map in
   *)
  let c0 = P.cert_null
  let var_fw_interv_hash_entry var_interv j =  
    let var, (i1, i2) = var_interv in
    let x_j = P.mk_X j in
    let x_j = P.Pw (x_j, I.mk_I (i1, i2), c0) in
      var, ((x_j, x_j), (i1, i2))

  let var_poly_hash_entry var_interv j = 
    let var, (i1, i2) = var_interv in
    let x_j =  P.mk_X j in
      var, x_j


  let main_tbl_hash_entry n var_interv j =  
    let i = I.mk_I var_interv in
    let x_j = P.mk_X j in
    let f_j =  Fu.mk_Pw_I x_j i in
    let x_j = Fu.mk_Pw x_j in
      (x_j, n), A.Poly_Int (f_j, f_j)


  let var_single_hash_entry = function
    | var, (i1, i2) when N.eq_i i1 i2 -> 
        begin
          let x_j = P.Pc i1 in
            var, x_j
        end
    | _ -> failwith "Not a singleton"


  let pos_indexes nvars = List.map (fun n -> Numbers.T.Translation.positive_n (n+1)) (U.int_to_list nvars)
  let array_indexes nvars = Array.of_list (pos_indexes nvars)

  let get_fold_tbl singletons var_map =
    let n1, n2 = List.length var_map, List.length singletons in
    let n = n1 + n2 in
    let tbl = Hashtbl.create n in
    let pos_indexes = pos_indexes n1 in
    let var_poly_list = List.map2 var_poly_hash_entry var_map pos_indexes in
    let var_single_list = List.map var_single_hash_entry singletons in
      U.add_list_table tbl (var_poly_list @ var_single_list); 
      tbl

  let get_tbl var_list bounds vars : eval_tbl =
    let var_map = List.combine var_list bounds in
    let n = List.length var_map in
    let tbl = Hashtbl.create n in
    let var_poly_interv_list = List.map2 var_fw_interv_hash_entry var_map vars in
      U.add_list_table tbl var_poly_interv_list;
      tbl

  let get_tbl_pol vars values =
    let n = List.length vars in
    let tbl = Hashtbl.create n in
    let l = List.combine vars values in
      U.add_list_table tbl l;
      tbl

  let project_vars old_vars old_values new_vars = 
    let n = List.length old_vars in
    let tbl = Hashtbl.create n in
    let l = List.combine old_vars old_values in
      U.add_list_table tbl l;
      Hashtbl.fold (fun k v acc -> if List.mem k new_vars then v::acc else acc) tbl [] 



        (*
  let get_tbl_pos_I vars box = 
    let n = List.length box in
    let tbl = Hashtbl.create n in
    let l = List.combine vars (List.map I.mk_I box) in
      U.add_list_table tbl l;
      tbl
         *)
(*
  let get_main_tbl bounds ellips_nb : fw_tbl =
    let n = List.length bounds in
    let tbl = Hashtbl.create n in
    let pos_indexes = pos_indexes n in
    let var_poly_interv_list = List.map2 (main_tbl_hash_entry ellips_nb) bounds pos_indexes in
      U.add_list_table tbl var_poly_interv_list;
      tbl
 *)
(*
  let get_tree_info t var_list bounds = 
    let var_map = List.combine var_list bounds in
    let singletons, new_var_map = List.partition is_singleton var_map in
    let nvars = List.length new_var_map in
    let vars = array_indexes nvars in
    let fold_tbl = get_fold_tbl singletons new_var_map in
    let t = R.fold_poly fold_tbl false t in
    let var_list, bounds = List.split new_var_map in
    let tbl = get_tbl var_list bounds in
      t, var_list, bounds, vars, tbl
 *)

  
end
