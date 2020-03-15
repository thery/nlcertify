
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

module Make : functor (N : Numeric.T) -> T with type num_i = N.t

