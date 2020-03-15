
module Make 
  (N: Numeric.T) 
  (Fun: Functions.T with type num_i = N.t) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t and type f = Fun.f)  
  (M: Mesh_interval.T with type num_i = N.t and type interval = I.interval) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval) 
  (Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval)
  (F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) 
  (Ty: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node = F.node and type inter_mut = I.inter_mut and type interval = I.interval and type cert_pop = P.cert_pop)  
  (R: Rewrite.T with type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type pol = P.pol and type func_tree = F.func_tree) 
  (Tb: Algo_tables.T with type num_i = N.t and type interval = I.interval and type pol = P.pol with type eval_tbl = Ty.eval_tbl and type fw_tbl = Ty.fw_tbl and type p = P.positive)  
  (O: Operations.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Tb.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive and type rewrite_tbl = Ty.rewrite_tbl) 
  (Approx : Approx_func.T with type num_i = N.t and type f = Fun.f and type interval = I.interval and type fw_pol = P.fw_pol) 
  (Ia : Interval_arith.T with type num_i = N.t and type interval = I.interval and type positive = P.positive and type interval = I.interval and type eval_tbl = Ty.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type algo_semi_alg = Ty.algo_semi_alg)
  (Tm : Taylor_cut.T with type num_i = N.t and type interval = I.interval and type pol = P.pol and type fw_pol = P.fw_pol and type algo_semi_alg = Ty.algo_semi_alg and type eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type fold_poly_tree = Ty.fold_poly_tree with type positive = P.positive and type poly_interval = Ty.poly_interval)
  (Sergei: Sergei.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Ty.eval_tbl and type val_tbl = Ty.val_tbl  ) 
  (Sparsepop : Sparsepop.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type eval_tbl = Ty.eval_tbl and type val_tbl = Ty.val_tbl and type rt = Fu.relax_type and type cert_pop = P.cert_pop)
  (Oracle: Oracle.T with type num_i = N.t and type pol = P.pol with type term = P.term)
  = struct 

    type num_i = N.t
    type interval = I.interval
    type fw_pol = P.fw_pol
                    
    type algo_semi_alg = Ty.algo_semi_alg
    type taylor_model = Tm.taylor_model 
    type x0_cmp = Tm.x0_cmp
    type positive = P.positive
    type fold_poly_tree = Ty.fold_poly_tree
    type func_tree = F.func_tree
    type poly_interval = Ty.poly_interval

(* Decomposition of t(x, epsilon) as follows:
 * t = t_linear + t_nonlinear, where t_linear = epsilon^T * [(grad_epsilon t)] (x, 0)  
 * t_linear shall be precisely bounded with SOS while t_nonlinear is bounded using interval arithmetics
 * *)
    let decompose t vars n_exact tm2 = 
      let grad_xepsilon = Tm.grad_of_tm2 tm2 in
      let n_float = Array.length vars in
      let grad_epsilon = Array.sub grad_xepsilon n_exact (n_float - n_exact) in
      let epsilons = Array.sub vars n_exact (n_float - n_exact) in
      let zeros = M.init_array (n_float - n_exact) in
      let grad_epsilon_0 = Array.map (O.eval_T_numarray epsilons zeros) grad_epsilon in
      let epsilons_T = Array.map O.x_T epsilons in
      let t_linear = M.inner_product_general grad_epsilon_0 epsilons_T O.add_T O.mul_T O.zero_T in
      let t_nonlinear = O.sub_T t t_linear in
        U.debug (Ty.string_float_T 10 t_linear);
        U.debug (Ty.string_float_T 10 t_nonlinear);
       t_linear, t_nonlinear
  end
