module type T = 
sig
  type num_i
  type sdpa_matrix_list = Dense of num_i array array list | Sparse of (int * int * int * int * num_i) array list
  val gen_output_s : string -> string
  val write_sdpa_pb : num_i array -> sdpa_matrix_list -> out_channel -> unit
  val write_sdpa_sparse : int -> int -> int array -> num_i array -> sdpa_matrix_list -> out_channel -> unit
  val parse_sdpa_output : string -> num_i * string * string * string
  val sparse_input_robust_sdp_1998 : num_i -> num_i array array -> int * int * int array * num_i array *
sdpa_matrix_list
  val sparse_input_robust_sdp_2008 : num_i array array -> num_i array array -> int * int * int array * num_i array * sdpa_matrix_list
  val solve_sdp : int -> int -> int array -> num_i array -> sdpa_matrix_list -> string -> num_i * num_i list * string * (num_i array * num_i array array) array * num_i array array
  val lambda_min : num_i array -> num_i array array list -> num_i
  val lambda_min_robust : num_i array array -> num_i array array -> num_i
end


module Make : functor (N: Numeric.T) -> functor (U: Tutils.T with type t = N.t) -> functor (M: Mesh_interval.T with type num_i = N.t) -> T with type num_i = N.t

