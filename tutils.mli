module type T = 
sig
  type t
  val pwd : string
  val tmp_dir : string
  val mk_dir : string -> unit
  val log_dir : string
  val mk_tmp : unit -> unit
  val mk_log : unit -> unit
  val verbose_mode : bool
  val log_s : string
  val log_verb_s : string
  val init_log_file : unit -> unit
  val _pr_ : string -> bool -> bool -> unit
  val debug : string -> unit
  val string_blanks : int -> string
  val wait : int -> unit
  val close_log_file : unit -> unit
  val eval_time_function_6 : (t -> t -> t -> t -> t -> t -> t) ->  t -> t -> t -> t -> t -> t -> t
  val m_I : t -> t -> t
  val k_th_segment_I : t -> t -> int -> int -> t
  val fst_fst : t * t * (t list) * (t list) * 'a -> t
  val fst_fst_fst : t * t * (t list) * (t list) * 'a * 'b -> t
  exception Empty_list
  val split4 : ('a * 'b * 'c * 'd) list -> 'a list * 'b list * 'c list * 'd list
  val split5 : (t * t * t list * t list * 'a) list -> t list * t list * t list list * t list list * 'a list
  val split6 : (t * t * t list * t list * 'a * 'b) list -> t list * t list * t list list * t list list * 'a list * 'b list
  val int_to_list : int -> int list
  val ceil_int : int -> int
  val points_of_I : t -> t -> int -> t list
  val add_list_int : int list -> int
  val sum_n : int -> int
  val max_list_int : int list -> int 
  val end_itlist : (string -> string -> string) -> string list -> string
  val hd_tl : 'a list -> 'a * 'a list
  val last : 'a list -> 'a
  val combine_f : ('a -> 'b -> 'c) -> 'a list -> 'b list -> 'c list
  val sub_list : 'a list -> int -> int -> 'a list
  val elim_same_lists : ('a -> 'a -> bool) -> 'a list -> 'a list
  val combine_tuple : (t * t) list -> t list list
  val combine_tuple_1 : ('a * 'a) list -> 'a list list
  val strings_of_file : string -> string list
  val string_of_file : string -> string
  val find_in_file : string -> Str.regexp -> string
  val add_list_table : ('a, 'b) Hashtbl.t -> ('a * 'b) list -> unit
  val plural : int -> string
  val concat_string : string list -> string
  val concat_string_with_string : string list -> string -> string
  val string_of_list : string list -> string
  val init_list : int -> 'a -> 'a list
  val permute_list : 'a list -> 'a list
  val permute_list_n : int -> 'a list -> 'a list
  val get_permutations : 'a list -> 'a list list
  val index_of_elt : 'a list -> 'a -> int
  val dump_string_of_list : string -> t list
  val dump_string_of_tuple_list : string -> (t * t) list
  val string_of_tuple : t * t -> string
  val string_of_i_list_aux : t list -> string
  val string_of_i_list : t list -> string
  val string_of_mesh : t list list -> string
  val tl_string : string -> string
  val string_of_tuple_list_aux : (t * t) list -> string
  val string_of_tuple_list : (t * t) list -> string
  val string_float_box : (t * t) list -> int -> string
  val string_of_cut_box : (t * t) list list -> string
  val cut_point : (t * t) list -> (t * t) list * (t * t) list
  val binary_decomp : int -> int -> int -> bool list
  val base_decomp_aux : int -> int -> int -> int -> int list
  val bin_decomp : int -> int -> bool list
  val base_decomp : int -> int -> int -> int list
  val pow_2_n : int -> int
  val pow_base_n : int -> int -> int
  val binomial : int -> int -> int
  val map_func : ('a -> 'b) list -> 'a -> 'b list
  val sort_idx : t list -> int list
  val avoid_duplicata : ('a -> 'a -> int) -> 'a list -> 'a list
  val hashtbl_to_list : ('a, 'b) Hashtbl.t -> ('a * 'b) list
  val hashtbl_keys : ('a, 'b) Hashtbl.t -> 'a list
  val remove_from_list_aux : int -> int -> 'a list -> 'a list
  val remove_from_list : int -> 'a list -> 'a list
  val pick_rnd_in_I : t * t -> t
  val pick_rnd_in_box : int -> (t * t) list -> t list list
  val boxes_share_lower_bound : (t * t) list -> (t * t) list -> int -> bool 
  val boxes_share_upper_bound : (t * t) list -> (t * t) list -> int -> bool 
  val enumerate_ntuple_lex : int -> int -> int list array
  val lexcmp : int list -> int list -> int
  val deg_lex : int list -> int
  val lexidx_of_alpha : int list -> int
  val naive_lexidx_of_alpha : int list -> int list list -> int
  val lexsort : int list list -> int list list
  val alphacl_to_alphan : int list -> bool list -> int list 
end

module Make : functor (N : Numeric.T) -> T with type t = N.t
                                         
