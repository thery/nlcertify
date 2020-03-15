module type T = 
sig
  type num_i
  val _pr_ : string -> bool -> bool -> unit
  val tol_border : num_i
  type box_int = L | R | M | F
  val string_of_lfr : box_int -> string
  val is_M : box_int -> bool
  val is_L : box_int -> bool
  val is_F : box_int -> bool
  val is_R : box_int -> bool
  val eq_lmrf : box_int -> box_int -> bool
  val eq_lmrf_box : box_int list -> box_int list -> bool
  val string_of_lfr_list : box_int list -> string
  val mk_box_cst : box_int -> int -> box_int list
  val mk_box_left : int -> box_int list
  val mk_box_right : int -> box_int list
  val mk_box_full : int -> box_int list
  val mk_box_middle : int -> box_int list
  val mk_hypercube_left : int -> int -> box_int list
  val mk_hypercube_right : int -> int -> box_int list
  val mk_hypercubes_list_aux : int -> int -> box_int list list
  val mk_hypercubes_list : int -> box_int list list
  val mk_hypercubes_sub_list :bool array -> int -> box_int list list
  val map_box_int_bound : box_int -> (num_i * num_i) * (num_i * num_i) -> num_i * num_i
  val mk_br_bl :num_i * num_i ->num_i -> num_i -> (num_i * num_i) * (num_i * num_i)
  val project_x_on_corner :num_i list -> (num_i * num_i) list -> num_i list
  val clean_box :((num_i * num_i) * (num_i * num_i)) array ->box_int list ->(num_i * num_i) list -> box_int list * (num_i * num_i) list
  val get_permutations : 'a -> 'a
  val get_permutations_cyclic : 'a list -> 'a list list
  val mk_box_list_hess :(num_i * num_i) list ->num_i list -> 'a ->num_i array ->(num_i * num_i) list * (num_i * num_i) list list list
  val mk_box_list :(num_i * num_i) list ->num_i list -> num_i -> (num_i * num_i) list list
  val cut_box : int -> (num_i * num_i) list -> (num_i * num_i) list list
  val cut_box_first :(num_i * num_i) list -> int -> (num_i * num_i) list list
end

module Make: functor 
(N: Numeric.T) -> functor 
(U: Tutils.T with type t = N.t) -> functor 
(I: Interval.T with type num_i = N.t) -> functor 
(M:Mesh_interval.T with type num_i = N.t and type interval = I.interval) -> T with type num_i = N.t

