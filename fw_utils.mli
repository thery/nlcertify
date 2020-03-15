
module type T =
sig
  exception Div_refine
  exception Compose_refine
  type num_i
  type positive
  type interval
  type transc_approx
  type fw_pol
  type pol 
  type cert_itv
  type relax_type = Lasserre | Schor
  val relax_type_of_string : string -> relax_type
  val tan_approx : transc_approx -> num_i * num_i
  val string_of_approx : transc_approx -> string
  val string_approx : transc_approx -> string
  val string_float_approx : transc_approx -> int -> string
  val length_of_fw : fw_pol -> int
  val fw_0 : fw_pol
  val fw_1 : fw_pol
  val string_of_fw : fw_pol -> string
  val string_fw : int -> fw_pol -> string
  val interval_of_fw : fw_pol -> interval
  val ifw : fw_pol -> interval
  val mk_Pw_I_cert : pol -> interval -> cert_itv -> fw_pol
  val mk_Pw_I : pol -> interval -> fw_pol
  val mk_Pw : pol -> fw_pol
  val mk_Max : fw_pol list -> fw_pol
  val assign_interval : interval -> fw_pol -> fw_pol
  val assign_interval_certif : interval -> fw_pol -> cert_itv -> fw_pol
  val ai : interval -> fw_pol -> fw_pol
  val aic : interval -> fw_pol -> cert_itv -> fw_pol
  val fold_fw : fw_pol -> fw_pol
  val elim_sort : fw_pol list -> fw_pol list
  val assign_min : fw_pol list -> fw_pol
  val assign_max : fw_pol list -> fw_pol
  val extract_fw_from_max : fw_pol -> fw_pol
  val fw_addC : num_i -> fw_pol -> fw_pol
  val fw_mulC : num_i -> fw_pol -> fw_pol
  val fw_minus : fw_pol -> fw_pol
  val fw_add : fw_pol -> fw_pol -> fw_pol
  val fw_sub : fw_pol -> fw_pol -> fw_pol
  val fw_ident : fw_pol -> fw_pol
  val approx_fw_add : fw_pol -> fw_pol -> fw_pol -> fw_pol -> fw_pol * fw_pol
  val approx_fw_minus : fw_pol -> fw_pol -> fw_pol * fw_pol
  val approx_fw_sub :fw_pol -> fw_pol -> fw_pol -> fw_pol -> fw_pol * fw_pol
  val fw_mul : fw_pol -> fw_pol -> fw_pol
  val fw_div : fw_pol -> fw_pol -> fw_pol
(*  val fw_mult : fw_pol -> fw_pol -> fw_pol -> fw_pol list*)
  val fw_divide :fw_pol -> fw_pol -> fw_pol -> fw_pol list
  val approx_fw_mult :fw_pol ->fw_pol ->fw_pol -> fw_pol -> fw_pol * fw_pol
  val approx_fw_div :fw_pol ->fw_pol ->fw_pol -> fw_pol -> fw_pol * fw_pol
  val approx_fw_inv :fw_pol -> fw_pol -> fw_pol * fw_pol
  val approx_fw_pow : float ->fw_pol -> fw_pol -> fw_pol * fw_pol
  val approx_fw_sqrt :fw_pol -> fw_pol -> fw_pol * fw_pol
  val compose_fw_approx_for_eval :fw_pol -> transc_approx -> fw_pol
  val eval_fw : (positive, num_i) Hashtbl.t -> fw_pol -> num_i
  val vars_of_fw : fw_pol -> positive list
end

module Make : functor 
(N: Numeric.T) -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> functor 
(P: Polynomial.T with type num_i = N.t and type interval = I.interval) -> T with type num_i = N.t and type positive = P.positive and type interval = I.interval and type transc_approx = P.transc_approx and type fw_pol = P.fw_pol and type pol = P.pol and type cert_itv = P.cert_itv
