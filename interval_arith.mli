module type T = 
sig
  type num_i 
  type positive
  type pol 
  type fw_pol
  type eval_tbl
  type eval_interv_type 
  type poly_interval 
  type fold_poly_tree 
  type interval
  type algo_semi_alg
  val interval_T : algo_semi_alg -> eval_tbl -> (pol * int, eval_interv_type) Hashtbl.t -> (string, poly_interval) Hashtbl.t -> positive list -> fold_poly_tree -> bool -> interval
end

module Make : functor 
(N: Numeric.T) -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) ->  functor 
(P: Polynomial.T with type num_i = N.t and type interval = I.interval) ->  functor 
(F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) -> functor 
(Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval) -> functor
(E:Unfold_eval_tree.T with type num_i = N.t and type func_tree = F.func_tree and type interval = I.interval) ->  functor 
(A: Algo_types.T with type num_i = N.t and type node = F.node and type inter_mut = I.inter_mut and type interval = I.interval and type pol = P.pol and type fw_pol = P.fw_pol) -> functor 
(T: Algo_tables.T with type num_i = N.t and type p = P.positive and type eval_tbl = A.eval_tbl) -> T with type num_i = N.t and type positive = P.positive and type pol = P.pol  and type fw_pol = P.fw_pol and type eval_tbl = A.eval_tbl and type eval_interv_type = E.eval_interv_type and type poly_interval = A.poly_interval and type fold_poly_tree = A.fold_poly_tree and type interval = I.interval and type algo_semi_alg = A.algo_semi_alg
 

