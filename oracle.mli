module type T =
sig
  type num_i
  type positive 
  type term 
  type pol
  type fw_pol 
  type val_tbl 
  type bound = Fx of pol * num_i | LoUp of pol * (num_i * num_i) | Bin of pol | Dummy of pol
  val fix_var : pol -> num_i -> (positive, num_i * num_i) Hashtbl.t -> bound 
  val bound_var : pol -> num_i -> num_i -> (positive, num_i * num_i) Hashtbl.t -> bound 
  val objvar : term
  val times_op : term -> term -> term
  val plus_op : term -> term -> term
  val sqr_op : term -> term
  val minus_op : term -> term
  val moins_op : term -> term -> term
  val plus_op_list : term list -> term
  val times_op_list : term list -> term
  val id_op : term -> term
  val tan_equation : num_i -> num_i -> pol -> pol
  val par_equation : num_i -> num_i -> num_i -> pol -> pol -> pol
  val cubic_equation : num_i -> num_i -> num_i -> num_i -> pol -> pol -> pol
  val minimax_equation : num_i list -> pol -> pol
  val gen_cstrname : int -> string
  val gen_cstr : string -> term -> string -> string
  val var_hashitem_to_pol : string * val_tbl -> pol
  val init_matlab : unit -> in_channel * out_channel * in_channel
  val stop_matlab : in_channel -> out_channel -> in_channel -> unit
  val init_sollya : unit -> in_channel * out_channel * in_channel
  val stop_sollya : in_channel -> out_channel -> in_channel -> unit
  val gen_output_s : string -> int -> string
  val gen_varname : int -> int -> pol
  val gen_variables_names : int -> int -> pol list
  val gen_constraints_names : int -> string -> string list
  val norm_meth01 : pol -> num_i -> num_i -> pol
  val norm_meth1 : pol -> num_i -> num_i -> pol
  val interval_of_box_item : string * val_tbl -> num_i * num_i
  val divide_hashtbl : (string, val_tbl) Hashtbl.t -> fw_pol list -> (string * val_tbl) list
  val bound_of_interval : string * val_tbl -> (positive, num_i * num_i) Hashtbl.t -> bound 
  val oracle_var_index : pol -> int list
  val varpol_index : (string * val_tbl) list -> positive list
  val var_idx_list : (positive * (num_i * num_i)) list -> int list
  val variables_string : (*int -> (string * val_tbl) list*) (positive * (num_i * num_i)) list -> string -> string -> string
  val binary_variables_string : (string * val_tbl) list -> string -> string -> string
  val get_bound_poly : (fw_pol -> (string, val_tbl) Hashtbl.t -> bool -> 'c -> string -> int -> num_i * num_i * num_i list * num_i list) -> fw_pol -> (string, val_tbl) Hashtbl.t  -> bool -> 'c -> string -> int -> num_i * num_i * num_i list * num_i list
end

module Make : functor 
(N: Numeric.T) -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> functor 
(P: Polynomial.T with type num_i = N.t and type interval = I.interval) -> functor 
(A: Algo_types.T with type num_i = N.t and type fw_pol = P.fw_pol)  -> T with type num_i = N.t and type positive = P.positive and type pol = P.pol and type term = P.term and type fw_pol = P.fw_pol and type val_tbl = A.val_tbl 


