module type T =
sig
  type num_i
  val _pr_ : string -> bool -> bool -> unit
  type term =
    Zero
    | Const of num_i
    | Var of string
    | Inv of term
    | Opp of term
    | Add of (term * term)
    | Sub of (term * term)
    | Mul of (term * term)
    | Div of (term * term)
    | Pow of (term * int)
  val simpl_term : term -> string
  val is_add_term : term -> bool
  val is_opp_term : term -> bool
  val is_fst_opp_term : term -> bool
  val is_zero_term : term -> bool
  val is_one_term : term -> bool
  val is_minus_one_term : term -> bool
  val is_const_term : term -> bool
  val opp_term : term -> term
  val cancel_opp_term : term -> term
  val mul_of_pow_term : term -> int -> term
  val add_term : term -> term -> term
  val mul_term : term -> term -> term
  val fold_add_term : term list -> term
  val fold_mul_term : term list -> term
  val mul_term_list : term list -> term -> term list
  val expand_term : term -> term
  val unfold_add_term : term -> term list
  val unfold_mul_term : term -> term list
  val exp_term : term -> term
  val string_of_term : term -> (num_i -> string) -> string
  val output_term : out_channel -> term -> unit

  (** e is a find function: finds in a hashtbl the value of the argument (which is a key) **)
                                             
  type positive = Numbers.T.positive

  val jump : positive -> (positive -> 'a) -> positive -> 'a
  val nth_jump : (positive -> 'a) -> positive -> 'a
  val hd_jump  : (positive -> 'a) -> 'a
  val tl_jump  : (positive -> 'a) -> positive -> 'a

  type pol =
      Pc of num_i
    | Pinj of positive * pol
    | PX of pol * positive * pol
  type transc_approx =
      Minimax of num_i list
    | Cub of num_i * num_i * num_i * num_i * num_i
    | Par of num_i * num_i * num_i * num_i
    | Tan of num_i * num_i
  type interval
  type sos_block = Sos_block of int * pol 
  type kkt = Sos of sos_block array | Eq_coeff of pol | L1 of pol
  type putinar_psatz = Putinar_psatz of ((kkt * int) array)
  type cert_pop = Cert_pop of pol * num_i array * putinar_psatz
  type cert_itv = cert_pop * cert_pop
  val cert_pop_null : cert_pop
  val cert_null : cert_itv
  val mk_cert_pop : pol -> num_i array -> putinar_psatz -> cert_pop
  type fw_pol = 
    | Pw of pol * interval * cert_itv
    | Fw of (fw_pol * fw_pol) * interval * cert_itv
    | Min of ( fw_pol list) * interval * cert_itv
    | Max of (fw_pol list) * interval * cert_itv
    | Plus of (fw_pol * fw_pol) * interval * cert_itv
    | Mult of (fw_pol * fw_pol) * interval * cert_itv
    | Minus of fw_pol * interval
    | Sqrt of fw_pol * interval
    | Comp of (transc_approx * fw_pol) * interval * cert_itv
    | MaxMin of (fw_pol * fw_pol) * interval * cert_itv
   val degree_pol : pol -> int
  val degree_approx : transc_approx -> int
  val is_degree_one : pol -> bool
  val p0 : num_i -> pol
  val p1 : num_i -> pol
  val peq : pol -> pol -> bool
  val mkPinj : positive -> pol -> pol
  val mkPinj_pred : positive -> pol -> pol
  val mkPX : pol -> positive -> pol -> pol
  val mkXi : positive -> pol
  val mkX : pol
  val popp : pol -> pol
  val paddC : pol -> num_i -> pol
  val psubC : pol -> num_i -> pol
  val paddI : (pol -> pol -> pol) -> pol -> positive -> pol -> pol
  val psubI : (pol -> pol -> pol) -> pol -> positive -> pol -> pol
  val paddX : (pol -> pol -> pol) -> pol -> positive -> pol -> pol
  val psubX : (pol -> pol -> pol) -> pol -> positive -> pol -> pol
  val padd_counter : int ref
  val padd : pol -> pol -> pol
  val psub : pol -> pol -> pol
  val pmulC_aux : pol -> num_i -> pol
  val pmulC : pol -> num_i -> pol
  val pmulI : (pol -> pol -> pol) -> pol -> positive -> pol -> pol
  val pmul : pol -> pol -> pol
  val psquare : pol -> pol
  val approx_eq : transc_approx -> transc_approx -> bool
  val eval_p : (positive -> num_i) -> pol -> num_i
  val idx_of_varpol: pol -> positive
  val eval_pol : (positive, num_i) Hashtbl.t -> pol -> num_i
  val vars_of_pol : pol -> positive list
  val basic_pol_I : (string, 'a * (num_i * num_i)) Hashtbl.t -> pol -> interval
  val scale_pol : (positive, num_i * num_i) Hashtbl.t -> (positive * num_i) list -> pol -> bool -> pol * num_i
  val deriv_p : positive -> pol -> pol
  val eval_pol_num : positive -> num_i -> pol -> pol 
  val pol_norm_inf : pol -> num_i
  val monomials : pol -> pol list
  val string_of_horner : pol -> string
  val monomial_support : int -> pol -> int array * num_i
  val fw_contains_min_max : bool -> fw_pol -> bool
  val fw_contains_min : fw_pol -> bool
  val fw_contains_max : fw_pol -> bool
  val no_disj_pol : fw_pol -> bool
  val is_Fw : fw_pol -> bool
  val is_Plus : fw_pol -> bool
  val is_Mult : fw_pol -> bool
  val is_Sqrt : fw_pol -> bool
  val is_Max : fw_pol -> bool
  val is_Min : fw_pol -> bool
  val is_Minus : fw_pol -> bool
  val is_Comp : fw_pol -> bool
  val is_Pol : fw_pol -> bool
  val pol_of_fw : fw_pol -> pol
  val fweq : fw_pol -> fw_pol -> bool
  module Pretty_Print :
  sig
    val pp_positive : out_channel -> positive -> unit
    val pp_f : out_channel -> float -> unit
    val pp_pol : (out_channel -> num_i -> unit) -> out_channel -> pol -> unit
  end
  type n = Numbers.T.n
  type pExpr =
      PEc of num_i
    | PEX of positive
    | PEadd of pExpr * pExpr
    | PEsub of pExpr * pExpr
    | PEmul of pExpr * pExpr
    | PEopp of pExpr
    | PEpow of pExpr * n
  val mk_X : positive -> pol
  val ppow_pos : (pol -> pol) -> pol -> pol -> positive -> pol
  val ppow_N : (pol -> pol) -> pol -> n -> pol
  val monomial_product : positive list -> pol
  val norm_aux : pExpr -> pol
  val norm : pExpr -> pol
  val xdenorm : positive -> pol -> pExpr
  val denorm : pol -> pExpr
  val expr_to_term : pExpr -> term
  val mkX_i : int -> pol
  val p_subC : pol -> num_i -> pol
  val p_addC : pol -> num_i -> pol
  val p_mulC : pol -> num_i -> pol
  val p_opp : pol -> pol
  val p_add : pol -> pol -> pol
  val p_mul : pol -> pol -> pol
  val p_square : pol -> pol
  val p_sub : pol -> pol -> pol
  val p_pow : pol -> int -> pol
  val monomial_prod : positive list -> pol
  val monomial_sum : positive list -> pol
  val p_eq : pol -> pol -> bool
  val p_is_null : pol -> bool
  val fw_eq : fw_pol -> fw_pol -> bool
  val fw_neq : fw_pol -> fw_pol -> bool
  val fw_eq_sort : fw_pol -> fw_pol -> int
  val poly_func_list : (string * (pol -> pol -> pol)) list
  val deriv_pol : positive -> pol -> pol
  val grad_pol : positive array -> pol -> pol array
  val eval_grad_pol : (positive, num_i) Hashtbl.t -> pol array -> num_i array
  val poly_func : (string, pol -> pol -> pol) Hashtbl.t
  val term_of_pol : pol -> term
  val string_of_pol : pol -> string
  val string_of_pol_rat : pol -> string
  val string_of_pol_float : pol -> int -> string
  val string_of_pol_zarith : pol -> string
  val box_of_tbl : (string, num_i * num_i) Hashtbl.t -> positive list -> (num_i * num_i) list
  val string_of_pol_coq : pol -> string
  val change_vars_pol : positive list -> pol -> pol
end

module Make : functor (N: Numeric.T)  -> functor (U: Tutils.T with type t = N.t) -> functor (I: Interval.T with type num_i = N.t) -> T with type num_i = N.t and type interval = I.interval

