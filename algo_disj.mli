module type T = 
sig
  type num_i 
  type positive
  type interval 
  type cert_itv
  type fold_poly_tree 
  type algo_semi_alg 
  type eval_tbl 
  type rewrite_tbl 
  type fw_tbl 
  type poly_interval 
  type pol
  type fw_pol 
  type taylor_model
  type x0_cmp
  val br_count : int ref
  val br_tbl : (fold_poly_tree, int ref) Hashtbl.t
  val eval_ref : interval ref
  val clean_tree : fold_poly_tree -> fold_poly_tree
  val sqr_optim_guess : num_i list -> bool -> num_i list
  val algo_semi_alg : algo_semi_alg -> int -> pol list -> fold_poly_tree -> eval_tbl -> rewrite_tbl ->   (fold_poly_tree, taylor_model * x0_cmp * num_i * num_i * fw_pol list * fw_pol list) Hashtbl.t ->  positive list -> (num_i * num_i) list -> num_i list list -> bool -> int -> poly_interval list
  val algo_bundle_aux : (fold_poly_tree -> num_i list list -> int -> poly_interval list) -> algo_semi_alg -> pol list -> eval_tbl -> int -> num_i list list -> num_i -> fold_poly_tree -> int -> num_i list ref -> cert_itv -> fw_pol -> num_i * num_i list * cert_itv * fw_pol
  val algo_optim : algo_semi_alg -> pol list -> eval_tbl -> rewrite_tbl -> positive list -> fold_poly_tree -> num_i list list -> (num_i * num_i) list -> num_i list ref -> interval * num_i list * fw_pol
end

module Make : functor 
(N: Numeric.T) -> functor 
(Fun: Functions.T with type num_i = N.t) -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t and type f = Fun.f) ->  functor 
(P: Polynomial.T with type num_i = N.t and type interval = I.interval) -> functor 
(Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval and type cert_itv = P.cert_itv) -> functor 
(F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) -> functor 
(Ty: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node = F.node and type inter_mut = I.inter_mut and type interval = I.interval and type cert_pop = P.cert_pop) -> functor 
(Tb: Algo_tables.T with type num_i = N.t and type p = P.positive and type eval_tbl = Ty.eval_tbl and type fw_tbl = Ty.fw_tbl) ->  functor 
(O: Operations.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Tb.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive and type rewrite_tbl = Ty.rewrite_tbl) -> functor 
(Approx : Approx_func.T with type num_i = N.t and type positive = P.positive and type f = Fun.f and type interval = I.interval and type fw_pol = P.fw_pol) -> functor 
  (Ia : Interval_arith.T with type num_i = N.t and type positive = P.positive and type interval = I.interval and type eval_tbl = Ty.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type algo_semi_alg = Ty.algo_semi_alg) -> functor
(Tm : Taylor_cut.T with type num_i = N.t and type positive = P.positive and type fw_pol = P.fw_pol and type eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type algo_semi_alg = Ty.algo_semi_alg and type fold_poly_tree = Ty.fold_poly_tree) -> functor                                                                                                (Template : Template.T with type num_i =  N.t and type positive = P.positive and type fw_pol = P.fw_pol and type  eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type algo_semi_alg = Ty.algo_semi_alg and type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type taylor_model = Tm.taylor_model and type x0_cmp = Tm.x0_cmp ) -> functor
(S : Sparsepop.T with type num_i = N.t) -> T with type num_i = N.t and type positive = P.positive and type interval = I.interval and type fold_poly_tree = Ty.fold_poly_tree and type algo_semi_alg = Ty.algo_semi_alg and type eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type fw_tbl = Ty.fw_tbl and type poly_interval = Ty.poly_interval and type fw_pol = P.fw_pol and type taylor_model = Tm.taylor_model and type x0_cmp = Tm.x0_cmp and type pol = P.pol and type cert_itv = P.cert_itv
