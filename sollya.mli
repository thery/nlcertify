module type T =
sig
  type num_i 
  type interval 
  exception Diverge
  val sollya_main_cmd : int -> int -> string -> string -> interval -> string
  val write_sollya : string list -> string
  val read_oc_in : Unix.file_descr -> string list
  val read_until_flush : string -> string
  val parse_sollya_output : string -> int -> num_i list
  val get_minimax : string -> int -> interval -> num_i list
end

module Make : functor 
  (N: Numeric.T) -> functor
  (Fun: Functions.T with type num_i = N.t) -> functor
  (U: Tutils.T with type t = N.t) -> functor
  (I: Interval.T with type num_i = N.t) -> functor
  (M: Mesh_interval.T with type num_i = N.t and type interval = I.interval) -> functor
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval) -> functor
  (Fu: Fw_utils.T with type num_i = N.t and type positive = P.positive and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval and type transc_approx = P.transc_approx) -> functor
  (A: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol) -> functor
  (O: Oracle.T with type num_i = N.t and type positive = P.positive and type pol = P.pol with type term = P.term and type val_tbl = A.val_tbl) -> T 
with type num_i = N.t and type interval = I.interval
