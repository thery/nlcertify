module type T = 
sig
  type num_i
  type interval
  type func_tree
  type eval_type =
      Bool_eval of bool
    | Num_eval of num_i
    | Fail_eval of string
  type eval_left_right_type =
      EL of eval_type
    | ER of eval_type
    | EM
  val func_at_node : func_tree -> string
  val interv_at_node : func_tree -> interval
  val medium_value_at_node : func_tree -> num_i
  val contains_s : string -> func_tree list -> bool
  val contains_func_aux : func_tree -> bool
  val contains_func : func_tree -> bool
  val contains_fun : func_tree -> bool
  val is_func_arg : func_tree -> bool
  val contains_func_as_arg : func_tree list -> bool
  val extract_func_from_tree :func_tree list -> string * func_tree list
  val find_non_void_string : string list -> string
  val find_funcloc : func_tree -> string
  val unfold_func_tree :string -> func_tree -> func_tree list
  val unfold_add_tree : func_tree -> func_tree list
  val unfold_mul_tree : func_tree -> func_tree list
  val fold_add_tree : func_tree list -> func_tree
  val compose_unfold_tree_with_func :string -> func_tree -> func_tree
  val compose_tree_with_func :string -> func_tree -> func_tree * string
  val find_fun_tree : func_tree -> func_tree
  val find_fun_list : func_tree list -> func_tree
  val build_fun_tree : func_tree -> func_tree
  val is_tuple : func_tree list -> bool
  val mk_tuple_tree : func_tree -> func_tree -> func_tree
  val mk_tuple_aux : func_tree -> func_tree list
  val cut_tuples : func_tree -> func_tree list
  val remove_tuple : func_tree -> func_tree
  val eval_func_aux :(string, num_i) Hashtbl.t -> func_tree -> eval_type
  val eval_tuple : (string, num_i) Hashtbl.t -> func_tree -> eval_type list
  val tuple_to_list : func_tree -> func_tree list
  val replace_leaf_funcloc_by_tree :(string * func_tree) list -> func_tree -> func_tree
  val unfold_tree_with_fun_tree : func_tree -> func_tree -> func_tree
  val unfold_ineq_tree : func_tree -> func_tree
  val print_unfold_tree :bool -> ((string * string list) * func_tree, string list * func_tree)Hashtbl.t ->(string * string list) * func_tree -> string * string list * func_tree
  val eval_func_unfold : string -> num_i list -> eval_type
  val eval_func_num : string -> num_i list -> num_i
  val eval_tree :func_tree -> string list -> num_i list -> num_i
  val get_low_values : num_i list -> num_i list
  type eval_interv_type =
      Bool_interval of bool
    | Num_interval of interval
  val to_interval : eval_interv_type -> interval
  val to_boolean : eval_interv_type -> bool
  val eval_interval :(string, num_i * num_i) Hashtbl.t ->func_tree -> eval_interv_type
  val eval_interval_unfold :string -> (num_i * num_i) list -> num_i * num_i
  val eval_func_mesh :string -> (num_i * num_i) list -> int -> num_i list
end

module Make: functor 
(N: Numeric.T) -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> functor 
(F: Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) -> functor 
(M:Mesh_interval.T with type num_i = N.t) -> T with type num_i = N.t and type interval = I.interval and type func_tree = F.func_tree

