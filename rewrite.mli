module type T = 
sig
  type func_tree 
  type fold_poly_tree 
  type poly_interval 
  type pol 
  val atan2_to_atn : (fold_poly_tree -> poly_interval list) -> fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  val fold_poly : (fold_poly_tree -> poly_interval list) -> (string, pol) Hashtbl.t -> bool -> func_tree -> fold_poly_tree
  val extract_tame_hypermap : func_tree -> func_tree * func_tree
end

module Make: functor 
(N: Numeric.T) -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> functor 
(P: Polynomial.T with type num_i = N.t) -> functor 
(Fu: Fw_utils.T with type num_i = N.t and type fw_pol = P.fw_pol) -> functor 
(F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) -> functor 
(E:Unfold_eval_tree.T with type num_i = N.t and type func_tree = F.func_tree) -> functor 
(A: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node = F.node and type inter_mut = I.inter_mut and type interval = I.interval) -> functor 
(O: Operations.T with type num_i = N.t and type fold_poly_tree = A.fold_poly_tree) ->  T with type func_tree = F.func_tree and type fold_poly_tree = A.fold_poly_tree and type poly_interval = A.poly_interval and type pol = P.pol

