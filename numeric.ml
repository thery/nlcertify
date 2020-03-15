
module type T =
sig
  include Numerical_plugin.T
end


module Ocaml_float = struct
  type t = float
  let lb_ub_tol = 10
  let size_i q = 0
  let under_upper_tol = 14
  let print_accuracy = 6 
  let zero_i = 0.0
  let one_i = 1.0
  let two_i = 2.0
  let three_i = 3.0
  let four_i = 4.0
  let six_i = 6.0
  let ten_i = 10.0
  let nan_i = nan
  let infty = infinity
  let add_i, sub_i, minus_i, mult_i, div_i, abs_i, pow_i, max_i, min_i =
    (+.),(-.),(~-.),( *. ),(/.),abs_float,( ** ), max, min
  let eq_i,lt_i,le_i,gt_i,ge_i = (=),(<),(<=),(>),(>=)
  let cos_i, sin_i, tan_i, acos_i, asin_i, atan_i, log_i, exp_i, sqrt_i = cos, sin, tan, acos, asin, atan, log, exp, sqrt
  let sgn_i a = 
    if lt_i a zero_i then -1 
    else if gt_i a zero_i then 1
    else 0

  let is_integer i = float_of_int (int_of_float i) = i
  let compare_i = compare
  let ceil_i, floor_i = ceil, floor
  let num_of_int = float_of_int
  let int_of_num = int_of_float
  let num_of_float f = f
  let float_of_num f = f                         
  let rat_precision = 10000
  let ugly_rat_of_num f = 
    let numerator = mult_i (num_of_int rat_precision) f in
      int_of_num numerator, rat_precision

  let string_of_i_rat f = let n, d = ugly_rat_of_num f in Printf.sprintf "%i/%i" n d


  let interval_acc = num_of_float (Config.Config.interval_acc) 
  let under_i i = mult_i i (sub_i one_i (pow_i interval_acc (minus_i (float_of_int under_upper_tol))))                                          
  let upper_i i = mult_i i (add_i one_i (pow_i interval_acc (minus_i (float_of_int under_upper_tol))))

  let sqr_i x = pow_i x 2.
  let inv_i = (fun x -> div_i one_i x)

  let rel_err_i a b = abs_i (div_i (sub_i a b) a)
  let abs_err_i a b = abs_i (sub_i a b)
  let of_string s = try float_of_string s with Failure _ -> (print_string s; failwith "float_of_string")
  let num_of_string = of_string

  let string_of_i_1 num = 
    let (*pr_acc*)_ = if eq_i (sub_i num (floor num)) zero_i then 1 else print_accuracy in
    let result = Printf.sprintf "%g" (*pr_acc*) num in
      result 
 
  let string_of_i_2 num = 
    let s = string_of_float num in
    let x = s ^ (if String.get s (String.length s -1) = '.' then "0" else "") in
      x

  let string_of_i = string_of_i_1


  let lower_bound i acc = 
    let f = if ge_i i zero_i then sub_i else add_i in
    let result = mult_i i (f one_i (pow_i interval_acc (minus_i (float_of_int acc)))) in
      print_string (string_of_i result);
     result

  let upper_bound i acc = 
    let f = if le_i i zero_i then sub_i else add_i in
      mult_i i (f one_i (pow_i interval_acc (minus_i (float_of_int acc))))
  let sqrt_i_lo i = lower_bound (sqrt_i i) 10
  let sqrt_i_up i = upper_bound (sqrt_i i) 10


  let pow_int a n = 
    let rec pow_int_aux n acc = if n <= 0 then acc else pow_int_aux (n - 1) (acc * a) in
      pow_int_aux n 1

  let zarith_rat_of_num i = 
    let s = string_of_i i in
    let dot_position = Str.search_forward (Str.regexp "\\.") s 0 in
    let num_string = (String.sub s 0 dot_position) ^ (String.sub s (dot_position + 1) (String.length s -1 - dot_position)) in
    let den = Z.pow (Z.of_int 10) (String.length s - 1 - dot_position) in
    let q = 
      try Q.make (Z.of_string num_string) den
      with Failure _ -> print_string num_string; failwith "int_of_string"
    in
      q
  let num_of_float_exact f = f
  let num_of_rat q = let n, d = Q.num q, Q.den q in (Z.to_float n) /. (Z.to_float d)

  let string_of_i_q i = Q.to_string (zarith_rat_of_num i)
  let string_of_i_coq = string_of_i
  let to_string = string_of_i
  let string_float i precision = string_of_i i
  let atan2_i x y = atan2 y x
end

module Ocaml_zarith = struct
  type t = Q.t
  let of_int = Q.of_int
  let lb_ub_tol = 10
  let under_upper_tol = 14
  let print_accuracy = 6 
  let size_i q = 16 * (Z.size (Q.num q) + Z.size (Q.den q))
  let zero_i = Q.zero
  let one_i = Q.one
  let two_i = of_int 2
  let three_i = of_int 3
  let four_i = of_int 4
  let six_i = of_int 6
  let ten_i = of_int 10
  let infty = Q.inf
  let add_i, sub_i, minus_i, mult_i, div_i, max_i, min_i = Q.add, Q.sub, Q.neg, Q.mul, Q.div, Q.max, Q.min
  let eq_i,lt_i,le_i,gt_i,ge_i = Q.equal, Q.lt, Q.leq, Q.gt, Q.geq
  let sgn_i = Q.sign
  let abs_i i = if sgn_i i = 1 then i else minus_i i
  let int_of_num = Q.to_int
  let num_of_int = Q.of_int
  let inv_i = Q.inv

  let pow_i a b = 
    let rec pow_i_aux a b = if b < 0 then inv_i (pow_i_aux a (- b)) else if b = 0 then one_i else mult_i a (pow_i_aux a (b-1)) in
      pow_i_aux a (int_of_num b)
  let num_of_float = Q.of_float

  let interval_acc = num_of_float (Config.Config.interval_acc) 

  let string_of_i i = 
    let str = Q.to_string i in
    let num_den_list = Str.split (Str.regexp "/") str in
     match num_den_list with
       | [num; den] -> "(" ^ num ^ "#" ^ den ^ ")" 
       | [num] ->  "(" ^ num ^ "#1)" 
       | _ -> (print_string str; failwith "impossible to convert into coq IQR format")

  let string_of_i_coq i = string_of_i i
                            
  let lower_bound i acc = 
    let f = if ge_i i zero_i then sub_i else add_i in
    let result = mult_i i (f one_i (pow_i ten_i (minus_i (num_of_int acc)))) in
     result

  let upper_bound i acc = 
    let f = if le_i i zero_i then sub_i else add_i in
      mult_i i (f one_i (pow_i ten_i (minus_i (num_of_int acc))))

  let num_of_string = Q.of_string
  let num_of_rat q = q
  let float_of_num i = let n, d = Q.num i, Q.den i in (Z.to_float n) /. (Z.to_float d)

  let float_to_rat_func func x = num_of_float (func (float_of_num x))
  let cos_i =  float_to_rat_func cos
  let sin_i =  float_to_rat_func sin
  let tan_i = float_to_rat_func tan
  let acos_i = float_to_rat_func acos
  let asin_i = float_to_rat_func asin
  let atan_i = float_to_rat_func atan
  let log_i = float_to_rat_func log
  let exp_i = float_to_rat_func exp
  let sqrt_i = float_to_rat_func sqrt
  let sqrt_i_lo i = lower_bound (sqrt_i i) 10
  let sqrt_i_up i = upper_bound (sqrt_i i) 10


  let is_integer i = num_of_int (int_of_num i) = i
  let compare_i = Q.compare
  let ceil_i i =  Q.of_bigint (Z.cdiv (Q.num i) (Q.den i))
  let floor_i i =  Q.of_bigint (Z.fdiv (Q.num i) (Q.den i))

  let rat_precision = 10000
  let ugly_rat_of_num f = 
    let numerator = mult_i (num_of_int rat_precision) f in
      int_of_num numerator, rat_precision
  let string_of_i_rat = Q.to_string
  let to_string = Q.to_string

  let interval_acc = num_of_float (Config.Config.interval_acc) 
  let under_i i = i 
  let upper_i i = i

  let sqr_i x = pow_i x two_i

  let rel_err_i a b = abs_i (div_i (sub_i a b) a)
  let abs_err_i a b = abs_i (sub_i a b)
  let of_string = num_of_string

  let pow_int a n = 
    let rec pow_int_aux n acc = if n <= 0 then acc else pow_int_aux (n - 1) (acc * a) in
      pow_int_aux n 1

  (*TODO: fix the bug for zarith_rat_of_num*)
  let zarith_rat_of_num i = failwith "failwith zarith_rat_of_num for zarith"
                              (*
    let s = string_of_i i in
     let dot_position = Str.search_forward (Str.regexp "\\.") s 0 in
    let num_string = (String.sub s 0 dot_position) ^ (String.sub s (dot_position + 1) (String.length s -1 - dot_position)) in
    let den = pow_int 10 (String.length s - 1 - dot_position) in
     Q.( // ) (int_of_string num_string) den
                               *)
  let num_of_float_exact f = 
    let s = Printf.sprintf "%.10f" (*pr_acc*) f in
    let dot_position = 
      try Str.search_forward (Str.regexp "\\.") s 0 
      with Not_found ->  print_string s; failwith "Dot not found"
    in
   let num_string = (String.sub s 0 dot_position) ^ (String.sub s (dot_position + 1) (String.length s -1 - dot_position)) in
   let den = Z.pow (Z.of_int 10) (String.length s - 1 - dot_position) in
   let q = 
     try Q.make (Z.of_string num_string) den
     with Failure _ -> print_string num_string; failwith "int_of_string"
   in
    q

  let string_of_i_q i = Q.to_string (zarith_rat_of_num i)

  let string_q q = Q.to_string q

  let f_of_string s = try float_of_string s with Failure _ -> (print_string s; failwith "float_of_string")

  let string_float i precision =
    let p, q = Z.to_string (Q.num i), Z.to_string (Q.den i) in
    let np, nq = String.length p, String.length q in
    let carry = 20 in
    let p, q = 
      if np >= nq then if np <= carry then p, q else String.sub p 0 carry, String.sub q 0 (max 2 (carry - np + nq))
      else if nq <= carry then p, q else String.sub p 0 (max 2 (carry - nq + np)), String.sub q 0 carry
    in
      Printf.sprintf "%g" (((f_of_string p)) /. ( (f_of_string q)))

  let atan2_i x y = failwith "atan2 of zarith"
end

(* Floating-point numbers with radix beta = 10 *)
module Flocaml = struct
  let beta = 10
  type z = Z.t
  type t = {fnum : z; fexp : z}
  let size_i q = 16 * (Z.size q.fnum + Z.size q.fexp)
  let mk_float zm ze = {fnum = zm; fexp = ze}
  let zero =  Z.zero
  let of_int n = mk_float (Z.of_int n) zero
  let beta_z = Z.of_int beta

  let lb_ub_tol = 10
  let under_upper_tol = 14
  let print_accuracy = 6 
  let zero_i = of_int 0
  let one_i = of_int 1
  let two_i = of_int 2
  let three_i = of_int 3
  let four_i = of_int 4
  let six_i = of_int 6
  let ten_i = of_int 10
  let beta_i = of_int beta
  let infty = mk_float Z.one (Z.of_int 5)

  let falign f1 f2 =
    let m1, m2 = f1.fnum, f2.fnum in let e1, e2 = f1.fexp, f2.fexp in
      if Z.leq e1 e2 
      then (m1, Z.mul m2 (Z.pow beta_z (Z.to_int (Z.sub e2 e1)))), e1
      else (Z.mul m1 (Z.pow beta_z (Z.to_int (Z.sub e1 e2))), m2), e2

  let add_i f1 f2 = 
    let (m1, m2), e = falign f1 f2 in
      mk_float (Z.add m1 m2) e

  let rec digits_aux p nb pow n = 
    if n == 0 then nb 
    else if Z.lt p pow then nb 
    else digits_aux p (Z.succ nb) (Z.mul beta_z pow) (n - 1)

  let digits2_Pnat = Z.popcount 

  let digits z = 
    if Z.equal z Z.zero then z
    else if Z.lt z Z.zero then digits_aux (Z.neg z) Z.one beta_z (digits2_Pnat (Z.neg z))
    else digits_aux z Z.one beta_z (digits2_Pnat z)

  let minus_i f = mk_float (Z.neg f.fnum) f.fexp
  let sub_i f1 f2 = add_i f1 (minus_i f2)
  let mult_i f1 f2 = 
    let m1, m2 = f1.fnum, f2.fnum in let e1, e2 = f1.fexp, f2.fexp in
      mk_float (Z.mul m1 m2) (Z.add e1 e2)

  let prec_z = Z.of_int 10

  let div_i f1 f2 = 
    let m1, m2 = f1.fnum, f2.fnum in let e1, e2 = f1.fexp, f2.fexp in
    let d1 = digits m1 in
    let d2 = digits m2 in
    let e = Z.sub e1 e2 in
    let zp = Z.sub (Z.add d2 prec_z) d1 in
    let m, e' = 
      if Z.gt zp Z.zero then Z.mul m1 (Z.pow beta_z (Z.to_int zp)), Z.sub e zp
      else m1, e
    in
    let q, r = Z.ediv_rem m m2 in
      mk_float q e'

(*    Uq.debug  (Printf.sprintf "Test div:%s\n" (Nq.string_of_i (Nq.div_i (Nq.num_of_float 340.) (Nq.num_of_float 4800000000.))));*)

  let inv_i f = div_i one_i f

  let max_i f1 f2 = 
    let (m1, m2), e = falign f1 f2 in
      if Z.leq m1 m2 then mk_float m2 e else mk_float m1 e 

  let min_i f1 f2 = 
    let (m1, m2), e = falign f1 f2 in
      if Z.leq m1 m2 then mk_float m1 e else mk_float m2 e 

  let eq_i f1 f2 = let (m1, m2), e = falign f1 f2 in Z.equal m1 m2
  let lt_i f1 f2 = let (m1, m2), e = falign f1 f2 in Z.lt m1 m2
  let le_i f1 f2 = let (m1, m2), e = falign f1 f2 in Z.leq m1 m2
  let gt_i f1 f2 = let (m1, m2), e = falign f1 f2 in Z.gt m1 m2
  let ge_i f1 f2 = let (m1, m2), e = falign f1 f2 in Z.geq m1 m2
  let sgn_i f = Z.sign f.fnum
  let abs_i f = let m, e = f.fnum, f.fexp in mk_float (Z.abs m) e

  (* Input f = m 10^e : Round division towards 0 if e < 0*)                                             
  let int_of_num f = 
    let m, e = f.fnum, f.fexp in       
      if Z.geq e Z.zero then Z.to_int (Z.mul m (Z.pow beta_z (Z.to_int e))) 
      else Z.to_int (Z.div m (Z.pow beta_z (- (Z.to_int e))))
  let num_of_int = of_int

  let pow_i a b = 
    let rec pow_i_aux a b = if b < 0 then inv_i (pow_i_aux a (- b)) else if b = 0 then one_i else mult_i a (pow_i_aux a (b-1)) in
      pow_i_aux a (int_of_num b)

  let num_of_string s = 
    let dot_position = 
      try Str.search_forward (Str.regexp "\\.") s 0 
      with Not_found ->  print_string s; failwith "Dot not found"
    in
    let m_string = (String.sub s 0 dot_position) ^ (String.sub s (dot_position + 1) (String.length s -1 - dot_position)) in
    let e = String.length s - 1 - dot_position in
     mk_float (Z.of_string m_string) (Z.of_int (-e))

  let num_of_float i = num_of_string (string_of_float i)

  let interval_acc = num_of_float (Config.Config.interval_acc) 
  let float_of_num f = let m, e = f.fnum, f.fexp in 
      let exp = Z.pow beta_z (abs (Z.to_int e)) in
      if Z.geq e Z.zero then Z.to_float (Z.mul m exp) 
      else Z.to_float m /. Z.to_float exp

  let string_of_i i = string_of_float (float_of_num i)

  let string_of_i_coq f = 
    let m, e = f.fnum, f.fexp in 
      (*Z.to_string m ^ "e" ^ Z.to_string e *)
    let ms = Z.to_string m in
      if Z.equal m Z.zero then "cO"
      else if Z.gt m Z.zero then ms ^ "#" ^ (Z.to_string e)
      else ms ^ "##" ^ (Z.to_string e)
      (*if Z.lt e Z.zero then "Float " ^ Z.to_string m ^ " (" ^ Z.to_string e ^ ")" else  "Float " ^ Z.to_string m ^ " " ^ Z.to_string e *)


  let lower_bound i acc = 
    let f = if ge_i i zero_i then sub_i else add_i in
    let result = mult_i i (f one_i (pow_i ten_i (minus_i (num_of_int acc)))) in
     result

  let upper_bound i acc = 
    let f = if le_i i zero_i then sub_i else add_i in
      mult_i i (f one_i (pow_i ten_i (minus_i (num_of_int acc))))

  let num_of_rat q =  let n, d = Q.num q, Q.den q in div_i (mk_float n zero) (mk_float d zero)

  let float_to_flocaml_func func x = num_of_float (func (float_of_num x))
  let cos_i =  float_to_flocaml_func cos
  let sin_i =  float_to_flocaml_func sin
  let tan_i = float_to_flocaml_func tan
  let acos_i = float_to_flocaml_func acos
  let asin_i = float_to_flocaml_func asin
  let atan_i = float_to_flocaml_func atan
  let log_i = float_to_flocaml_func log
  let exp_i = float_to_flocaml_func exp
  let sqrt_i = float_to_flocaml_func sqrt
  let sqrt_i_lo i = lower_bound (sqrt_i i) 10
  let sqrt_i_up i = upper_bound (sqrt_i i) 10


  let is_integer i = num_of_int (int_of_num i) = i
  let compare_i f1 f2 = 
    let (m1, m2), e = falign f1 f2 in
     Z.compare m1 m2

  let ceil_i f = 
    let m, e = f.fnum, f.fexp in
      if Z.lt e Z.zero 
      then mk_float (Z.cdiv m (Z.pow beta_z (-(Z.to_int e)))) Z.zero
      else f

  let floor_i f = 
    let m, e = f.fnum, f.fexp in
      if Z.lt e Z.zero 
      then mk_float (Z.fdiv m (Z.pow beta_z (-(Z.to_int e)))) Z.zero
      else f

  let rat_precision = 10000
  let ugly_rat_of_num f = 
    let numerator = mult_i (num_of_int rat_precision) f in
      int_of_num numerator, rat_precision

  let string_of_i_rat = string_of_i 
  let to_string = string_of_i 

  let interval_acc = num_of_float (Config.Config.interval_acc) 
  let under_i i = i 
  let upper_i i = i

  let sqr_i f = let m, e = f.fnum, f.fexp in mk_float (Z.pow m 2) (Z.mul e (Z.of_int 2))

  let rel_err_i a b = abs_i (div_i (sub_i a b) a)
  let abs_err_i a b = abs_i (sub_i a b)
  let of_string = num_of_string

  let pow_int a n = 
    let rec pow_int_aux n acc = if n <= 0 then acc else pow_int_aux (n - 1) (acc * a) in
      pow_int_aux n 1

  (*TODO: fix the bug for zarith_rat_of_num*)
  let zarith_rat_of_num i = 
    let s = string_of_i i in
     let dot_position = Str.search_forward (Str.regexp "\\.") s 0 in
    let num_string = (String.sub s 0 dot_position) ^ (String.sub s (dot_position + 1) (String.length s -1 - dot_position)) in
    let den = pow_int 10 (String.length s - 1 - dot_position) in
     Q.( // ) (int_of_string num_string) den

  let num_of_float_exact f = num_of_string (Printf.sprintf "%.10f" (*pr_acc*) f)

  let string_of_i_q = string_of_i
  let string_float i precision = string_of_i i                   
(*
  let string_float f precision = 
  10let m, e = f.fnum, f.fexp in 
    let p = Z.to_string m in
    let np = String.length p in
    let nq = e in
    let carry = 20 in
    let p, q = 
      if np >= nq then if np <= carry then p, q else String.sub p 0 carry, String.sub q 0 (carry - np + nq)
      else if nq <= carry then p, q else String.sub p 0 (carry - nq + np), String.sub q 0 carry
    in
      Printf.sprintf "%.*f" precision (((float_of_string p)) /. ( (float_of_string q)))
 *)
  let atan2_i x y = failwith "atan2 of flocaml"
end

let list_of_modules =
  let l = [ ("float", (module Ocaml_float: T));  ("zarith", (module Ocaml_zarith: T)); ("flocaml", (module Flocaml: T))] in
    l

let of_string s =
  try
    List.assoc s list_of_modules
  with Not_found -> invalid_arg (s^": unknown numerical module")



