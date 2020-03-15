module Ast :
sig
  type bop = Badd | Bsub | Bmul | Bdiv | Bpow
  type uop = Umin | Uinv
  type orderop = Ble | Blt | Bge | Bgt | Beq
  type e =
      Evar of string
    | Evarloc of string
    | Eint of int
    | Eflo of float
    | Enum of Q.t
    | Efun of string * e
    | Efunc of string
    | Eapp of e * e
    | Ebop of bop * e * e
    | Euop of uop * e
    | Ecnd of orderop * e * e
    | Eifthen of e * e
    | Eifthenelse of e * e * e
    | Elet of string * e * e
    | Etuple of e * e
    | Eand of e * e
    | Boundlist of e list
    | Ineqlist of (e * e) list
  type f_entry = string * string list
  type f_expr = f_entry * e
  val print_ast : e -> unit
  val of_string : string -> Q.t
end
