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

module Make : functor
  (N: Numeric.T) -> functor
  (Fun: Functions.T with type num_i = N.t) -> functor
  (U: Tutils.T with type t = N.t) -> functor
  (I: Interval.T with type num_i = N.t and type f = Fun.f)  -> functor
  (F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) -> functor
  (M: Mesh_interval.T with type num_i = N.t and type interval = I.interval) -> functor
  (E: Unfold_eval_tree.T with type num_i = N.t and type interval = I.interval and type func_tree = F.func_tree) -> functor
  (Mk: Mk_flyspeck.T with type num_i = N.t and type func_tree = F.func_tree) -> T
 with type num_i = N.t and type interval = I.interval and type func_tree = F.func_tree

