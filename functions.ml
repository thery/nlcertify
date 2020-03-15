
module type T = 
sig
  exception EInfty
  type num_i
  type f = Infty | Num of num_i     
  val zero : num_i
  val cos' : num_i -> f
  val sin' : num_i -> f
  val cos' : num_i  -> f
  val tan' : num_i -> f                     
  val asin' : num_i -> f
  val acos' : num_i -> f
  val atan' : num_i -> f
  val log' : num_i -> f
  val exp' : num_i -> f
  val sqrt' : num_i -> f
  val inv' : num_i -> f
  val cos'' : num_i -> f
  val sin'' : num_i -> f
  val cos'' : num_i  -> f
  val tan'' : num_i -> f                     
  val asin'' : num_i -> f
  val acos'' : num_i -> f
  val atan'' : num_i -> f
  val log'' : num_i -> f
  val exp'' : num_i -> f
  val sqrt'' : num_i -> f
  val inv'' : num_i -> f
  val transc'_num : (num_i -> f) -> num_i -> num_i
  val atan_d3 : num_i -> f
end

module Make(N: Numeric.T) = struct
 
  type f = Infty | Num of N.t 
  exception EInfty
  type num_i = N.t
  let zero = N.zero_i
  open N
  (* TODO: Infty constructor is useless because we defined infty in module Numeric *)
  let i_of_num = function
    | Num i -> i
    | Infty -> raise EInfty 

  let cos' x  = Num (minus_i (sin_i x))
  let sin' x = Num (cos_i x)
  let tan' x = Num (inv_i (cos_i (pow_i x two_i))  )
  let atan' x = Num (inv_i ( add_i one_i (pow_i x two_i)))

  let acos' x = 
    if (lt_i (abs_i x) one_i) 
    then Num ( minus_i (inv_i ( sqrt_i( ( sub_i one_i (pow_i x two_i))))))
    else Infty

  let asin' x = 
    if (lt_i (abs_i x) one_i) 
    then Num ( inv_i (sqrt_i( ( sub_i one_i (pow_i x two_i)))))
    else Infty

  let sqrt' x = 
    if (gt_i x zero_i) 
    then Num (inv_i (mult_i two_i (sqrt_i x)))
    else Infty

  let log' x = 
    if (gt_i x zero_i) 
    then Num (inv_i x)
    else Infty

  let exp' x = Num (exp_i x)

  let inv' x = 
    if not (eq_i x zero_i)
    then  Num (minus_i (inv_i (pow_i x two_i))) 
    else Infty

  let cos'' x = Num (minus_i (cos_i x))
  let sin'' x = Num (minus_i (sin_i x))
  let tan'' x = 
    let tan' = inv_i (cos_i (pow_i x two_i)) in
      Num (mult_i two_i (mult_i tan'  (tan_i x) ))

  let atan'' x = Num (minus_i (div_i (mult_i two_i x )  (pow_i (add_i one_i (pow_i x two_i)) two_i )))
  let atan_d3 x = Num (div_i (sub_i (mult_i six_i (sqr_i x))  two_i)  (pow_i (add_i one_i (sqr_i x)) three_i ))

  let acos'' x = 
    if (lt_i (abs_i x) one_i)
    then 
      begin
        let den = mult_i (sqrt_i( ( sub_i one_i (pow_i x two_i))))  ( sub_i one_i (pow_i x two_i)) and num = minus_i x in
          Num (div_i num den)
      end
    else failwith "While computing acos'' or asin'': out of ]-1, 1[ range"
  (*-y/(1 - y^2)^(3/2)  *)

  let asin'' x = 
    let acos'' = acos'' x in
      match acos'' with 
        | Num acs -> Num (minus_i acs)
        | Infty -> Infty

  let sqrt'' x = 
    if (gt_i x zero_i)
    then Num  (inv_i (minus_i (mult_i four_i (mult_i (sqrt_i x) x) )))
    else Infty
  (*  -1/(4*y^(3/2))*)


  let log'' x = 
    if (gt_i x zero_i)
    then inv' x  
    else Infty       
  (*-1/y^2*)

  let exp'' x = Num (exp_i x)

  let inv'' x = 
    if not (eq_i x zero_i)
    then  Num (div_i two_i (pow_i x three_i))
    else Infty
  (*2/y^3*)

  let transc'_num transc' x0 =
    let x0_deriv = transc' x0 in
      match x0_deriv with
        | Num x0_value -> x0_value
        | Infty -> invalid_arg ((string_of_i x0) ^ " Function not derivable")
end

