module type T = 
sig
  type num_i 
  type interval 
  type fw_pol
  type algo_semi_alg
  type taylor_model 
  type x0_cmp
  type positive
  type fold_poly_tree
  type func_tree
  type cut = No_cut | Cut of num_i list
  val hard_boxes : (num_i * num_i) list list ref
  val x0_cut_n : int ref
  val bool_of_cut : cut -> bool
  val pbs_solved : int ref
  val n_cuts : int ref
  val x0_of_cut : cut -> num_i list
  val x0_cut_tbl : (num_i list, int ref) Hashtbl.t
  val pop_sym : bool array
  val cuts_heur_max : int
  val tol_tight : num_i
  val tol_min : num_i
  val tol_r : num_i
  val tol_r_rect : num_i
  val tol_tm2 : num_i
  val get_rect_cut_tm2 : algo_semi_alg -> string list -> positive list -> fold_poly_tree -> taylor_model -> x0_cmp -> (num_i * num_i) list -> num_i array -> num_i -> num_i -> int -> (num_i * num_i) list * (num_i * num_i) list list list
  val stretch_cube : algo_semi_alg -> string list -> positive list -> fold_poly_tree -> taylor_model -> x0_cmp -> (num_i * num_i) list -> num_i -> (num_i * num_i) list list
  val get_cut_tm2 : algo_semi_alg -> string list ->  positive list -> fold_poly_tree  -> taylor_model -> x0_cmp -> (num_i * num_i) list -> num_i -> num_i -> (num_i * num_i) list list
  val algo_cut : taylor_model -> algo_semi_alg -> string list -> positive list -> fold_poly_tree -> (num_i * num_i) list -> int -> int ref -> cut -> interval
  val init_algo_cut : func_tree -> func_tree -> string list -> (num_i * num_i) list -> bool -> bool -> in_channel -> out_channel -> int -> interval * interval
  val custom_algo_cut :  bool -> bool -> in_channel -> out_channel -> int -> interval * interval
end

module Make :  
  functor (N: Numeric.T) -> 
  functor (Fun: Functions.T with type num_i = N.t) -> 
  functor (U: Tutils.T with type t = N.t) -> 
  functor (I: Interval.T with type num_i = N.t and type f = Fun.f) ->  
  functor (M: Mesh_interval.T with type num_i = N.t and type interval = I.interval) -> 
  functor (P: Polynomial.T with type num_i = N.t and type interval = I.interval) -> 
  functor (Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval) ->
  functor (F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) -> 
  functor (Ty: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node = F.node and type inter_mut = I.inter_mut and type interval = I.interval and type cert_pop = P.cert_pop) ->  
 functor (R: Rewrite.T with type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type pol = P.pol and type func_tree = F.func_tree) -> 
  functor (Tb: Algo_tables.T with type num_i = N.t and type p = P.positive and type pol = P.pol with type eval_tbl = Ty.eval_tbl and type fw_tbl = Ty.fw_tbl and type p = P.positive) ->  
  functor (O: Operations.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Tb.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive and type rewrite_tbl = Ty.rewrite_tbl) -> 
  functor (Approx : Approx_func.T with type num_i = N.t and type f = Fun.f and type interval = I.interval and type fw_pol = P.fw_pol) -> 
  functor (Tm : Taylor_cut.T with type num_i = N.t and type positive = P.positive and type fw_pol = P.fw_pol and type algo_semi_alg = Ty.algo_semi_alg and type eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type fold_poly_tree = Ty.fold_poly_tree with type positive = P.positive) ->
  functor (Sergei: Sergei.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Ty.eval_tbl and type val_tbl = Ty.val_tbl  ) -> 
  functor (Sparsepop : Sparsepop.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type eval_tbl = Ty.eval_tbl and type val_tbl = Ty.val_tbl and type rt = Fu.relax_type and type cert_pop = P.cert_pop) ->
  functor (Oracle: Oracle.T with type num_i = N.t and type pol = P.pol with type term = P.term) ->
  functor (A: Algo_disj.T with type num_i = N.t and type positive = P.positive and type interval = I.interval and type algo_semi_alg = Ty.algo_semi_alg and type eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type fold_poly_tree = Ty.fold_poly_tree) -> T with type num_i = N.t and type interval = I.interval and type fw_pol = P.fw_pol and type algo_semi_alg = Ty.algo_semi_alg and type taylor_model = Tm.taylor_model and type x0_cmp = Tm.x0_cmp and type positive = P.positive and type fold_poly_tree = Ty.fold_poly_tree and type func_tree = F.func_tree

 
