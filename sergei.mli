module type T = sig
  type num_i
  type pol
  type val_tbl
  type eval_tbl
  val var_hashitem_to_string : string * val_tbl -> string
  val gen_output_s : string -> string
  val gen_variables_names : string -> int -> string list
  val sergei_string_of_interval : string * val_tbl -> string
  val sergei_string_of_box : (string * val_tbl) list -> string
  val divide_hashtbl : eval_tbl -> (string * val_tbl) list
  val write_sergei_problem : pol -> eval_tbl -> bool -> out_channel -> unit
  exception Sergei_error
  val parse_sergei_output_aux : string -> num_i
  val parse_sergei_output : string -> num_i
  val get_bound_poly : pol -> eval_tbl -> bool -> num_i
end

module Make : functor 
(N: Numeric.T) -> functor 
(U: Tutils.T with type t = N.t) ->  functor 
(P: Polynomial.T with type num_i = N.t) ->    functor 
(A: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol) -> T with  type num_i = N.t and type pol = P.pol and type val_tbl = A.val_tbl and type eval_tbl = A.eval_tbl




