module type T =
sig
  type num_i
  type node
  type pol
  type fw_pol 
  type positive
  type fold_poly_tree 
  type eval_type
  type eval_tbl
  type rewrite_tbl

  val poly_T : pol -> fold_poly_tree
  val id_T : fold_poly_tree -> fold_poly_tree
  val const_T : num_i -> fold_poly_tree
  val zero_T : fold_poly_tree
  val one_T : fold_poly_tree
  val two_T : fold_poly_tree
  val four_T : fold_poly_tree
  val pi_T : fold_poly_tree
  val half_pi_T : fold_poly_tree
  val quarter_pi_T : fold_poly_tree
  val x_T : positive -> fold_poly_tree
  val fun_T : fold_poly_tree -> string -> fold_poly_tree
  val fun2_T : fold_poly_tree -> fold_poly_tree -> string -> fold_poly_tree
  val sin_T : fold_poly_tree -> fold_poly_tree
  val cos_T : fold_poly_tree -> fold_poly_tree
  val tan_T : fold_poly_tree -> fold_poly_tree
  val exp_T : fold_poly_tree -> fold_poly_tree
  val log_T : fold_poly_tree -> fold_poly_tree
  val atan_T : fold_poly_tree -> fold_poly_tree
  val is_const_T : fold_poly_tree -> bool
  val is_pol_T : fold_poly_tree -> bool
  val is_sqrt_lc_T : fold_poly_tree -> bool
  val kronecker_T : positive -> positive -> fold_poly_tree
  val add_T : fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  val is_add_T : fold_poly_tree -> bool
  val is_add_sub_T : fold_poly_tree -> bool
  val eq_n : node -> node -> bool
  val eq_T : fold_poly_tree -> fold_poly_tree -> bool
  val d_T : fold_poly_tree -> num_i
  val mul_T : fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  val sqrt_T : fold_poly_tree -> fold_poly_tree
  val minus_T : fold_poly_tree -> fold_poly_tree
  val sub_T : fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  val inv_T : fold_poly_tree -> fold_poly_tree
  val div_T : fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  val square_T : fold_poly_tree -> fold_poly_tree
  val pow_T :fold_poly_tree ->fold_poly_tree -> fold_poly_tree
  module Infixes : 
  sig
    val ( <+> ) :fold_poly_tree ->fold_poly_tree -> fold_poly_tree
    val ( <-> ) :fold_poly_tree ->fold_poly_tree -> fold_poly_tree
    val ( <*> ) :fold_poly_tree ->fold_poly_tree -> fold_poly_tree
    val ( </> ) :fold_poly_tree ->fold_poly_tree -> fold_poly_tree
    val ( <**> ) : fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  end
  val list_bop_T : (string *(fold_poly_tree -> fold_poly_tree -> fold_poly_tree)) list
  val tbl_bop_T : (string,fold_poly_tree -> fold_poly_tree -> fold_poly_tree) Hashtbl.t
  val create_T_table : unit
  val contains_fun_T : string -> fold_poly_tree -> bool
  val contains_inv_T : fold_poly_tree -> bool
  val contains_no_add_T : fold_poly_tree -> bool
  val unfold_T :string ->fold_poly_tree ->fold_poly_tree -> fold_poly_tree list
  val unfold_mul_T : fold_poly_tree -> fold_poly_tree list
  val unfold_add_T :fold_poly_tree -> fold_poly_tree list
  val fold_mul_T :fold_poly_tree list -> fold_poly_tree
  val fold_add_T :fold_poly_tree list -> fold_poly_tree
  val put_tbl_T :(fold_poly_tree, num_i) Hashtbl.t ->(num_i -> num_i -> num_i) -> fold_poly_tree -> unit
  val get_T :(num_i -> num_i -> num_i) ->fold_poly_tree * num_i -> fold_poly_tree
  val get_num_denum_T :fold_poly_tree -> fold_poly_tree * fold_poly_tree
  val simpl_T : fold_poly_tree -> fold_poly_tree
  val fold_simpl : fold_poly_tree -> fold_poly_tree
  val simpl1_T : fold_poly_tree -> fold_poly_tree
  val eval_aux : (positive, num_i) Hashtbl.t -> eval_tbl -> rewrite_tbl ->fold_poly_tree -> eval_type
  val eval_T : (positive, num_i) Hashtbl.t -> eval_tbl -> rewrite_tbl ->fold_poly_tree -> num_i
  val eval_T_num : positive -> num_i -> fold_poly_tree -> fold_poly_tree 
  val eval_T_numarray : positive array -> num_i array -> fold_poly_tree -> fold_poly_tree
  val is_semialg_T : fold_poly_tree -> bool 
  val vars_T : fold_poly_tree -> positive list 
  val min_heuristic :fold_poly_tree -> eval_tbl -> rewrite_tbl -> (num_i * num_i) list -> positive list -> num_i * num_i * num_i list
  val min_heuristic_disj :fold_poly_tree ->fold_poly_tree -> eval_tbl -> rewrite_tbl -> (num_i * num_i) list -> positive list -> num_i * num_i list * num_i * num_i list
end

module Make : functor 
(N: Numeric.T) -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> functor 
(P: Polynomial.T with type num_i = N.t) -> functor 
(Fu: Fw_utils.T with type num_i = N.t and type positive = P.positive and type fw_pol = P.fw_pol) -> functor 
(F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) -> functor 
(E:Unfold_eval_tree.T with type num_i = N.t) -> functor 
(A: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node = F.node and type inter_mut = I.inter_mut) -> functor
(Tb: Algo_tables.T with type num_i = N.t and type p = P.positive and type eval_tbl = A.eval_tbl and type fw_tbl = A.fw_tbl) -> T with type num_i = N.t and type fw_pol = P.fw_pol  and type node = F.node and type pol = P.pol and type positive = P.positive and type fold_poly_tree = A.fold_poly_tree and type eval_type = E.eval_type and type eval_tbl = A.eval_tbl and type rewrite_tbl = A.rewrite_tbl
 
