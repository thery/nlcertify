module type T = sig
  type num_i
  type positive
  type pol
  type fold_poly_tree
  val deriv_T_aux : positive -> (pol * positive, fold_poly_tree) Hashtbl.t -> fold_poly_tree -> fold_poly_tree
  val simpl : fold_poly_tree -> fold_poly_tree
  val deriv_T : positive -> (pol * positive, fold_poly_tree) Hashtbl.t -> bool -> fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  val deriv2_T : positive -> positive -> (pol * positive, fold_poly_tree) Hashtbl.t -> bool -> fold_poly_tree -> fold_poly_tree
  type grad = Grad of fold_poly_tree array
  type hess = Hess of fold_poly_tree array array
  val grad_zero_T : int -> grad
  val hessian_zero_T : int -> hess
  val grad_T : positive array -> (pol * positive, fold_poly_tree) Hashtbl.t -> fold_poly_tree -> fold_poly_tree -> bool -> grad
  val hessian_T : positive array -> (pol * positive, fold_poly_tree) Hashtbl.t -> fold_poly_tree -> bool -> hess
  val proj_grad_T : int -> positive -> num_i -> grad -> grad
  val proj_hess_T : int -> positive -> num_i -> hess -> hess
end

module Make : functor 
(N: Numeric.T) -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> functor 
(P: Polynomial.T with type num_i = N.t) -> functor 
(F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) ->  functor 
(M: Mesh_interval.T with type num_i = N.t and type interval = I.interval) -> functor 
(A: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node = F.node and type inter_mut = I.inter_mut) -> functor 
(O: Operations.T with type num_i = N.t and type pol = P.pol and type fold_poly_tree = A.fold_poly_tree and type positive = P.positive) -> T with type num_i = N.t and type positive = P.positive and type pol = P.pol and type fold_poly_tree = A.fold_poly_tree
 
