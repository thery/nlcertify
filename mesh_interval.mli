module type T =
sig
  type num_i
  type interval
  val find_interv_list :bool list -> (num_i * num_i) list -> (num_i * num_i) list
  val find_point_list_base :int list -> (num_i * num_i) list -> int -> num_i list
  val find_interv_list_base : int list -> (num_i * num_i) list -> int -> (num_i * num_i) list
  val find_all_interv_list :(num_i * num_i) list -> int -> int -> (num_i * num_i) list list
  val find_all_point_list_base :(num_i * num_i) list -> int -> int -> int -> num_i list list
  val find_all_interv_list_base :(num_i * num_i) list -> int -> int -> int -> (num_i * num_i) list list
  val eq_box : (num_i * num_i) list -> (num_i * num_i) list -> bool
  type box = interval list
  type union_box = box list
  val mk_box_i : interval list -> (num_i * num_i) list
  val mk_box_I : (num_i * num_i) list -> interval list
  val void_box : int -> interval list
  val box_belongs_box_I : box -> box -> bool
  val box_contains_singleton_I : box -> bool
  val union_box_I : box -> box -> box
  val union_singl_box_I : box -> box -> union_box
  val filter_singleton_box_aux : union_box -> union_box
  val filter_singleton_box :(num_i * num_i) list list -> (num_i * num_i) list list
  val union_partial_box_I :interval list list -> interval list list
  val multi_cut_point : (num_i * num_i) list -> (num_i * num_i) list list
  val mesh_of_point : (num_i * num_i) list -> int -> num_i list list
  val mesh_of_interval :(num_i * num_i) list -> int -> (num_i * num_i) list list
  val list_I : num_i list -> box
  val cut_I : interval -> int -> box
  val get_widths : (num_i * num_i) list -> num_i list
  val min_distance : (num_i * num_i) list -> num_i
  val add_array_int : int array -> int
  val add_point : num_i list -> num_i list
  val add_points_aux_I : int -> num_i list -> num_i list
  val add_points_I :interval -> int -> num_i list -> num_i list
  val xconvert_bounds : (num_i * num_i) list -> bool -> (num_i * num_i) list
  val size : 'a array -> int
  val string_of_array_f : 'a array -> ('a -> string) -> string
  val string_of_array_ssreflect_seq : 'a array -> ('a -> string) -> string
  val string_of_sdpa_line : int * int * int * int * num_i -> string
  val string_of_matrix_f : 'a array array -> ('a -> string) -> string
  val string_of_array_int : int array -> string
  val string_of_array : num_i array -> string
  val string_of_array_ln : num_i array -> string
  val string_of_matrix : num_i array array -> string
  val string_of_interval_array : interval array -> string
  val string_of_interval_matrix : interval array array -> string
  val string_of_sdpa_array :(int * int * int * int * num_i) array -> string
  val matrix_of_list : 'a -> 'a list -> 'a array array
  val init_array : int -> num_i array
  val int_to_array : int -> int array
  val matrix_mult :'a array array ->
            'b array array ->
            'c -> ('a -> 'b -> 'd) -> ('c -> 'd -> 'c) -> 'c array array
  val matrix_mult_i :
            num_i array array -> num_i array array -> num_i array array
  val map2_array :
            'a -> ('b -> 'c -> 'a) -> 'b array -> 'c array -> 'a array
  val array_sub : num_i array -> num_i array -> num_i array
  val map_matrix :
                                                  'a -> ('b -> 'a) -> 'b array array -> 'a array array
  val map_sym_matrix :
            'a -> ('b -> 'a) -> 'b array array -> 'a array array
  val matrix_list_to_list_matrix :
            int -> int -> 'a array array list -> 'a list array array
  val tuple_matrix_to_matrix_I : num_i array array -> num_i array array -> interval array array
  val list_matrix_to_matrix_I :
            num_i list array array -> interval array array
  val matrix_list_to_matrix_I :
            int -> int -> num_i array array list -> interval array array
  val map2_matrix_tuple :
            'a ->
            'b ->
            ('c -> 'd -> 'a * 'b) ->
            'c array array ->
            'd array array -> 'a array array * 'b array array
  val center_sum_matrix_I :
            interval array array ->
            num_i array array ->
            interval array array * num_i array array
  val matrix_inf_I : interval array array -> num_i array array
  val matrix_rho_I : interval array array -> num_i array array
  val diag_of_matrix : 'a array array -> 'a -> 'a array
  val inv_of_diag : num_i array -> num_i array
  val sqrt_diag : num_i array -> num_i array
  val foldl_matrix : ('a -> 'a -> 'a) -> 'a array array -> 'a -> 'a
  val rho_of_matrix : interval array array -> num_i
  val matrix_opp :
            'a -> ('b -> 'a) -> 'b array array -> 'a array array
  val matrix_minus_I :
            interval array array -> interval array array
  val matrix_cmul : num_i -> num_i array array -> num_i array array
  val matrix_add :
            'a ->
            ('a -> 'a -> 'a) ->
            'a array array -> 'a array array -> 'a array array
  val array_matrix_cmult :
            'a array ->
            'b array array -> ('a -> 'b -> 'c) -> 'c -> 'c array array
  val matrix_array_cmult :
            'a array ->
            'b array array -> ('a -> 'b -> 'c) -> 'c -> 'c array array
  val matrix_array_cmult2 :
            'a array ->
            'b array array ->
            ('c -> 'd -> 'd) -> ('a -> 'b -> 'c) -> 'd -> 'd array
  val inner_product : num_i array -> num_i array -> num_i
  val inner_product_general : 'a array -> 'a array -> ('a -> 'a -> 'a) -> ('a -> 'a -> 'a) -> 'a -> 'a
  val matrix_array_mult2_i :
            num_i array -> num_i array array -> num_i array
  val array_matrix_mult :
            num_i array -> num_i array array -> num_i array array
  val matrix_array_mult :
            num_i array -> num_i array array -> num_i array array
  val array_matrix_mult_I :
            interval array ->
            interval array array -> interval array array
  val matrix_array_mult_I :
            interval array ->
            interval array array -> interval array array
  val norm_of_array : num_i array -> num_i
  val norm_array : num_i array -> num_i array
  val norm_inf_array : num_i array -> num_i array
  val length2 : 'a array -> 'b array -> int
  val matrix_add_list :
            int -> int -> num_i array array list -> num_i array array
  val matrix_sub :
            'a ->
            ('b -> 'a) ->
            ('a -> 'a -> 'a) ->
            'a array array -> 'b array array -> 'a array array
  val matrix_sub_i :
            num_i array array -> num_i array array -> num_i array array
  val matrix_sub_I :
            interval array array ->
            interval array array -> interval array array
  val matrix_I : num_i array array -> interval array array
  val matrix_id : 'a -> 'a -> int -> 'a array array
  val sign_list : int -> num_i list list
  val sign_list_1 : int -> num_i list list
  val sign_mat : int -> num_i array array
  val blit_block :
            'a array array -> 'a array array -> int -> int -> unit
  val sym_of_mat : 'a array array -> unit
  val e_ij : int -> int -> int -> num_i array array
  val robust_sdp_a :
            'a ->
            int ->
            num_i array array ->
            num_i array array -> num_i array array -> num_i -> num_i array array
  val robust_sdp_b :
            num_i array array list ->
            num_i array array list -> num_i array array -> num_i array array
  type eij = Eij of int * int | Ei of int
  type rhoij = Rhoij of num_i * int * int | Rhoi of num_i * int
  val upper_mat_idx : int -> (int * int) array
  val ei : int -> (int * int) array -> eij
  val rho_i : int -> (int * int) array -> num_i -> rhoij
end
module Make: functor (N: Numeric.T) -> functor (U: Tutils.T with type t = N.t) -> functor (I: Interval.T with type num_i = N.t) -> T with type num_i = N.t and type interval = I.interval 
