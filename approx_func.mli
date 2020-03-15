module type T = 
sig
  type num_i
  type positive
  type transc_approx
  type f
  type fw_pol
  type interval

  val rel_tol_arg : num_i
  val abs_tol_arg : num_i
  val rope_of_chord : num_i -> num_i -> (num_i -> num_i) -> num_i
  val coeff_origine : num_i -> num_i -> (num_i -> num_i) -> num_i
  val get_chord_equation : num_i -> num_i -> (num_i -> num_i) -> transc_approx
  val get_tangent_equation : num_i -> (num_i -> num_i) -> (num_i -> f) -> transc_approx
  val get_osc_par_eq : num_i -> (num_i -> num_i) -> (num_i -> f) -> num_i -> transc_approx
  val get_cubic_eq : num_i -> (num_i -> num_i) -> (num_i -> f) -> (num_i -> f) -> num_i -> transc_approx
  val delta_func_tan : (num_i -> num_i) -> num_i -> num_i -> num_i -> bool
  val compose_fw_approx : fw_pol -> transc_approx -> fw_pol
  val combine_fw_tan_chords : bool -> transc_approx list -> fw_pol -> fw_pol
  val get_tangent : (num_i -> num_i) -> (num_i -> f) -> num_i -> num_i -> int -> int -> transc_approx
  val get_tangents_aux : (num_i -> num_i) -> (num_i -> f) -> num_i -> num_i -> int -> int -> bool -> transc_approx list
  val get_tangents : (num_i -> num_i) -> (num_i -> f) -> interval -> int -> bool -> transc_approx list
(*  val get_tan_osc_aux : (num_i -> num_i) -> (num_i -> f) -> (interval ->
 *  num_i) -> (interval -> num_i) -> interval -> bool -> bool -> num_i ->
 *  transc_approx * transc_approx*)
  val get_tan_osc :  (num_i -> num_i) -> (num_i -> f) -> bool -> bool -> (interval -> num_i) -> (interval -> num_i) -> interval -> num_i list -> transc_approx list * transc_approx list
  val get_chord : (num_i -> num_i) -> num_i -> num_i -> int -> int -> transc_approx
  val get_chords_aux : (num_i -> num_i) -> num_i -> num_i -> int -> int -> transc_approx list
  val get_chords : (num_i -> num_i) -> interval -> int -> transc_approx list
  val check_approx_s : string -> interval -> transc_approx list -> transc_approx list -> interval * interval
  val add_argmins_with_eval : string -> interval -> transc_approx list -> transc_approx list -> num_i list ref -> unit
  val mk_approx : (num_i -> num_i) -> (num_i -> f) -> bool -> bool -> fw_pol -> interval -> (interval -> num_i) -> (interval -> num_i) -> positive list -> num_i list list -> num_i list ref -> bool -> transc_approx list * transc_approx list
  val mk_approx_rec : string -> (num_i -> num_i) -> (num_i -> f) -> bool -> bool -> fw_pol -> interval -> (interval -> num_i) -> (interval -> num_i) -> positive list -> num_i list list -> num_i list ref -> int -> transc_approx list * transc_approx list
  val approx_transc_with_poly : string -> fw_pol -> fw_pol -> (num_i -> num_i) -> (num_i -> f) -> (interval -> num_i) -> (interval -> num_i) -> (interval -> bool) list -> interval  -> positive list -> num_i list list -> (fw_pol * fw_pol) * (interval * interval)
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
(O: Oracle.T with type num_i = N.t and type positive = P.positive and type pol = P.pol with type term = P.term and type val_tbl = A.val_tbl) -> functor 
(S: Sollya.T with type num_i = N.t and type interval = I.interval) -> functor
(Tb: Algo_tables.T with type num_i = N.t and type p = P.positive and type eval_tbl = A.eval_tbl and type fw_tbl = A.fw_tbl) -> T with type num_i = N.t and type positive = P.positive and type transc_approx = Fu.transc_approx and type f = Fun.f and type fw_pol = P.fw_pol and type interval = I.interval

 
