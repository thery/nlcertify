module type T =
sig
  type num_i 
  type positive 
  type interval
  type fold_poly_tree 
  type algo_semi_alg 
  type fw_pol 
  type taylor_model
  type poly_interval
  type eval_tbl 
  type rewrite_tbl 
  type x0_cmp

  module H :
  sig
    type key = fold_poly_tree * int
    type 'a t
    val create : int -> 'a t
    val clear : 'a t -> unit
    val reset : 'a t -> unit
    val copy : 'a t -> 'a t
    val add : 'a t -> key -> 'a -> unit
    val remove : 'a t -> key -> unit
    val find : 'a t -> key -> 'a
    val find_all : 'a t -> key -> 'a list
    val replace : 'a t -> key -> 'a -> unit
    val mem : 'a t -> key -> bool
    val iter : (key -> 'a -> unit) -> 'a t -> unit
    val fold :(key -> 'a -> 'b -> 'b) ->'a t -> 'b -> 'b
    val length : 'a t -> int
    val stats : 'a t -> Hashtbl.statistics
  end
  val tbl_hess_I :(taylor_model, interval array array) Hashtbl.t
  val main_tbl : poly_interval H.t
  val add_cuts_algo :algo_semi_alg -> eval_tbl -> rewrite_tbl -> (fold_poly_tree, taylor_model * x0_cmp * num_i * num_i * fw_pol list * fw_pol list) Hashtbl.t -> fold_poly_tree -> num_i list -> positive array ->
(num_i * num_i) list -> int -> bool -> unit
  val recut : algo_semi_alg -> num_i list list -> fold_poly_tree -> eval_tbl -> rewrite_tbl -> (fold_poly_tree, taylor_model * x0_cmp * num_i * num_i * fw_pol list * fw_pol list) Hashtbl.t -> positive array -> (num_i * num_i) list -> int -> bool -> poly_interval
end

module Make : functor
  (N: Numeric.T) -> functor 
  (Fun: Functions.T with type num_i = N.t) -> functor 
  (U: Tutils.T with type t = N.t) -> functor 
  (I: Interval.T with type num_i = N.t and type f = Fun.f) -> functor
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval) -> functor
  (Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval) -> functor
  (F:Flyspeck_types.T with type  num_i = N.t and type inter_mut = I.inter_mut) -> functor 
  (Ty: Algo_types.T with type  num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node   = F.node and type inter_mut = I.inter_mut and type interval = I.interval) -> functor
  (Tb: Algo_tables.T with type num_i = N.t and type p = P.positive and type eval_tbl = Ty.eval_tbl and type fw_tbl = Ty.fw_tbl) -> functor 
  (O: Operations.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Tb.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive  and type rewrite_tbl = Ty.rewrite_tbl) -> functor 
  (Approx : Approx_func.T with type  num_i = N.t and type positive = P.positive and type f = Fun.f and type  interval = I.interval and type fw_pol = P.fw_pol) -> functor 
  (Ia : Interval_arith.T  with type num_i = N.t and type positive = P.positive and type interval = I.interval and type eval_tbl = Ty.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type algo_semi_alg = Ty.algo_semi_alg) -> functor 
  (Tm : Taylor_cut.T with type num_i =  N.t and type positive = P.positive and type interval = I.interval and type fw_pol = P.fw_pol and type  eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type algo_semi_alg = Ty.algo_semi_alg and type fold_poly_tree = Ty.fold_poly_tree) -> T with type num_i = N.t and type positive = P.positive and type interval = I.interval and type fold_poly_tree = Ty.fold_poly_tree and type algo_semi_alg = Ty.algo_semi_alg and type eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type poly_interval = Ty.poly_interval and type fw_pol = P.fw_pol and type taylor_model = Tm.taylor_model and type x0_cmp = Tm.x0_cmp 
