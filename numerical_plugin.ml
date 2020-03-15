module type T = 
sig
  type t
  val lb_ub_tol : int
  val under_upper_tol : int
  val print_accuracy : int
  val size_i : t -> int
  val zero_i : t
  val one_i : t
  val two_i : t
  val three_i : t
  val four_i : t
  val six_i : t
  val ten_i : t
  val infty : t
  val add_i : t -> t -> t
  val sub_i : t -> t -> t
  val mult_i : t -> t -> t
  val div_i : t -> t -> t
  val minus_i : t -> t
  val inv_i : t -> t
  val abs_i : t -> t
  val max_i : t -> t -> t
  val min_i : t -> t -> t
  val sqrt_i : t -> t
  val sqrt_i_lo : t -> t
  val sqrt_i_up : t -> t
  val compare_i : t -> t -> int
  val pow_i : t -> t -> t
  val ceil_i : t -> t
  val floor_i : t -> t
  val num_of_string : string -> t
  val num_of_int : int -> t                            
  val int_of_num : t -> int
  val num_of_float : float -> t
  val float_of_num : t -> float
  val zarith_rat_of_num : t -> Q.t
  val num_of_rat : Q.t -> t
  val num_of_float_exact : float -> t
  val string_of_i_rat : t -> string
  val interval_acc : t
  val under_i : t -> t                       
  val upper_i : t -> t
  val lower_bound : t -> int -> t
  val upper_bound : t -> int -> t
  val sin_i : t -> t
  val cos_i : t -> t
  val tan_i : t -> t                     
  val asin_i : t -> t
  val acos_i : t -> t
  val atan_i : t -> t
  val log_i : t -> t
  val exp_i : t -> t
  val sqr_i : t -> t
  val atan2_i : t -> t -> t
  val eq_i : t -> t -> bool
  val le_i : t -> t -> bool
  val lt_i : t -> t -> bool
  val ge_i : t -> t -> bool
  val gt_i : t -> t -> bool
  val sgn_i : t -> int
  val is_integer : t -> bool
  val rel_err_i : t -> t -> t
  val abs_err_i : t -> t -> t
  val of_string : string -> t
  val string_of_i : t -> string 
  val string_of_i_q : t -> string
  val string_of_i_coq : t -> string
  val string_float : t -> int -> string
  val to_string : t -> string
end


let module_tbl = Hashtbl.create 10 

let add_numeric_module s m =
  Hashtbl.add module_tbl s m

let to_list () =
  Hashtbl.fold (fun s m res -> (s,m)::res) module_tbl []
