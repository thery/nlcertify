(* binary and unary operators type *)
module Ast = struct
  type bop = Badd | Bsub | Bmul | Bdiv | Bpow
  type uop = Umin | Uinv
  type orderop = Ble | Blt | Bge | Bgt | Beq 
  (*type ineqop = Ige | Igt*)

  (* expression trees type *)
  type e = Evar of string
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
  (*
   type bounds_list = Boundlist of e list
   type ineq_disj = Ineqlist of (e * ineqop) list 
   *)
  (*       
   | Eletin of flocal * e * e
   *)

  type f_entry = string * string list
  type f_expr = f_entry * e

  let print_ast ast =
    let rec pp_ast e =
      match e with
        | Evar s-> "Evar(" ^ s ^ ")"
        | Efunc s-> "Efunc(" ^ s ^ ")" 
        | Eint s -> "Eint(" ^ string_of_int s ^ ")"
        | Eflo s -> "Eflo(" ^ string_of_float s ^ ")"
        | Enum s -> "Enum(" ^ Q.to_string s ^ ")"
        | Efun (s,e) -> "Efun("^ s ^","^(pp_ast e)^")"
        | Eapp (e1,e2) -> "Eapp(" ^(pp_ast e1) ^","^  (pp_ast e2)^")"
        | Ebop (bop,e1,e2) -> 
            (match bop with
               |Bpow -> "Bpow(" 
               |Badd -> "Badd("
               |Bsub -> "Bsub("
               |Bmul -> "Bmul("
               |Bdiv -> "Bdiv(")^(pp_ast e1)^"," ^(pp_ast e2)^")"
        |Euop (uop,e) -> 
            (match uop with 
               |Umin -> "Umin("
               |Uinv -> "Uinv(")^(pp_ast e)^")"
        | _ -> ""
    (* |Eletin (f,e1,e2) -> "Eapp("^f ^ *)
    in
      print_string (pp_ast ast)

let pow_i a b = 
  let rec pow_i_aux a b = if b < 0 then Q.inv (pow_i_aux a (- b)) else if b = 0 then Q.one else Q.mul a (pow_i_aux a (b-1)) in
  pow_i_aux a b
let ten_i = Q.of_int 10

let of_string s = 
  let num_den_list = Str.split (Str.regexp "e") s in 
  match num_den_list with
       | [num; den] -> Q.mul (Q.of_float (float_of_string num)) (pow_i ten_i (int_of_string den))
       | _ -> failwith "Bad scientific number format"

end
