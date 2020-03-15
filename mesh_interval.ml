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
  val matrix_mult_i : num_i array array -> num_i array array -> num_i array array
  val map2_array : 'a -> ('b -> 'c -> 'a) -> 'b array -> 'c array -> 'a array
  val array_sub : num_i array -> num_i array -> num_i array
  val map_matrix : 'a -> ('b -> 'a) -> 'b array array -> 'a array array
  val map_sym_matrix : 'a -> ('b -> 'a) -> 'b array array -> 'a array array
  val matrix_list_to_list_matrix : int -> int -> 'a array array list -> 'a list array array
  val tuple_matrix_to_matrix_I : num_i array array -> num_i array array -> interval array array
  val list_matrix_to_matrix_I : num_i list array array -> interval array array
  val matrix_list_to_matrix_I : int -> int -> num_i array array list -> interval array array
  val map2_matrix_tuple :
            'a ->
            'b ->
            ('c -> 'd -> 'a * 'b) ->
            'c array array ->
            'd array array -> 'a array array * 'b array array
  val center_sum_matrix_I : interval array array -> num_i array array -> interval array array * num_i array array
  val matrix_inf_I : interval array array -> num_i array array
  val matrix_rho_I : interval array array -> num_i array array
  val diag_of_matrix : 'a array array -> 'a -> 'a array
  val inv_of_diag : num_i array -> num_i array
  val sqrt_diag : num_i array -> num_i array
  val foldl_matrix : ('a -> 'a -> 'a) -> 'a array array -> 'a -> 'a
  val rho_of_matrix : interval array array -> num_i
  val matrix_opp : 'a -> ('b -> 'a) -> 'b array array -> 'a array array
  val matrix_minus_I : interval array array -> interval array array
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
  val matrix_array_mult2_i : num_i array -> num_i array array -> num_i array
  val array_matrix_mult : num_i array -> num_i array array -> num_i array array
  val matrix_array_mult : num_i array -> num_i array array -> num_i array array
  val array_matrix_mult_I : interval array -> interval array array -> interval array array
  val matrix_array_mult_I : interval array -> interval array array -> interval array array
  val norm_of_array : num_i array -> num_i
  val norm_array : num_i array -> num_i array
  val norm_inf_array : num_i array -> num_i array
  val length2 : 'a array -> 'b array -> int
  val matrix_add_list : int -> int -> num_i array array list -> num_i array array
  val matrix_sub :
            'a ->
            ('b -> 'a) ->
            ('a -> 'a -> 'a) ->
            'a array array -> 'b array array -> 'a array array
  val matrix_sub_i : num_i array array -> num_i array array -> num_i array array
  val matrix_sub_I : interval array array -> interval array array -> interval array array
  val matrix_I : num_i array array -> interval array array
  val matrix_id : 'a -> 'a -> int -> 'a array array
  val sign_list : int -> num_i list list
  val sign_list_1 : int -> num_i list list
  val sign_mat : int -> num_i array array
  val blit_block : 'a array array -> 'a array array -> int -> int -> unit
  val sym_of_mat : 'a array array -> unit
  val e_ij : int -> int -> int -> num_i array array
  val robust_sdp_a :
            'a ->
            int ->
            num_i array array ->
            num_i array array -> num_i array array -> num_i -> num_i array array
  val robust_sdp_b : num_i array array list -> num_i array array list -> num_i array array -> num_i array array
  type eij = Eij of int * int | Ei of int
  type rhoij = Rhoij of num_i * int * int | Rhoi of num_i * int
  val upper_mat_idx : int -> (int * int) array
  val ei : int -> (int * int) array -> eij
  val rho_i : int -> (int * int) array -> num_i -> rhoij
end

module Make(N: Numeric.T) (U: Tutils.T with type t = N.t) (I: Interval.T with type num_i = N.t) = struct
  type num_i = N.t
  type interval = I.interval
  let rec find_interv_list b_list interv_list = 
    match (b_list, interv_list) with 
      | (bl::b_tl, ((a, b)::interv_tl)) -> (if bl = true then (a, U.m_I a b) else (U.m_I a b, b))::(find_interv_list b_tl interv_tl)
      | [], [] -> []
      | _ -> failwith "boolean list and interval list have different lengths"

let rec find_point_list_base b_list point_list base = 
  match (b_list, point_list) with
    | (bl::b_tl, ((a, b)::tl)) ->  (U.k_th_segment_I a b bl base)::(find_point_list_base b_tl tl base)
    | [], [] -> []
    | _ -> failwith "euclidian rests list and interval list have different lengths"


let rec find_interv_list_base b_list interv_list base = 
  match (b_list, interv_list) with
    | (bl::b_tl, ((a, b)::interv_tl)) ->  ( N.under_i (U.k_th_segment_I a b bl base), N.upper_i (U.k_th_segment_I a b (bl+1) base) )::(find_interv_list_base b_tl interv_tl base)
    | [], [] -> []
    | _ -> failwith "euclidian rests list and interval list have different lengths"

let rec find_all_interv_list point n k = 
  if k = ((U.pow_2_n n)) then [] else (
    let b_list = U.bin_decomp n k in
    let halves_interv_list = find_interv_list b_list point in
      (*
       * Printf.printf "%s\n" (string_of_tuple_list halves_interv_list);
       * *)
      halves_interv_list::(find_all_interv_list point n (k+1))
  )

let rec find_all_point_list_base point n k base=
  if k = ((U.pow_base_n base n)) then [] else (
    let b_list = U.base_decomp n k base in
    let mesh_point_list = find_point_list_base b_list point base in
      (*
       * Printf.printf "%s\n" (string_of_float_list mesh_point_list);
       *)
      mesh_point_list::(find_all_point_list_base point n (k+1) base)
  )

let rec find_all_interv_list_base point n k base=
  if k = ((U.pow_base_n base n)) then [] 
  else (
    let b_list = U.base_decomp n k base in
    let mesh_interv_list = find_interv_list_base b_list point base in
  (*
   * Printf.printf "%s\n" (string_of_tuple_list mesh_interv_list);
   *)
      mesh_interv_list::(find_all_interv_list_base point n (k+1) base)
  )

let eq_box l1 l2 = List.for_all2 (fun (a, b) (c, d) -> N.eq_i a c && N.eq_i b d) l1 l2

type box = interval list
type union_box = box list

let mk_box_i = List.map I.tuple_of_I
let mk_box_I b = List.map (fun ab -> I.mk_I (fst ab, snd ab)) b
let void_box n = U.init_list n I.Void_i
let box_belongs_box_I b1 b2 = List.for_all2 I.included_in_I b1 b2
let box_contains_singleton_I b = List.exists I.is_singleton_I b

let union_box_I b1 b2 = List.map2 I.union_I b1 b2                                   
let union_singl_box_I b1 b2 (*: union_box*) = 
  if box_contains_singleton_I b1 || box_contains_singleton_I b2 then [List.map2 I.union_I b1 b2]
  else [b1; b2]

let rec filter_singleton_box_aux (*: union_box -> union_box *)= function
  | b1::b2::tl -> union_singl_box_I b1 b2 @ filter_singleton_box_aux tl
  | [b] -> [b]
  | [] -> []
  
let filter_singleton_box p = 
  let p_I = List.map mk_box_I p in
  let filter_p_I = filter_singleton_box_aux p_I in
  let p = List.map mk_box_i filter_p_I in
    U.elim_same_lists eq_box p

let rec union_partial_box_I = function 
  | b1::b2::tl -> union_box_I b1 b2 :: union_partial_box_I tl
  | [b] -> [b]
  | [] -> []


let multi_cut_point point = 
  let n = List.length point in
  let combin_interv = find_all_interv_list point n 0 in
    combin_interv
(*
let mesh_cmp_box idx x0 cmp_bounds n = 
  let l, r = fst cmp_bounds, snd cmp_bounds in
 *)
  


(*
 * gives the list of all points of the mesh created from the initial box by dividing each interval by base
 *)
let mesh_of_point point base = 
  let n = List.length point in 
  let combin_interv = find_all_point_list_base point n 0 base in
    combin_interv

(*
 * gives the same with all the intervals of the mesh
 *)
let mesh_of_interval point base = 
  let n = List.length point in 
  let combin_interv = find_all_interv_list_base point n 0 base in
    combin_interv


let rec list_I = function 
  | a::b::tl -> (I.mk_I (a, b)) :: (list_I (b::tl))
  | _ -> []

let cut_I itv n = 
  let a, b = I.tuple_of_I itv in
  let points = U.points_of_I a b n in
    list_I points

let get_widths bounds = List.map (fun (a, b) -> I.width_I (I.mk_I (a, b))) bounds

let min_distance bounds = I.min_list (get_widths bounds)

let add_point l = 
  let itv_list = list_I l in
  let w_list = List.map I.width_I itv_list in 
  let max_w = I.max_list w_list in
  let w_index = U.index_of_elt w_list max_w in
  let itv = List.nth itv_list w_index in
  let a0, b0 = I.tuple_of_I itv in
  let m0 = U.m_I a0 b0 in
  let new_l = (U.sub_list l 0 w_index) @ [m0] @ (U.sub_list l (w_index + 1) (List.length l - 1 )) in
    new_l 

let rec add_points_aux_I n l =
 if n < 1 then l else add_points_aux_I (n - 1) (add_point l)

let add_points_I interval n l =
  let a, b = I.tuple_of_I interval in
  let result = 
    if I.belongs_list_I l interval then  
      begin
        let alb = (a::l)@[b] in
        let l = add_points_aux_I n alb in
          U.sub_list l 1 (List.length l - 2)
      end
    else l
  in
    result 

  let to_Q (q: float) =  (*N.num_of_float_exact i*)
  let module Nf = (val (Numeric.of_string ("float")): Numeric.T) in 
(*    N.num_of_rat (Nf.zarith_rat_of_num (Nf.num_of_float q))*)
      N.num_of_float_exact q

let xconvert_bounds bounds xconvert = 
  let module Nf = (val (Numeric.of_string ("float")): Numeric.T) in 
  let fun_i i = 
    if xconvert then begin
      let i1 = N.sqr_i i in 
      let i2 = to_Q ((N.float_of_num i)**2.) in
        if N.eq_i i1 i2 then i1 else i2 end
    else i in
  List.map (fun (a, b) -> fun_i a, fun_i b ) bounds 

let size = Array.length

let string_of_array_f m f = 
  let s = ref "" in
    for i = 0 to (size m - 1) do 
      s :=  !s ^ f ( m. (i)) (*^ ";"*);
    done;
     !s 

let string_of_array_ssreflect_seq m f = 
  let s = ref "[::" in
    for i = 0 to (size m - 2) do 
      s :=  !s ^ f ( m. (i))  ^ " ;";
    done;
     !s ^  f ( m. (size m - 1))  ^ "]"



(* can check if e = 0 then print "" *)
let string_of_sdpa_line = function
  | a, b, c, d, e -> Printf.sprintf "%i %i %i %i %s\n" a b c d (N.string_of_i e)

let string_of_matrix_f m f = 
  let s = ref "" in
    for i = 0 to (size m - 1) do
      s :=  !s ^ string_of_array_f ( m. (i) ) f;
    done;
    !s

let add_array_int m = 
  let s = ref 0 in
    for i = 0 to (size m - 1) do
      s :=  !s + m. (i);
    done;
    !s


  let string_of_array_int m = string_of_array_f m (fun i -> string_of_int i ^ " ")
  let string_of_array m = string_of_array_f m (fun i -> N.string_of_i i ^ " ")
  let string_of_array_ln m = 
    let s = ref "" in
      for i = 0 to (size m - 1) do 
        s :=  !s ^ (string_of_int i) ^ " " ^ N.string_of_i ( m. (i)) ^ "\n" (*^ ";"*);
      done;
      !s

let string_of_matrix m = string_of_matrix_f m (fun i -> N.string_of_i i ^ " ")

let string_of_interval_array m = string_of_array_f m I.string_I
let string_of_interval_matrix m = string_of_matrix_f m I.string_I

let string_of_sdpa_array m = string_of_array_f m string_of_sdpa_line

let matrix_of_list e l = 
  let n = List.length l in
  let mat = Array.make_matrix n 1 e in
    for i = 0 to (n - 1) do
      mat. (i). (0) <- List.nth l i;
    done;
    mat

let init_array n = Array.make n N.zero_i
  let int_to_array n = Array.of_list (U.int_to_list n)

let matrix_mult m1 m2 e cmul cadd = 
  let nx1 = size m1 and nx2 = size m2 in
  let ny1 = size (m1. (0)) and ny2 = size (m2. (0)) in
  let nx, ny, n = 
    if ny1 != nx2 then failwith "Impossible to multiply matrices"
    else nx1, ny2, ny1
  in
  let mat = Array.make_matrix nx ny e in
    for i = 0 to (nx - 1) do
      for j = 0 to (ny - 1) do
        for k = 0 to (n - 1) do
          mat. (i). (j) <- cadd (mat. (i). (j)) (cmul (m1. (i). (k)) (m2. (k). (j)));
        done;
      done;
    done;
    mat

let matrix_mult_i m1 m2 = matrix_mult m1 m2 N.zero_i N.mult_i N.add_i

let map2_array e f a1 a2 = 
  let n = size a1 in
  let a = Array.make n e in 
    for i = 0 to (n - 1) do
          a. (i) <- f a1. (i) a2. (i);
      done;
    a 

let array_sub = map2_array N.zero_i N.sub_i


(* Dummy function: works only for square matrices and particular cases... *)                  
let map_matrix e f m =
  let nx = size m in
    if nx = 0 then [||] else
      begin
        let ny = size (m. (0)) in
        let mat = Array.make_matrix nx ny e in 
          for i = 0 to (nx - 1) do
            for j = 0 to (ny - 1) do
              mat. (i). (j) <- f (m. (i). (j));
            done;
          done;
          mat
      end

let map_sym_matrix e f m = 
  let nx = size m in
    if nx = 0 then [||] else
      begin
        let ny = size (m. (0)) in
        let mat = Array.make_matrix nx ny e in 
          for i = 0 to (nx - 1) do
            for j = i to (ny - 1) do
              mat. (i). (j) <- f (m. (i). (j));
              mat. (j). (i) <- mat. (i). (j);
            done;
          done;
          mat
      end

let matrix_list_to_list_matrix x y m_list = 
  let pick i j = List.map (fun m -> m. (i). (j)) m_list in
  let r = Array.make_matrix x y [] in
    for i = 0 to (x - 1) do
      for j = 0 to (y - 1) do
        r. (i). (j) <- pick i j;
      done;
    done;
    r

  let tuple_matrix_to_matrix_I m1 m2 = 
    let n = size m1 in
    let r = Array.make_matrix n n I.Void_i in
      for i = 0 to (n - 1) do
       for j = 0 to (n - 1) do
         r. (i). (j) <- I.mk_I (m1. (i). (j), m2. (i). (j));
        done;
      done;
      r

let list_matrix_to_matrix_I m = map_matrix I.Void_i I.list_to_I m
let matrix_list_to_matrix_I x y m_list = list_matrix_to_matrix_I (matrix_list_to_list_matrix x y m_list)

let map2_matrix_tuple eh eb f h b = 
  let n = size h in
  let new_h = Array.make_matrix n n eh in
  let new_b = Array.make_matrix n n eb in 
  for i = 0 to (n - 1) do
    for j = 0 to (n - 1) do
      let h_elt, b_elt = f  (h. (i). (j)) (b. (i). (j)) in
        new_h. (i). (j) <- h_elt; new_b. (i). (j) <- b_elt; 
    done;
  done;
  new_h, new_b

let center_sum_matrix_I h (*(h: interval array array)*) b (*: interval array array * num_i array array *)= map2_matrix_tuple I.zero_I N.zero_i I.center_sum_I h b 

let matrix_inf_I m = map_matrix N.zero_i I.inf_I m
let matrix_rho_I m = map_matrix N.zero_i I.abs_sup_I m

let diag_of_matrix m e = 
  let n = Array.length m in
  let d = Array.make n e in
    for i = 0 to n - 1 do
      d. (i) <- m. (i). (i);
      (*d. (i) <- one_i;*)
    done;
    d
let inv_of_diag d = Array.map N.inv_i d
let sqrt_diag d = Array.map (fun i -> N.sqrt_i (N.abs_i i)) d

let foldl_matrix f m e = 
  let n = size m in
  let a = Array.make n e in
    for i = 0 to (n - 1) do
      a. (i) <- Array.fold_left f e m. (i);
    done;
    Array.fold_left f e a 

let rho_of_matrix m = foldl_matrix N.max_i (matrix_rho_I m) N.zero_i

let matrix_opp e cminus m = map_matrix e cminus m
let matrix_minus_I m = matrix_opp I.zero_I I.minus_I m 


let matrix_cmul c m = map_matrix N.zero_i (fun a -> N.mult_i c a) m 

let matrix_add e cadd m1 m2 =  
  let nx1 = size m1 and nx2 = size m2 in
  let ny1 = size (m1. (0)) and ny2 = size (m2. (0)) in
  let nx, ny = 
    if (nx1 != nx2 || ny1 != ny2) then failwith "Impossible to add matrices"
    else nx1, ny1
  in
  let mat = Array.make_matrix nx ny e in
    for i = 0 to (nx - 1) do
      for j = 0 to (ny - 1) do
          mat. (i). (j) <- cadd (mat. (i). (j)) (cadd (m1. (i). (j)) (m2. (i). (j)));
      done;
    done;
    mat

let array_matrix_cmult d m cmult e = 
  let n = size d in
  let mat = Array.make_matrix n n e in
    for i = 0 to (n - 1) do
      for j = 0 to (n - 1) do
        mat. (i). (j) <- cmult (d. (i)) (m. (i). (j));  
      done;
    done;
    mat
let matrix_array_cmult d m cmult e = 
  let n = size d in
  let mat = Array.make_matrix n n e in
    for i = 0 to (n - 1) do
      for j = 0 to (n - 1) do
        mat. (i). (j) <- cmult (d. (j)) (m. (i). (j));  
      done;
    done;
    mat

(*  a' times m multiplication *)      
let matrix_array_cmult2 a m cadd cmult e = 
  let n = size a in
  let mat = Array.make n e in
    for i = 0 to (n - 1) do
      for j = 0 to (n - 1) do
        mat. (i) <- cadd (cmult (a. (j)) (m. (j). (i))) mat. (i);  
      done;
    done;
    mat

let inner_product a1 a2 = 
  let n = size a1 in
  let r = ref N.zero_i in
    for i = 0 to (n - 1) do
      r := N.add_i !r (N.mult_i a1. (i) a2. (i));
    done;
    !r

let inner_product_general a1 a2 add mul zero = 
  let n = size a1 in
  let r = ref zero in
    for i = 0 to (n - 1) do
      r := add !r (mul a1. (i) a2. (i));
    done;
    !r

let matrix_array_mult2_i a m (* : num_i array*) = matrix_array_cmult2 a m N.add_i N.mult_i N.zero_i
let array_matrix_mult d m = array_matrix_cmult d m N.mult_i N.zero_i
let matrix_array_mult d m = matrix_array_cmult d m N.mult_i N.zero_i
let array_matrix_mult_I d m = array_matrix_cmult d m I.mult_I I.zero_I
let matrix_array_mult_I d m = matrix_array_cmult d m I.mult_I I.zero_I

 
let norm_of_array gx0 = 
  let n = size gx0 in
  let sqr_norm = ref N.zero_i in
  for i = 0 to (n - 1) do
    sqr_norm := N.add_i !sqr_norm (N.sqr_i gx0. (i));
  done;
  N.sqrt_i !sqr_norm 

let norm_array gx0 = 
  let norm = norm_of_array gx0 in
  let n = size gx0 in
    if N.eq_i norm N.zero_i then init_array n 
    else Array.map (fun gi -> N.div_i gi norm) gx0
    
let norm_inf_array gx0 = 
  let norm = I.max_list (Array.to_list gx0) in
  let n = size gx0 in
    if N.eq_i norm N.zero_i then init_array n 
    else Array.map (fun gi -> N.div_i gi norm) gx0

let length2 m1 m2 = 
  let n1, n2 = size m1, size m2 in
    if (n1 != n2) then failwith "Different array sizes"
    else n1

let matrix_add_list nx ny m = List.fold_left (matrix_add N.zero_i N.add_i) (Array.make_matrix nx ny N.zero_i) m

let matrix_sub e cminus cadd m1 m2 = matrix_add e cadd m1 (matrix_opp e cminus m2)
let matrix_sub_i m1 m2 =  matrix_sub N.zero_i N.minus_i N.add_i m1 m2
let matrix_sub_I m1 m2 =  matrix_sub I.zero_I I.minus_I I.add_I m1 m2
let matrix_I m = map_matrix I.zero_I I.mk_i_I m

let matrix_id e0 e1 n = 
  let mat = Array.make_matrix n n e0 in
    for i = 0 to (n - 1) do
      mat. (i). (i) <- e1;
    done;
    mat

let rec sign_list n = 
  if n = 0 then [[]]
  else 
    let tl = sign_list (n - 1) in
      (List.map (fun l -> N.one_i::l) tl) @ (List.map (fun l -> (N.minus_i N.one_i)::l) tl)

let sign_list_1 n =  
  let sign_list_pred = sign_list (n - 1) in
    List.map (fun l -> N.one_i::l) sign_list_pred

let sign_mat n = 
  let list_of_arrays = List.map Array.of_list (sign_list_1 n) in
    Array.of_list list_of_arrays

(* copies all elements from block b to matrix m, starting at element of index
* (i,j) *)
let blit_block b m i j =  
  let n = size b in
   for k = 0 to (n - 1) do
    for l = 0 to (size (b. (k)) - 1) do
     m. (i + k). (j + l) <- b. (k). (l);
    done;
   done;
   ()

(* transforms m which is an upper triangular matrix
 * in order to obtain a symmetric matrix *)      
let sym_of_mat m = 
  let n = size m in
    for i = 1 to (n - 1) do
      for j = 0 to (i - 1) do
        m. (i). (j) <- m. (j). (i);
      done;
    done;
    ()


(* e_i_j is the n x n matrix with 1 value if index = (i,j) or (j,i) and 0 otherwise *)
let e_ij i j n = 
  let mat = Array.make_matrix n n N.zero_i in
    mat. (i). (j) <- N.one_i; mat. (j). (i) <- N.one_i;
    mat

(* Matrix from Th 2.1 (a) and (b) in the "Robust Semidefinite Programming" article by Ben-Tal, El Ghaoui, Nemirovski, solving SDPs with uncertain data *)

let robust_sdp_a k n sk qk fk rho =
  let size = n * 2 in
  let mat = Array.make_matrix size size N.zero_i in
    blit_block sk mat 0 0; 
    let frho = matrix_cmul rho fk in
      blit_block qk mat n n;
      blit_block frho mat 0 n;
      sym_of_mat mat;
      mat

let robust_sdp_b sk_list qk_list f0 =  
  let n = size f0 in
  let sk_sum = matrix_add_list n n sk_list in
  let qk_sum = matrix_add_list n n qk_list in
  let sum = matrix_add N.zero_i N.add_i sk_sum qk_sum in
  let mat = matrix_sub N.zero_i N.minus_i N.add_i (matrix_cmul N.two_i f0) sum in
    sym_of_mat mat;
    mat

(* Particular case for robust_sdp functions when one needs to write the sdpa
 * input problem; returns an array of matrices fi for each variable s_k_i, q_k_i
 * (corresponding to the matrices Sk and Qk of the article) 0 for any
 * additional variable, and the matrix f0 *)

type eij = Eij of int * int | Ei of int 
type rhoij = Rhoij of num_i * int * int | Rhoi of num_i * int

let upper_mat_idx n = 
  let tab = Array.make (U.sum_n n) (0, 0) in
  let idx = ref 0 in
    for i = 0 to (n - 1) do
      for j = i to (n - 1) do
        tab. (!idx) <- (i , j);
        idx := !idx + 1;
      done;
    done;
    tab                  

let ei k upper_tbl : eij = 
  let i, j = upper_tbl. (k) in
    if i = j then Ei (i + 1) else Eij (i + 1, j + 1)

let rho_i k upper_tbl rho : rhoij =
  let i, j = upper_tbl. (k) in 
    if i = j then Rhoi (N.minus_i rho, i + 1) else Rhoij (N.minus_i (N.mult_i N.two_i rho), i + 1, j + 1)

end
