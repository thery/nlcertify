module type T = sig
  type num_i 
  type positive
  type pol 
  type fw_pol 
  type term 
  type val_tbl 
  type eval_tbl 
  type rt
  type bound
  type cert_pop
  exception Unbounded
  exception Scale_refine
  val pt_s : string
  val eq_s : string
  val le_s : string
  val ge_s : string
  val param : string -> int -> int -> string
  val mk_param_sdpa : int -> unit
  val gen_param_pop : int -> int -> string
  val gen_output_s : string -> string
  val minor_var : pol -> num_i -> (positive, num_i * num_i) Hashtbl.t -> string
  val major_var : pol -> num_i -> (positive, num_i * num_i) Hashtbl.t -> string
  val fix_var : pol -> num_i -> (positive, num_i * num_i) Hashtbl.t -> string
  val bound_meth_box : pol -> num_i -> num_i -> (positive, num_i * num_i) Hashtbl.t -> string
  val equals_cstr : pol -> pol -> string
  val equals_cstr_term : term -> term -> string
  val major_cstr : pol -> pol  -> string
  val minor_cstr : pol -> pol  -> string
  val norm_meth_box : pol -> pol -> num_i -> num_i -> string
  val write_sparsepop_problem : fw_pol -> pol list -> pol list -> fw_pol list -> (string, val_tbl) Hashtbl.t -> bool -> out_channel -> string -> rt (*-> num_i list *)-> num_i * int * int list
  val parse_aux : string -> int -> num_i * num_i
  val parse_optimum : string -> int list -> num_i list * num_i list
  exception UnfeasPOP of string
  val parse_sparsepop_output_aux : string -> int list -> num_i * num_i * num_i list * num_i list * string * num_i * num_i
  val read_oc_in : Unix.file_descr -> string list
  val parse_sparsepop_output : in_channel -> int list -> num_i * num_i * num_i list * num_i list * string * num_i * num_i
val get_bound_poly_conj : fw_pol -> pol list ->  pol list -> fw_pol list ->  (string, val_tbl) Hashtbl.t -> bool -> in_channel -> out_channel -> int -> int -> rt (*-> num_i list*) -> num_i * num_i * num_i list * num_i list * num_i
  val get_bound_poly_conj_sparsepopcpp : fw_pol -> pol list -> pol list ->  fw_pol list ->  (string, val_tbl) Hashtbl.t -> bool -> in_channel -> out_channel -> int -> int -> rt (*-> num_i list*) -> bool -> num_i * num_i * num_i list * num_i list * num_i * pol * cert_pop
  val get_bound_poly : bool -> bool -> fw_pol -> pol list ->  pol list -> fw_pol list ->  (string, val_tbl) Hashtbl.t -> bool -> in_channel -> out_channel -> int -> int -> rt -> bool -> bool -> num_i * num_i * num_i list * num_i list * pol * cert_pop
end



module Make : functor 
(N: Numeric.T) ->  functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> functor 
(P: Polynomial.T with type num_i = N.t and type interval = I.interval) -> functor 
(Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval) -> functor 
(A: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol) -> functor 
(O: Oracle.T with type num_i = N.t and type positive = P.positive and type pol = P.pol and type fw_pol = P.fw_pol and type term = P.term and type val_tbl = A.val_tbl) -> functor 
(L: Fw2oracle_lasserre.T with type num_i = N.t and type positive = P.positive and type interval = I.interval and type pol = P.pol and type fw_pol = P.fw_pol and type rt = Fu.relax_type and type bound = O.bound) -> T with type num_i = N.t and type positive = P.positive and type pol = P.pol and type fw_pol = P.fw_pol and type term = P.term and type val_tbl = A.val_tbl and type eval_tbl = A.eval_tbl and type rt = Fu.relax_type and type bound = O.bound and type cert_pop = P.cert_pop
 



