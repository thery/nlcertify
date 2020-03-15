
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


module Make(N: Numeric.T)(F: Functions.T with type num_i = N.t) (U: Tutils.T with type t = N.t)   = struct

  open N
  open F
  type num_i = N.t
  type f = F.f
  (*open Tutils*)
  let zero_tuple = zero_i, zero_i
  let ten_tuple = ten_i, ten_i 

  let func_checkable = [
    "sin";"cos";"tan";"asin";"acos";"atan";"sqrt";"log";"inv_i"; "exp"
  ]

  let ml_functions = [
    "cnd";"if";"then";"else";"let";"and";"tuple";"sin";"cos";"tan";"asin";"acos";"atan";"sqrt";"log";"exp";"add_i";"sub_i";"mult_i";"div_i";"pow_i";"minus_i";"abs_i";"inv_i";"eq_i";"lt_i";"le_i";"gt_i";"gt_e";"atan2"
  ]

  let list_func_basic2 = [
    ("add_i",add_i);("sub_i",sub_i);("mult_i",mult_i);("div_i",div_i);("pow_i",pow_i); ("atan2", fun x y -> atan2_i y x)
  (*  ("atan2",atan2);*)
  ]
  let list_func_basic = [
    ("cos",cos_i);("sin",sin_i);("tan",tan_i);("atan",atan_i);("acos",acos_i);("asin",asin_i);("minus_i",minus_i);("sqrt",sqrt_i);("abs_i",abs_i);("inv_i",inv_i);("log",log_i);("exp",exp_i)
  ]

  let list_func_transc = [
    ("cos",cos_i);("sin",sin_i);("tan",tan_i);("atan",atan_i);("acos",acos_i);("asin",asin_i); ("log", log_i); ("exp", exp_i)
  ]

  let list_func_bool = [
    ("eq_i",eq_i);("lt_i",lt_i);("le_i",le_i);("gt_i",gt_i);("ge_i",ge_i);
  ]

  let list_str_func_bool = [
    ("eq_i","=");("lt_i","<");("le_i","<=");("gt_i",">");("ge_i",">=");("and","&&")
  ]


  type interval = Int of num_i * num_i | Void_i
  type inter_mut = {mutable i:interval}

  let tuple_of_num i = (i, i) 
  let tuple_of_num_list = List.map tuple_of_num
  let zero_tuple = tuple_of_num zero_i
  let ten_tuple = tuple_of_num ten_i
  exception Refine

  let tuple_is_singleton = function
    | a, b when eq_i a b -> true
    | _ -> false

  let mk_I = function
    | i1, i2 -> Int (i1, i2)

  let mk_i_I i = mk_I (tuple_of_num i)

  let tuple_I = function
    | Int (i1, i2) -> i1, i2
    | Void_i -> raise Refine

  let mid_I = function
    | Int (i1, i2) -> U.m_I i1 i2
    | Void_i -> raise Refine


  let width_I = function
    | Int (i1, i2) -> sub_i i2 i1
    | Void_i -> raise Refine


  let half_width_I i = div_i (width_I i) two_i

  let inf_I = function
    | Int (i1, i2) -> i1
    | Void_i -> raise Refine

  let sup_I = function
    | Int (i1, i2) -> i2
    | Void_i -> raise Refine                  

  let norm_I = function
    | Int (i1, i2) -> (le_i (abs_i i1) one_i) && (le_i (abs_i i2) one_i)
    | Void_i -> raise Refine

  let abs_sup_I = function
    | Int (i1, i2) -> max_i (abs_i i1) (abs_i i2)
    | Void_i -> raise Refine

  let tuple_of_I interval = 
    match interval with
      | Int (i1, i2) -> (i1, i2)
      | Void_i -> failwith "Cannot extract floats with Void_i"  

  let max_I = function
    | Int (i1, i2), Int (i3, i4) -> Int (max_i i1 i3, max_i i2 i4)
    | _ -> Void_i

  let min_I = function
    | Int (i1, i2), Int (i3, i4) -> Int (min_i i1 i3, min_i i2 i4)
    | _ -> Void_i

  let string_of_list_i l = U.string_of_list (List.map string_of_i l)
  let string_float_list l prec = U.string_of_list (List.map (fun i -> string_float i prec) l)

  let void_I  = function
    | Void_i -> true
    | _ -> false

  let mk_void_I () = Void_i

  let string_I interv = 
    match interv with 
      | Int (i1,i2) -> "[" ^string_of_i (i1)^ ", " ^string_of_i (i2)^"]" 
      | Void_i -> "[]"

  let string_float_I interv prec = 
    match interv with 
      | Int (i1,i2) -> "[" ^ string_float i1 prec ^ ", " ^ string_float i2 prec ^"]" 
      | Void_i -> "[]"

  let string_of_list_I l = U.concat_string_with_string (List.map string_I l) "; " 

  let string_of_I interv = 
    match interv.i with
      | Int (i1,i2) -> "[" ^string_of_i (i1)^ ", " ^string_of_i (i2)^"]" 
      | Void_i -> "[Void_i]"

  let min_list l =
    try  
      let rec min_aux l m =
        match l with
          |[] -> m
          |h::tl -> min_aux tl (if le_i h m then h else m)
      in
        min_aux l (List.nth l 0)
    with Failure _ -> failwith "list is too short"

  let max_list l : num_i =
    try  
      let rec max_aux l m =
        match l with
          |[] -> m
          |h::tl -> max_aux tl (if ge_i h m then h else m)
      in
        max_aux l (List.nth l 0)
    with Failure _ -> failwith "list is too short"


  let list_to_I = function
    | hd::tl as l -> mk_I ((min_list l), (max_list l))
    | [] -> Void_i

  let min_list_cnd l l_cnd pos =
    let cmp_i = if pos then ge_i else le_i in
    let rec min_aux l l_cnd m =
      match l, l_cnd with
        |[], [] -> m
        |h::tl, h_cnd::tl_cnd -> min_aux tl tl_cnd (if (le_i h m && cmp_i h_cnd zero_i) then h else m)
        | _ -> failwith "list is too short"
    in
      min_aux l l_cnd (max_list l) 

  let rec sort_tol rel_tol abs_tol = function
    | a::b::tl -> 
        begin
          let elt = if le_i (rel_err_i a b) rel_tol || le_i (abs_err_i a b) abs_tol then [] else [a] in
            elt @ (sort_tol rel_tol abs_tol (b::tl))
        end
    | _ as l -> l

  let min_i a b = min_list [a; b]
  let max_i a b = max_list [a; b]

  let is_singleton_I = function  | Int (a, b) when eq_i a b -> true | _ -> false

  let union_I interv1 interv2 = 
    match interv1, interv2 with 
      | Int (a1, b1), Int (a2, b2) -> Int (min_i a1 a2, max_i b1 b2)
      | Int (a, b), Void_i -> Int(a, b)
      | Void_i, Int (a, b) -> Int(a, b)
      | _ -> Void_i

  let intersection_I interv1 interv2 = 
    match interv1, interv2 with 
      | Int (a1, b1), Int (a2, b2) -> 
          begin
            let a = max_i a1 a2 and b = min_i b1 b2 in
              if le_i a b then Int (a, b) else Void_i
          end
      | _ -> Void_i

  let narrow_I interv1 interv2 = 
    match interv1, interv2 with
      | Int _, Int _ -> intersection_I interv1 interv2
      | _ -> union_I interv1 interv2

  let rec union_list_I interv_list = 
    match interv_list with 
      | interv::tl -> union_I interv (union_list_I tl)
      | [] -> Void_i

  let rec fold_spec f = function
    | [i] -> i
    | i::tl ->  f i (fold_spec f tl)
    | []-> failwith "Intervals fold_spec needs at least two arguments"

  let intersection_list_I = fold_spec intersection_I

  let add_I interv1 interv2 =
    match interv1, interv2 with
      | Int (i1,i2), Int (i3,i4) ->  Int (add_i i1 i3 , add_i i2 i4)
      | interv1, Void_i -> Void_i
      | Void_i, interv2 -> Void_i
  (* | Void_i, Void_i -> Void_i*)

  let minus_I interv = 
    match interv with 
      |Int (i1,i2) -> Int (minus_i i2, minus_i i1)
      |Void_i -> Void_i

  let sub_I interv1 interv2 = add_I interv1 (minus_I interv2)

  let mult_ineff_I interv1 interv2 =
    match interv1, interv2 with
      | Int (a,b), Int (c,d)-> let l = [mult_i a c;mult_i a d;mult_i b c;mult_i b d] in
          Int (min_list l, max_list l)
      | _ -> Void_i 

  let is_positive_interv interv = 
    match interv with 
      | Int (a, b) -> ge_i a zero_i
      | Void_i -> false

  let sgn_I interv =
    match  interv with 
      | Int (a, b) ->
          if ge_i a zero_i then 1 
          else if le_i b zero_i then (-1)
          else if (le_i a zero_i && ge_i b zero_i) then 0 
          else 
            begin
              U._pr_ (string_I interv) true true;
              failwith "interval not defined"
            end
      | Void_i ->  0

  let center_sum_I i m : interval * num_i = 
    let new_i =  mk_I ((minus_i (half_width_I i)), (half_width_I i)) in
    let a, b = tuple_of_I i in
    let new_m = add_i m (U.m_I a b) in
      new_i, new_m

  let rec mult_I interv1 interv2 =
    match (interv1, interv2) with
      | (Int (a,b), Int (c,d))-> 
          (match sgn_I interv1, sgn_I interv2 with
             | 1,1 -> Int(mult_i a c, mult_i b d)
             | 1,0 -> Int(mult_i b c, mult_i b d)
             | 0,0 -> Int(min_i (mult_i a d) (mult_i b c), max_i (mult_i a c) (mult_i b d))
             | 0,1 -> mult_I interv2 interv1
             | (-1),(-1) -> mult_I (minus_I interv1) (minus_I interv2) 
             | -1,1 -> minus_I (mult_I (minus_I interv1) interv2)
             | (-1),0 -> minus_I (mult_I (minus_I interv1) interv2)
             | 1,(-1) -> minus_I (mult_I (minus_I interv2) interv1)
             | 0,(-1) -> minus_I (mult_I (minus_I interv2) interv1)
             | _ -> failwith "can not evaluate sign of intervals"
          )
      | _ ->  Void_i

  let multiplication_I = mult_I 

  let mk_num_I i = Int (i,i)

  let zero_I = mk_num_I zero_i
  let one_I = mk_num_I one_i
  let two_I = mk_num_I two_i

  let ge_I interv1 interv2 = 
    match (interv1,interv2) with 
      | (Int (a,b), Int(c,d)) -> a >= d 
      | _ -> false

  let gt_I interv1 interv2 =
    match (interv1,interv2) with
      | (Int (a,b), Int(c,d)) -> a > d 
      | _ -> false

  let le_I interv1 interv2 =
    match (interv1,interv2) with
      | (Int (a,b), Int(c,d)) -> b <= c 
      | _ -> false

  let lt_I interv1 interv2 =
    match (interv1,interv2) with
      | (Int (a,b), Int(c,d)) -> b < c 
      | _ -> false

  let eq_I interv1 interv2 =
    match interv1, interv2 with
      | Int (a, b), Int(c, d) -> a = c && b = d
      | Void_i, Void_i -> true
      | _ -> false

  let belongs_I x = function
    | Int (a,b) -> le_i x b && ge_i x a
    | Void_i -> false

  let belongs_list_I l interv = List.for_all (fun x -> belongs_I x interv) l 


  let included_in_I interv1 interv2 = 
    match interv1 with 
      | Int (a,b) -> (belongs_I a interv2 && belongs_I b interv2)
      | Void_i -> true

  let interv_of_min i1 i2 =
    match i1, i2 with
      | Void_i, _ -> i2
      | _, Void_i -> i1
      | _, _ -> 
          begin
            let a = min_i (inf_I i1) (inf_I i2) in
            let b = min_i (sup_I i1) (sup_I i2) in
              Int (a, b)
          end
  let interv_of_max i1 i2 =
    match i1, i2 with
      | Void_i, _ -> i2
      | _, Void_i -> i1
      | _, _ -> 
          begin
            let a = max_i (inf_I i1) (inf_I i2) in
            let b = max_i (sup_I i1) (sup_I i2) in
              Int (a, b)
          end
  let interv_of_min = fold_spec interv_of_min
  let interv_of_max = fold_spec interv_of_max
  let abs_I interv =  
    match interv with 
      | Int (a,b) -> 
          begin
            if ge_I interv zero_I then interv
            else if le_I interv zero_I then minus_I interv
            else Int (zero_i, max (abs_i a) (abs_i b))
          end
      | Void_i -> Void_i

  let abs_diff_I interv1 interv2 = abs_I (sub_I interv1 interv2)



  (*
   let narrow_I interv1 interv2 = 
   let a =  max (inf_I interv1) (inf_I interv2) in
   let b =  min (sup_I interv1) (sup_I interv2) in
   Int (a, b)
   *)
  let inv_I interv = 
    match interv with 
      |  Int (a,b) -> if belongs_I zero_i interv then failwith "Dividing by interval containing zero!!" else Int(div_i one_i b, div_i one_i a)
      |  Void_i -> Void_i

  let div_I interv1 interv2 = multiplication_I (interv1) (inv_I interv2)

  let sqr_I i = multiplication_I (abs_I i) (abs_I i)

  let rec pow_I_aux interv1 i = 
    if i<=0 then Int(one_i, one_i) 
    else if i = 2 then sqr_I interv1 
    else multiplication_I (pow_I_aux interv1 (i-1)) interv1

  let pow_I interv1 interv2 = 
    match interv2 with 
      | Int (a, b) -> if eq_i a b then  ( let a = int_of_num a in pow_I_aux interv1 a) else  failwith "cannot take the power of this interval"
      | _ -> failwith "cannot take the power of this interval"

  let sqrt_I interv = 
    match interv with 
      | Int (a,b) -> if ge_i a zero_i then Int (sqrt_i_lo a, sqrt_i_up b) else Void_i
      | Void_i -> Void_i

  let pi = mult_i four_i (atan_i one_i) 
  let p_1_sqrt_3 = inv_i (sqrt_i three_i)
  let m_1_sqrt_3 = minus_i p_1_sqrt_3
  let half_pi = div_i pi two_i
  let three_half_pi = mult_i half_pi three_i
  let two_pi = mult_i pi two_i
  let itv1 = Int (minus_i two_pi , minus_i three_half_pi) 
  let itv2 = Int (minus_i half_pi, half_pi) 
  let itv3 = Int (three_half_pi, two_pi) 
  let itv4 = Int (minus_i three_half_pi, minus_i half_pi) 
  let itv5 = Int (half_pi, three_half_pi) 


  let atan_I interv = 
    match interv with
      | Int (a,b) -> Int (atan_i a, atan_i b)
      | Void_i -> Void_i

  let log_I interv =
    match interv with
      | Int (a,b) -> Int (log_i a, log_i b)
      | Void_i -> Void_i

  let exp_I = function
    | Int (a, b) -> Int (exp_i a, exp_i b)
    | Void_i -> Void_i

  let period_I f0 p interv min_f max_f = 
    match interv with 
      | Int (a,b) -> (if lt_i (sub_i b a) p then 
                        (let k = ceil_i (div_i a  p) in 
                         let new_a = sub_i a (mult_i k p) in 
                         let new_b = sub_i b (mult_i k p) in 
                           f0 (Int( new_a , new_b)) )
                      else Int (min_f, max_f)) 
      | Void_i -> Void_i 
  let sin0_I interv = 
    match interv with 
      | Int (a,b) -> 
          begin
            if gt_i (sub_i b a) two_pi then Int( minus_i one_i, one_i)
            else if (belongs_I a itv1 && belongs_I b itv1) || (belongs_I a itv2 && belongs_I b itv2) || (belongs_I a itv3 && belongs_I b itv3) then Int (sin_i a,sin_i b)
            else if (belongs_I a itv4 && belongs_I b itv4) || (belongs_I a itv5 && belongs_I b itv5) then Int (sin_i b,sin_i a)
            else if ( 
              (belongs_I (minus_i three_half_pi) interv && belongs_I b itv4)
                ||  (belongs_I half_pi interv && belongs_I a itv2 && belongs_I b itv5)
            )then Int (min_i (sin_i a) (sin_i b), one_i)
            else if( 
              (belongs_I three_half_pi interv && belongs_I a itv5)
                || (belongs_I (minus_i half_pi) interv && belongs_I a itv4 && belongs_I b itv2)
            )then Int (minus_i one_i, max_i (sin_i a) (sin_i b))
            else Int( minus_i one_i, one_i)
          end
      |Void_i -> Void_i 

  let sin_I interv = period_I sin0_I two_pi interv (minus_i one_i) one_i

  let cos_I interv = sin_I (sub_I (mk_i_I half_pi) interv) 

  let tan_I interv = div_I (sin_I interv) (cos_I interv)

  let acos_I interv = 
    match interv with
      |Int (a,b) -> if (belongs_I a (Int((minus_i one_i), one_i)) && belongs_I b (Int(minus_i one_i, one_i)) ) then Int (acos_i b, acos_i a) else failwith "acos_i not defined on this interval"
      |Void_i -> Void_i

  let asin_I interv = sub_I (mk_i_I half_pi) (acos_I interv)

  let list_interval_basic2 = [
    ("add_i",add_I);("sub_i",sub_I);("mult_i",multiplication_I);("div_i",div_I);("pow_i",pow_I)
  ]
  let list_interval_basic = [
    ("cos",cos_I);("sin",sin_I);("tan",tan_I);("sin",sin_I);("atan",atan_I);("acos",acos_I);("asin",asin_I);("minus_i",minus_I);("sqrt",sqrt_I);("abs_i",abs_I);("inv_i",inv_I);("log",log_I);("exp", exp_I)
  ]
  let list_interval_bool = [
    ("eq_i",eq_I);("lt_i",lt_I);("le_i",le_I);("gt_i",gt_I);("ge_i",ge_I)
  ]

  let f_interv_inter_mut1 f im () = {i = f im.i}
  let f_interv_inter_mut2 f im1 im2 = f im1.i im2.i
  let minus_of_I im () = f_interv_inter_mut1 minus_I im ()
  let eq_of_I im1 im2 = f_interv_inter_mut2 eq_I im1 im2

  let add_I_num i n = add_I i (mk_i_I n)                        
  let mult_I_num i n = mult_I i (mk_i_I n)
  let add_of_I_num i n () = { i = add_I i.i (Int (n, n))}
  let mult_of_I_num i n () = { i = mult_I i.i (Int (n, n))}

  let min_c_atan interval = 
    let transc'_num = F.transc'_num in
    let f1, f2 = tuple_of_I interval in
    let c_1_sqrt3 = transc'_num atan'' (p_1_sqrt_3) in
    let c_f1 = transc'_num atan'' f1 and c_f2 = transc'_num atan'' f2 in
      if ge_I interval zero_I then 
        if belongs_I p_1_sqrt_3 interval
        then c_1_sqrt3
        else min_i c_f1 c_f2
      else if le_I interval zero_I then min_i c_f1 c_f2
      else 
        if ge_i f2 p_1_sqrt_3 
        then c_1_sqrt3
        else min_i c_f1 c_f2

  let max_c_atan interval = 
    let f1, f2 = tuple_of_I interval in
    let c_1_sqrt3 = transc'_num atan'' (p_1_sqrt_3) in
    let c_m_1_sqrt3 = minus_i c_1_sqrt3 in
    let c_f1 = transc'_num atan'' f1 and c_f2 = transc'_num atan'' f2 in
      if le_I interval zero_I then
        if (belongs_I m_1_sqrt_3 interval) 
        then c_m_1_sqrt3
        else max_i c_f1 c_f2
      else if ge_I interval zero_I then max_i c_f1 c_f2
      else 
        if le_i f1 m_1_sqrt_3 
        then c_m_1_sqrt3
        else max_i c_f1 c_f2

  let min_c_cos interval = inf_I (minus_I (cos_I interval))
  let max_c_cos interval = sup_I (minus_I (cos_I interval))
  let min_c_sin interval = inf_I (minus_I (sin_I interval))
  let max_c_sin interval = sup_I (minus_I (sin_I interval))
  let tan_2_I interval = 
    let ( * ), ( + ) = mult_I, add_I in
      one_I + two_I * (tan_I interval) * (one_I + sqr_I (atan_I interval))
  let min_c_tan, max_c_tan = (fun i -> inf_I (tan_2_I i)), (fun i -> sup_I (tan_2_I i))
  let min_c_exp, max_c_exp = (fun i -> inf_I (exp_I i)), (fun i -> sup_I (exp_I i))
  let min_c_log i = inf_I (minus_I (inv_I (sqr_I i)))
  let max_c_log i = sup_I (minus_I (inv_I (sqr_I i)))
  let min_c_acos i = transc'_num acos'' (sup_I i)
  let max_c_acos i = transc'_num acos'' (inf_I i)
  let min_c_asin i = N.minus_i (max_c_acos i)
  let max_c_asin i = N.minus_i (min_c_acos i)
  let min_c_sqrt i = transc'_num sqrt'' (inf_I i)
  let max_c_sqrt i = transc'_num sqrt'' (sup_I i)

  let min_c_conv_atan interval x0 =
    let f1, f2 = tuple_of_I interval in
    let f'_x0 = transc'_num atan' x0 in
    let f_x0 = atan_i x0 in
      if eq_i f1 x0  || eq_i f2 x0 then transc'_num atan'' x0 
      else
        begin
          let f_aux x = 
            let f_x = atan_i x in
            let e0 = sub_i f_x f_x0 in
            let e1 = mult_i f'_x0 (sub_i x x0 ) in
            let e2 = sqr_i (sub_i x x0 ) in
              div_i (sub_i e0 e1) e2
          in
            (*
            _pr_ (Printf.sprintf "f1: %.15f f2: %.15f x0: %.15f" f1 f2 x0) false false;
             *)
            mult_i two_i (min_i (f_aux f1) (f_aux f2))
        end

  let max_c_conv_atan interval x0 =
    let f1, f2 = tuple_of_I interval in
    let f'_x0 = transc'_num atan' x0 in
    let f_x0 = atan_i x0 in
      if eq_i f1 x0 || eq_i f2 x0 then transc'_num atan'' x0 
      else
        begin
          let f_aux x = 
            let f_x = atan_i x in
            let e0 = sub_i f_x f_x0 in
            let e1 = mult_i f'_x0 (sub_i x x0 ) in
            let e2 = sqr_i (sub_i x x0 ) in
              div_i (sub_i e0 e1) e2
          in
            (*
            _pr_ (Printf.sprintf "f1: %.15f f2: %.15f x0: %.15f" f1 f2 x0) false false;
             *)
            mult_i two_i (max_i (f_aux f1) (f_aux f2))
        end


  let list_min_c = [
    ("atan", min_c_atan);("acos", min_c_acos);("asin", min_c_asin);("cos", min_c_cos);("sin", min_c_sin);("tan", min_c_tan);("exp", min_c_exp);("log", min_c_log); ("sqrt", min_c_sqrt);
  ]
  let list_max_c = [
    ("atan", max_c_atan);("acos", max_c_acos);("asin", max_c_asin);("cos", max_c_cos);("sin", max_c_sin);("tan", max_c_tan);("exp", max_c_exp);("log", max_c_log); ("sqrt", max_c_sqrt);
  ]

  let sin_is_conv interv = 
    match interv with
      | Int (a,b) -> if  ((belongs_I a (Int( minus_i pi , zero_i)) &&  belongs_I b (Int(minus_i pi , zero_i))) 
          ||  (belongs_I a (Int(pi , two_pi)) &&  belongs_I b (Int(pi , two_pi))))
then true else false
             | Void_i -> true
  let sin_is_conc interv = 
    match interv with
      | Int (a,b) -> if  ((belongs_I a (Int(zero_i, pi)) &&  belongs_I b (Int( zero_i, pi))) 
          ||  (belongs_I a (Int( minus_i two_pi , minus_i pi)) &&  belongs_I b (Int( minus_i two_pi , minus_i pi))))
then true else false
             | Void_i -> true

  let cos_is_conv interv = sin_is_conv (sub_I (mk_i_I half_pi) interv)
  let cos_is_conc interv = sin_is_conc (sub_I (mk_i_I half_pi) interv)
  let tan_is_conv interv = 
    match interv with
      | Int (a,b) -> 
          if ge_i (sub_i b a) pi
          then false 
          else 
            begin
              let k = int_of_num (div_i a pi) in 
              let k = num_of_int k in
              let new_a = sub_i a (mult_i k pi) in 
              let new_b = sub_i b (mult_i k pi) in 
                ge_I (Int(new_a, new_b)) zero_I
            end
      | Void_i -> true

  let tan_is_conc interv = tan_is_conv (minus_I interv)
  let atan_is_conv interv = le_I interv zero_I
  let atan_is_conc interv = atan_is_conv (minus_I interv)
  let asin_is_conv interv = ge_I interv zero_I && included_in_I interv (mk_I (minus_i one_i, one_i))
  let asin_is_conc interv = asin_is_conv (minus_I interv)
  let acos_is_conv interv = le_I interv zero_I && included_in_I interv (mk_I (minus_i one_i, one_i))
  let acos_is_conc interv = acos_is_conv (minus_I interv)
  let sqrt_is_conc interv = ge_I interv zero_I
  let sqrt_is_conv interv = false
  let log_is_conc interv = gt_I interv zero_I
  let log_is_conv interv = false
  let exp_is_incr i = true
  let exp_is_deacr i = false
  let exp_is_conc i = false
  let exp_is_conv i = true


  let sin_is_incr interv = included_in_I interv itv1 || included_in_I interv (Int( minus_i half_pi , half_pi)) || included_in_I interv (minus_I itv1)

  let sin_is_deacr interv = included_in_I interv itv4 || included_in_I interv itv5

  let cos_is_incr interv = sin_is_incr (sub_I (mk_i_I half_pi) interv)
  let cos_is_deacr interv = sin_is_deacr (sub_I (mk_i_I half_pi) interv)

  let tan_is_incr interv = 
    match interv with
      | Int (a,b) -> lt_i (sub_i b a) pi
      | Void_i -> true

  let tan_is_deacr interv = false
  let atan_is_incr interv = ((*Printf.printf "check incr %s %B\n" (string_I interv) (not (interv_is_nan interv) );*) true  )
  let atan_is_deacr interv = false
  let asin_is_incr interv = included_in_I interv (mk_I (minus_i one_i, one_i))
  let asin_is_deacr interv = false
  let acos_is_incr interv = false
  let acos_is_deacr interv = included_in_I interv (mk_I (minus_i one_i, one_i))
  let sqrt_is_incr interv = ge_I interv zero_I
  let sqrt_is_deacr interv = false
  let log_is_incr interv = ge_I interv zero_I
  let log_is_deacr interv = false
  let inv_is_deacr interv = not (belongs_I zero_i interv)
  let inv_is_incr interv = false                         
  let inv_is_conc interv = lt_I interv zero_I
  let inv_is_conv interv = gt_I interv zero_I

  let list_check_prop = [
    ("sin",[sin_is_conv;sin_is_conc;sin_is_incr;sin_is_deacr]);
    ("cos",[cos_is_conv;cos_is_conc;cos_is_incr;cos_is_deacr]);
    ("tan",[tan_is_conv;tan_is_conc;tan_is_incr;tan_is_deacr]);
    ("asin",[asin_is_conv;asin_is_conc;asin_is_incr;asin_is_deacr]);
    ("acos",[acos_is_conv;acos_is_conc;acos_is_incr;acos_is_deacr]);
    ("atan",[atan_is_conv;atan_is_conc;atan_is_incr;atan_is_deacr]);
    ("sqrt",[sqrt_is_conv;sqrt_is_conc;sqrt_is_incr;sqrt_is_deacr]);
    ("log",[log_is_conv;log_is_conc;log_is_incr;log_is_deacr]);
    ("exp",[exp_is_conv;exp_is_conc;exp_is_incr;exp_is_deacr]);
    ("inv_i",[inv_is_conv;inv_is_conc;inv_is_incr;inv_is_deacr])
  ]

  let list_derivative_basic = [
    ("cos",cos');("sin",sin');("tan",tan');("atan",atan');("acos",acos');("asin",asin');("sqrt",sqrt');("log",log');("inv_i",inv'); ("exp",exp')
  ]
  let list_deriv_order2 = [
    ("cos",cos'');("sin",sin'');("tan",tan'');("atan",atan'');("acos",acos'');("asin",asin'');("sqrt",sqrt'');("log",log'');("inv_i",inv'');("exp",exp'')
  ]
  let list_deriv_order3 = [
    ("atan",F.atan_d3);
  ]

  let func_basic2 : (string, (num_i -> num_i -> num_i )) Hashtbl.t = Hashtbl.create 5
  let func_basic : (string, (num_i -> num_i )) Hashtbl.t  = Hashtbl.create 12
  let func_transc : (string, (num_i -> num_i )) Hashtbl.t  = Hashtbl.create 7
  let func_bool : (string, (num_i -> num_i -> bool )) Hashtbl.t  = Hashtbl.create 5 
  let str_func_bool : (string, string) Hashtbl.t  = Hashtbl.create 6 

  let func_interval_basic2 = Hashtbl.create 5
  let func_interval_basic = Hashtbl.create 12
  let func_interval_bool = Hashtbl.create 5


  let func_derivative_basic : (string, (num_i -> F.f )) Hashtbl.t = Hashtbl.create 9                        
  let func_deriv_order2 : (string, (num_i -> F.f )) Hashtbl.t = Hashtbl.create 9                        
  let func_deriv_order3 : (string, (num_i -> F.f)) Hashtbl.t = Hashtbl.create 9                        

  let func_min_c = Hashtbl.create 9
  let func_max_c = Hashtbl.create 9

  let func_check_prop_list = Hashtbl.create 9


  type user_func = {
    u_name: string;
    u : num_i -> num_i;
    u_I : interval -> interval;
    u' : num_i -> F.f;
    u'' : num_i -> F.f;
    u_min_c : interval -> num_i;
    u_max_c : interval -> num_i;
    u_prop : (interval -> bool) list
  }
  let mk_user_func name u u_I u' u'' u_min_c u_max_c u_prop =     
    {u_name = name; u = u; u_I = u_I; u' = u'; u'' = u''; u_min_c = u_min_c; u_max_c = u_max_c; u_prop = u_prop}

  let func1 () = 
    let name = "ml_27" in
    let inv_pi = N.inv_i pi in      
    let minus_pi = N.minus_i pi in
    let inv_pi_I, minus_pi_I = mk_i_I inv_pi, mk_i_I minus_pi in
    let ( * ), ( + ) = N.mult_i, N.add_i in
    let u x = cos_i (x * inv_pi) * exp_i (minus_pi * x) in
    let u_I i = mult_I (cos_I (mult_I inv_pi_I i)) (exp_I (mult_I minus_pi_I i)) in
    let u' x = F.Num ((N.minus_i inv_pi) * sin_i (x * inv_pi) * exp_i (minus_pi * x) + minus_pi * cos_i (x * inv_pi) * exp_i (minus_pi * x)) in
    let u'' x = Num N.zero_i in
    let u_c = N.sqr_i inv_pi + N.two_i + N.sqr_i pi in
    let u_min_c, u_max_c = (fun _ -> N.minus_i u_c), (fun _ -> u_c) in
    let u_prop = [(fun _ -> false); (fun _ -> false); (fun _ -> false); (fun _ -> false)] in
      mk_user_func name u u_I u' u'' u_min_c u_max_c u_prop 

  let func2 () = 
    let name = "pp_33" in
    let e = exp_i one_i in
    let e_3_2 = exp_i (num_of_float 1.5) in
    let ( * ), ( + ), ( / ), ( - ) = N.mult_i, N.add_i, N.div_i, N.sub_i in
    let ( <= ), ( >= ) = le_i, ge_i in
    let u y = sqr_i (log_i y) in
    let u_I i = sqr_I (log_I i) in
    let u' y = F.Num (two_i / y * log_i y) in
    let u'' y = F.Num (two_i / (sqr_i y) * (one_i - log_i y)) in
    let u_min_c i = 
      if belongs_I e_3_2 i then  F.transc'_num u'' e_3_2 
      else if (sup_I i) <= e_3_2 then  F.transc'_num u'' (sup_I i)
      else F.transc'_num u'' (inf_I i) in
    let u_max_c i = max_i (F.transc'_num u'' (inf_I i)) (F.transc'_num u'' (sup_I i)) in
    let is_incr i = (inf_I i) >= e in (* is also convexe on such i *)
    let is_deacr i = (sup_I i) <= e in (* is also concave on such i *)
    let u_prop = [is_incr; is_deacr; is_incr; is_deacr] in
      mk_user_func name u u_I u' u'' u_min_c u_max_c u_prop 

  let func3 () = 
    let name = "swf_43" in
    let ( * ), ( + ), ( / ), ( - ) = N.mult_i, N.add_i, N.div_i, N.sub_i in
    let u y = sin_i (sqrt_i y) in
    let u_I i = sin_I (sqrt_I i) in
    let deriv y = one_i / (two_i * sqrt_i y) * (cos_i (sqrt_i y)) in
    let u' y = F.Num (deriv y) in
    let u'' y = F.Num (N.num_of_float 0.001) in
    let u_min_c i = N.num_of_float (-0.001) in
    let u_max_c i =  N.num_of_float 0.001 in
    let is_incr i = false in (* is also convexe on such i *)
    let is_deacr i = false in (* is also concave on such i *)
    let u_prop = [is_incr; is_deacr; is_incr; is_deacr] in
      mk_user_func name u u_I u' u'' u_min_c u_max_c u_prop 


  let user_functions : user_func list = [func1 (); func2 (); func3()]

  let add_table_user_func user_func : unit = 
    let name, u, u_I, u', u'', u_min_c, u_max_c, u_prop = user_func.u_name, user_func.u, user_func.u_I, user_func.u', user_func.u'', user_func.u_min_c, user_func.u_max_c, user_func.u_prop in
      Hashtbl.add func_basic name u;
      Hashtbl.add func_transc name u;
      Hashtbl.add func_interval_basic name u_I;
      Hashtbl.add func_derivative_basic name u';
      Hashtbl.add func_deriv_order2 name u'';
      Hashtbl.add func_min_c name u_min_c;
      Hashtbl.add func_max_c name u_max_c;
      Hashtbl.add func_check_prop_list name u_prop;
      ()

  let create_basic_tables = 
    let add_list_table = U.add_list_table in
    add_list_table func_basic2 list_func_basic2;
    add_list_table func_basic list_func_basic ;
    add_list_table func_transc list_func_transc ;
    add_list_table func_bool list_func_bool ;
    add_list_table str_func_bool list_str_func_bool; 

    add_list_table func_interval_basic2 list_interval_basic2; 
    add_list_table func_interval_basic list_interval_basic ;
    add_list_table func_interval_bool list_interval_bool ;

    add_list_table func_derivative_basic list_derivative_basic ;
    add_list_table func_deriv_order2 list_deriv_order2 ;
    add_list_table func_deriv_order3 list_deriv_order3 ;

    add_list_table func_min_c list_min_c ;
    add_list_table func_max_c list_max_c ;
    add_list_table func_check_prop_list list_check_prop;
      List.iter add_table_user_func user_functions;
      ()
end
