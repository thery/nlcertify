module type T = 
sig
  type num_i
  type interval 
  type func_tree
  val branch_and_bound_naive : string -> (num_i * num_i) list -> int -> interval * int
  val multi_bb_naive : func_tree -> string list -> (num_i * num_i) list -> int -> interval * int
  val initialize_bb : string -> interval * int
  val extract_checkable_func : func_tree -> (string * num_i) list
  val extract_check_func : func_tree -> string list -> (num_i * num_i) list -> (string * num_i) list
  val extract_k_th_list : int -> ('a * 'b) list list -> 'a * 'b list
  val merge_data : ('a * 'b) list list -> ('a * 'b list) list
  val string_of_check_data : string * interval -> string
  val min_max_list : 'a * num_i list -> 'a * interval
  val check_prop : string * interval -> string
  val extract_check_func_mesh : func_tree -> string list -> (num_i * num_i) list -> int -> string
  val extract_check_flyspeck_ineq : string -> int -> string
end


module Make 
  (N: Numeric.T) 
  (Fun: Functions.T with type num_i = N.t) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t and type f = Fun.f)  
  (F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) 
  (M: Mesh_interval.T with type num_i = N.t and type interval = I.interval) 
  (E: Unfold_eval_tree.T with type num_i = N.t and type interval = I.interval and type func_tree = F.func_tree)
  (Mk: Mk_flyspeck.T with type num_i = N.t and type func_tree = F.func_tree)
 = struct

   type num_i = N.t
   type interval = I.interval
   type func_tree = F.func_tree

   let rec branch_and_bound_naive key point ncut = 
     let (a, b) = (E.eval_interval_unfold key point) in
       if (I.belongs_I N.zero_i (I.mk_I (a, b))) 
       then 
         let (interv1, interv2) = U.cut_point point in
         let (image1, ncut1) = branch_and_bound_naive key interv1 ncut in
         let (image2, ncut2) = branch_and_bound_naive key interv2 ncut in
           (I.union_I image1 image2, ncut1+ncut2+1)
           else ((I.Int(a, b)), ncut)

   let rec multi_bb_naive tree var_list bounds ncut = 
     (*let tree = unfold_ineq_tree tree in*)
     (*Printf.printf "With unfold: %s\n"  (string_func_tree tree);*)
     (*Printf.printf "%s\n" (string_flyspeck_ineq  true);*)
     (*  let bounds =  [(2., 2.) ; (2., 2.52) ; (2., 2.) ; (2., 2.) ; (2.52, 2.52) ; (2., 2.52)] in*)
     (*  let bounds = [(2., 2.52) ; (2., 2.52) ; (2., 2.52) ; (2., 2.52) ; (2.52, 2.52) ; (2., 2.52)] in*)
     let var_point = List.combine var_list bounds in
     let var_hash_table = Hashtbl.create 10 in
       U.add_list_table var_hash_table var_point;
       let _ = E.eval_interval var_hash_table tree in
       let interv = E.interv_at_node tree in
         (*Printf.printf "Root Interval is: %s\n" (string_I interv);*)
         if I.is_positive_interv interv 
         then (interv,ncut) 
         else(
           (*let combin_interv = multi_cut_point point in*)
           Printf.printf "Negative Root Interval is: %s\n" (I.string_I interv);
           let combin_interv =  M.mesh_of_interval bounds 2 in
           let (image_list, ncut_list)= List.split (List.map (fun i -> multi_bb_naive tree var_list i ncut) combin_interv )in
             Printf.printf "\n\n union of intervals : %s\n\n" (I.string_I (I.union_list_I image_list));
             (I.union_list_I image_list, (U.add_list_int ncut_list) + 1))

   let rec initialize_bb  = 
     let (var_list, (full_ineqs, bounds)) = Mk.select_flyspeck_bounds_ineq  true in
     let ineqs, op = List.split full_ineqs in
     let tree = List.hd ineqs in
       multi_bb_naive tree var_list bounds 0

   let rec extract_checkable_func tree =
     match tree with 
       | F.Leaf _ -> []
       | F.Branch ((F.Ffunc s, i_func), t) -> (*Printf.printf "eval at %s\n" (s);*)( 
           if i_func.I.i = I.Void_i then [] else (
             if List.mem s I.func_checkable then (
               match t with 
                 | [sub_tree] -> ((s, E.medium_value_at_node sub_tree))::(extract_checkable_func sub_tree)
                 | _ -> failwith "No valid sub-trees")
             else List.concat (List.map extract_checkable_func t) )
         )
       | _ -> failwith "tree not correctly unfolded"

   let extract_check_func tree var_list point = 
     let var_point = List.combine var_list point in
     let var_hash_table = Hashtbl.create 10 in 
       U.add_list_table var_hash_table var_point;
       let _ = E.eval_interval var_hash_table tree in
       (* let interv = interv_at_node tree in
        let prev = Unix.gettimeofday() in *)
       let extraction_result =  extract_checkable_func tree in
         (*  let current = Unix.gettimeofday() in*)
         (*Printf.printf "extraction: %f\n" (current -. prev);
          Printf.printf "Root Interval is: %s\n" (string_I interv);*)
         extraction_result

   let extract_k_th_list k data_list = 
     let k_th_checkable = List.map (fun data -> List.nth data k) data_list in
     let (func, data) = List.split k_th_checkable in 
       (List.hd func,  data)

   let merge_data data = 
     let n = List.length (List.hd data) in
     let indexes = U.int_to_list n in
     let func_data = List.map (fun k -> extract_k_th_list k data) indexes in
       func_data

   let string_of_check_data func_data_item = 
     fst func_data_item ^": "^(I.string_I (snd func_data_item))^"\n"

   let min_max_list data_item = 
     let l = snd data_item in
     let a = I.min_list l and b = I.max_list l in
       (fst data_item, I.Int(a, b))

   let check_prop data_item = 
     let (func, (interv:interval)) = data_item in
     let str = "function " ^ func ^ " has no checkable properties" in   
       try
         let prop_list = Hashtbl.find I.func_check_prop_list func in
         let bool_list = U.map_func prop_list interv in
           match bool_list with 
             | [is_conv;is_conc;is_incr;is_deacr] -> (
                 let convexity = if is_conv then "is convexe" else if is_conc then "is concave" else "has no global convexity property" in
                 let monotonicity = if is_incr then "is increasing" else if is_deacr then "is deacreasing" else "has no global monotonicity property" in
                   "On "^(I.string_I interv) ^ " :function " ^ func ^" "^ convexity ^" and " ^ monotonicity ^ "\n"
               )
             | _ -> failwith "bool_list does not contain appropriate data"
       with Not_found -> failwith str     

   let extract_check_func_mesh tree var_list point base = 
     let mesh = M.mesh_of_point point base in
     let mesh = List.map I.tuple_of_num_list mesh in 
     let data = List.map (extract_check_func tree var_list) mesh in
     let check_func_data = merge_data data in
     let min_max_func_data = List.map min_max_list check_func_data in
     let properties_string = U.concat_string (List.map check_prop min_max_func_data)in
       properties_string

   let extract_check_flyspeck_ineq  accuracy =
     Printf.printf "%s\n" (Mk.string_flyspeck_ineq  false);
     let (var_list, (full_ineqs, bounds)) = Mk.select_flyspeck_bounds_ineq  true in
     let ineqs, op = List.split full_ineqs in
     let ineq = List.hd ineqs in
       extract_check_func_mesh ineq var_list bounds accuracy

 end
