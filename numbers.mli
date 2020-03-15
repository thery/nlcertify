module T : sig
  type positive = XI of positive | XO of positive | XH
  type z = Z0 | Zpos of positive | Zneg of positive
  type n = N0 | Npos of positive
  type comparison = Eq | Lt | Gt
  module Translation :
  sig
    val positive : positive -> int
    val positive_n : int -> positive
    val index : positive -> int
    val n : n -> int
    val n_n : int -> n
  end
  module Pos :
  sig
    val succ : positive -> positive
    val add : positive -> positive -> positive
    val add_carry : positive -> positive -> positive
    val pred_double : positive -> positive
    val pred : positive -> positive
    val compare_cont : positive -> positive -> comparison -> comparison
    val compare : positive -> positive -> comparison
    val compare_int : positive -> positive -> int
    val poseq_bool : positive -> positive -> bool
    val posgt_bool : positive -> positive -> bool
    val posge_bool : positive -> positive -> bool
  end
  module Z :
  sig
    type t = z
    val zero : z
    val one : z
    val two : z
    val double : z -> z
    val succ_double : z -> z
    val pred_double : z -> z
    val pos_sub : positive -> positive -> z
    val pos_mul : z -> z -> z
    val pow_pos : ('a -> 'a -> 'a) -> 'a -> positive -> 'a
    val zle_bool : z -> z -> bool
  end
end
