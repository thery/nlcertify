module type T =
sig
  type num_i
  val _pr_ : string -> bool -> bool -> unit
  type term =
    Zero
    | Const of num_i
    | Var of string
    | Inv of term
    | Opp of term
    | Add of (term * term)
    | Sub of (term * term)
    | Mul of (term * term)
    | Div of (term * term)
    | Pow of (term * int)
  val simpl_term : term -> string
  val is_add_term : term -> bool
  val is_opp_term : term -> bool
  val is_fst_opp_term : term -> bool
  val is_zero_term : term -> bool
  val is_one_term : term -> bool
  val is_minus_one_term : term -> bool
  val is_const_term : term -> bool
  val opp_term : term -> term
  val cancel_opp_term : term -> term
  val mul_of_pow_term : term -> int -> term
  val add_term : term -> term -> term
  val mul_term : term -> term -> term
  val fold_add_term : term list -> term
  val fold_mul_term : term list -> term
  val mul_term_list : term list -> term -> term list
  val expand_term : term -> term
  val unfold_add_term : term -> term list
  val unfold_mul_term : term -> term list
  val exp_term : term -> term
  val string_of_term : term -> (num_i -> string) -> string
  val output_term : out_channel -> term -> unit
  type positive = Numbers.T.positive
  val jump : positive -> (positive -> 'a) -> positive -> 'a
  val nth_jump : (positive -> 'a) -> positive -> 'a
  val hd_jump  : (positive -> 'a) -> 'a
  val tl_jump  : (positive -> 'a) -> positive -> 'a
  type pol =
      Pc of num_i
    | Pinj of positive * pol
    | PX of pol * positive * pol
  type transc_approx =
      Minimax of num_i list
    | Cub of num_i * num_i * num_i * num_i * num_i
    | Par of num_i * num_i * num_i * num_i
    | Tan of num_i * num_i
  type interval
  type sos_block = Sos_block of int * pol 
  type kkt = Sos of sos_block array | Eq_coeff of pol | L1 of pol
  type putinar_psatz = Putinar_psatz of ((kkt * int) array)
  type cert_pop = Cert_pop of pol * num_i array * putinar_psatz
  type cert_itv = cert_pop * cert_pop
  val cert_pop_null : cert_pop
  val cert_null : cert_itv
  val mk_cert_pop : pol -> num_i array -> putinar_psatz -> cert_pop
  type fw_pol = 
    | Pw of pol * interval * cert_itv
    | Fw of (fw_pol * fw_pol) * interval * cert_itv
    | Min of ( fw_pol list) * interval * cert_itv
    | Max of (fw_pol list) * interval * cert_itv
    | Plus of (fw_pol * fw_pol) * interval * cert_itv
    | Mult of (fw_pol * fw_pol) * interval * cert_itv
    | Minus of fw_pol * interval
    | Sqrt of fw_pol * interval
    | Comp of (transc_approx * fw_pol) * interval * cert_itv
    | MaxMin of (fw_pol * fw_pol) * interval * cert_itv
  val degree_pol : pol -> int
  val degree_approx : transc_approx -> int
  val is_degree_one : pol -> bool
  val p0 : num_i -> pol
  val p1 : num_i -> pol
  val peq : pol -> pol -> bool
  val mkPinj : positive -> pol -> pol
  val mkPinj_pred : positive -> pol -> pol
  val mkPX : pol -> positive -> pol -> pol
  val mkXi : positive -> pol
  val mkX : pol
  val popp : pol -> pol
  val paddC : pol -> num_i -> pol
  val psubC : pol -> num_i -> pol
  val paddI : (pol -> pol -> pol) -> pol -> positive -> pol -> pol
  val psubI : (pol -> pol -> pol) -> pol -> positive -> pol -> pol
  val paddX : (pol -> pol -> pol) -> pol -> positive -> pol -> pol
  val psubX : (pol -> pol -> pol) -> pol -> positive -> pol -> pol
  val padd_counter : int ref
  val padd : pol -> pol -> pol
  val psub : pol -> pol -> pol
  val pmulC_aux : pol -> num_i -> pol
  val pmulC : pol -> num_i -> pol
  val pmulI : (pol -> pol -> pol) -> pol -> positive -> pol -> pol
  val pmul : pol -> pol -> pol
  val psquare : pol -> pol                         
  val approx_eq : transc_approx -> transc_approx -> bool
  val eval_p : (positive -> num_i) -> pol -> num_i
  val idx_of_varpol: pol -> positive
  val eval_pol : (positive, num_i) Hashtbl.t -> pol -> num_i
  val vars_of_pol : pol -> positive list
  val basic_pol_I : (string, 'a * (num_i * num_i)) Hashtbl.t -> pol -> interval
  val scale_pol : (positive, num_i * num_i) Hashtbl.t -> (positive * num_i) list -> pol -> bool -> pol * num_i
  val deriv_p : positive -> pol -> pol
  val eval_pol_num : positive -> num_i -> pol -> pol 
  val pol_norm_inf : pol -> num_i
  val monomials : pol -> pol list
  val string_of_horner : pol -> string
  val monomial_support : int -> pol -> int array * num_i
  val fw_contains_min_max : bool -> fw_pol -> bool
  val fw_contains_min : fw_pol -> bool
  val fw_contains_max : fw_pol -> bool
  val no_disj_pol : fw_pol -> bool
  val is_Fw : fw_pol -> bool
  val is_Plus : fw_pol -> bool
  val is_Mult : fw_pol -> bool
  val is_Sqrt : fw_pol -> bool
  val is_Max : fw_pol -> bool
  val is_Min : fw_pol -> bool
  val is_Minus : fw_pol -> bool
  val is_Comp : fw_pol -> bool
  val is_Pol : fw_pol -> bool
  val pol_of_fw : fw_pol -> pol
  val fweq : fw_pol -> fw_pol -> bool
  module Pretty_Print :
  sig
    val pp_positive : out_channel -> positive -> unit
    val pp_f : out_channel -> float -> unit
    val pp_pol : (out_channel -> num_i -> unit) -> out_channel -> pol -> unit
  end
  type n = Numbers.T.n
  type pExpr =
      PEc of num_i
    | PEX of positive
    | PEadd of pExpr * pExpr
    | PEsub of pExpr * pExpr
    | PEmul of pExpr * pExpr
    | PEopp of pExpr
    | PEpow of pExpr * n
  val mk_X : positive -> pol
  val ppow_pos : (pol -> pol) -> pol -> pol -> positive -> pol
  val ppow_N : (pol -> pol) -> pol -> n -> pol
  val monomial_product : positive list -> pol
  val norm_aux : pExpr -> pol
  val norm : pExpr -> pol
  val xdenorm : positive -> pol -> pExpr
  val denorm : pol -> pExpr
  val expr_to_term : pExpr -> term
  val mkX_i : int -> pol
  val p_subC : pol -> num_i -> pol
  val p_addC : pol -> num_i -> pol
  val p_mulC : pol -> num_i -> pol
  val p_opp : pol -> pol
  val p_add : pol -> pol -> pol
  val p_mul : pol -> pol -> pol
  val p_square : pol -> pol
  val p_sub : pol -> pol -> pol
  val p_pow : pol -> int -> pol
  val monomial_prod : positive list -> pol
  val monomial_sum : positive list -> pol
  val p_eq : pol -> pol -> bool
  val p_is_null : pol -> bool
  val fw_eq : fw_pol -> fw_pol -> bool
  val fw_neq : fw_pol -> fw_pol -> bool
  val fw_eq_sort : fw_pol -> fw_pol -> int
  val poly_func_list : (string * (pol -> pol -> pol)) list
  val deriv_pol : positive -> pol -> pol
  val grad_pol : positive array -> pol -> pol array
  val eval_grad_pol : (positive, num_i) Hashtbl.t -> pol array -> num_i array
  val poly_func : (string, pol -> pol -> pol) Hashtbl.t
  val term_of_pol : pol -> term
  val string_of_pol : pol -> string
  val string_of_pol_rat : pol -> string
  val string_of_pol_float : pol -> int -> string
  val string_of_pol_zarith : pol -> string
  val box_of_tbl : (string, num_i * num_i) Hashtbl.t -> positive list -> (num_i * num_i) list
  val string_of_pol_coq : pol -> string
  val change_vars_pol : positive list -> pol -> pol
end


module Make(N: Numeric.T) (U: Tutils.T with type t = N.t) (I: Interval.T with type num_i = N.t) = struct

  type num_i = N.t
  open N
  let _pr_ = U._pr_
  type term =
    | Zero
    | Const of num_i
    | Var of string
    | Inv of term
    | Opp of term
    | Add of (term * term)
    | Sub of (term * term)
    | Mul of (term * term)
    | Div of (term * term)
    | Pow of (term * int)



(*
let rec string_of_term t =
  match t with
    | Opp Zero -> ""
    | Opp t1 -> "(- " ^ string_of_term t1 ^ ")"
    | Add (t, Zero) -> string_of_term t
    | Add (Zero, t) -> string_of_term t
    | Add (t1, t2) ->
        "(" ^ (string_of_term t1) ^ " + " ^ (string_of_term t2) ^ ")"
    | Sub (t, Zero) -> string_of_term t
    | Sub (t1, t2) ->
        "(" ^ (string_of_term t1) ^ " - " ^ (string_of_term t2) ^ ")"
    | Mul (t, Zero) -> ""
    | Mul (Zero, t) -> ""
    | Mul (Const x, t) -> 
        begin
          if eq_i x one_i then string_of_term t else 
        end
    | Mul (t1, t2) ->
        begin
        match t1, t2 with 
            Const x, t2 -> 
              begin
                if eq_i x one_i then string_of_term t2
              end
        begin
          if eq_i t1 one_i then string_of_term t2 
          else if eq_i t2 one_i then string_of_term t1
          else
            "(" ^ (string_of_term t1) ^ " * " ^ (string_of_term t2) ^ ")"
        end
    | Inv t1 -> "(/ " ^ string_of_term t1 ^ ")"
    | Div (t1, t2) ->
        "(" ^ (string_of_term t1) ^ " / " ^ (string_of_term t2) ^ ")"
    | Pow (t1, n1) ->
        begin
          if n1=0 then string_of_i one_i 
          else if n1=1 then string_of_term t1
          else
            "(" ^ (string_of_term t1) ^ " ^ " ^ (string_of_int n1) ^ ")"
        end
    | Zero -> "0"
    | Var v -> v
    | Const x -> string_of_i x;;
 *)
(*
let norm_string_of_var = function
  | Add (Mul (Const one_i, Pow (Var v, 1)), Zero) -> v
  | _ -> failwith "can not print variables from poly"

 *)
(*
let rec f t =
  match t with
    | Opp t1 -> "(- " ^ f t1 ^ ")"
    | Add (t1, t2) ->
        "(" ^ (f t1) ^ " + " ^ (f t2) ^ ")"
    | Sub (t1, t2) ->
        "(" ^ (f t1) ^ " - " ^ (f t2) ^ ")"
    | Mul (t1, t2) ->
        "(" ^ (f t1) ^ " * " ^ (f t2) ^ ")"
    | Inv t1 -> "(/ " ^ f t1 ^ ")"
    | Div (t1, t2) ->
        "(" ^ (f t1) ^ " / " ^ (f t2) ^ ")"
    | Pow (t1, n1) ->
        "(" ^ (f t1) ^ " ^ " ^ (string_of_int n1) ^ ")"
    | Zero -> "0"
    | Var v -> v
    | Const x -> string_of_i x (*Printf.sprintf "%f" (x)*)
 *)
let rec simpl_term t =
  match t with
    | Zero -> "Zero"
    | Const n -> "Const (" ^ (N.string_of_i n) ^ ")"
    | Var n   -> n
    | Inv t   -> Printf.sprintf "1/(%s)" (simpl_term t)
    | Opp t    -> Printf.sprintf "Opp (%s)" (simpl_term t)
    | Add(t1,t2) -> Printf.sprintf "Add (%s, %s)" (simpl_term t1) (simpl_term t2)
    | Sub(t1,t2) -> Printf.sprintf "Sub (%s, %s)" (simpl_term t1) (simpl_term t2)
    | Mul(t1,t2) -> Printf.sprintf "Mul (%s, %s)" (simpl_term t1) (simpl_term t2)
    | Div(t1,t2) -> Printf.sprintf "Div (%s, %s)" (simpl_term t1) (simpl_term t2)
    | Pow(t1,i) -> Printf.sprintf "Pow (%s, %i)" (simpl_term t1) i



let is_add_term = function
  | Add _ | Sub _ | Opp _ -> true | _ -> false

let rec is_opp_term = function
  | Opp t -> not (is_opp_term t) | Const x when N.lt_i x zero_i -> true 
  | Mul (t1, t2) | Div (t1, t2) -> (is_opp_term t1 && not (is_opp_term t2)) || (is_opp_term t2 && not (is_opp_term t1)) 
  | _ -> false

let rec is_fst_opp_term = function
  | Opp _ -> true | _ -> false

let rec is_zero_term = function
  | Const x when N.eq_i x zero_i -> true | Zero -> true 
  | Opp t when is_zero_term t -> true
  | Add (t1, t2) when is_zero_term t1 && is_zero_term t2 -> true
  | Mul (t1, t2) when is_zero_term t1 || is_zero_term t2 -> true
  | _ -> false

let rec is_one_term = function
  | Const x when N.eq_i x one_i -> true
  | Opp (Const x) when N.eq_i x (minus_i one_i) -> true
  | Add (t1, t2) when (is_zero_term t1 && is_one_term t2) || (is_zero_term t2 && is_one_term t1) -> true
  | Mul (t1, t2) when is_one_term t1 && is_one_term t2 -> true
  | _ -> false

let is_minus_one_term = function
  | Const x when eq_i x (minus_i one_i) -> true | _ -> false

let is_const_term = function
  | Const _ -> true | _ -> false

let opp_term = function
  | Opp t -> t
  | Const x when lt_i x zero_i -> Const (minus_i x)
  | _ as t -> Opp t

let rec cancel_opp_term = function
  | Opp (Opp t) -> cancel_opp_term t
  | Opp (Const x) when lt_i x zero_i -> Const (minus_i x)
  | _ as t -> t

let rec mul_of_pow_term t n = 
  if n = 0 then Const one_i
  else if n > 0 then Mul (t, mul_of_pow_term t (n - 1))
  else failwith "negative power in mul_of_pow_term"


let add_term t1 t2 = Add (t1, t2)
let mul_term t1 t2 = Mul (t1, t2)

let rec fold_add_term = function
  | [t] -> t
  | hd::tl -> Add (hd, fold_add_term tl)
  | [] -> failwith "Empty list in fold_add_term"

let rec fold_mul_term = function
  | [t] -> t
  | Const(x1)::Const(x2)::tl -> fold_mul_term (Const (mult_i x1 x2)::tl)
  | hd::tl -> Mul (hd, fold_mul_term tl)
  | [] -> failwith "Empty list in fold_mul_term"

let mul_term_list l t = List.map (mul_term t) l

let rec expand_term = function
  | Mul (t1, t2) -> 
      begin
        let l1, l2 = unfold_add_term (expand_term t1), unfold_add_term (expand_term t2) in
        let term_list = List.concat (List.map (mul_term_list l1) l2) in
          fold_add_term term_list
      end
  | Add (t1, t2) -> Add (expand_term t1, expand_term t2)
  | Sub (t1, t2) -> Sub (expand_term t1, expand_term t2)
  | Opp t -> Opp (expand_term t)
  | Div (t1, t2) -> Div (expand_term t1, expand_term t2)
  | Inv t -> Inv (expand_term t)
  | Pow (t, n) -> expand_term (mul_of_pow_term t n)
  | _ as t -> t

and unfold_add_term = function
  | Add (t1, t2) when is_zero_term t1 && is_zero_term t2 -> [Zero]
  | Add (t1, t2) when is_zero_term t1 -> unfold_add_term t2
  | Add (t1, t2) when is_zero_term t2 -> unfold_add_term t1
  | Add (t1, t2) -> unfold_add_term t1 @ unfold_add_term t2
  | _ as t -> [t]

and unfold_mul_term = function
  | Opp t -> 
     begin
       let l = unfold_mul_term t in
         match l with 
           | hd::tl -> Opp hd :: tl
           | [] -> []
     end 
  | Mul (t1, t2) when is_one_term t1 && is_one_term t2 -> [Const one_i]
  | Mul (t1, t2) when is_one_term t1 -> unfold_add_term t2
  | Mul (t1, t2) when is_one_term t2 -> unfold_add_term t1
  | Mul (t1, t2) -> unfold_mul_term t1 @ unfold_mul_term t2
  | _ as t -> [t]

let exp_term t =
  let t = expand_term t in
  let add_terms =  unfold_add_term t in
  let find_opp_terms t = 
    let mul_terms = unfold_mul_term t in
    let mul_terms = List.map cancel_opp_term mul_terms in
    let neg_list, pos_list = List.partition is_opp_term mul_terms in
    let opp_neg_list = List.map opp_term neg_list in
    let term_list = opp_neg_list @ pos_list in
    let const_list, mul_list = List.partition is_const_term term_list in 
    let final_term_list = fold_mul_term (const_list @ mul_list) in
    let odd = (List.length neg_list) mod 2 = 1 in
      if odd then Opp( final_term_list) else final_term_list
  in
  let add_terms = List.map find_opp_terms add_terms in
  let t = fold_add_term add_terms in
   _pr_ (simpl_term t) false false;
    t

  let string_of_term_aux t string_of_num = 
  let rec f t = 
  match t with
    | Opp t1 when is_zero_term t1 -> "0"
    | Opp t1 -> (
        _pr_ (simpl_term t1) false false;
        "- " ^ f t1
      )

    | Add (t1, t2) when is_zero_term t1 && is_zero_term t2 -> "0"
    | Add (t1, t2) when is_zero_term t1 -> f t2
    | Add (t1, t2) when is_zero_term t2 -> f t1
    | Add (t1, t2) -> 
        begin
          let term_list = unfold_add_term t in
          let mk_str no_hd = function
            | Opp c -> " - " ^ f c
            | _ as c -> (if no_hd then " + " else "") ^ f c
          in
          let string_list = 
            match term_list with
              | hd::tl ->  (mk_str false hd):: List.map (mk_str true) tl
              | [] -> []
          in
            U.concat_string string_list 
        end
          (*
    | Add (t1, t2)  when is_opp_term t1 -> " - " ^ f (opp_term t1) ^ " + " ^ f t2
           *)
    | Sub (t1, t2) when is_zero_term t1 && is_zero_term t2 -> (_pr_ "SUB FOUND!!!" true true;"")
    | Sub (t1, t2) when is_zero_term t1 -> (_pr_ "SUB FOUND!!!" true true;  f (Opp t2))
    | Sub (t1, t2) when is_zero_term t2 ->(_pr_ "SUB FOUND!!!" true true; f t1)
    | Sub (t1, t2) ->(_pr_ "SUB FOUND!!!" true true; (f t1) ^ " - " ^ (f t2))

    | Mul (t1, t2) when is_zero_term t1 || is_zero_term t2 -> "0"
    | Mul (t1, t2) when is_one_term t1 -> f t2
    | Mul (t1, t2) when is_one_term t2 -> f t1
    | Mul (t1, t2) when is_minus_one_term t1 -> (_pr_ ("-1 found" ^ f t1) true true; f (opp_term t2))
    | Mul (t1, t2) when is_minus_one_term t2 ->  (_pr_ ("-1 found" ^ f t2) true true;   f (opp_term t1))

    | Mul (t1, t2) when is_add_term t1 && is_add_term t2 ->  "(" ^ (f t1) ^ ") * (" ^ (f t2) ^ ")"
    | Mul (t1, t2) when is_add_term t1 ->   "(" ^ (f t1) ^ ") * " ^ (f t2) 
    | Mul (t1, t2) when is_add_term t2 ->   (f t1) ^ " * (" ^ (f t2) ^ ")"
    | Mul (t1, t2) -> (f t1) ^ " * " ^ (f t2)

    | Div (t1, t2) when is_zero_term t1 -> ""
    | Div (t1, t2) when is_one_term t1 -> f (Inv t2)
    | Div (t1, t2) when is_one_term t2 -> f t1

    | Div (t1, t2) when is_add_term t1 && is_add_term t2 ->  "(" ^ (f t1) ^ ") / (" ^ (f t2) ^ ")"
    | Div (t1, t2) when is_add_term t1 ->   "(" ^ (f t1) ^ ") / " ^ (f t2) 
    | Div (t1, t2) when is_add_term t2 ->   (f t1) ^ " / (" ^ (f t2) ^ ")"
    | Div (t1, t2) -> (f t1) ^ " / " ^ (f t2)

    | Inv t1 -> " / " ^ f t1
    | Pow (t1, n1) when n1 = 1 -> f t1 
    | Pow (t1, n1) -> (f) t1 ^ " ^ " ^ (string_of_int n1)
    | Zero -> "0"
    | Var v -> v
    | Const x -> string_of_num x (*Printf.sprintf "%f" (x)*)
  in
    f t
let string_of_term t = string_of_term_aux (exp_term t)
(*
let string_of_term t =
  let res = f t in
  let res = Str.global_replace (Str.regexp "\\(\\+ -0\\.0 \\)\\|\\(\\+ 0\\.0 \\)") "" res in
    (*
  let res = Str.global_replace (Str.regexp "-0\\.0)") ")" res in
  let res = Str.global_replace (Str.regexp "\\+ 0\\.0)") ")" res in
  let res = Str.global_replace (Str.regexp "\\+ -") "-" res in
     *)
  let res = Str.global_replace (Str.regexp " 1\\.0 \\* ") "" res in
  let res = Str.global_replace (Str.regexp " \\^ 1") "" res in
  let res = Str.global_replace (Str.regexp "(\\([a-z][0-9]\\))") "\\1" res in
    res
 *)
let rec output_term o t =
  match t with
    | Zero -> output_string o "0"
    | Const n -> output_string o (string_of_i n)
    | Var n   -> Printf.fprintf o "v%s" n
    | Inv t   -> Printf.fprintf o "1/(%a)" output_term t
    | Opp t    -> Printf.fprintf o "- (%a)" output_term t
    | Add(t1,t2) -> Printf.fprintf o "(%a)+(%a)" output_term t1 output_term t2
    | Sub(t1,t2) -> Printf.fprintf o "(%a)-(%a)" output_term t1 output_term t2
    | Mul(t1,t2) -> Printf.fprintf o "(%a)*(%a)" output_term t1 output_term t2
    | Div(t1,t2) -> Printf.fprintf o "(%a)/(%a)" output_term t1 output_term t2
    | Pow(t1,i) -> Printf.fprintf o "(%a)^(%i)" output_term t1 i

  let add = Numbers.T.Pos.add
  let jump i e = fun x -> e (add x i)
  let nth_jump e n = e n
  let hd_jump e = nth_jump e Numbers.T.XH
  let tl_jump e = jump Numbers.T.XH e

  type positive = Numbers.T.positive

  type pol =
    | Pc of num_i
    | Pinj of positive * pol
    | PX of  pol * positive *  pol

type transc_approx =
    Minimax of num_i list
  | Cub of num_i * num_i * num_i * num_i * num_i
  | Par of num_i * num_i * num_i * num_i
  | Tan of num_i * num_i
  type interval = I.interval

  type sos_block = Sos_block of int * pol 
  type kkt = Sos of sos_block array | Eq_coeff of pol | L1 of pol
  type putinar_psatz = Putinar_psatz of ((kkt * int) array)
  type cert_pop = Cert_pop of pol * num_i array * putinar_psatz
  type cert_itv = cert_pop * cert_pop
  let mk_cert_pop r eigs s =  Cert_pop (r, eigs, s)
  let cert_pop_null =  mk_cert_pop (Pc N.zero_i) [||] (Putinar_psatz [||])
  let cert_null = (cert_pop_null, cert_pop_null)
  type fw_pol = 
    | Pw of pol * interval * cert_itv
    | Fw of (fw_pol * fw_pol) * interval * cert_itv
    | Min of ( fw_pol list) * interval * cert_itv
    | Max of (fw_pol list) * interval * cert_itv
    | Plus of (fw_pol * fw_pol) * interval * cert_itv
    | Mult of (fw_pol * fw_pol) * interval * cert_itv
    | Minus of fw_pol * interval
    | Sqrt of fw_pol * interval
    | Comp of (transc_approx * fw_pol) * interval * cert_itv
    | MaxMin of (fw_pol * fw_pol) * interval * cert_itv

let pos = Numbers.T.Translation.positive

let rec degree_pol = function
  | Pc _ -> 0
  | Pinj (_, p) -> degree_pol p 
  | PX (p, i, q) -> max (degree_pol p + pos i) (degree_pol q)

  let degree_approx = function
    | Minimax l -> List.length l - 1
    | Cub _ -> 3 | Par _ -> 2 | Tan _ -> 1

let is_degree_one p = (degree_pol p = 1)

(** val p0 : 'a1 -> 'a1 pol **)

let p0 cO =
  Pc cO

(** val p1 : 'a1 -> 'a1 pol **)

let p1 cI =
  Pc cI

(** val peq : ('a1 -> 'a1 -> bool) -> 'a1 pol -> 'a1 pol -> bool **)
let compare = Numbers.T.Pos.compare
let pred_double = Numbers.T.Pos.pred_double

let rec peq p p' =
  match p with
    | Pc c ->
        (match p' with
           | Pc c' -> N.eq_i c c'
           | _ -> false)
    | Pinj (j, q0) ->
        (match p' with
           | Pinj (j', q') ->
               (match compare j j' with
                  | Numbers.T.Eq -> peq q0 q'
                  | _ -> false)
           | _ -> false)
    | PX (p2, i, q0) ->
        (match p' with
           | PX (p'0, i', q') ->
               (match compare i i' with
                  | Numbers.T.Eq -> if peq p2 p'0 then peq q0 q' else false
                  | _ -> false)
           | _ -> false)

(** val mkPinj : positive -> 'a1 pol -> 'a1 pol **)

let mkPinj j p = match p with
  | Pc c -> p
  | Pinj (j', q0) -> Pinj ((add j j'), q0)
  | PX (p2, p3, p4) -> Pinj (j, p)

(** val mkPinj_pred : positive -> 'a1 pol -> 'a1 pol **)

let mkPinj_pred j p =
  match j with
    | Numbers.T.XI j0 -> Pinj ((Numbers.T.XO j0), p)
    | Numbers.T.XO j0 -> Pinj ((pred_double j0), p)
    | Numbers.T.XH -> p

(** val mkPX :
  'a1 -> ('a1 -> 'a1 -> bool) -> 'a1 pol -> positive -> 'a1 pol -> 'a1 pol **)

let mkPX p i q0 =
  match p with
    | Pc c -> if N.eq_i c N.zero_i then mkPinj Numbers.T.XH q0 else PX (p, i, q0)
    | Pinj (p2, p3) -> PX (p, i, q0)
    | PX (p', i', q') ->
        if peq q' (p0 N.zero_i)
        then PX (p', (add i' i), q0)
        else PX (p, i, q0)

(** val mkXi : 'a1 -> 'a1 -> positive -> 'a1 pol **)

let mkXi i =
  PX ((p1 N.one_i), i, (p0 N.zero_i))

(** val mkX : 'a1 -> 'a1 -> 'a1 pol **)

let mkX =
  mkXi Numbers.T.XH

(** val popp : ('a1 -> 'a1) -> 'a1 pol -> 'a1 pol **)

let rec popp = function
  | Pc c -> Pc (N.minus_i c)
  | Pinj (j, q0) -> Pinj (j, (popp q0))
  | PX (p2, i, q0) -> PX ((popp p2), i, (popp q0))

(** val paddC : ('a1 -> 'a1 -> 'a1) -> 'a1 pol -> 'a1 -> 'a1 pol **)

let rec paddC p c =
  match p with
    | Pc c1 -> Pc (N.add_i c1 c)
    | Pinj (j, q0) -> Pinj (j, (paddC q0 c))
    | PX (p2, i, q0) -> PX (p2, i, (paddC q0 c))

(** val psubC : ('a1 -> 'a1 -> 'a1) -> 'a1 pol -> 'a1 -> 'a1 pol **)

let rec psubC p c =
  match p with
    | Pc c1 -> Pc (N.sub_i c1 c)
    | Pinj (j, q0) -> Pinj (j, (psubC q0 c))
    | PX (p2, i, q0) -> PX (p2, i, (psubC q0 c))

(** val paddI :
  ('a1 -> 'a1 -> 'a1) -> ('a1 pol -> 'a1 pol -> 'a1 pol) -> 'a1 pol ->
  positive -> 'a1 pol -> 'a1 pol **)
let pred_double = Numbers.T.Pos.pred_double 
let pos_sub = Numbers.T.Z.pos_sub

let rec paddI pop q0 j = function
  | Pc c -> mkPinj j (paddC q0 c)
  | Pinj (j', q') ->
      (match pos_sub j' j with
         | Numbers.T.Z0 -> mkPinj j (pop q' q0)
         | Numbers.T.Zpos k -> mkPinj j (pop (Pinj (k, q')) q0)
         | Numbers.T.Zneg k -> mkPinj j' (paddI pop q0 k q'))
  | PX (p2, i, q') ->
      (match j with
         | Numbers.T.XI j0 -> PX (p2, i, (paddI pop q0 (Numbers.T.XO j0) q'))
         | Numbers.T.XO j0 -> PX (p2, i, (paddI pop q0 (pred_double j0) q'))
         | Numbers.T.XH -> PX (p2, i, (pop q' q0)))

(** val psubI :
  ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1) -> ('a1 pol -> 'a1 pol -> 'a1 pol) ->
  'a1 pol -> positive -> 'a1 pol -> 'a1 pol **)
let rec psubI pop q0 j = function
  | Pc c -> mkPinj j (paddC (popp q0) c)
  | Pinj (j', q') ->
      (match pos_sub j' j with
         | Numbers.T.Z0 -> mkPinj j (pop q' q0)
         | Numbers.T.Zpos k -> mkPinj j (pop (Pinj (k, q')) q0)
         | Numbers.T.Zneg k -> mkPinj j' (psubI pop q0 k q'))
  | PX (p2, i, q') ->
      (match j with
         | Numbers.T.XI j0 -> PX (p2, i, (psubI pop q0 (Numbers.T.XO j0) q'))
         | Numbers.T.XO j0 ->
             PX (p2, i, (psubI pop q0 (pred_double j0) q'))
         | Numbers.T.XH -> PX (p2, i, (pop q' q0)))

(** val paddX :
  'a1 -> ('a1 -> 'a1 -> bool) -> ('a1 pol -> 'a1 pol -> 'a1 pol) -> 'a1 pol
  -> positive -> 'a1 pol -> 'a1 pol **)
let rec paddX pop p' i' p = match p with
  | Pc c -> PX (p', i', p)
  | Pinj (j, q') ->
      (match j with
         | Numbers.T.XI j0 -> PX (p', i', (Pinj ((Numbers.T.XO j0), q')))
         | Numbers.T.XO j0 -> PX (p', i', (Pinj ((pred_double j0), q')))
         | Numbers.T.XH -> PX (p', i', q'))
  | PX (p2, i, q') ->
      (match pos_sub i i' with
         | Numbers.T.Z0 -> mkPX (pop p2 p') i q'
         | Numbers.T.Zpos k -> mkPX (pop (PX (p2, k, (p0 N.zero_i))) p') i' q'
         | Numbers.T.Zneg k -> mkPX (paddX pop p' k p2) i q')

(** val psubX :
  'a1 -> ('a1 -> 'a1) -> ('a1 -> 'a1 -> bool) -> ('a1 pol -> 'a1 pol -> 'a1
  pol) -> 'a1 pol -> positive -> 'a1 pol -> 'a1 pol **)

let rec psubX pop p' i' p = match p with
  | Pc c -> PX ((popp p'), i', p)
  | Pinj (j, q') ->
      (match j with
         | Numbers.T.XI j0 -> PX ((popp p'), i', (Pinj ((Numbers.T.XO j0), q')))
         | Numbers.T.XO j0 -> PX ((popp p'), i', (Pinj ((pred_double j0), q')))
         | Numbers.T.XH -> PX ((popp p'), i', q'))
  | PX (p2, i, q') ->
      (match pos_sub i i' with
         | Numbers.T.Z0 -> mkPX (pop p2 p') i q'
         | Numbers.T.Zpos k -> mkPX (pop (PX (p2, k, (p0 N.zero_i))) p') i' q'
         | Numbers.T.Zneg k -> mkPX (psubX pop p' k p2) i q')

(** val padd :
  'a1 -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1 -> bool) -> 'a1 pol -> 'a1 pol
  -> 'a1 pol **)

  let padd_counter = ref 0        
let rec padd p = function
  | Pc c' -> paddC p c'
  | Pinj (j', q') -> incr padd_counter; paddI padd q' j' p
  | PX (p'0, i', q') ->
      (match p with
         | Pc c -> PX (p'0, i', (paddC q' c))
         | Pinj (j, q0) -> incr padd_counter;
             (match j with
                | Numbers.T.XI j0 -> PX (p'0, i', (padd (Pinj ((Numbers.T.XO j0), q0)) q'))
                | Numbers.T.XO j0 ->
                    PX (p'0, i',
                        (padd (Pinj ((pred_double j0), q0)) q'))
                | Numbers.T.XH -> PX (p'0, i', (padd q0 q')))
         | PX (p2, i, q0) -> incr padd_counter;
             (match pos_sub i i' with
                | Numbers.T.Z0 -> 
                    mkPX (padd p2 p'0) i (padd q0 q')
                | Numbers.T.Zpos k -> 
                    mkPX (padd (PX (p2, k, (p0 N.zero_i))) p'0) i'
                      (padd q0 q')
                | Numbers.T.Zneg k -> 
                    mkPX (paddX padd p'0 k p2) i
                      (padd q0 q')))

(** val psub :
  'a1 -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1) -> ('a1
  -> 'a1 -> bool) -> 'a1 pol -> 'a1 pol -> 'a1 pol **)

let rec psub p = function
  | Pc c' -> psubC p c'
  | Pinj (j', q') ->  incr padd_counter;  psubI psub q' j' p
  | PX (p'0, i', q') ->  incr padd_counter; 
      (match p with
         | Pc c -> PX ((popp p'0), i', (paddC (popp q') c))
         | Pinj (j, q0) ->
             (match j with
                | Numbers.T.XI j0 ->
                    PX ((popp p'0), i',
                        (psub (Pinj ((Numbers.T.XO j0), q0)) q'))
                | Numbers.T.XO j0 ->
                    PX ((popp p'0), i',
                        (psub (Pinj ((pred_double j0), q0))
                           q'))
                | Numbers.T.XH -> PX ((popp p'0), i', (psub q0 q')))
         | PX (p2, i, q0) ->
             (match pos_sub i i' with
                | Numbers.T.Z0 ->
                    mkPX (psub p2 p'0) i
                      (psub q0 q')
                | Numbers.T.Zpos k ->
                    mkPX (psub (PX (p2, k, (p0 N.zero_i))) p'0)
                      i' (psub q0 q')
                | Numbers.T.Zneg k ->
                    mkPX
                      (psubX psub p'0 k p2) i
                      (psub q0 q')))

(** val pmulC_aux :
  'a1 -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1 -> bool) -> 'a1 pol -> 'a1 ->
  'a1 pol **)

let rec pmulC_aux p c =
  match p with
    | Pc c' -> Pc (N.mult_i c' c)
    | Pinj (j, q0) -> mkPinj j (pmulC_aux q0 c)
    | PX (p2, i, q0) ->
        mkPX (pmulC_aux p2 c) i
          (pmulC_aux q0 c)

(** val pmulC :
  'a1 -> 'a1 -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1 -> bool) -> 'a1 pol ->
  'a1 -> 'a1 pol **)

let pmulC p c =
  if N.eq_i c N.zero_i
  then p0 N.zero_i
  else if N.eq_i c N.one_i then p else pmulC_aux p c

(** val pmulI :
  'a1 -> 'a1 -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1 -> bool) -> ('a1 pol ->
  'a1 pol -> 'a1 pol) -> 'a1 pol -> positive -> 'a1 pol -> 'a1 pol **)

let rec pmulI pmul0 q0 j = function
  | Pc c -> mkPinj j (pmulC q0 c)
  | Pinj (j', q') ->
      (match pos_sub j' j with
         | Numbers.T.Z0 -> mkPinj j (pmul0 q' q0)
         | Numbers.T.Zpos k -> mkPinj j (pmul0 (Pinj (k, q')) q0)
         | Numbers.T.Zneg k -> mkPinj j' (pmulI pmul0 q0 k q'))
  | PX (p', i', q') ->
      (match j with
         | Numbers.T.XI j' ->
             mkPX (pmulI pmul0 q0 j p') i'
               (pmulI pmul0 q0 (Numbers.T.XO j') q')
         | Numbers.T.XO j' ->
             mkPX (pmulI pmul0 q0 j p') i'
               (pmulI pmul0 q0 (pred_double j') q')
         | Numbers.T.XH ->
             mkPX (pmulI pmul0 q0 Numbers.T.XH p') i' (pmul0 q' q0))

(** val pmul :
  'a1 -> 'a1 -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1
  -> bool) -> 'a1 pol -> 'a1 pol -> 'a1 pol **)

let rec pmul p p'' = match p'' with
  | Pc c -> pmulC p c
  | Pinj (j', q') -> pmulI pmul q' j' p
  | PX (p', i', q') ->
      (match p with
         | Pc c -> pmulC p'' c
         | Pinj (j, q0) ->
             let qQ' =
               match j with
                 | Numbers.T.XI j0 -> pmul (Pinj ((Numbers.T.XO j0), q0)) q'
                 | Numbers.T.XO j0 ->
                     pmul (Pinj ((pred_double j0), q0)) q'
                 | Numbers.T.XH -> pmul q0 q'
             in
               mkPX (pmul p p') i' qQ'
         | PX (p2, i, q0) ->
             let qQ' = pmul q0 q' in
             let pQ' = pmulI pmul q' Numbers.T.XH p2 in
             let qP' = pmul (mkPinj Numbers.T.XH q0) p' in
             let pP' = pmul p2 p' in
               padd 
                 (mkPX (padd (mkPX pP' i (p0 N.zero_i)) qP') i'
                    (p0 N.zero_i)) (mkPX pQ' i qQ'))

(** val psquare :
  'a1 -> 'a1 -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1
  -> bool) -> 'a1 pol -> 'a1 pol **)

let rec psquare = function
  | Pc c -> Pc (N.sqr_i c)
  | Pinj (j, q0) -> Pinj (j, (psquare q0))
  | PX (p2, i, q0) ->
      let twoPQ =
        pmul p2
          (mkPinj Numbers.T.XH (pmulC q0 N.two_i))
      in
      let q2 = psquare q0 in
      let p3 = psquare p2 in
        mkPX (padd (mkPX p3 i (p0 N.zero_i)) twoPQ) i q2

let approx_eq a2 = function
  | Tan (a, b) -> 
      begin
        match a2 with 
          | Tan (c, d) -> eq_i a c && eq_i b d
          | _ -> false
      end
   | Par (p1, p2, p3, p4) -> 
      begin
        match a2 with 
          | Par (q1, q2, q3, q4) -> eq_i p1 q1 && eq_i p2 q2 && eq_i p3 q3 && eq_i p4 q4
          | _ -> false
      end
   | Cub (p1, p2, p3, p4, p5) -> 
      begin
        match a2 with 
          | Cub (q1, q2, q3, q4, q5) -> eq_i p1 q1 && eq_i p2 q2 && eq_i p3 q3 && eq_i p4 q4 && eq_i p5 q5
          | _ -> false
      end
  | Minimax l1 -> 
      begin
        match a2 with
          | Minimax l2 -> List.for_all2 eq_i l1 l2
          | _ -> false
      end

  let idx_of_varpol = function
      PX (Pc a, Numbers.T.XH, Pc b) when N.eq_i a N.one_i && N.eq_i b N.zero_i -> Numbers.T.XH
    | Pinj (j, PX (Pc a, Numbers.T.XH, Pc b)) when N.eq_i a N.one_i && N.eq_i b N.zero_i  -> add j Numbers.T.XH
    | _ -> failwith "Not a polynomial variable"

  let pow_pos = Numbers.T.Z.pow_pos

  let rec eval_p_general e add mul pow f = function
    | Pc c -> f c
    | Pinj (j, q) -> eval_p_general (jump j e) add mul pow f q
    | PX (p, i, q) ->
        let x = hd_jump e in
        let xi = pow x i in
          add (mul (eval_p_general e add mul pow f p) xi)  (eval_p_general (tl_jump e) add mul pow f q)

  let eval_p e = eval_p_general e add_i mult_i (pow_pos mult_i) (fun c -> c)

  let rec basic_p_I e = function
    | Pc c -> I.mk_i_I c
    | Pinj (j, q) ->  basic_p_I (jump j e) q
    | PX (p, i, q) ->
        let p_I = hd_jump e in
        let xi_I =  I.pow_I p_I (I.mk_i_I (N.num_of_int (pos i))) in
          I.add_I (I.mult_I (basic_p_I e p) xi_I)  (basic_p_I (tl_jump e) q)


(*
let rec project_pol var value = function
  | Pc c -> c
  | Pinj (j, q) -> 
      begin
        match pos_sub var j with 
          | Numbers.T.Zpos k -> mkPinj j (project_pol var value q)
          | _ as p -> p
      end
  | PX (p, i, q) ->
      let proj_q = project_pol var value q in
      let
        match pos_sub var i with
          | Numbers.T.Z0 -> 
 *)

   let find_pos tbl = fun x -> try Hashtbl.find tbl x with Not_found -> invalid_arg ((string_of_int ( pos x)) ^ " in Table Pb for Polynomials")          
  let find_string tbl = fun x -> try Hashtbl.find tbl x with Not_found -> invalid_arg (x ^ "Table Pb for Polynomials")

let rec deriv_p var = function 
  | Pc c -> p0 N.zero_i
  | Pinj (j, q) -> 
      begin
        match pos_sub var j with
          | Numbers.T.Zpos k -> mkPinj j (deriv_p k q)
          | _ -> p0 N.zero_i
      end
  | PX (p, i, q) -> 
          begin
            let p' = deriv_p var p in
            let x1 = mkXi i in
            let x1', q' = 
              match pos_sub var Numbers.T.XH with
                | Numbers.T.Zpos k -> p0 N.zero_i, mkPinj Numbers.T.XH (deriv_p k q) 
                | Numbers.T.Z0 -> 
                    begin
                      match pos_sub i Numbers.T.XH with
                        | Numbers.T.Zpos k ->  pmulC (mkXi k) (N.num_of_int (pos i)), p0 N.zero_i
                        | _ -> p0 N.one_i, p0 N.zero_i
                    end
                | _ -> p0 N.zero_i, p0 N.zero_i
            in
            let deriv_prod = padd (pmul p x1') (pmul p' x1) in
             padd deriv_prod q'
          end


  let rec eval_pol_num var value = function
    | Pc c -> Pc c
    | Pinj (j, q) -> 
      begin
        match pos_sub var j with
          | Numbers.T.Zpos k -> mkPinj j (eval_pol_num k value q)
          | _ -> Pinj (j, q)
      end
    | PX (p, i, q) -> 
        begin
          let p' = eval_pol_num var value p in
          let x1 = mkXi i in
          let x1', q' = 
            match pos_sub var Numbers.T.XH with
              | Numbers.T.Zpos k -> x1, mkPinj Numbers.T.XH (eval_pol_num k value q) 
              | _ -> Pc (pow_i value (N.num_of_int (pos i))),  mkPinj Numbers.T.XH q
          in
          let eval_prod = pmul p' x1' in
            padd eval_prod q'
        end

  let rec pol_norm_inf = function
    | Pc c -> N.abs_i c
    | Pinj (_, q) -> pol_norm_inf q
    | PX (p, _, q) -> N.max_i (pol_norm_inf p) (pol_norm_inf q)

   let rec monomials  = function
    | Pc c -> if N.eq_i c zero_i then [] else [Pc c]
    | Pinj (j, q) -> List.map (mkPinj j) (monomials q)
    | PX (p, i, q) -> 
        begin
          let x1_power_i =  mkXi i in 
          let p_mon = monomials p in
          let fst_mon_list = List.map (pmul x1_power_i) p_mon in
          let snd_mon_list = List.map (mkPinj Numbers.T.XH) (monomials q) in
            fst_mon_list @ snd_mon_list
        end

  let rec string_of_horner = function
    | Pc c -> Printf.sprintf "Pc (%s)" (N.string_of_i c)
    | Pinj (j, q) -> Printf.sprintf "Pinj (%s, %s)" (string_of_int (pos j)) (string_of_horner q)
    | PX (p, i, q) -> Printf.sprintf "PX (%s, %s, %s)" (string_of_horner p) (string_of_int (pos i)) (string_of_horner q)

    let rec monomial_support n = function
      | Pc c -> Array.make n 0, c
      | Pinj (j, q) -> 
          begin
            let msq, coeff = monomial_support n q in
            let ms = Array.make n 0 in
            let j = pos j in
              for k = 0 to Array.length (msq) - j - 1 do
                ms. (k + j) <- msq. (k);
              done;
              ms, coeff
          end
      | PX (p, i, q) -> 
          begin
            if (*not (peq q (p0 N.zero_i))*) false then failwith "non null q in monomial!"
            else 
             begin
               let msp, coeff = monomial_support n p in
                 msp. (0) <- (msp. (0)) + (pos i);
                 msp, coeff
             end 
          end

let rec fw_contains_min_max is_min = function
  | Pw _ -> false
  | Fw _ -> false 
  | Max (l, _, _) -> if is_min then List.fold_left (fun a b -> a || fw_contains_min_max is_min b) false l else true
  | Min (l, _, _) -> if is_min then true else List.fold_left (fun a b -> a || fw_contains_min_max is_min b) false l
  | Plus ((fw1, fw2), _, _) -> (fw_contains_min_max is_min fw1 || fw_contains_min_max is_min fw2)
  | Mult ((fw1, fw2), _, _) -> (fw_contains_min_max is_min fw1 || fw_contains_min_max is_min fw2)
  | Minus (fw, _) -> fw_contains_min_max is_min fw
  | Sqrt (fw, _) -> fw_contains_min_max is_min fw
  | Comp ((a, fw), _, _) -> fw_contains_min_max is_min fw
  | MaxMin ((f1, f2), _, _) -> List.exists (fw_contains_min_max is_min) [f1;f2]

let fw_contains_min fw = fw_contains_min_max true fw
let fw_contains_max fw = fw_contains_min_max false fw

let no_disj_pol fw = (fw_contains_min fw || fw_contains_max fw)

let is_Fw = function | Fw _ -> true  | _ -> false
let is_Plus = function | Plus _ -> true   | _ -> false
let is_Mult = function | Mult _ -> true   | _ -> false
let is_Sqrt = function | Sqrt _ -> true   | _ -> false
let is_Max = function  | Max _ -> true   | _ -> false
let is_Min = function  | Min _ -> true   | _ -> false
let is_Minus = function | Minus _ -> true   | _ -> false
let is_Comp = function | Comp _ -> true   | _ -> false
let is_Pol = function | Pw _ -> true  | _ -> false
  let is_MaxMin = function | MaxMin _ -> true | _ -> false
let pol_of_fw = function  | Pw (p, _, _) -> p  | _ -> failwith "Not a polynomial"

let rec fweq f1 f2 = 
  match f1 with 
    | Pw (p1, i1, _) -> 
        begin
          match f2 with
            | Pw (p2, i2, _) -> peq p1 p2 && I.eq_I i1 i2
            | _ -> false
        end
    | Fw ((p1, p2), i1, _) ->
        begin
          match f2 with 
            | Fw ((p3, p4), i2, _) -> (fweq p1 p3) && (fweq p2 p4) && I.eq_I i1 i2
            | _ -> false
        end
    | Plus ((p1, p2), i1, _) -> 
        begin
          match f2 with 
            | Plus ((p3, p4), i2, _) -> (fweq p1 p3 && fweq p2 p4 && I.eq_I i1 i2) || (fweq p1 p4 && fweq p2 p3 && I.eq_I i1 i2)
            | _ -> false
        end
    | Mult ((p1, p2), i1, _) -> 
        begin
          match f2 with 
            | Mult ((p3, p4), i2, _) -> (fweq p1 p3 && fweq p2 p4 && I.eq_I i1 i2) || (fweq p1 p4 && fweq p2 p3 && I.eq_I i1 i2)
            | _ -> false
        end
    | Sqrt (f3, i1) -> 
        begin
          match f2 with
            | Sqrt (f4, i2) -> fweq f3 f4 && I.eq_I i1 i2
            | _ -> false
        end
    | Minus (f3, i1) -> 
        begin
          match f2 with
            | Minus (f4, i2) -> fweq f3 f4 && I.eq_I i1 i2
            | _ -> false
        end
    | Min (fw_l1, i1, _) -> 
        begin
          match f2 with
            | Min (fw_l2, i2, _) -> List.for_all2 fweq fw_l1 fw_l2 && I.eq_I i1 i2
            | _ -> false
        end
    | Max (fw_l1, i1, _) -> 
        begin
          match f2 with
            | Min (fw_l2, i2, _) -> List.for_all2 fweq fw_l1 fw_l2 && I.eq_I i1 i2
            | _ -> false
        end
    | Comp ((a1, fw1), i1, _) ->
        begin
          match f2 with
            | Comp ((a2, fw2), i2, _) -> fweq fw1 fw2 && approx_eq a1 a2 && I.eq_I i1 i2
            | _ -> false
        end
    | MaxMin ((a1, b1), i1, _) ->
        begin
          match f2 with
            | MaxMin ((a2, b2), i2, _) -> fweq a1 a2 && fweq b1 b2 && I.eq_I i1 i2
            | _-> false
        end


module Pretty_Print =
struct

  let pp_positive o x = Printf.fprintf o "%i" (pos x)

let pp_f o f = Printf.fprintf o "%f" f

let pp_pol pp_c o e =
  let rec pp_pol o e =
    match e with
      | Pc n -> Printf.fprintf o "Pc %a" pp_c n
      | Pinj (p, pol) -> Printf.fprintf o "Pinj (%a, %a)" pp_positive p pp_pol pol
          | PX (pol1, p, pol2) -> Printf.fprintf o "PX (%a, %a, %a)" pp_pol pol1 pp_positive p pp_pol pol2 in
  pp_pol o e

    end

  type n = Numbers.T.n

type  pExpr =
  | PEc of num_i
  | PEX of positive
  | PEadd of pExpr * pExpr
  | PEsub of pExpr * pExpr
  | PEmul of pExpr * pExpr
  | PEopp of pExpr
  | PEpow of pExpr * n


(** val mk_X : 'a1 -> 'a1 -> positive -> 'a1 pol **)

let mk_X j =
  mkPinj_pred j mkX

(** val ppow_pos :
  'a1 -> 'a1 -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1
  -> bool) -> ('a1 pol -> 'a1 pol) -> 'a1 pol -> 'a1 pol -> positive -> 'a1
  pol **)

let rec ppow_pos subst_l res p = function
  | Numbers.T.XI p3 ->
      subst_l
        (pmul 
           (ppow_pos subst_l
              (ppow_pos subst_l res p p3) p p3) p)
  | Numbers.T.XO p3 ->
      ppow_pos subst_l
        (ppow_pos subst_l res p p3) p p3
  | Numbers.T.XH -> subst_l (pmul res p)

(** val ppow_N :
  'a1 -> 'a1 -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1
  -> bool) -> ('a1 pol -> 'a1 pol) -> 'a1 pol -> n -> 'a1 pol **)

let ppow_N subst_l p = function
  | Numbers.T.N0 -> p1 N.one_i
  | Numbers.T.Npos p2 -> ppow_pos subst_l (p1 N.one_i) p p2

  let p_pow p n0 = ppow_N (fun p0 -> p0) p (Numbers.T.Translation.n_n n0)

(** val norm_aux :
  'a1 -> 'a1 -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1 -> 'a1) -> ('a1 -> 'a1
  -> 'a1) -> ('a1 -> 'a1) -> ('a1 -> 'a1 -> bool) -> 'a1 pExpr -> 'a1 pol **)

let rec monomial_product = function
  | [] -> Pc N.one_i
  | j::tl ->  pmul (mk_X j) (monomial_product tl)


  let rec scale_p e = function
    | Pc c -> Pc c
    | Pinj (j, q) -> mkPinj j (scale_p (jump j e) q)
    | PX (p, i, q) ->
        let lo, up = hd_jump e in
        let x1 = mk_X Numbers.T.XH in
        let scale_x1 = paddC (pmulC x1 (N.sub_i up lo)) lo in
        let scale_x1_pow = p_pow scale_x1 (pos i) in
          padd (pmul (scale_p e p) scale_x1_pow) (mkPinj Numbers.T.XH (scale_p (tl_jump e) q))

  let eval_pol tbl p = eval_p (find_pos tbl) p

  let compare_int = Numbers.T.Pos.compare_int

  let vars_of_pol p = 
    let rec f acc = function
      | Pc _ -> acc
      | Pinj (i, q) -> 
        begin
          let vars_q = f acc q in
          let l = (List.map (add i) vars_q) @ acc in
            U.avoid_duplicata compare_int l
        end
      | PX (p, i, q) -> 
        begin
          let vars_p, vars_q = f [] p, List.map (add Numbers.T.XH) (f [] q) in
          let l = Numbers.T.XH::vars_p @ vars_q @ acc in
            U.avoid_duplicata compare_int l
        end
    in
    let vars = f [] p in
      U.avoid_duplicata compare_int vars

  let rec norm_aux = function
  | PEc c -> Pc c
  | PEX j -> mk_X j
  | PEadd (pe1, pe2) ->
      (match pe1 with
        | PEopp pe3 ->
            psub 
              (norm_aux pe2)
              (norm_aux pe3)
         | _ ->
             (match pe2 with
                | PEopp pe3 ->
                    psub 
                      (norm_aux pe1)
                      (norm_aux pe3)
                | _ ->
                    padd (norm_aux pe1)
                      (norm_aux pe2)))
  | PEsub (pe1, pe2) ->
      psub (norm_aux pe1)
        (norm_aux pe2)
  | PEmul (pe1, pe2) ->
      pmul (norm_aux pe1)
        (norm_aux pe2)
  | PEopp pe1 -> popp (norm_aux pe1)
  | PEpow (pe1, n0) ->
      ppow_N (fun p -> p)
        (norm_aux pe1) n0

let norm = norm_aux 


(** val xdenorm : positive -> 'a1 pol -> 'a1 pExpr **)

let rec xdenorm jmp = function
  | Pc c -> PEc c
  | Pinj (j, p2) -> xdenorm (add j jmp) p2
  | PX (p2, j, q0) ->
      PEadd ((PEmul ((xdenorm jmp p2), (PEpow ((PEX jmp), (Numbers.T.Npos j))))),
             (xdenorm (Numbers.T.Pos.succ jmp) q0))

(** val denorm : 'a1 pol -> 'a1 pExpr **)

let denorm p =
  xdenorm Numbers.T.XH p

(** val expr_to_term : 'a1 pExpr -> term **)

let rec expr_to_term = function
  | PEc z ->  Const z
  | PEX v ->  Var ("x"^(string_of_int (Numbers.T.Translation.index v)))
  | PEmul (p1, p2) ->
      let p1 = expr_to_term p1 in
      let p2 = expr_to_term p2 in
      let res = Mul (p1, p2) in 	   
        res
  | PEadd (p1, p2) -> Add (expr_to_term p1, expr_to_term p2)
  | PEsub (p1, p2) -> Sub (expr_to_term p1, expr_to_term p2)
  | PEpow (p, n)   -> Pow (expr_to_term p , Numbers.T.Translation.n n)
  | PEopp p ->  Opp (expr_to_term p)
(*
  let cadd, copp, csub, cmul, cpow = add_i, minus_i, sub_i, mult_i, pow_i
  let ceqb = eq_i 
  let cO, cI = zero_i, one_i
  let cinv, cdiv = inv_i, div_i
  let c_of_int = num_of_int
 *)
  let mkX_i n = if n = 0 then Pc N.one_i else mk_X (Numbers.T.Translation.positive_n n)
  let p_subC = psubC 
  let p_addC = paddC 
  let p_mulC = pmulC 
  let p_opp  = popp 
  let p_add = padd 
  let p_mul = pmul
  let p_square = psquare 
  let p_sub = psub 

  let monomial_prod indexes = monomial_product indexes
  let monomial_sum indexes = List.fold_left p_add (p0 N.zero_i) (List.map (fun i -> p_square (mk_X i)) indexes)
  let p_eq p1 p2 = peq p1 p2
  let p_is_null p = p_eq p (p0 N.zero_i)
  let fw_eq f1 f2 = fweq f1 f2
  let fw_neq f1 f2 = not (fweq f1 f2)
  let fw_eq_sort f1 f2 = if fweq f1 f2 then 0 else 1
  let poly_func_list = [
    ("add_i", p_add); ("sub_i", p_sub); ("mult_i", p_mul)
  ]
  let deriv_pol = deriv_p 
  let grad_pol vars p = Array.map (fun v -> deriv_pol v p) vars
  let eval_grad_pol l g = Array.map (eval_pol l) g
  let poly_func = Hashtbl.create 3
  let _ = U.add_list_table poly_func poly_func_list

  let term_of_pol p = (expr_to_term (denorm p))
  let string_of_pol p = string_of_term (term_of_pol p) N.string_of_i
  let string_of_pol_rat p = string_of_term (term_of_pol p) N.string_of_i_q
  let string_of_pol_float p prec = string_of_term (term_of_pol p) (fun i -> N.string_float i prec)
  let string_of_pol_zarith p = string_of_term (term_of_pol p) N.to_string

  let scale_pol tbl_scale fixed_var_num_list p no_scale = 
   let vars, nums = List.split fixed_var_num_list in
   let p_fixed = List.fold_right2 eval_pol_num vars nums p in 
   let p_scaled = try scale_p (find_pos tbl_scale) p_fixed with Failure _ -> failwith "Pb in scale_p" in
   let norm = if Config.Config.scale_pol && Config.Config.norm_magnitude && (not no_scale) then pol_norm_inf p_scaled else N.one_i in
      pmulC p_scaled (N.inv_i norm), norm 

  let box_of_tbl tbl vars = 
    let var_list = List.map string_of_pol (List.map mk_X vars) in
      try List.map (find_string tbl) var_list with Failure _ -> failwith "Pb in box_of_tbl"

  let basic_pol_I tbl p = basic_p_I 
  ( fun v -> 
      let s =  string_of_pol (mk_X v) in
        I.mk_I (snd (find_string tbl s))) p

  let string_of_pol_coq p = string_of_term (term_of_pol p) N.string_of_i_coq

  let eval_p_subst (e : positive -> pol) = eval_p_general e padd pmul (ppow_pos (fun p0 -> p0) (Pc one_i)) (fun c -> Pc c)

  let change_vars_pol vars p = 
    let nvars = List.length vars in
    let indexes = List.map (fun n -> mkX_i (n+1)) (U.int_to_list nvars) in 
    let tbl = Hashtbl.create nvars in
    let l = List.combine vars indexes in
      U.add_list_table tbl l; 
    let e = fun i -> Hashtbl.find tbl i in
     eval_p_subst e p
end
