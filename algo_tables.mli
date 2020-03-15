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

module Make : functor 
(N: Numeric.T) -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> functor 
(P: Polynomial.T with type num_i = N.t and type interval = I.interval) -> functor 
(Fu: Fw_utils.T with type num_i = N.t and type fw_pol = P.fw_pol and type pol = P.pol and type interval = I.interval) -> functor 
(A: Algo_types.T with type num_i = N.t and type fw_pol = P.fw_pol) -> T with type num_i = N.t and type interval = I.interval and type fw_pol = P.fw_pol and type p = P.positive and type pol = P.pol and type poly_interval = A.poly_interval and type eval_tbl = A.eval_tbl and type fw_tbl = A.fw_tbl
