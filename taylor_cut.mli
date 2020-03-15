module type T = 
sig
  type num_i 
  type grad 
  type hess
  type pol 
  type fw_pol
  type interval 
  type algo_semi_alg 
  type fold_poly_tree
  type eval_tbl
  type rewrite_tbl
  type poly_interval
  type positive

  type xO = num_i list
  type lambda = Lm of num_i | LM of num_i
  type taylor_model = TM2 of xO * grad * hess * lambda * lambda
  type x0_cmp = X0_CMP of xO * num_i * num_i array * num_i array array * pol array * num_i * num_i
  val string_of_lambda : lambda -> string
  val string_of_cmp : x0_cmp -> string
  val cmp_of_x0 : x0_cmp -> xO * num_i * num_i array * num_i array array * pol array * num_i * num_i
  val hess_of_x0_cmp : x0_cmp -> num_i array array
  val x0_of_x0_cmp : x0_cmp -> xO
  val grad_of_x0_cmp : x0_cmp -> num_i array
  val f_of_x0_cmp : x0_cmp -> num_i
  val lambda_min_of_x0_cmp : x0_cmp -> num_i 
  val lambda_max_of_x0_cmp : x0_cmp -> num_i 
  val tm2_zero : int -> taylor_model
  val hess_of_tm2 : taylor_model -> fold_poly_tree array array
  val grad_of_tm2 : taylor_model -> fold_poly_tree array
  val eval_grad : taylor_model -> positive list -> num_i list -> eval_tbl -> rewrite_tbl -> num_i array
  val eval_hess : taylor_model -> positive list -> num_i list -> eval_tbl -> rewrite_tbl -> num_i array array
  val ia_grad : algo_semi_alg -> taylor_model -> eval_tbl -> (string, poly_interval) Hashtbl.t -> positive list ->  interval array
  val ia_hess : algo_semi_alg -> taylor_model -> eval_tbl -> (string, poly_interval) Hashtbl.t -> positive list -> interval array array
  val sym_hess_I : algo_semi_alg -> taylor_model -> eval_tbl -> (string, poly_interval) Hashtbl.t -> positive list -> interval array array
  val norm_with_hess : num_i -> num_i array array -> num_i array
  val norm_with_hess_using_sym : (num_i * num_i) list -> num_i -> num_i array array -> bool array -> num_i array
  val gen_H_bounds : num_i array array -> (num_i * num_i) list
  val gen_tau_bounds : num_i list -> num_i array -> num_i * num_i
  val cst_of_TM2 : num_i array -> num_i -> num_i array -> num_i array array -> num_i
  val delta_h : positive array -> num_i list -> pol array
  val inner_prod_num_pol : num_i array -> pol array -> pol
  val inner_prod_pol_pol : pol array -> pol array -> pol
  val norm_sqr_pol : pol array -> pol
  val mat_pol_prod : num_i array array -> pol array -> pol array
  val array_pol_prod : num_i array -> pol array -> pol array
  val lambda_min_of_hess : num_i array array -> num_i
  val lambda_max_of_hess : num_i array array -> num_i
  val initiate_tm2 : positive array -> fold_poly_tree -> fold_poly_tree -> bool -> taylor_model
  val proj_tm2 : int -> positive -> num_i -> taylor_model -> taylor_model
  val compute_grad_hess : positive array -> eval_tbl -> rewrite_tbl -> fold_poly_tree -> taylor_model -> xO -> num_i -> num_i -> x0_cmp
  val assign_lmin : num_i -> x0_cmp -> x0_cmp
  val assign_lmax : num_i -> x0_cmp -> x0_cmp
  val compute_lm_hx0 : x0_cmp -> num_i
  val compute_lambda_min : algo_semi_alg -> eval_tbl -> rewrite_tbl -> (taylor_model, interval array array ) Hashtbl.t -> taylor_model -> x0_cmp -> ?var_list:string list -> positive list -> ?sub_box:(num_i * num_i) list -> bool -> num_i * num_i
  val lin_pol_of_tm2 : algo_semi_alg  -> eval_tbl -> taylor_model -> x0_cmp -> ?var_list:string list -> positive list -> ?bounds: (num_i * num_i) list -> num_i array -> bool -> fw_pol * fw_pol * (num_i * num_i) list * (num_i * num_i) list list list
  val quadr_pol_of_tm2 : algo_semi_alg  -> eval_tbl -> taylor_model -> x0_cmp -> ?var_list:string list -> positive list -> ?bounds: (num_i * num_i) list -> num_i array -> bool -> fw_pol * fw_pol * (num_i * num_i) list * (num_i * num_i) list list list
  val pol_of_tm2 : algo_semi_alg  -> eval_tbl -> taylor_model -> x0_cmp -> ?var_list:string list -> positive list -> ?bounds: (num_i * num_i) list -> num_i array -> bool -> fw_pol * fw_pol * (num_i * num_i) list * (num_i * num_i) list list list
  val get_min_partition : (num_i * num_i) list list list -> (num_i * num_i) list list
end

module Make : functor 
(N: Numeric.T) -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> functor 
(M: Mesh_interval.T with type num_i = N.t and type interval = I.interval) -> functor 
(P: Polynomial.T with type num_i = N.t and type interval = I.interval) -> functor 
(Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval) -> functor 
(F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) -> functor 
(Ty: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol) -> functor 
(D: Derivatives.T with type num_i = N.t and type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive) -> functor 
(Tb: Algo_tables.T with type num_i = N.t and type p = P.positive and type eval_tbl = Ty.eval_tbl) -> functor 
(Ia : Interval_arith.T with type num_i = N.t and type positive = P.positive and type interval = I.interval and type eval_tbl = Ty.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type algo_semi_alg = Ty.algo_semi_alg) -> functor 
(C: Cut_box.T with type num_i = N.t) -> functor 
(O: Operations.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Tb.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive and type rewrite_tbl = Ty.rewrite_tbl) -> T 
with type num_i = N.t and type grad = D.grad and type hess = D.hess and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval and type algo_semi_alg = Ty.algo_semi_alg and type fold_poly_tree = Ty.fold_poly_tree and type eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type poly_interval = Ty.poly_interval and type positive = P.positive

