module type T =
sig
  type num_i
  type inter_mut
  type vstring =
      Fvar of string
    | Fvarloc of string
    | Fflo of num_i
    | Fint of int
  type fstring = Void | Ffunc of string | Ffuncloc of string
  type fineqop = Fstrict | Fnonstrict
  type node = fstring * inter_mut
  val void_im : unit -> inter_mut
  val void_f : fstring * inter_mut
  type func_tree =
      Leaf of vstring * inter_mut
    | Branch of node * func_tree list
  val void_n : node * func_tree list
  type flyspeck_tree =
      Fbox of func_tree list
    | Fdisj of (func_tree * func_tree) list
  type sphere_hash_tree = (string,(string list*func_tree)) Hashtbl.t
  type bounds_hash_tree = (string,(string list*flyspeck_tree)) Hashtbl.t                          
  type ineqs_hash_tree = (string,(string list*flyspeck_tree)) Hashtbl.t
  val sphere_table : sphere_hash_tree
  val bounds_table : bounds_hash_tree
  val ineq_table : ineqs_hash_tree 
  val string_func_tree : func_tree -> string
  val string_of_func : (string * string list) * func_tree -> string
  val string_of_hash_key : sphere_hash_tree -> string -> string
  val nodes_number : func_tree -> int
  val nodes_number_list : func_tree list -> int
  val leaves_nodes_number : func_tree -> int
  val leaves_nodes_number_list : func_tree list -> int
  val depth_aux : int -> (int -> func_tree -> int) -> func_tree list -> int
  val depth : func_tree -> int
  val make_func_tree : node -> func_tree list -> func_tree
  val func_of_node : func_tree -> node
  val branches : func_tree -> func_tree list
  val zero_t : func_tree
  val add_tree : func_tree -> func_tree -> func_tree
  val minus_tree : func_tree -> func_tree
  val degree_map_tree : func_tree -> int
  val string_of_var : string -> string
  val string_of_fun : string -> string
  val mk_branch : func_tree -> func_tree -> func_tree
  val init_leaf : vstring -> func_tree
  val init_tree : fstring -> func_tree
  val rev_tree : func_tree -> func_tree
end

module Make : functor 
(N: Numeric.T)  -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> T with type num_i = N.t and type inter_mut = I.inter_mut

