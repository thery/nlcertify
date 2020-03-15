
%{

(* anonymous function construct ast creation function *)
let mkfun = List.fold_right (fun i f -> Ast.Ast.Efun (i,f))

%}


/* tokens definition */
%token <string>  VAR
%token <string>  FUNC BOUND INEQ 
%token <string> INT FLOAT NUM
%token PLUS MINUS STAR SLASH POW
%token LE LT GE GT EQUALS 
%token SSCOLON SCOLON LPAR RPAR FUN RARROW COMA EQUALS OHOOK CHOOK  
%token IF ELSE THEN LET IN AND 

/* token priorities */
%left COMA
%left LE LT GE GT EQUALS
%left PLUS MINUS
%left STAR SLASH 
%left POW
%nonassoc uminus uinv
/* initial token */
%type <Ast.Ast.f_expr> prog
%start prog

%%

prog : LET FUNC alist EQUALS oexpr SSCOLON {(($2,$3),$5)} ;
     | LET FUNC EQUALS oexpr SSCOLON {(($2,[]),$4)} ;
     | LET BOUND alist EQUALS oexpr SSCOLON {(($2,$3),$5)} ;
/*     | LET BOX alist EQUALS OHOOK boundsexpr CHOOK {(($2,$3),
Ast.Ast.Boundlist $6 )} ;
     | LET OBJ alist EQUALS cexpr {(($2,$3), $5 )} ;*/
/*   | LET BOUND alist EQUALS OHOOK boundsexpr CHOOK SSCOLON{(($2,$3),Ast.Ast.Boundlist ($6))} ;*/
     | LET INEQ alist EQUALS OHOOK ineqsexpr  CHOOK SSCOLON {(($2,$3),Ast.Ast.Ineqlist($6))} ;
     | LET FUNC LPAR var_nuple RPAR EQUALS oexpr SSCOLON {(($2,$4),$7)} ;

oexpr : expr { $1 }
    | OHOOK boundsexpr CHOOK {Ast.Ast.Boundlist $2}
    /* | OHOOK ineqsexpr CHOOK {Ast.Ast.Ineqlist ($2)} */
      | FUN alist RARROW oexpr { mkfun $2 $4 }
      | LET VAR EQUALS expr IN oexpr {Ast.Ast.Elet ($2,$4,$6)}
      | expr AND expr {Ast.Ast.Eand ($1,$3)}
/*      | expr COMA expr {Ast.Ast.Etuple ($1,$3)}*/
      ;

boundsexpr : expr {[$1]}
           | expr SCOLON boundsexpr {$1::$3}
           ;

ineqsexpr : ineqexpr {[$1]}
          | ineqexpr SCOLON ineqsexpr {$1::$3}
          ;

ineqexpr : LPAR expr COMA expr RPAR {($2, $4) } 
/*        | LPAR expr COMA NONS RPAR {($2,Ast.Ast.Ige) }*/
         ;

expr : aexpr { $1 }
     | expr COMA expr {Ast.Ast.Etuple ($1,$3)}
     | orderapp {Ast.Ast.Ecnd (fst $1,fst (snd $1),snd (snd $1)) }
     | unopapp { Ast.Ast.Euop (fst $1,snd $1) }
     | binopapp { Ast.Ast.Ebop (fst $1,fst (snd $1),snd (snd $1)) }
     ;

aexpr : cexpr { $1 }
      | aexpr cexpr { Ast.Ast.Eapp ($1,$2) }
      ;

alist : VAR { [$1] }
      | VAR alist { $1 :: $2 }
      | LPAR VAR RPAR {[$2]}
      | LPAR VAR RPAR  alist { $2 :: $4 }
      ;

var_nuple : VAR { [$1] }
      | VAR COMA var_nuple { $1 :: $3 }
      ;

cexpr : LPAR oexpr RPAR { $2 }      
      | IF oexpr THEN oexpr {Ast.Ast.Eifthen($2,$4)}
      | IF oexpr THEN oexpr ELSE oexpr {Ast.Ast.Eifthenelse($2,$4,$6)}
      | FUNC { Ast.Ast.Efunc $1 }
      | VAR  { Ast.Ast.Evar $1 }
      | INT  { Ast.Ast.Eint (int_of_string $1) }
      | FLOAT { Ast.Ast.Eflo (float_of_string $1) }
      | NUM { Ast.Ast.Enum (Ast.Ast.of_string $1) }
      ;

unopapp : MINUS expr %prec uminus { (Ast.Ast.Umin,$2) } ;
        | SLASH expr %prec uinv { (Ast.Ast.Uinv,$2) } ;
         

binopapp : expr PLUS  expr { (Ast.Ast.Badd,($1,$3)) }
         | expr MINUS expr { (Ast.Ast.Bsub,($1,$3)) }
         | expr STAR  expr { (Ast.Ast.Bmul,($1,$3)) }
         | expr SLASH expr { (Ast.Ast.Bdiv,($1,$3)) }
         | expr POW expr { (Ast.Ast.Bpow,($1,$3)) }
         ;

orderapp : expr LE expr { (Ast.Ast.Ble,($1,$3)) }
         | expr LT expr { (Ast.Ast.Blt,($1,$3)) }
         | expr GE expr { (Ast.Ast.Bge,($1,$3)) }
         | expr GT expr { (Ast.Ast.Bgt,($1,$3)) }
         | expr EQUALS expr { (Ast.Ast.Beq,($1,$3)) }
         ;
