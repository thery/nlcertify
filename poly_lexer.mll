
{

(* keyword/identifiers treatment function *)

exception Eof
}

(* regexp definitions *)
let blank = (' ' | '\t' | '\n' | '\r')+
let dec = ['0'-'9']+
let flo = dec '.' (dec)*
let lower = ['a'-'z']
let upper = ['A'-'Z']
let letter = lower | upper
let var = letter (dec)*

(* main lexing rule *)
rule token = parse
| blank { token lexbuf }
| var as v {Poly_parser.VAR v}
| flo as f { Poly_parser.FLOAT f }
| dec as d { Poly_parser.INT d }
| "+" { Poly_parser.PLUS }
| "-" { Poly_parser.MINUS }
| "*" { Poly_parser.STAR }
| "^" { Poly_parser.POW }
| "/" { Poly_parser.SLASH }
| "(" { Poly_parser.LPAR }
| ")" { Poly_parser.RPAR }
| eof { raise Eof }
| _ as s { Printf.printf "Poly Lexer cannot handle the following string: %s" s; failwith "failure" }

