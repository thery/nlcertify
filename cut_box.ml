(*open Unfold_eval_tree*)
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


module Make
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t)  
  (M:Mesh_interval.T with type num_i = N.t and type interval = I.interval) = struct

  type num_i = N.t
  open N
  let _pr_ = U._pr_
  let tol_border = N.num_of_float Config.Config.tolerance_cut_box
  type box_int = L | R | M | F
  let string_of_lfr = function
    | L -> "Left" | R -> "Right" | M -> "Middle" | F -> "Full"                                                      
  let is_M = function | M -> true | _ -> false
  let is_L = function | L -> true | _ -> false
  let is_F = function | F -> true | _ -> false
  let is_R = function | R -> true | _ -> false

let eq_lmrf a b = 
  match a, b with 
  | L, L | R, R | M, M | F, F -> true | _ -> false
let eq_lmrf_box l1 l2 = List.for_all2 eq_lmrf l1 l2

let string_of_lfr_list lfr_l = U.string_of_list (List.map string_of_lfr lfr_l)

let rec mk_box_cst cst n : box_int list = if n <= 0 then [] else cst::(mk_box_cst cst (n-1))
let mk_box_left, mk_box_right, mk_box_full, mk_box_middle  = mk_box_cst L, mk_box_cst R, mk_box_cst F, mk_box_cst M
(*
let mk_hypercubes_pair l n = [ ((mk_box_left (n)) @ (Right::(mk_box_full (l-n-1)))) ; ((mk_box_right (n)) @ (Left::(mk_box_full (l-n-1)))) ]
let rec mk_hypercubes_list_aux l n = if n >= l then [mk_box_right l; mk_box_left l] else (mk_hypercubes_pair l n)  @ mk_hypercubes_list_aux l (n+1)
 *)
let mk_hypercube_left l m = (mk_box_middle (m-1)) @ (L::(mk_box_full (l-m)))
let mk_hypercube_right l m = (mk_box_middle (m-1)) @ (R::(mk_box_full (l-m)))
let rec mk_hypercubes_list_aux l m = if m > l then [mk_box_middle l] else (mk_hypercube_left l m) :: (mk_hypercube_right l m) :: mk_hypercubes_list_aux l (m+1)
let mk_hypercubes_list n = List.rev (mk_hypercubes_list_aux n 1)

let mk_hypercubes_sub_list full_vars ns = 
  let n = M.size full_vars in
  let nv = n - ns in
    _pr_ (Printf.sprintf "ns = %i nv = %i" ns nv) false false;
  let p = mk_hypercubes_list nv in
  let n_cubes = List.length p in
  let result = Array.make_matrix n_cubes n F in 
    for row = 0 to n_cubes - 1 do
      let tbl = Array.of_list (List.nth p row) in
      let c_count = ref 0 in
        for c = 0 to n - 1 do
          let lmrf, count = if full_vars. (c) then F, 0 else tbl. (!c_count), 1 in
          result. (row). (c) <- lmrf; c_count := !c_count + count;
        done;
    done;
  Array.to_list (Array.map Array.to_list result)
                             
let map_box_int_bound lrmf = function
  | bl, br ->
      begin
        match lrmf with 
          | L -> bl
          | R -> br
          | M ->  min_i (snd bl) (snd br), max_i (fst bl) (fst br)
          | F -> min_i (fst bl) (fst br), max_i (snd bl) (snd br)
      end
(*
let mk_br_bl bounds_i optim_i radius = 
  let under_left = under_i (add_i (fst bounds_i) radius) in
  let upper_left = upper_i (add_i (fst bounds_i) radius) in
  let under_right = under_i (sub_i (snd bounds_i) radius) in
  let upper_right = upper_i (sub_i (snd bounds_i) radius) in
  let dleft = abs_i (sub_i (fst bounds_i) optim_i) in
  let dright = abs_i (sub_i (snd bounds_i) optim_i) in
    (*
    if eq_i (fst bounds_i) optim_i 
     *)
    if lt_i dleft dright  
    then (fst bounds_i, upper_left), (under_left, snd bounds_i)
    else (under_right, snd bounds_i), (fst bounds_i, upper_right)
 *)

let mk_br_bl bounds_i optim_i radius =
  let l, r = fst bounds_i, snd bounds_i in
  let w, wl, wr = sub_i r l, sub_i optim_i l, sub_i r optim_i in
  let optim_i, ratio_l, ratio_r = if eq_i w zero_i then l, one_i, zero_i else optim_i, div_i wl w, div_i wr w in
  let rad_l, rad_r = mult_i ratio_l radius, mult_i ratio_r radius in
  let x0, y0 = sub_i optim_i rad_l, add_i optim_i rad_r in 
  let x0, y0 = max_i x0 l, min_i y0 r in
    (*
  let l_plus_rad, r_sub_rad = add_i l radius, sub_i r radius in
     *)
  let a, b, c, d = 
    (* Case when optim_i is closed to the left corner *)
    if le_i (abs_err_i l optim_i) tol_border then l, y0, y0, r 
    (* Case when optim_i is closed to the right corner *)
    else if le_i (abs_err_i r optim_i) tol_border then x0, r, l, x0  
    (* Other Cases *)
    else if I.belongs_I optim_i (I.mk_I (l, x0)) then l, x0, y0, r 
    else if I.belongs_I optim_i (I.mk_I (y0, r)) then y0, r, l, x0
    else l, x0, y0, r 
  in
    _pr_ (U.string_of_tuple_list [(a, b); (c, d)]) false false;
    (a, b), (c, d)

let project_x_on_corner x bounds = 
  let f x_i b_i = 
    let l, r = fst b_i, snd b_i in
    let dl = abs_i (sub_i l x_i) in
    let dr = abs_i (sub_i r x_i) in
      if le_i dl dr then l else r 
  in 
    List.map2 f x bounds

let clean_box bounds_lmrf_array lmrf_box num_box = 
  let lmrf_box, num_box = Array.of_list lmrf_box, Array.of_list num_box in
  let n = M.size lmrf_box in
    assert (n = M.size num_box);
    for j = 0 to n - 1 do
      let bl, br = bounds_lmrf_array. (j) in
      let _ = 
        begin
          if eq_i (snd bl) (fst br) || eq_i (snd br) (fst bl) then 
            begin
              if is_M lmrf_box. (j) then
                begin
                  lmrf_box. (j) <- L; num_box. (j) <- map_box_int_bound L (bl, br);
                end
              else if is_L lmrf_box. (j) then
                begin 
                  lmrf_box. (j) <- R; num_box. (j) <- map_box_int_bound R (bl, br);
                end
              else ()
            end
          else ()
        end
      in
        (*
      let _ = 
        begin
          if eq_i (fst bl) (snd bl) || (eq_i (fst br) (snd br)) then 
            begin
              lmrf_box. (j) <- F; num_box. (j) <- map_box_int_bound F (bl, br);
            end
          else ()
        end
      in
         *)
        ()
    done;
      Array.to_list lmrf_box, Array.to_list num_box

let get_permutations b = b
let get_permutations_cyclic = U.get_permutations 

let rec mk_box_list_hess bounds x0 hx0 radius_array  : (num_i * num_i) list * (num_i * num_i) list list list = 
  let x0 = Array.of_list x0 in
  let n = M.size x0 in
  let bounds = Array.of_list bounds in
  (*let n_boxes = 2 * n in*)
  let bounds_lmrf_array = Array.make n ((zero_i, zero_i), (zero_i, zero_i)) in
  let full_vars_array = Array.make n false in
  let n_full_vars = ref 0 in
    for i = 0 to (n - 1) do
      let b_i, x_i = bounds. (i), x0. (i) in
      (*let ri = mult_i radius (abs_i g_i) in*)
      let ri = radius_array. (i) in
      let wi = I.width_I (I.mk_I b_i) in
      let r_i, is_singl, count = if ge_i ri wi then wi, true, 1 else ri, false, 0 in
        _pr_ (Printf.sprintf "i = %i is_singl = %b" (i+1) is_singl ) false false;
        bounds_lmrf_array . (i) <- mk_br_bl b_i x_i r_i ; full_vars_array. (i) <- is_singl; n_full_vars := !n_full_vars + count;
    done;
    let map_lmrf lmrf_list = List.map2 map_box_int_bound lmrf_list (Array.to_list bounds_lmrf_array) in
    let lmrf_box_list = mk_hypercubes_sub_list full_vars_array !n_full_vars in
    let num_box_list =  List.map map_lmrf lmrf_box_list in
    let lmrf_and_num_boxes = List.map2 (clean_box bounds_lmrf_array) lmrf_box_list num_box_list in
    let lmrf_boxes, num_boxes = List.split lmrf_and_num_boxes in
      try
        begin          
          let lmrf_sub_box, lmrf_partition = U.hd_tl lmrf_boxes in
            (*
             begin
               _pr_ "The partitioning of the box is the box itself: i will try to get a smaller box" true true;
               mk_box_list_hess (Array.to_list bounds) (Array.to_list x0) hx0 radius_array
             end
             *)
          let lmrf_partition = U.elim_same_lists eq_lmrf_box lmrf_partition in
            _pr_ (U.concat_string_with_string (List.map string_of_lfr_list lmrf_partition) "\n") true false;
            let partition = List.map get_permutations lmrf_partition in
            (*
             let partition =  map (permute_list_n 5) partition in
             *)
            (*
             let partitions = map (fun idx -> map (fun t -> nth t idx) partitions) (int_to_list n_boxes) in
             map_lrf sub_box, map (fun p -> map map_lrf p) partitions
             *)
            let num_sub_box, num_partitions = map_lmrf lmrf_sub_box, List.map (fun p -> List.map map_lmrf p) [partition] in
              num_sub_box, num_partitions
        end
      with U.Empty_list -> failwith "Both sub box and partitioning are empty, initial problem may be infeasible"

(* Cut the box in (n + 1) boxes with n = length optim, assuming optima is a corner of
 * the box bounds *)

let mk_box_list bounds x0 radius = 
  let bounds_lr_list = List.map2 (fun b o -> mk_br_bl b o radius) bounds x0 in
  let map_lrf lrf_list = List.map2 map_box_int_bound lrf_list bounds_lr_list in
  let box12 = mk_hypercubes_list (List.length x0) in
    List.rev (List.map map_lrf box12)

let cut_box dir bounds = 
  let bounds = Array.of_list bounds in
  let n = M.size bounds in
  let box1, box2 = Array.make n (zero_i, zero_i), Array.make n (zero_i, zero_i) in
    for i = 0 to n - 1 do
      let l, r = fst (bounds. (i)), snd (bounds. (i)) in
      let m = U.m_I l r in
      let bl, br = if i = dir then (l, upper_i m), (under_i m, r) else bounds. (i), bounds. (i) in
        box1. (i) <- bl;  box2. (i) <- br;
    done;
    [Array.to_list box1; Array.to_list box2]

let cut_box_first (box : (num_i * num_i) list) n : (num_i * num_i) list list = 
  let hd, tl_list = U.hd_tl box in
  let hd_list = M.cut_I (I.mk_I hd) n in
  let hd_list = M.mk_box_i hd_list in
    List.map (fun h -> h::tl_list) hd_list
end
