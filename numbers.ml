module T = struct

  type positive =
    | XI of positive
    | XO of positive
    | XH

  type z =
    | Z0
    | Zpos of positive
    | Zneg of positive

  type n =
    | N0
    | Npos of positive


  type comparison =
    | Eq
    | Lt
    | Gt

  module Translation =
  struct
    let rec positive p =
      match p with
        | XH -> 1
        | XI p -> 1+ 2*(positive p)
        | XO p -> 2*(positive p)

    let rec positive_n n =
      if n=1 then XH
      else if n land 1 = 1 then XI (positive_n (n lsr 1))
      else  XO (positive_n (n lsr 1))

    let rec index i = (* Swap left-right ? *)
      match i with
        | XH -> 1
        | XI i -> 1+(2*(index i))
        | XO i -> 2*(index i)

    let n nt =
      match nt with
        | N0 -> 0
        | Npos p -> positive p

    let n_n nt =
      if nt < 0
      then assert false
      else if nt = 0 then N0
      else Npos (positive_n nt)

  end

  module Pos = 
  struct

    (** val succ : positive -> positive **)

    let rec succ = function
      | XI p -> XO (succ p)
      | XO p -> XI p
      | XH -> XO XH

    (** val add : positive -> positive -> positive **)

    let rec add x y =
      match x with
        | XI p ->
            (match y with
               | XI q0 -> XO (add_carry p q0)
               | XO q0 -> XI (add p q0)
               | XH -> XO (succ p))
        | XO p ->
            (match y with
               | XI q0 -> XI (add p q0)
               | XO q0 -> XO (add p q0)
               | XH -> XI p)
        | XH ->
            (match y with
               | XI q0 -> XO (succ q0)
               | XO q0 -> XI q0
               | XH -> XO XH)

    (** val add_carry : positive -> positive -> positive **)

    and add_carry x y =
      match x with
        | XI p ->
            (match y with
               | XI q0 -> XI (add_carry p q0)
               | XO q0 -> XO (add_carry p q0)
               | XH -> XI (succ p))
        | XO p ->
            (match y with
               | XI q0 -> XO (add_carry p q0)
               | XO q0 -> XI (add p q0)
               | XH -> XO (succ p))
        | XH ->
            (match y with
               | XI q0 -> XI (succ q0)
               | XO q0 -> XO (succ q0)
               | XH -> XI XH)

    (** val pred_double : positive -> positive **)

    let rec pred_double = function
      | XI p -> XI (XO p)
      | XO p -> XI (pred_double p)
      | XH -> XH

    (** val pred : positive -> positive **)

    let pred = function
      | XI p -> XO p
      | XO p -> pred_double p
      | XH -> XH
 
    let rec mul x y =
      match x with
        | XI p -> add y (XO (mul p y))
        | XO p -> XO (mul p y)
        | XH -> y

    (** val compare_cont : positive -> positive -> comparison -> comparison **)

    let rec compare_cont x y r =
      match x with
        | XI p ->
            (match y with
               | XI q0 -> compare_cont p q0 r
               | XO q0 -> compare_cont p q0 Gt
               | XH -> Gt)
        | XO p ->
            (match y with
               | XI q0 -> compare_cont p q0 Lt
               | XO q0 -> compare_cont p q0 r
               | XH -> Gt)
        | XH ->
            (match y with
               | XH -> r
               | _ -> Lt)

    (** val compare : positive -> positive -> comparison **)

    let compare x y =
      compare_cont x y Eq

    let poseq_bool x y = match compare x y with | Eq -> true | _ -> false

    let posle_bool x y = match compare x y with | Gt -> false | _ -> true
    let posgt_bool x y = match compare x y with | Gt -> true | _ -> false
    let posge_bool x y = match compare x y with | Lt -> false | _ -> true


    let compare_int x y = 
      match compare x y with | Eq -> 0 | Gt -> 1 | Lt -> -1

  end

  module Z = 
  struct 
    type t = z

    (** val zero : z **)

    let zero =
      Z0

    (** val one : z **)

    let one =
      Zpos XH

    (** val two : z **)

    let two =
      Zpos (XO XH)

    (** val double : z -> z **)

    let double = function
      | Z0 -> Z0
      | Zpos p -> Zpos (XO p)
      | Zneg p -> Zneg (XO p)

    (** val succ_double : z -> z **)

    let succ_double = function
      | Z0 -> Zpos XH
      | Zpos p -> Zpos (XI p)
      | Zneg p -> Zneg (Pos.pred_double p)

    (** val pred_double : z -> z **)

    let pred_double = function
      | Z0 -> Zneg XH
      | Zpos p -> Zpos (Pos.pred_double p)
      | Zneg p -> Zneg (XI p)

    (** val pos_sub : positive -> positive -> z **)

    let rec pos_sub x y =
      match x with
        | XI p ->
            (match y with
               | XI q0 -> double (pos_sub p q0)
               | XO q0 -> succ_double (pos_sub p q0)
               | XH -> Zpos (XO p))
        | XO p ->
            (match y with
               | XI q0 -> pred_double (pos_sub p q0)
               | XO q0 -> double (pos_sub p q0)
               | XH -> Zpos (Pos.pred_double p))
        | XH ->
            (match y with
               | XI q0 -> Zneg (XO q0)
               | XO q0 -> Zneg (Pos.pred_double q0)
               | XH -> Z0)

    let pos_mul x y = 
      match x, y with
        | Z0, _ -> zero
        | _, Z0 -> zero
        | Zpos x', Zpos y' -> Zpos (Pos.mul x' y')
        | Zpos x', Zneg y' -> Zneg (Pos.mul x' y')
        | Zneg x', Zpos y' -> Zneg (Pos.mul x' y')
        | Zneg x', Zneg y' -> Zpos (Pos.mul x' y')

 

    let rec pow_pos rmul x = function
      | XI i0 -> let p = pow_pos rmul x i0 in rmul x (rmul p p)
      | XO i0 -> let p = pow_pos rmul x i0 in rmul p p
      | XH -> x

    let zle_bool z1 z2 = 
      match z1 with
        | Z0 -> (match z2 with Zneg _ -> false | _ -> true)
        | Zpos p1 ->  (match z2 with Zpos p2 -> Pos.posle_bool p1 p2 | _ -> false)
        | Zneg p1 -> (match z2 with Zneg p2 -> Pos.posle_bool p1 p2 | _ -> true)

  end 
end
