module type T =
sig
  type num_i
  type node
  type pol
  type fw_pol 
  type positive
  type fold_poly_tree 
  type eval_type
  type eval_tbl
  type rewrite_tbl

  val poly_T : pol -> fold_poly_tree
  val id_T : fold_poly_tree -> fold_poly_tree
  val const_T : num_i -> fold_poly_tree
  val zero_T : fold_poly_tree
  val one_T : fold_poly_tree
  val two_T : fold_poly_tree
  val four_T : fold_poly_tree
  val pi_T : fold_poly_tree
  val half_pi_T : fold_poly_tree
  val quarter_pi_T : fold_poly_tree
  val x_T : positive -> fold_poly_tree
  val fun_T : fold_poly_tree -> string -> fold_poly_tree
  val fun2_T : fold_poly_tree -> fold_poly_tree -> string -> fold_poly_tree
  val sin_T : fold_poly_tree -> fold_poly_tree
  val cos_T : fold_poly_tree -> fold_poly_tree
  val tan_T : fold_poly_tree -> fold_poly_tree
  val exp_T : fold_poly_tree -> fold_poly_tree
  val log_T : fold_poly_tree -> fold_poly_tree
  val atan_T : fold_poly_tree -> fold_poly_tree
  val is_const_T : fold_poly_tree -> bool
  val is_pol_T : fold_poly_tree -> bool
  val is_sqrt_lc_T : fold_poly_tree -> bool
  val kronecker_T : positive -> positive -> fold_poly_tree
  val add_T : fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  val is_add_T : fold_poly_tree -> bool
  val is_add_sub_T : fold_poly_tree -> bool
  val eq_n : node -> node -> bool
  val eq_T : fold_poly_tree -> fold_poly_tree -> bool
  val d_T : fold_poly_tree -> num_i
  val mul_T : fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  val sqrt_T : fold_poly_tree -> fold_poly_tree
  val minus_T : fold_poly_tree -> fold_poly_tree
  val sub_T : fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  val inv_T : fold_poly_tree -> fold_poly_tree
  val div_T : fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  val square_T : fold_poly_tree -> fold_poly_tree
  val pow_T :fold_poly_tree ->fold_poly_tree -> fold_poly_tree
  module Infixes : 
  sig
    val ( <+> ) :fold_poly_tree ->fold_poly_tree -> fold_poly_tree
    val ( <-> ) :fold_poly_tree ->fold_poly_tree -> fold_poly_tree
    val ( <*> ) :fold_poly_tree ->fold_poly_tree -> fold_poly_tree
    val ( </> ) :fold_poly_tree ->fold_poly_tree -> fold_poly_tree
    val ( <**> ) : fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  end
  val list_bop_T : (string *(fold_poly_tree -> fold_poly_tree -> fold_poly_tree)) list
  val tbl_bop_T : (string,fold_poly_tree -> fold_poly_tree -> fold_poly_tree) Hashtbl.t
  val create_T_table : unit
  val contains_fun_T : string -> fold_poly_tree -> bool
  val contains_inv_T : fold_poly_tree -> bool
  val contains_no_add_T : fold_poly_tree -> bool
  val unfold_T :string ->fold_poly_tree ->fold_poly_tree -> fold_poly_tree list
  val unfold_mul_T : fold_poly_tree -> fold_poly_tree list
  val unfold_add_T :fold_poly_tree -> fold_poly_tree list
  val fold_mul_T :fold_poly_tree list -> fold_poly_tree
  val fold_add_T :fold_poly_tree list -> fold_poly_tree
  val put_tbl_T :(fold_poly_tree, num_i) Hashtbl.t ->(num_i -> num_i -> num_i) -> fold_poly_tree -> unit
  val get_T :(num_i -> num_i -> num_i) ->fold_poly_tree * num_i -> fold_poly_tree
  val get_num_denum_T :fold_poly_tree -> fold_poly_tree * fold_poly_tree
  val simpl_T : fold_poly_tree -> fold_poly_tree
  val fold_simpl : fold_poly_tree -> fold_poly_tree
  val simpl1_T : fold_poly_tree -> fold_poly_tree
  val eval_aux : (positive, num_i) Hashtbl.t -> eval_tbl -> rewrite_tbl ->fold_poly_tree -> eval_type
  val eval_T : (positive, num_i) Hashtbl.t -> eval_tbl -> rewrite_tbl ->fold_poly_tree -> num_i
  val eval_T_num : positive -> num_i -> fold_poly_tree -> fold_poly_tree
  val eval_T_numarray : positive array -> num_i array -> fold_poly_tree -> fold_poly_tree
  val is_semialg_T : fold_poly_tree -> bool 
  val vars_T : fold_poly_tree -> positive list 
  val min_heuristic :fold_poly_tree -> eval_tbl -> rewrite_tbl -> (num_i * num_i) list -> positive list -> num_i * num_i * num_i list
  val min_heuristic_disj :fold_poly_tree ->fold_poly_tree -> eval_tbl -> rewrite_tbl -> (num_i * num_i) list -> positive list -> num_i * num_i list * num_i * num_i list
end

module Make
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (P: Polynomial.T with type num_i = N.t) 
  (Fu: Fw_utils.T with type num_i = N.t and type positive = P.positive and type fw_pol = P.fw_pol) 
  (F: Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) 
  (E: Unfold_eval_tree.T with type num_i = N.t) 
  (A: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node = F.node and type inter_mut = I.inter_mut) 
  (Tb: Algo_tables.T with type num_i = N.t and type p = P.positive and type eval_tbl = A.eval_tbl and type fw_tbl = A.fw_tbl)
  = struct

    type num_i = N.t
    type node = F.node
    type pol = P.pol
    type fw_pol = P.fw_pol
    type positive = P.positive
    type fold_poly_tree = A.fold_poly_tree
    type eval_type = E.eval_type
    type eval_tbl = A.eval_tbl
    type rewrite_tbl = A.rewrite_tbl

    let poly_T p = A.Pol (p, F.void_im ())
    let id_T t = t
    let const_T c = poly_T (P.Pc c)

    let zero_T = const_T N.zero_i
    let one_T = const_T N.one_i
    let two_T = const_T N.two_i
    let four_T = const_T N.four_i
    let pi = N.mult_i N.four_i (N.atan_i N.one_i) 
    let pi_T = const_T pi
    let half_pi_T = const_T (N.div_i pi N.two_i)
    let quarter_pi_T = const_T (N.div_i pi N.four_i)

    let x_T v = poly_T (P.mk_X v)

    let fun_T t s = A.Br_poly (( F.Ffunc s, F.void_im ()), [t])
    let fun2_T t1 t2 s = A.Br_poly (( F.Ffunc s, F.void_im ()), [t1; t2])

    let sin_T t  = fun_T t "sin"
    let cos_T t  = fun_T t "cos"
    let tan_T t  = fun_T t "tan"
    let atan_T t = fun_T t "atan"
    let exp_T t = fun_T t "exp"
    let log_T t = fun_T t "log"

    let rec is_const_T = function
      | A.Pol (P.Pc _, _) -> true
      | A.Br_poly (( F.Ffunc _, _), t_list) -> List.for_all is_const_T t_list
      | _ -> false

    let is_pol_T = function
      | A.Pol (p, _) -> true
      | _ -> false

    let rec is_sqrt_lc_T = function
      | A.Pol (P.Pc _, _) -> true
      | A.Br_poly (( F.Ffunc "sqrt", _), [ A.Pol (p, _)    ]) when P.degree_pol p <= 1 -> true
      | A.Br_poly ((F.Ffunc "mult_i", _), [a; b]) when is_const_T a -> is_sqrt_lc_T b
      | A.Br_poly ((F.Ffunc "mult_i", _), [a; b]) when is_const_T b -> is_sqrt_lc_T a
      | A.Br_poly (( F.Ffunc s, _), t_list) when s = "add_i" || s = "sub_i" || s = "minus_i" -> List.for_all is_sqrt_lc_T t_list
      | _ -> false

    let kronecker_T v1 v2 =
      match Numbers.T.Pos.compare v1 v2 with
        | Numbers.T.Eq -> one_T
        | _  -> zero_T

    let add_T t1 t2 =
      match t1, t2 with
        | A.Pol (p1, _), _ when P.p_is_null p1 -> t2
        | _, A.Pol (p2, _) when P.p_is_null p2 -> t1
        | A.Pol (p1, i1), A.Pol (p2, i2) -> A.Pol (P.p_add p1 p2, F.void_im ())
        | _ -> A.Br_poly (( F.Ffunc "add_i", F.void_im ()), [t1; t2])

    let is_add_T = function
      | A.Br_poly (( F.Ffunc "add_i", _), _) -> true
      | _ -> false

    let is_add_sub_T = function
      | A.Br_poly (( F.Ffunc s, _), _) when (s = "add_i" || s = "sub_i") -> true
      | _ -> false


    let eq_n n1 n2 = 
      match n1, n2 with
        | (F.Ffunc s1, _),  (F.Ffunc s2, _) -> s1 = s2
        | (F.Ffuncloc s1, _),  (F.Ffuncloc s2, _) -> s1 = s2
        | (F.Void , _), (F.Void, _) -> true
        | _ -> false 


    let rec eq_T t1 t2 = 
      match t1, t2 with 
        | A.Pol (p1, _), A.Pol (p2, _) -> P.p_eq p1 p2
        | A.Br_poly (n1, l1),  A.Br_poly (n2, l2) -> (n1 = n2) && (List.for_all2 eq_T l1 l2)
        | A.Varloc (s1, _), A.Varloc (s2, _) -> s1 = s2
        | _ -> false
(*
    let find_diff_T t1 t2 = 
      match t1, t2 with
        | A.Pol (p1, _), A.Pol (p2, _) -> if not (P.p_eq p1 p2) then t1, t2 else failwith "no diff"
        | A.Varloc (s1, _), A.Varloc (s2, _) -> if not (s1 = s2) then t1, t2 else failwith "no diff"
        | A.Br_poly (n1, l1),  A.Br_poly (n2, l2) ->  l1 l2
 *)

    let rec d_T = function
      | A.Pol (p, _) -> N.num_of_int (P.degree_pol p)
      | A.Br_poly ((F.Ffunc "minus_i", _), [a]) -> d_T a 
      | A.Br_poly ((F.Ffunc "sqrt", _), [a]) -> N.div_i (d_T a) N.two_i
      | A.Br_poly ((F.Ffunc "add_i", _), [a; b]) -> N.max_i (d_T a) (d_T b)
      | A.Br_poly ((F.Ffunc "sub_i", _), [a; b]) -> N.max_i (d_T a) (d_T b)
      | A.Br_poly ((F.Ffunc "pow_i", _), [a; A.Pol (P.Pc c, _)]) -> N.mult_i (d_T a) c
      | A.Br_poly ((F.Ffunc "mult_i", _), [a; b]) -> N.add_i (d_T a) (d_T b)
      | A.Br_poly ((F.Ffunc "div_i", _), [a; b]) -> N.sub_i (d_T a) (d_T b)
      | _ -> N.one_i

    let rec mul_T t1 t2 =
      let result = 
        match t1, t2 with
          | A.Pol (p1, _), _ when P.p_is_null p1 -> zero_T
          | _, A.Pol (p2, _) when P.p_is_null p2 -> zero_T
          | A.Pol (p1, _), A.Pol (p2, _) when P.degree_pol p1 + P.degree_pol p2 <= 4 ->  A.Pol (P.p_mul p1 p2, F.void_im ())
          | A.Br_poly (( F.Ffunc "sqrt", _), [a]), A.Br_poly (( F.Ffunc "sqrt", _), [b]) -> sqrt_T (mul_T a b)
          (*
           | A.Pol (p1, i1), A.Pol (p2, i2) -> A.Pol (p_mul p1 p2, F.void_im ())
           *)
          | _ when eq_T t1 one_T -> t2
          | _ when eq_T t2 one_T -> t1
          | _,  A.Br_poly (( F.Ffunc "inv_i", _), [h]) -> if eq_T t1 h then one_T else A.Br_poly (( F.Ffunc "div_i", F.void_im ()), [t1; h])
          | _ -> A.Br_poly (( F.Ffunc "mult_i", F.void_im ()), [t1; t2])
      in
        result


    and sqrt_T = function
      | A.Br_poly (( F.Ffunc "mult_i", _), [A.Pol (a, _); A.Pol (b, _)]) when P.p_eq a b -> A.Pol (a, F.void_im())
      | _ as t -> fun_T t "sqrt"



    let minus_T t =
      match t with
        | A.Pol (p, i) -> A.Pol (P.p_opp p, F.void_im ())
        | _ -> A.Br_poly (( F.Ffunc "minus_i", F.void_im ()), [t])

    let sub_T t1 t2 = add_T t1 (minus_T t2)

    let inv_T t =
      match t with
        | A.Pol (P.Pc c, i) -> A.Pol (P.Pc (N.inv_i c), F.void_im ())
        | _ -> A.Br_poly (( F.Ffunc "inv_i", F.void_im ()), [t])

    let div_T t1 t2 = mul_T t1 (inv_T t2)

    let rec square_T t1 = 
      match t1 with
        | A.Pol _ -> mul_T t1 t1
        | A.Br_poly (( F.Ffunc "sqrt", _), [h]) -> h
        | A.Br_poly (( F.Ffunc "mult_i", _), [a; b]) -> mul_T (square_T a) (square_T b)
        | A.Br_poly (( F.Ffunc "inv_i", _), [h]) -> inv_T (square_T h)
        | _ -> fun2_T t1 two_T "pow_i"

    let rec pow_T t = function
      | A.Pol (P.Pc n, _) when N.eq_i n N.two_i -> square_T t
      | A.Pol (P.Pc n, _) when N.eq_i n N.one_i -> t
      | A.Pol (P.Pc n, _) when N.eq_i n N.zero_i -> one_T
      | A.Pol (P.Pc n, _) when N.eq_i n (N.inv_i N.two_i) -> sqrt_T t
      | A.Pol (P.Pc n, _) as power ->
          begin
            match t with 
              | A.Br_poly (( F.Ffunc "mult_i", _), [a; b]) -> mul_T (pow_T a power) (pow_T b power)
              | A.Br_poly (( F.Ffunc "inv_i", _), [h]) -> inv_T (pow_T h power)
              | _ ->  fun2_T t power "pow_i"
          end
      | _ as power ->  fun2_T t power "pow_i"


    module Infixes =
    struct
      let (<+>) = add_T
      let (<->) = sub_T
      let (<*>) = mul_T 
      let (</>) = div_T
      let (<**>)= pow_T
    end

  (*
   let pow_T t1 t2 = fun2_T t1 t2 "pow_i"
   *)
    let list_bop_T = [
      ("add_i", add_T); ("sub_i", sub_T); ("mult_i", mul_T); ("div_i", div_T); ("pow_i", pow_T) 
    ]

    let tbl_bop_T = Hashtbl.create 5

    let create_T_table =  
      let _ = U.add_list_table tbl_bop_T list_bop_T in
        ()


    let rec contains_fun_T str = function
      | A.Br_poly (( F.Ffunc s, _), _) when (s = str) -> true
      | A.Br_poly ( _, t) -> List.exists (contains_fun_T str) t
      | _ -> false
    let contains_inv_T = contains_fun_T "inv_i"

    (* checks if the tree does not contain +, - at the root *)
    let rec contains_no_add_T = function
      | A.Br_poly (( F.Ffunc s, _), _) when (s = "add_i" || s = "sub_i") -> false 
      | _ -> true

    let rec unfold_T s e = function
      | A.Br_poly (( F.Ffunc str, _), [a; b]) when s = str -> unfold_T s e a @ unfold_T s e b
      | _ as t -> if eq_T t e then [] else [t]

    let unfold_mul_T =  unfold_T "mult_i" one_T
    let unfold_add_T = unfold_T "add_i" zero_T
    open Infixes
    let fold_mul_T t = List.fold_right (<*>) t one_T
    let fold_add_T t = List.fold_right (<+>) t zero_T

    let put_tbl_T tbl f_i t = 
      let a, power = match t with
        | A.Br_poly (( F.Ffunc "pow_i", _), [a; A.Pol (P.Pc p, _)] ) -> a, p
        | A.Br_poly (( F.Ffunc "sqrt", _), [a] ) -> a, N.inv_i N.two_i 
        | _ -> t, N.one_i
      in
      let _ = 
        try 
          let power_prev = Hashtbl.find tbl a in
            Hashtbl.replace tbl a (f_i power_prev power);
        with Not_found ->  Hashtbl.add tbl a (f_i N.zero_i power);
      in
        ()

  let get_T f_i = function
    | a, power -> 
        begin
          let power = f_i N.zero_i power in
            a <**> (const_T power)
        end

  let rec get_num_denum_T = function
    | A.Br_poly (( F.Ffunc "div_i", _), [a; b]) -> 
        begin
          let (pa, qa), (pb, qb) = get_num_denum_T (a), get_num_denum_T (b) in
            (pa <*> qb), (qa <*> pb)
        end
    | A.Br_poly (( F.Ffunc "mult_i", _), [a; A.Br_poly (( F.Ffunc "inv_i", _), [b]) ]) -> 
        begin
          let (pa, qa), (pb, qb) = get_num_denum_T (a), get_num_denum_T (b) in
            (pa <*> qb), (qa <*> pb)
        end
    | A.Br_poly (( F.Ffunc "mult_i", _), [a; b]) -> 
        begin
          let (pa, qa), (pb, qb) = get_num_denum_T (a), get_num_denum_T (b) in
          let mess = Printf.sprintf "pa: %s\n qa: %s\n pb: %s\n qb: %s\n" (A.string_T pa) (A.string_T qa) (A.string_T pb) (A.string_T qb) in
            U._pr_ mess false false; 
            (pa <*> pb), (qa <*> qb)
        end
      | A.Br_poly ((F.Ffunc s, _), [a; b]) when (s = "add_i" || s = "sub_i") -> 
          begin
            let (pa, qa), (pb, qb) = get_num_denum_T (simpl_T a), get_num_denum_T (simpl_T b) in
              U._pr_ s false false; U._pr_ (A.string_T a) false false;  U._pr_ (A.string_T b) false false; 
              let mess = Printf.sprintf "pa: %s\n qa: %s\n pb: %s\n qb: %s\n" (A.string_T pa) (A.string_T qa) (A.string_T pb) (A.string_T qb) in
                U._pr_ mess false false; 
                try
                  let f = Hashtbl.find tbl_bop_T s in                
                    f (simpl_T (pa <*> qb)) (simpl_T (pb <*> qa)), simpl_T (qa <*> qb)
                with Not_found -> failwith "Unknown Tree operation"
          end
          | A.Br_poly ((F.Ffunc "minus_i", _), [a]) -> 
              let pa, qa = get_num_denum_T (simpl_T a) in
                minus_T pa, qa
    | _ as t -> t, one_T

  and simpl_T t = 
    let tbl_T = Hashtbl.create 10 in
    let a, b = get_num_denum_T t in
    let l_a, l_b = unfold_mul_T a, unfold_mul_T b in
      List.iter (put_tbl_T tbl_T N.add_i) l_a; List.iter (put_tbl_T tbl_T N.sub_i) l_b;
      let new_l = U.hashtbl_to_list tbl_T in
      let new_l_a, new_l_b = List.partition (fun (_, p) -> N.ge_i p N.zero_i) new_l in
      let simpl_t = fold_mul_T (List.map (get_T N.add_i) new_l_a) </> fold_mul_T (List.map (get_T N.sub_i) new_l_b) in
        simpl_t

    let fold_simpl tree : fold_poly_tree =
      let rec fold_pol : (fold_poly_tree -> fold_poly_tree) = function
        | A.Br_poly ((F.Ffunc s, i), t) ->
            let fold_t = List.map fold_pol t in
              begin
                try
                  let p_func = Hashtbl.find P.poly_func s in
                    match fold_t with 
                      | [A.Pol (p1, i1); A.Pol (p2, i2)] -> A.Pol (p_func p1 p2, F.void_im())
                      | _ -> A.Br_poly ((F.Ffunc s, i), fold_t) 
                with Not_found ->
                  if s = "minus_i" then 
                    begin
                      match fold_t with
                        | [A.Pol (p1, i1)] -> A.Pol (P.p_opp p1, F.void_im ())
                        | _ -> A.Br_poly ((F.Ffunc s, i), fold_t)
                    end
                  else if s = "atan2" then
                    begin
                      match fold_t with
                        | [A.Pol (P.Pc f1, i1); A.Pol (P.Pc f2, i2)] -> A.Pol (P.Pc (N.atan2_i f2 f1), F.void_im ())
                        | _ -> A.Br_poly ((F.Ffunc s, i), fold_t)
                    end
                  else 
                    try
                      let f = Hashtbl.find I.func_basic s in
                        match fold_t with
                          | [A.Pol (P.Pc f0, i1)] -> A.Pol (P.Pc (f f0), i1)
                          | _ -> A.Br_poly ((F.Ffunc s, i), fold_t)
                    with Not_found -> A.Br_poly ((F.Ffunc s, i), fold_t) 
              end
        | A.Br_poly ((n, i), t) -> A.Br_poly ((n, i), List.map fold_pol t)
        | _ as t -> t
      in
        fold_pol tree

    let simpl1_T t = fold_simpl (simpl_T t)

    let eval_aux l tbl tbl_loc t : eval_type = 
      let rec eval_T_aux t = 
        match t with
          | A.Varloc (v, _) -> 
              begin
                try
                  match Hashtbl.find tbl v with
                    | (p1, p2), _ when P.fw_eq p1 p2 -> E.Num_eval (Fu.eval_fw l p1)
                    | _ -> E.Fail_eval ("Impossible to evaluate at " ^ v)
                with Not_found -> 
                  begin
                    try
                      match Hashtbl.find tbl_loc v with
                        | A.Poly_Int (p1, p2) when P.fw_eq p1 p2 -> E.Num_eval (Fu.eval_fw l p1)
                        | _ -> E.Fail_eval ("Impossible to evaluate at " ^ v)
                    with Not_found -> E.Fail_eval v 
                  end
              end 
          | A.Pol (p, _) -> E.Num_eval (P.eval_pol l p)
          | A.Br_poly ((F.Ffunc "and", _), [a; b]) -> 
              begin
                match eval_T_aux a, eval_T_aux b with
                  | E.Bool_eval b1, E.Bool_eval b2 -> E.Bool_eval (b1 && b2)
                  | _ -> E.Fail_eval "and"
              end
          | A.Br_poly ((F.Ffunc "cnd", _), [A.Br_poly ((F.Ffunc "if", _),  [t1]); A.Br_poly((F.Ffunc "then", _), [t2]); A.Br_poly((F.Ffunc "else", _), [t3])]) -> 
              begin
                match eval_T_aux t1 with
                  | E.Bool_eval b -> eval_T_aux (if b then t2 else t3)
                  | _ -> E.Fail_eval "cnd"
              end
          | A.Br_poly ((F.Ffunc s, _), [a; b]) -> 
              begin
                try
                  let bop = Hashtbl.find I.func_basic2 s in
                    match eval_T_aux a, eval_T_aux b with
                      | E.Num_eval e1, E.Num_eval e2 -> E.Num_eval (bop e1 e2)
                      | _ -> U._pr_ ("bug in eval_T_aux at: " ^ s) true true; E.Fail_eval s
                with Not_found -> 
                  begin
                    try
                      let bool_op = Hashtbl.find I.func_bool s in
                        match eval_T_aux a, eval_T_aux b with
                          | E.Num_eval e1, E.Num_eval e2 -> E.Bool_eval (bool_op e1 e2)
                          | _ -> E.Fail_eval s
                    with Not_found -> E.Fail_eval s
                  end
              end
          | A.Br_poly ((F.Ffunc s, _), [a]) ->
              begin
                try
                  let uop = Hashtbl.find I.func_basic s in
                    match eval_T_aux a with
                      | E.Num_eval e -> E.Num_eval (uop e)
                      | _ -> E.Fail_eval s
                with Not_found -> E.Fail_eval s
              end
          | _ -> E.Fail_eval "Unknown case for this tree"
      in
        eval_T_aux t

    let eval_T tbl_pol tbl tbl_loc t =
      match eval_aux tbl_pol tbl tbl_loc t with
        | E.Num_eval e -> e
        | E.Bool_eval _ -> failwith "E.Bool_eval in eval_T"
        | E.Fail_eval s -> failwith s

    let eval_T_num var value t : fold_poly_tree = 
      let vim () = F.void_im () in
      let rec eval_T_aux t = 
        match t with
          | A.Pol (p, i) -> poly_T (P.eval_pol_num var value p)
          | A.Br_poly ((F.Ffunc "and", _), [a; b]) -> A.Br_poly ((F.Ffunc "and", vim ()), [eval_T_aux a; eval_T_aux b]) 
          | A.Br_poly ((F.Ffunc "cnd", _), [A.Br_poly ((F.Ffunc "if", _),  [t1]); A.Br_poly((F.Ffunc "then", _), [t2]); A.Br_poly((F.Ffunc "else", _), [t3])]) ->  A.Br_poly ((F.Ffunc "cnd", vim ()), [A.Br_poly ((F.Ffunc "if", vim ()),  [eval_T_aux t1]); A.Br_poly((F.Ffunc "then", vim ()), [eval_T_aux t2]); A.Br_poly((F.Ffunc "else", vim ()), [eval_T_aux t3])]) 
          | A.Br_poly ((F.Ffunc s, _), [a; b]) -> fun2_T (eval_T_aux a) (eval_T_aux b) s
          | A.Br_poly ((F.Ffunc s, _), [a]) -> fun_T (eval_T_aux a) s
          | A.Varloc (v, _)  -> A.Varloc (v, vim ())
          | _ -> failwith "unknown argument for eval_T_num"
      in
        eval_T_aux t

    let eval_T_numarray vars values t : fold_poly_tree = 
      let eval t var_value = eval_T_num (fst var_value) (snd var_value) t in
      let vars_values = List.combine (Array.to_list vars) (Array.to_list values) in
        List.fold_left eval t vars_values

    let rec is_semialg_T = function
      | A.Pol _ | A.Varloc _ -> true 
      | A.Br_poly ((F.Ffunc "cnd", _), [A.Br_poly ((F.Ffunc "if", _),  [t1]); A.Br_poly((F.Ffunc "then", _), [t2]); A.Br_poly((F.Ffunc "else", _), [t3])]) -> is_semialg_T t2 && is_semialg_T t3
      | A.Br_poly ((F.Ffunc s, _), t_list) -> not (Hashtbl.mem I.func_transc s) && List.for_all is_semialg_T t_list
      | _ -> true

    let vars_T t = 
      let vars = P.vars_of_pol in
      let sort = U.avoid_duplicata Numbers.T.Pos.compare_int in
      let concat = List.concat in
      let rec f = function
        | A.Pol (p, _) -> vars p 
        | A.Varloc _ -> [] 
        | A.Br_poly ((F.Ffunc "cnd", _), [A.Br_poly ((F.Ffunc "if", _),  _); A.Br_poly((F.Ffunc "then", _), [t2]); A.Br_poly((F.Ffunc "else", _), [t3])]) -> sort ((f t2) @ (f t3))
        | A.Br_poly ((F.Ffunc s, _), t_list) -> sort (concat (List.map f t_list))
        | _ -> [] in
        sort (f t)
               
    let min_heuristic t tbl tbl_loc bounds vars =
      let l = List.length bounds in
      let mesh = if Config.Config.heuristic_corners && l < 7
      then U.combine_tuple_1 bounds
      else (* otherwise, stack overflow *) U.pick_rnd_in_box (U.pow_2_n (min l 12)) bounds
      in
        U._pr_ (string_of_int (List.length bounds)) true false;
        let values = List.map (fun x -> eval_T (Tb.get_tbl_pol vars x) tbl tbl_loc t) mesh in
          U._pr_ ("evaluated") true false;
          let min_guess = I.min_list values in
          let max_guess = I.max_list values in
          let low_values = E.get_low_values values in
            U._pr_ ("Corner Low Values : " ^ (I.string_of_list_i low_values)) true false;
            let x0_index = U.index_of_elt values min_guess in
            let x0 = List.nth mesh x0_index in
            let mess = Printf.sprintf "Extremum guesses: %s, %s Optimum guess: %s" (N.string_of_i min_guess) (N.string_of_i max_guess) (I.string_of_list_i x0) in
              U._pr_ mess true false;
              min_guess, max_guess, x0 

    let min_heuristic_disj t fw tbl tbl_loc bounds vars = 
      let mesh = U.combine_tuple_1 bounds in
      let values = List.map (fun x -> eval_T (Tb.get_tbl_pol vars x) tbl tbl_loc t) mesh in
      let values_fw = List.map (fun x -> eval_T (Tb.get_tbl_pol vars x) tbl tbl_loc fw) mesh in
        U._pr_ (I.string_of_list_i values_fw) true false;
        let min_pos, min_neg = I.min_list_cnd values values_fw true, I.min_list_cnd values values_fw false in
        let x0_index_pos, x0_index_neg = U.index_of_elt values min_pos, U.index_of_elt values min_neg in
        let x0_pos, x0_neg = List.nth mesh x0_index_pos, List.nth mesh x0_index_neg in
        let mess_pos = Printf.sprintf "Extremum guess pos: %s Optimum guess pos: %s" (N.string_of_i min_pos) (I.string_of_list_i x0_pos) in
        let mess_neg = Printf.sprintf "Extremum guess neg: %s Optimum guess neg: %s" (N.string_of_i min_neg) (I.string_of_list_i x0_neg) in
          U._pr_ (mess_pos ^ mess_neg) true false ;
          min_pos, x0_pos, min_neg, x0_neg 
  end
