module type T = 
sig
  type num_i
  type func_tree
  type flyspeck_tree
  type eval_type
  type sphere_hash_tree
  val flyspeck_dir : string
  val sphere_final_ml : string
  val ineq_final_ml : string
  val check_func_prop : bool
  val mk_tree : Ast.Ast.e -> func_tree
  val mk_ineq_tree :Ast.Ast.e * Ast.Ast.e -> func_tree * func_tree
  val mk_flyspeck_tree : Ast.Ast.e -> flyspeck_tree
  val complete_tree : (string * string list) * Ast.Ast.e ->
                      (string, string list * func_tree) Hashtbl.t -> 
                      unit
  val arrange_result_in_tables : (string * string list) * Ast.Ast.e ->
    (string, string list * flyspeck_tree) Hashtbl.t ->
    (string, string list * flyspeck_tree) Hashtbl.t -> unit
  val make_ast_hashtable :(string, string list * func_tree) Hashtbl.t ->
    string -> unit
  val make_bounds_ineq_hashtables :
                sphere_hash_tree ->
    (string, string list * flyspeck_tree) Hashtbl.t ->
    (string, string list * flyspeck_tree) Hashtbl.t ->
    string list -> unit
  val eval_list2_to_tuple :eval_type list -> num_i * num_i
  val prepare_box :func_tree list -> (num_i * num_i) list
  val select_flyspeck_bounds_ineq :
    bool ->
    string list *
    ((func_tree * func_tree) list *
     (num_i * num_i) list)
  val string_full_ineq : func_tree * func_tree -> string
  val string_flyspeck_ineq : bool -> string
  val benchmarks_eval_interval : int -> unit
end


module Make 
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t)  
  (F:Flyspeck_types.T with type num_i = N.t) 
  (E: Unfold_eval_tree.T with type num_i = N.t and type interval = I.interval and type func_tree = F.func_tree)  = struct
  open Ast.Ast
  open N
  open U
  open F
  type num_i = N.t
  type func_tree = F.func_tree
  type flyspeck_tree = F.flyspeck_tree
  type eval_type = E.eval_type
  type sphere_hash_tree = F.sphere_hash_tree

  let of_float (i: float) =  
(*    let module Nf = (val (Numeric.of_string ("float")): Numeric.T) in *)
      num_of_float_exact i

   let of_num (i : Q.t) =
 (*   let module Nf = (val (Numeric.of_string ("zarith")): Numeric.T) in *)
      num_of_rat i
                                   
    let flyspeck_dir = "flyspeck_dir/"
    let sphere_final_ml = flyspeck_dir ^ "sphere_final.ml"
    let ineq_final_ml = flyspeck_dir ^ "ineq_final.ml"

(*let pi = Sphere_final.pi;;*)
let check_func_prop = true
(*
let atan2_I interv1 interv2 = 
        if (  y < x ) then atn(y / x) else
    (if (sgn_I interv2 = 1) then ((pi / &2) - atn(x / y)) else
    (if (y < &0) then (-- (pi/ &2) - atn (x / y)) else (  pi )))
*)
    let init_list_tree n tree = U.init_list n tree
    let mk_branch_mult t1 t2 = Branch ((Ffunc "mult_i", void_im()), [t1; t2])
    let mk_pow_branch tree f : func_tree = List.fold_left mk_branch_mult tree (init_list_tree (f - 1) tree)

let rec mk_tree = function
  | Evar s ->  (*Printf.printf "var: %s\n" s;*) init_leaf (Fvar s)
  | Evarloc s ->  (*Printf.printf "varloc: %s\n" s;*) init_leaf (Fvarloc s)
  | Efunc s ->(*Printf.printf "func: %s\n" s;*) init_tree (Ffunc s)
  | Eint s -> init_leaf (Fint s)
  | Eflo s ->  (*Printf.printf "float: %s\n" (string_of_float s);*) init_leaf (Fflo (of_float (*num_of_float*) s) )
  | Enum s -> init_leaf (Fflo (of_num (*num_of_float*) s) )
  | Efun (s, f) -> (*Printf.printf "fun: %s\n" s;*)  Branch ((Ffunc "fun", void_im()),[init_leaf (Fvarloc s);mk_tree f])
  | Eifthen (cnd, e) -> Branch ((Ffunc "cnd", void_im()), [Branch ((Ffunc "if", void_im()), [mk_tree cnd]); Branch ((Ffunc "then", void_im()),[mk_tree e])])
  | Eifthenelse (cnd, e1, e2) -> Branch ((Ffunc "cnd", void_im()), [Branch ((Ffunc "if",void_im()), [mk_tree cnd]); Branch ((Ffunc "then", void_im()), [mk_tree e1]); Branch ((Ffunc "else", void_im()), [mk_tree e2])])
  | Elet (s, e1, e2) -> Branch ((Ffunc "let", void_im()), [init_leaf (Fvarloc s); mk_tree e1; mk_tree e2])
  | Eand (e1, e2) -> Branch ((Ffunc "and", void_im()), [mk_tree e1; mk_tree e2])
  | Etuple (e1, e2) -> Branch ((Ffunc "tuple", void_im()), [mk_tree e1; mk_tree e2])
  | Ebop (Bpow, e, Enum f) ->  mk_pow_branch (mk_tree e) (Q.to_int f)
  | Ebop (Bpow, e, Eflo f) ->  mk_pow_branch (mk_tree e) (int_of_float f)
  | Ebop (Bpow, e, Eint i) -> mk_pow_branch (mk_tree e) i
  | Ebop (bop, e1, e2) -> Branch ((Ffunc
                                   (match bop with 
                                      | Bpow -> "pow_i"
                                      | Badd -> "add_i"
                                      | Bdiv -> "div_i"
                                      | Bsub -> "sub_i"
                                      | Bmul -> "mult_i"
                                   )
                                 ,void_im()),[mk_tree e1; mk_tree e2])                                                
  | Euop (uop, e) -> Branch ((Ffunc
                               (match uop with
                                  |Umin -> "minus_i"
                                  |Uinv -> "inv_i"
                               )
                             , void_im()), [mk_tree e])
  | Ecnd (orderop, e1, e2) -> Branch ((Ffunc
                                       (match orderop with
                                          | Ble -> "le_i"
                                          | Blt -> "lt_i"
                                          | Bge -> "ge_i"
                                          | Bgt -> "gt_i"
                                          | Beq -> "eq_i"
                                       )
                                     , void_im()), [mk_tree e1; mk_tree e2])
  | Eapp (e1, e2) -> mk_branch (mk_tree e1) (mk_tree e2)
  | _ -> failwith "Not able to build definition tree"
(*        | (Eapp (e1, e2)) as t-> mk_app_tree [] t*)
        (*| _ -> init_tree Void *)
(*
and mk_app_tree aux_tree = function
        | Eapp (e1,e2)-> (match e1 with 
                | Efunc s -> Branch((Ffunc s,void_im()),List.rev ((mk_tree e2):: aux_tree))
                | _ -> mk_app_tree (mk_tree e2::aux_tree) e1)
        |_-> failwith "no application in this tree"
*)
let mk_ineq_tree = function
(*  | (ineq1, op) -> (mk_tree ineq1, if op=Ige then Fnonstrict else
 *  Fstrict)*)
  | (ineq1, ineq2) -> (mk_tree ineq1, mk_tree ineq2)

let mk_flyspeck_tree = function
  | Boundlist l -> Fbox (List.map mk_tree l)
  | Ineqlist l -> Fdisj (List.map mk_ineq_tree l)
  | _ -> failwith "Not able to build flyspeck tree"


let complete_tree hash_entry table = 
  let (f,var_list,tree) = (fst (fst hash_entry), snd (fst hash_entry),mk_tree (snd hash_entry))in 
  let (up_var_list,up_tree) = (if var_list = [] then(
    match tree with 
      | Branch((Ffunc s , i1) , [Branch((Ffunc s2 , i2) , [])]) -> 
          (
            let new_var_list = fst (Hashtbl.find sphere_table s2 ) in
            let new_tree = Branch((Ffunc s , i1) , [Branch((Ffunc s2 , i2),[])] @ (List.map (fun v -> Leaf (Fvar v,void_im()) ) new_var_list ))in
              (new_var_list,new_tree)
          )
      |_ -> (var_list,tree) 
  )
                               else (var_list,tree) )in
    Hashtbl.replace table f (up_var_list, up_tree)

let arrange_result_in_tables result bounds_table ineq_table  =
  let (f,var_list),tree = result in
    match tree with 
      | Boundlist l -> (*Printf.printf "Boundlist %s\n" (string_func_tree (mk_tree (List.hd l)));*)
          Hashtbl.add bounds_table (f) (var_list,mk_flyspeck_tree tree)   
      (* "real box", i.e. [(m1,M1);...;(mn;Mn)]  *)
      | Ineqlist l -> 
          (*Printf.printf "Ineqlist %s\n" (string_func_tree (mk_tree (fst
           * (List.hd l)))); *)
          Hashtbl.add ineq_table (f) (var_list,mk_flyspeck_tree tree)     
      (* disjunction of inequalities  *)
      | _ ->( 
          let tmp_tree = mk_tree tree in 
            (* hidden box, like for example l_5735387903_bounds in ineq_final.ml *)
            match tmp_tree with 
              | Branch((Ffunc s,_),l) -> 
                  begin
                    (*
                    Printf.printf "Hidden box: %s\n" (string_func_tree tmp_tree);
                    Printf.printf "%s\n" s; 
                     *)
                    let new_var_list, new_tree = Hashtbl.find bounds_table s in 
                      Hashtbl.replace bounds_table f (new_var_list, new_tree)
                  end
              | _ ->  failwith "Cannot put this tree in hashtables"                          
        )
           

let make_ast_hashtable table file_name=
  let input_f = open_in file_name in
    try
      (* let input_file = Sys.argv.(1) in*)
      let lexbuf = Lexing.from_channel input_f in
        (* let lexbuf = Lexing.from_channel stdin in*)
        while true do
          try
            begin 
              let result = Parser.prog Lexer.token lexbuf in  
                complete_tree result table;
                (*print_ast (snd result);print_newline();print_newline();*)
        (*dump (mk_tree result); print_newline();*)
                ()
            end
          with Parsing.Parse_error -> failwith "Myparse error" 
        done 
    with Lexer.Eof  -> close_in input_f 

                (*try 
                let (var_table, tree) = Hashtbl.find table "beta_bump_lb" in
                print_func (("beta_bump_lb",var_table),tree)
                with Not_found -> Printf.printf "failed\n"*)

let make_bounds_ineq_hashtables def_table bounds_table ineq_table file_names = 
  let parse_ineqs file_name = 
  let input_f = open_in file_name in
    try
      let lexbuf = Lexing.from_channel input_f in
        while true do
          try
            let result = Parser.prog Lexer.token lexbuf in
              arrange_result_in_tables result bounds_table ineq_table;
          with Lexer.Openml -> ();
        done
    with Lexer.Eof  -> close_in input_f
  in
    List.iter parse_ineqs file_names

let rec eval_list2_to_tuple l = 
  match l with 
    | [E.Num_eval f1; E.Num_eval f2] -> (f1, f2)
    | _ -> failwith "Bad bounds for the box"


let prepare_box bounds = 
  let var_hashtbl = Hashtbl.create 2 in
  let box = List.map (fun b -> E.eval_tuple var_hashtbl b) bounds in
  let box = List.map eval_list2_to_tuple box in
    box

let select_flyspeck_bounds_ineq  unfold_bool= 
  let ineq_disj_string = "obj_"^ Config.Config.ineq_name in
  let (var_list_i, trees) = Hashtbl.find ineq_table ineq_disj_string in
  let bounds_string = "box_"^ Config.Config.ineq_name in
  let (var_list_b, bounds) = Hashtbl.find bounds_table bounds_string in
    if (List.length var_list_b = List.length var_list_i) then
      (match (trees, bounds) with 
         | (Fdisj i_list, Fbox b_list) -> let (ineqs_lhs, ineqs_rhs) = List.split i_list in
           (*Printf.printf "After mapping unfolded trees: %s\n" (concat_string (map string_func_tree ineqs)); *)
           let unfold_ineqs_lhs = List.map E.unfold_ineq_tree ineqs_lhs and unfold_ineqs_rhs = List.map E.unfold_ineq_tree ineqs_rhs and unfold_bounds = List.map E.unfold_ineq_tree b_list in
           (*let unfold_ineqs = map unfold_ineq_tree unfold_ineqs in*)
           (*Printf.printf "After mapping unfolded trees: %s\n" (concat_string (map string_func_tree unfold_ineqs));*)
           let unfold_bounds = prepare_box unfold_bounds in
           let unfold_full_ineqs = List.combine unfold_ineqs_lhs unfold_ineqs_rhs in
             if unfold_bool 
             then var_list_i, (unfold_full_ineqs, unfold_bounds) 
             else var_list_i, (i_list, unfold_bounds)
         | _ -> failwith "Not able to select inequalities")
    else failwith "Not able to match bounds and variables of inequality"

let string_full_ineq full_ineq = 
  let (lhs, rhs) = full_ineq in
    string_func_tree lhs ^ "\n" ^ string_func_tree rhs ^ "\n" (* (if op = Fnonstrict then "Non Strict" else "Strict") ^ "\n"*)

(*
 * let string_bounds b_tree = 
 * string_func_tree b_tree ^ "\n"
 *)

let string_flyspeck_ineq  unfold_bool = 
  let (var_list, (ineqs, bounds)) = select_flyspeck_bounds_ineq  unfold_bool in
  let string_i = concat_string (List.map string_full_ineq ineqs) in
  let string_b = string_of_tuple_list bounds in
    "Flyspeck Box: " ^ string_of_list var_list ^ " --> " ^ string_b ^ "\n" ^  
                                                                       "Flyspeck Tree: " ^ string_i

let benchmarks_eval_interval  n_eval =
  _pr_ (Printf.sprintf "%s\n" (string_flyspeck_ineq  false)) true false;
  let (var_list, (full_ineqs, bounds)) = select_flyspeck_bounds_ineq  true in
(*  let ineqs, op = split full_ineqs in*)
  let lhs, rhs = List.split full_ineqs in
  let tree_l, tree_r = List.hd lhs, List.hd rhs in
  (*let tree = unfold_ineq_tree tree in*)
  (*Printf.printf "With unfold: %s\n"  (string_func_tree tree);*)
  (*Printf.printf "%s\n" (string_flyspeck_ineq  true);*)
(*  let bounds =  [(2., 2.) ; (2., 2.52) ; (2., 2.) ; (2., 2.) ; (2.52, 2.52) ; (2., 2.52)] in*)
(*  let bounds = [(2., 2.52) ; (2., 2.52) ; (2., 2.52) ; (2., 2.52) ; (2.52, 2.52) ; (2., 2.52)] in*)
  let var_point = List.combine var_list bounds in
  let var_hash_table = Hashtbl.create 10 in
    add_list_table var_hash_table var_point;
  Printf.printf "bounds: %s\n" (string_of_tuple_list bounds);

  let i = ref 0 in
  let prev = Unix.gettimeofday() in
  while (!i<n_eval) do
    let _ = E.eval_interval var_hash_table tree_l in
    let _ = E.eval_interval var_hash_table tree_r in
    i:=!i+1;
  done;
  let current = Unix.gettimeofday() in
  let time_bench = current -. prev in
  let size_tree_l = leaves_nodes_number tree_l in
  let size_tree_r = leaves_nodes_number tree_r in
  let size_tree = size_tree_l + size_tree_r in
  let speed = (float_of_int size_tree) /. (time_bench /. (float_of_int (n_eval))) in
  Printf.printf "Evaluation time is: %f\n" time_bench;
  Printf.printf "Size of ineq tree is: %i\n" size_tree;
  Printf.printf "Speed is: %f\n" speed;
  Printf.printf "After interval arithmetic: lhs = %s\n rhs = %s\n" (I.string_I (E.interv_at_node tree_l)) (I.string_I (E.interv_at_node tree_r)) ;
  (*  Printf.printf "State of tree: %s\n" (string_func_tree tree);*)
  print_string "Benchmark completed\n"
  
  
end
