module type T = 
sig
  type num_i
  type interval 
  type inter_mut 
  type pol 
  type node 
  type fw_pol 
  type cert_pop
  type fold_poly_tree =
      Varloc of string * inter_mut
    | Pol of pol * inter_mut
    | Br_poly of node * fold_poly_tree list
  type poly_interval =
      Poly_Int of (fw_pol * fw_pol)
    | Bool_Int of bool
  type val_tbl = (fw_pol * fw_pol) * (num_i * num_i)
  type eval_tbl = (string, val_tbl) Hashtbl.t
  type rewrite_tbl = (string, poly_interval) Hashtbl.t
  type fw_tbl = (fold_poly_tree * int, poly_interval) Hashtbl.t
  type algo_semi_alg =
    ?incr_cliques:bool ->
    ?incr_relax_order:bool ->
    ?relax_order:int ->
    ?force:bool ->
    eval_tbl ->
    fw_pol ->
    pol list -> pol list -> fw_pol list ->
    bool -> bool -> bool -> num_i * num_i * num_i list * num_i list * pol * cert_pop
  val get_result : fw_pol * fw_pol -> poly_interval
  val list_result :(fw_pol * fw_pol) list -> poly_interval list
  val get_pmin : poly_interval -> fw_pol
  val get_pmax : poly_interval -> fw_pol
  val string_of_poly : pol -> string
  val string_fold_tree : fold_poly_tree -> string
  val string_T : fold_poly_tree -> string
  val string_float_T : int -> fold_poly_tree -> string
  val string_of_poly_interval : poly_interval -> string
  val interval_of_poly_interval : poly_interval -> interval
  val ipi : poly_interval -> interval
  val ipi_of_list : poly_interval list -> interval
  val fpt_nodes : fold_poly_tree -> int
  val fpt_nodes_list : fold_poly_tree list -> int
  val fpt_leaves_nodes : fold_poly_tree -> int
  val fpt_leaves_nodes_list : fold_poly_tree list -> int
  val depth_aux : 'a -> ('a -> 'b -> 'a) -> 'b list -> 'a
  val depth : fold_poly_tree -> int
  val branches_T : fold_poly_tree -> fold_poly_tree list
  val interv_at_node : fold_poly_tree -> interval
  val assign_interv_tree : interval -> fold_poly_tree -> unit
  val ait : interval -> fold_poly_tree -> unit
  val aipi : interval -> poly_interval -> poly_interval
end
module Make: functor 
(N: Numeric.T) -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> functor 
(Ft: Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) -> functor 
(P: Polynomial.T with type num_i = N.t) -> functor 
(Fu:Fw_utils.T with type num_i = N.t and type interval = I.interval and type fw_pol = P.fw_pol) -> T with type num_i = N.t and type interval = I.interval and type inter_mut = I.inter_mut and type pol = P.pol and type node = Ft.node and type fw_pol = P.fw_pol and type cert_pop = P.cert_pop

