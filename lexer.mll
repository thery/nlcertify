
{

(* keyword/identifiers treatment function *)
(*let l_fun = ["sin";"tan";"cos";"sqrt"]        *)

open Sphere_functions

let funcorident n l=
        if (List.mem n l) then (
                Parser.FUNC n )
        else  
                try
                        let value = List.assoc n [ ("let",Parser.LET) ; ("fun",Parser.FUN); ("if",Parser.IF); ("else",Parser.ELSE);("then",Parser.THEN);("in",Parser.IN)] in
                        (*Printf.printf "VALUE %s\n" n;*)
                        value 
                with Not_found -> (
                        (*Printf.printf "VAR: %s\n" n; *)
                        Parser.VAR n)

(*
let keyorident n = try
  List.assoc n [
                 ("fun",Parser.FUN) ]
  with Not_found -> Parser.VAR n
*)  
exception Eof
exception Openml
}

(* regexp definitions *)
let blank = (' ' | '\t' | '\n' | '\r')+
let dec = ['0'-'9']+
let flo = dec '.' (dec)*
let num = (flo | dec) 'e' '-'? dec
let lower = ['a'-'z'] | '_'
let upper = ['A'-'Z']
let letter = lower | upper
let lident = lower (letter | dec)*
let bound = "box_" (letter | dec) + 
let ineq = "obj_" (letter | dec) +
let open_ml = "open" blank (letter | dec)+ blank ";;"

(* main lexing rule *)
rule token = parse
    blank { token lexbuf }
  | flo as f { Parser.FLOAT f }
  | num as f { Parser.NUM f }
  | dec as d { Parser.INT d }
  | bound as s { Parser.BOUND s }
  | ineq as s { Parser.INEQ s }
  | lident as i { funcorident i (sphere_functions @ bounds_templates)}
  | "=" { Parser.EQUALS }
  | "," { Parser.COMA }
  | "+." | "+" { Parser.PLUS }
  | "-." | "-" { Parser.MINUS }
  | "*." | "*" { Parser.STAR }
  | "**" { Parser.POW }
  | "/." | "/" { Parser.SLASH }
  | "(" { Parser.LPAR }
  | ")" { Parser.RPAR }
  | "->" { Parser.RARROW }
  | ";;" {Parser.SSCOLON}
  | ";" {Parser.SCOLON}
  | "<=" {Parser.LE}
  | "<" { Parser.LT}
  | ">=" { Parser.GE}
  | ">" { Parser.GT}
  | "&&" {Parser.AND}
  | eof { raise Eof }
  | "[" {(*Printf.printf "[ found\n";*)Parser.OHOOK}
  | "]" {Parser.CHOOK}
(*  | "\"gt\"" {Parser.STRICT}
  | "\"ge\"" {Parser.NONSTRICT}
*)
  | open_ml {(*Printf.printf "Openml found\n";*)raise Openml}
  | _ as c { Printf.printf "Lexer cannot handle the following string: %c\n" c ; failwith "failure" }
