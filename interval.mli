
module type T =
sig
  exception Refine
  type num_i
  type f
  val func_checkable : string list
  val ml_functions : string list
  val list_func_basic2 : (string * (num_i -> num_i -> num_i)) list
  val list_func_basic : (string * (num_i -> num_i)) list
  val list_func_transc : (string * (num_i -> num_i)) list
  val list_func_bool : (string * (num_i -> num_i -> bool)) list
  val list_str_func_bool : (string * string) list
  type interval = Int of num_i * num_i | Void_i
  type inter_mut = { mutable i : interval; }
  val tuple_of_num : num_i -> num_i * num_i
  val tuple_of_num_list : num_i list -> (num_i * num_i) list
  val zero_tuple : num_i * num_i
  val ten_tuple : num_i * num_i
  val tuple_is_singleton : num_i * num_i -> bool
  val mk_I : num_i * num_i -> interval
  val mk_i_I : num_i -> interval
  val tuple_I : interval -> num_i * num_i
  val mid_I : interval -> num_i
  val width_I : interval -> num_i
  val half_width_I : interval -> num_i
  val inf_I : interval -> num_i
  val sup_I : interval -> num_i
  val norm_I : interval -> bool
  val abs_sup_I : interval -> num_i
  val tuple_of_I : interval -> num_i * num_i
  val max_I : interval * interval -> interval
  val min_I : interval * interval -> interval
  val string_of_list_i : num_i list -> string
  val string_float_list : num_i list -> int -> string
  val void_I : interval -> bool
  val mk_void_I : unit -> interval
  val string_I : interval -> string
  val string_float_I : interval -> int -> string
  val string_of_list_I : interval list -> string
  val string_of_I : inter_mut -> string
  val min_list : num_i list -> num_i
  val max_list : num_i list -> num_i
  val list_to_I : num_i list -> interval
  val min_list_cnd : num_i list -> num_i list -> bool -> num_i
  val sort_tol : num_i -> num_i -> num_i list -> num_i list
  val is_singleton_I : interval -> bool
  val union_I : interval -> interval -> interval
  val intersection_I : interval -> interval -> interval
  val narrow_I : interval -> interval -> interval
  val union_list_I : interval list -> interval
  val fold_spec : ('a -> 'a -> 'a) -> 'a list -> 'a
  val intersection_list_I : interval list -> interval
  val add_I : interval -> interval -> interval
  val minus_I : interval -> interval
  val sub_I : interval -> interval -> interval
  val mult_ineff_I : interval -> interval -> interval
  val is_positive_interv : interval -> bool
  val sgn_I : interval -> int
  val center_sum_I : interval -> num_i -> interval * num_i
  val mult_I : interval -> interval -> interval
  val multiplication_I : interval -> interval -> interval
  val mk_num_I : num_i -> interval
  val zero_I : interval
  val one_I : interval
  val ge_I : interval -> interval -> bool
  val gt_I : interval -> interval -> bool
  val le_I : interval -> interval -> bool
  val lt_I : interval -> interval -> bool
  val eq_I : interval -> interval -> bool
  val belongs_I : num_i -> interval -> bool
  val belongs_list_I : num_i list -> interval -> bool
  val included_in_I : interval -> interval -> bool
  val interv_of_min : interval list -> interval
  val interv_of_max : interval list -> interval
  val abs_I : interval -> interval
  val abs_diff_I : interval -> interval -> interval
  val inv_I : interval -> interval
  val div_I : interval -> interval -> interval
  val pow_I_aux : interval -> int -> interval
  val pow_I : interval -> interval -> interval
  val sqrt_I : interval -> interval
  val atan_I : interval -> interval
  val log_I : interval -> interval
  val exp_I : interval -> interval
  val period_I : (interval -> interval) -> num_i -> interval -> num_i -> num_i -> interval
  val pi : num_i
  val half_pi : num_i
  val three_half_pi : num_i
  val two_pi : num_i
  val itv1 : interval
  val itv2 : interval
  val itv3 : interval
  val itv4 : interval
  val itv5 : interval
  val sin0_I : interval -> interval
  val sin_I : interval -> interval
  val cos_I : interval -> interval
  val tan_I : interval -> interval
  val acos_I : interval -> interval
  val asin_I : interval -> interval
  val list_interval_basic2 : (string * (interval -> interval -> interval)) list
  val list_interval_basic : (string * (interval -> interval)) list
  val list_interval_bool : (string * (interval -> interval -> bool)) list
  val f_interv_inter_mut1 : (interval -> interval) -> inter_mut -> unit -> inter_mut
  val f_interv_inter_mut2 : (interval -> interval -> 'a) -> inter_mut -> inter_mut -> 'a
  val minus_of_I : inter_mut -> unit -> inter_mut
  val eq_of_I : inter_mut -> inter_mut -> bool
  val add_I_num : interval -> num_i -> interval
  val mult_I_num : interval -> num_i -> interval
  val add_of_I_num : inter_mut -> num_i -> unit -> inter_mut
  val mult_of_I_num : inter_mut -> num_i -> unit -> inter_mut
  val min_c_atan : interval -> num_i
  val max_c_atan : interval -> num_i
  val min_c_conv_atan : interval -> num_i -> num_i
  val max_c_conv_atan : interval -> num_i -> num_i
  val list_min_c : (string * (interval -> num_i)) list
  val list_max_c : (string * (interval -> num_i)) list
  val sin_is_conv : interval -> bool
  val sin_is_conc : interval -> bool
  val cos_is_conv : interval -> bool
  val cos_is_conc : interval -> bool
  val tan_is_conv : interval -> bool
  val tan_is_conc : interval -> bool
  val atan_is_conv : interval -> bool
  val atan_is_conc : interval -> bool
  val asin_is_conv : interval -> bool
  val asin_is_conc : interval -> bool
  val acos_is_conv : interval -> bool
  val acos_is_conc : interval -> bool
  val sqrt_is_conc : interval -> bool
  val sqrt_is_conv : interval -> bool
  val log_is_conc : interval -> bool
  val log_is_conv : interval -> bool
  val sin_is_incr : interval -> bool
  val sin_is_deacr : interval -> bool
  val cos_is_incr : interval -> bool
  val cos_is_deacr : interval -> bool
  val tan_is_incr : interval -> bool
  val tan_is_deacr : interval -> bool
  val atan_is_incr : interval -> bool
  val atan_is_deacr : interval -> bool
  val asin_is_incr : interval -> bool
  val asin_is_deacr : interval -> bool
  val acos_is_incr : interval -> bool
  val acos_is_deacr : interval -> bool
  val sqrt_is_incr : interval -> bool
  val sqrt_is_deacr : interval -> bool
  val log_is_incr : interval -> bool
  val log_is_deacr : interval -> bool
  val inv_is_deacr : interval -> bool
  val inv_is_incr : interval -> bool
  val inv_is_conc : interval -> bool
  val inv_is_conv : interval -> bool
  val list_check_prop : (string * (interval -> bool) list) list
  val list_derivative_basic : (string * (num_i -> f)) list
  val list_deriv_order2 : (string * (num_i -> f)) list
  val list_deriv_order3 : (string * (num_i -> f)) list
  val func_basic2 : (string, num_i -> num_i -> num_i) Hashtbl.t
  val func_basic : (string, num_i -> num_i) Hashtbl.t
  val func_transc : (string, num_i -> num_i) Hashtbl.t
  val func_bool : (string, num_i -> num_i -> bool) Hashtbl.t
  val str_func_bool : (string, string) Hashtbl.t
  val func_interval_basic2 : (string, interval -> interval -> interval) Hashtbl.t
  val func_interval_basic : (string, interval -> interval) Hashtbl.t
  val func_interval_bool : (string, interval -> interval -> bool) Hashtbl.t
  val func_derivative_basic : (string, num_i -> f) Hashtbl.t
  val func_deriv_order2 : (string, num_i -> f) Hashtbl.t
  val func_deriv_order3 : (string, num_i -> f) Hashtbl.t
  val func_min_c : (string, interval -> num_i) Hashtbl.t
  val func_max_c : (string, interval -> num_i) Hashtbl.t
  val func_check_prop_list : (string, (interval -> bool) list) Hashtbl.t
  val create_basic_tables : unit
end

module Make : functor (N : Numeric.T) -> functor (F: Functions.T with type num_i = N.t) -> functor (U: Tutils.T with type t = N.t) -> T with type num_i = N.t and type f = F.f

