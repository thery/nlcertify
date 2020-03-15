module type T = sig
  type interval 
  type positive
  type pol
  type fw_pol
  type num_i
  type rt 
  type bound
  val nvars : int ref
  val fw_vars_tbl : (fw_pol, int * interval) Hashtbl.t
  val fw_nvars_tbl : (fw_pol, int) Hashtbl.t
  val fw_cvars_tbl : (fw_pol, int) Hashtbl.t
  val vot_aux : (int -> fw_pol -> int) -> fw_pol -> int -> int
  val vot_aux2 : (int -> fw_pol -> int) -> fw_pol -> fw_pol -> int -> int
  val vars_of_tree_aux : rt -> fw_pol -> unit
  (*val novt_aux : int -> fw_pol -> rt -> int * (int * interval) list
  val norm_2 : (fw_pol -> bool) -> fw_pol -> fw_pol -> int -> int -> rt -> int * (int * interval) list*)
  val norm_vars_of_tree : unit -> (int * interval) list
  val norm_constraints_of_tree :  (int * interval) list -> int -> (positive, num_i * num_i) Hashtbl.t -> bound list
  val ineq_cstr_list : pol list ref
  val eq_cstr_list : pol list ref
  val ineq_cstr_tbl : pol list ref
  val eq_cstr_tbl : pol list ref
  val constraints_of_tree : fw_pol -> bool -> int -> rt -> pol
end

module Make : functor 
(N: Numeric.T) ->  functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> functor 
(P: Polynomial.T with type num_i = N.t and type interval = I.interval) -> functor 
(Fu: Fw_utils.T with type num_i = N.t and type fw_pol = P.fw_pol and type interval = I.interval) -> functor 
(O: Oracle.T with type num_i = N.t and type positive = P.positive and type pol = P.pol) -> T with type positive = P.positive and type interval = I.interval and type pol = P.pol and type fw_pol = P.fw_pol and type num_i = N.t and type rt =Fu.relax_type and type bound = O.bound

