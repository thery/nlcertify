module type T = sig
  type positive
  type num_i
  type numq
  type polf
  type polq
  type pexprq
  type cert_pop
  val mk_coq_cert :  polq -> polq list -> polq list -> polq list ->  numq list -> numq list -> (num_i array * num_i array array) array -> ((int list) array array) array -> num_i array array -> ((int list) array array) array -> num_i -> numq -> int array -> bool -> string -> (polq list) * pexprq * polq * numq * cert_pop
end

module Make : functor 
  (N: Numeric.T)-> functor 
  (U: Tutils.T with type t = N.t) -> functor
  (M: Mesh_interval.T with type num_i = N.t) -> functor 
  (I: Interval.T with type num_i = N.t) -> functor
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval)-> functor
  (Nq: Numeric.T) -> functor
  (Uq: Tutils.T with type t = Nq.t) -> functor
  (Mq: Mesh_interval.T with type num_i = Nq.t) -> functor
  (Iq: Interval.T with type num_i = Nq.t) -> functor
  (Pq: Polynomial.T with type num_i = Nq.t and type interval = Iq.interval)-> T with type num_i = N.t and type numq = Nq.t and type positive = P.positive and type polf = P.pol and type polq = Pq.pol and type pexprq = Pq.pExpr and type cert_pop = Pq.cert_pop
