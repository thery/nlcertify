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

module Make : functor 
(N: Numeric.T) -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> functor 
(F:Flyspeck_types.T with type num_i = N.t) -> functor 
(E: Unfold_eval_tree.T with type num_i = N.t and type interval = I.interval and type func_tree = F.func_tree) -> T with type num_i = N.t and type func_tree = F.func_tree and type flyspeck_tree = F.flyspeck_tree and type eval_type = E.eval_type and type sphere_hash_tree = F.sphere_hash_tree
