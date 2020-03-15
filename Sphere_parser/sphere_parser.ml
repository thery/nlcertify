(************************************************************************)
(* parse_ineq.ml:  parse flyspeck non-linear inequalities from hol      *)
(* to caml and coq format                                               *)
(*                                                                      *)
(*  Victor Magron (Lix/Inria)                                           *)
(*                                                                      *)
(************************************************************************)

open Big_int
open Num
open Str
open Sphere_functions
open List

let flyspeck_dir = "../flyspeck_dir/"

(*
let print_variables e = 
  let (variables:poly) = (poly_of_term (expr_to_term e)) in
  let (p_v:vname list)=(poly_variables variables) in
  ( string_of_variables (p_v ))                                           
 *)
let sphere_final = open_out_gen [Open_trunc;Open_wronly;Open_creat] 0o666
(flyspeck_dir^"sphere_final.v")
let sphere_final_ml = open_out_gen [Open_trunc;Open_wronly;Open_creat] 0o666
(flyspeck_dir^"sphere_final.ml")
let ineq_final = open_out_gen [Open_trunc;Open_wronly;Open_creat] 0o666 
(flyspeck_dir^"ineq_final.v")
let ineq_test = open_out_gen [Open_trunc;Open_wronly;Open_creat] 0o666
(flyspeck_dir^"ineq_test.v")
let ineq_test_ml = open_out_gen [Open_trunc;Open_wronly;Open_creat] 0o666
(flyspeck_dir^"ineq_test.ml")
let ineq_final_ml = open_out_gen [Open_trunc;Open_wronly;Open_creat] 0o666
(flyspeck_dir^"ineq_final.ml")
let sphere_hol = flyspeck_dir^"sphere.hl"
let cayleyR_def_hol = flyspeck_dir^"cayleyR_def.hl"
let muR_def_hol = flyspeck_dir^"muR_def.hl"
let enclosed_def_hol = flyspeck_dir^"enclosed_def.hl"
let ineq_hol =  flyspeck_dir^"ineq.hl"

let begin_ineq_ml = "open Sphere_final ;;\n"


let doubloon_list = ["dart_mll_w";"dart_mll_n";"dart_Hll_w";"dart_Hll_n"]

type vname=string

let rec xstring_of_variables (v_list:vname list):string = 
  match v_list with
    |[]->  ""
    |[(v:vname)] ->(v)
    |v::tl -> (v) ^";"^ (xstring_of_variables tl)

let string_of_variables var_list= "["^ (xstring_of_variables var_list)^"]"^"\n"                                                                                 

let rec end_itlist f l =
          match l with
                  []     -> failwith "end_itlist"
                  | [x]    -> x
                  | (h::t) -> f h (end_itlist f t);;

let strings_of_file filename =
          let fd = try Pervasives.open_in filename
                     with Sys_error _ ->
                                          failwith("strings_of_file: can't open
                                          "^filename) in
            let rec suck_lines acc =
                        try let l = Pervasives.input_line fd in
                  suck_lines (l::acc)
                                              with End_of_file ->List.rev acc in
            let data = suck_lines [] in
            (Pervasives.close_in fd; data);;

let string_of_file filename =
        end_itlist (fun s t -> s^"\n"^t) (strings_of_file filename);;

let rec int_to_list_aux n =
  if n<0 then [] else (n)::(int_to_list_aux (n-1))
let int_to_list n = List.rev (int_to_list_aux (n-1))

module S = Set.Make(String)
let filter_variables l=  
  S.elements (List.fold_left (fun a b -> S.add b a) S.empty l)
 
let max_d l=  
 let rec max_d_x l d_init= 
  match l with 
   hd::tl -> max_d_x tl (if hd<d_init then d_init else hd)
   |[] -> d_init
 in
 max_d_x l (List.nth l 0)
;; 

let index_max l =
 let m = max_d l in      
 let rec index_max l i=
  match l with 
   hd::tl-> (if (hd=m) then i else index_max tl (i+1))
   |[] -> i
 in
 index_max l 0 
;;


let rec sets_of_list l =
 match l with
  | [] -> [[]]
  | e::l -> let s = sets_of_list l in
	     s@(List.map (fun s0 -> e::s0) s)


             (*let removed_functions =
                     * ["FST";"SND";regular_spherical_polygon_area];             *)
(*
let string_to_vname_term s = "v"^s;;

let string_to_pow_term s =
  let pow_string= Str.regexp "\\^" in
  let tuple_list = Str.split pow_string s in
   if List.length tuple_list =2 then Pow( string_to_vname_term  (List.hd tuple_list),int_of_string (List.nth tuple_list 1))
   else  string_to_vname_term (List.hd tuple_list)   
;;

let string_to_pos_term s =
  if String.sub s 0 1="x" then string_to_pow_term s else Const (num_of_string s)
;;

let  string_to_term s =
  let beg_string = String.sub s 0 1 in
  let end_string= String.sub s 1 (String.length s - 1)in  
  match beg_string with 
    |"-"-> Opp(string_to_pos_term end_string)
    |_ -> string_to_pos_term s
;;


let rec string_to_mon_mul string_mon_list =
  match string_mon_list with
    []-> Zero 
    |[m] -> string_to_term m
    |m::tl -> Mul(string_to_term m, string_to_mon_mul tl)
;;


let rec string_to_poly_add s = 
  match s with
    [] -> Zero
    |[m] -> string_to_mon_mul m
    |m::tl -> Add(string_to_mon_mul m, string_to_poly_add tl)          
;;
 *)

let rec concat_string l =   
          match l with
            []->""
            |hd::tl -> hd ^ (concat_string tl)

let rec concat_string_with_space l =    
          match l with
            []->" "
            |hd::tl -> hd ^" "^ (concat_string_with_space tl)



let remove_comments s =
        let split_comment = Str.regexp "(\\*.*\\*)" in
        let s_aux = concat_string (Str.split split_comment s) in
        let c_beg = Str.regexp  "(\\*" in
        let c_end =  Str.regexp "\\*)" in
        let rec remove_comments_aux2 s = 
                try
                let com_begin = Str.search_forward c_beg s 0 in
                let com_end = Str.search_forward c_end s com_begin in
                try 
                let com_begin2 = Str.search_forward c_beg s (com_begin+2) in
                if com_begin2 < com_end then 
                       (
                        let new_s = (String.sub s 0 com_begin2) ^ (String.sub s
                        (com_end+2) (String.length s -com_end-2)) in
                        remove_comments_aux2 new_s)
                       else (let new_s = (String.sub s 0 com_begin) ^ (String.sub s
                        (com_end+2) (String.length s -com_end-2)) in
                        remove_comments_aux2 new_s
                       ) 
                with Not_found -> (let new_s = (String.sub s 0 com_begin) ^
                (String.sub s
                                 (com_end+2) (String.length s -com_end-2)) in
                                 remove_comments_aux2 new_s
                                                 )       
                with Not_found -> s
        in
        remove_comments_aux2 s_aux
;;

let rec pow_of_int i n =
        if n<1 then 1 else ( * )  (pow_of_int i (n-1)) i 
;;
let convert_decimal_number s =
  Printf.fprintf ineq_test "convert s: %s\n" s;
	let num_den = Str.split (Str.regexp "\\.\\|#") s in
        if List.length num_den = 2 then (
          let numerator = List.nth num_den 0 ^ List.nth num_den 1 in
	        let decimals = String.length (List.nth num_den 1) in
          let denum = string_of_int(pow_of_int 10 decimals) in
            "("^numerator ^ "/" ^ denum^")")
        else "(" ^ List.nth num_den 0 ^ ")"
;;
let convert_digit_number s =
	Str.global_replace (Str.regexp "&") "" (s^".")	


;;
let convert_pow_hol_to_ml s = 
	Str.global_replace (Str.regexp "pow") "**" (s^".")	

let add_match_after_let s1 s2 = 
        "let fresh_x := "^s2^" in\n"^"match fresh_x with "^s1^"=> "
;;


let rec convert_list_post_split f l =
        match l with 
        | []-> ""
        | (Str.Text s)::tl -> s ^ (convert_list_post_split f tl)
        | (Str.Delim s)::tl -> (f s) ^ (convert_list_post_split f tl)
;;


let lambda_fun_hol s = 
        let lambda = Str.regexp "\\\\\\([0-9a-zA-Z]*\\)\\." in 
        try     
                let _ = Str.search_forward lambda s 0 in
                let new_s = "fun "^Str.matched_group 1 s^" => " in
                Str.global_replace lambda new_s s
        with Not_found -> s     
           
;;
let lamda_fun_caml s = 
        let lambda = Str.regexp "\\\\\\([0-9a-zA-Z]*\\)\\." in 
        try     
                let _ = Str.search_forward lambda s 0 in
                let new_s = "fun "^Str.matched_group 1 s^" -> " in
                Str.global_replace lambda new_s s
        with Not_found -> s     


let if_then_else_hol s1 s2 op t u=
(*        let r = Str.regexp "\n\\|\t\\| " in
        let u_aux = Str.global_replace r "" u in
        let end_u = String.sub u_aux (String.length u_aux -1) 1 in
        let (u,end_u) = 
                (if (String.compare end_u "."=0) || (String.compare end_u "*"=0)
                        then    
                                let r_dot = Str.regexp ( "\\"^end_u) in 
                                let pos = Str.search_backward r_dot u
                                (String.length u -1) in
                                String.sub u 0 (pos -1),end_u 
                        else u,"") in
        let s = "match total_order_T " in
        Printf.printf "%s %s end_u: %s \n" t u end_u;
        let result = (if (op = "<") then (s^s1^" "^s2^" with\n inleft (left _) =>"^t^"\n | _ => "^u)
        else if (op = "<=") then (s^s1^" "^s2^" with\n inright _ =>"^u^"\n | _ => "^t^end_u)
        else if (op = "=") then (s^s1^" "^s2^" with\n inleft (right _) =>"^u^"\n | _ => "^t^end_u)
        else if (op = ">") then (s^s1^" "^s2^" with\n inright _ =>"^t^"\n | _ => "^u)
        else  (s^s1^" "^s2^" with\n inleft (left _) =>"^u^"\n | _ => "^t^end_u))
        in
        Printf.printf "result: %s \n" result;
        result*)
        let s = "match total_order_T " in
        let result = (if (op = "<") then (s^s1^" ) ("^s2^" with\n inleft (left _) =>"^t^"\n | _ => "^u)
        else if (op = "<=") then (s^s1^") ("^s2^" with\n inright _ =>"^u^"\n | _ => "^t)
        else if (op = "=") then (s^s1^") ("^s2^" with\n inleft (right _) =>"^u^"\n | _ => "^t)
        else if (op = ">") then (s^s1^") ("^s2^" with\n inright _ =>"^t^"\n | _ => "^u)
        else  (s^s1^") ("^s2^" with\n inleft (left _) =>"^u^"\n | _ => "^t))
        in
        result^" end "

        
;;

let search_forward_and_match r s =
        let decomp = Str.full_split r s in
        let if_then_else_decomp l = 
                match l with 
                |  [Str.Delim "if ";Str.Text cnd;Str.Delim "then"; Str.Text t; Str.Delim "else"; Str.Text u] -> (cnd,t,u)
                | _ -> ("","","")
        in
        let (cnd,t,u) = if_then_else_decomp decomp in        
        let cnd_regexp = Str.regexp "<=\\|>=\\|=\\|<\\|>" in
        let cnd_list = Str.full_split cnd_regexp cnd in

        let cnd_list_to_strings l = 
                match l with 
                | [Str.Text s1;Str.Delim op; Str.Text s2] ->  (s1,s2,op)
                | _ -> ("","","")
        in

        let (s1,s2,op) = cnd_list_to_strings cnd_list in
        if_then_else_hol s1 s2 op t u
;;

let rec add_two_elem l =
        match l with 
        | a::b::tl ->(a^b)::(add_two_elem tl)
        | _ -> []
;;

let if_hol_to_coq def =
        (*if (if_by_hand def) then make_if_by_hand else*)
        let if_only_hol = Str.regexp "if " in
        let if_only_list = Str.full_split if_only_hol def in
         
        let rec permute_if_delim l = 
                match l with 
                | Str.Text t::tl -> Str.Text t:: permute_if_delim tl
                | Str.Delim d::Str.Text t::tl -> Str.Delim(d ^ t)::permute_if_delim tl                
                | _ ->[]
        in
        let if_list =  permute_if_delim if_only_list in

        let if_hol = Str.regexp "if \\|then\\|else" in
                convert_list_post_split (search_forward_and_match if_hol) if_list
        
;;

let rec concat_string_to_list s l =
        match l with 
        |[] -> []
        |hd::tl -> (s^hd)::concat_string_to_list s tl
;;


let is_by_hand s def = 
        let r =  Str.regexp s in
        let first_test r def =
                try 
                Str.search_forward r def 0 
                with Not_found -> (- 1)
        in
        if (first_test r def !=0) then false else true


let matan_coq = "Definition matan x :=\
         match total_order_T (x ) ( 0)  with
         inleft (right _) => 1
         | inright _ =>  atn (sqrt x) / (sqrt x) 
         | _ => (ln ((1 + sqrt( - x))/(1 - sqrt( - x)))) / (2 * sqrt (- x))
         end. \n"
;;
let critical_edge_coq = "Definition critical_edge_y y := 
        match total_order_T y (2*hminus)  with 
        |inright _ => 
          match total_order_T (2*hplus) y with 
            |inright _ => true
              |_ => false
                end
        |_ => false
        end.\n"
;;
let beta_bump_y_coq = "Definition beta_bump_y y1 y2 y3 y4 y5 y6 :=
          (if critical_edge_y y1 then 1 else 0) *
            (if critical_edge_y y2 then 0 else 1) *
              (if critical_edge_y y3 then 0 else 1) *
                (if critical_edge_y y4 then 1 else 0) *
                  (if critical_edge_y y5 then 0 else 1) *
                    (if critical_edge_y y6 then 0 else 1) *
                        (bump (y1/ 2) - bump (y4 / 2)).\n"
;;

let wtcount3_y_coq = "Definition wtcount3_y y1 y2 y3  :=
          (if critical_edge_y y1 then 1 else 0) +
            (if critical_edge_y y2 then 1 else 0) +
              (if critical_edge_y y3 then 1 else 0).\n"
;;

let quadratic_root_plus_coq = "Definition quadratic_root_plus t:=
match t with (a,b,c) => ( - b + sqrt(b ^ 2 - 4 * a * c))/ (2 * a)end.\n"
;;


let modify_atn2_args def= 
        let r = Str.regexp "\\(atn2(\\([()0-9a-zA-Z_ \\+\\*-]*\\),\\([()0-9a-zA-Z_ \\+\\*-]*\\))\\)" in
        try 
                let _ = Str.search_forward r def 0 in
                let new_atn2 = "atn2"^ " (" ^Str.matched_group 2 def
                ^") " ^ " (" ^  Str.matched_group 3 def ^") " in
                Str.global_replace r new_atn2 def 
        with Not_found -> def
;;                 

let hminus_coq = "Definition hminus:= 12136/10000.\n"
;;
let hminus_ml = "let hminus = 1.2136;;\n"
let make_by_hand def = 
        if (is_by_hand "Definition matan" def) then  matan_coq
        else if (is_by_hand "Definition dih_y " def) then 
                Str.global_replace  (Str.regexp "\\.") " end." def
        else if (is_by_hand "Definition critical_edge" def) then
                critical_edge_coq
        else if (is_by_hand "Definition node[2-3]_y f\\|Definition rotate[2-6] f" def) then 
                Str.replace_first (Str.regexp "f ") "(f : R->R->R->R->R->R->R) " def
        else if (is_by_hand "Definition y_of_x fx" def) then
                Str.replace_first (Str.regexp "fx ") "(fx : R->R->R->R->R->R->R) "
                def                
        else if (is_by_hand "Definition asn797k" def) then                
               Str.global_replace (Str.regexp "x2 x3 x4 x5 x6") "(x2 x3 x4 x5 x6 : R)"
                def
        else if (is_by_hand "Definition asnFnhk" def) then                
               Str.global_replace (Str.regexp "x3 x4 x5 x6") "(x3 x4 x5 x6 : R)"
                def
        else if (is_by_hand "Definition edge_flat2_x" def) then
                Str.replace_first (Str.regexp "x1 x2 x3 x4 x5 x6") "(x1 x2 x3 x4 x5 x6 : R)" 
                def
        else if (is_by_hand "Definition beta_bump_force_y" def) then
                Str.replace_first (Str.regexp "y1 y2 y3 y4 y5 y6") "(y1 y2 y3 y4 y5 y6 : R)" 
                def
        else if (is_by_hand "Definition beta_bump_y" def) then beta_bump_y_coq
        else if (is_by_hand "Definition wtcount3_y" def) then wtcount3_y_coq
        else if (is_by_hand "Definition dih_x_div_sqrtdelta" def) then
                let def = Str.global_replace (Str.regexp "end") "" def in
                Str.global_replace (Str.regexp "(0)") "(0) end " def
        else if (is_by_hand "Definition atn2" def) then
                let def = Str.global_replace (Str.regexp "end") "" def in
                let def = Str.global_replace (Str.regexp "PI )))") "PI )end)end)end" def in
                Str.global_replace (Str.regexp "(x,y)") " x y " def
        else if (is_by_hand "Definition hminus" def) then hminus_coq
                
        else if (
           is_by_hand "Definition SDIFF" def 
        || is_by_hand "Definition ydodec" def 
        || is_by_hand "Definition fdodec" def 
        || is_by_hand "Definition vol_conv" def
        || is_by_hand "Definition eventually_radial" def
        || is_by_hand "Definition regular_spherical_polygon_area" def 
        || is_by_hand "Definition pathL" def 
        || is_by_hand  "Definition pathR" def
        || is_by_hand "Definition hminus" def       
                ) then ""
        else if (is_by_hand "Definition quadratic_root_plus" def ) then
                quadratic_root_plus_coq
        else modify_atn2_args def
;;
let make_by_hand_ml def = 
        if (is_by_hand "let hminus" def) then hminus_ml
(*        else if (is_by_hand "let atn2" def) then "let atn2 (x,y)= atan2 x y;;\n"*)
        else if (is_by_hand "let atn2" def) then 
          "let atn2 (x,y)= if ((y>-.x) && ( y<x)) then atn (y /. x) else if
           (0.<y) then pi /. 2. -. atn(x /. y) else if  (0.>y) then -.( pi /.
           2.) -. atn(x /. y) else pi ;;\n"
(*            "let atn2 (x,y)= atan2 x y ;;\n"*)
        else if (is_by_hand "let dih_y" def) then "let dih_y y1 y2 y3 y4 y5 y6 = dih_x (y1*. y1) (y2*. y2) (y3*. y3) (y4*. y4) (y5*. y5) (y6*. y6);;\n"
        else def


let pi_hol_local r definition = 
        try 
                let _ = Str.search_forward r definition 0 in
                Str.global_replace (Str.regexp "pi") "PI" definition
        with Not_found -> definition
;;

let pi_hol_2_coq r definition= 
        let list_pi = Str.full_split r definition in
        convert_list_post_split (pi_hol_local r) list_pi 
;; 

let begin_sphere_v = 
"Require Import Reals.
Open Scope R_scope.

Axiom atn : R -> R.
Axiom asn : R -> R.
Axiom acs : R -> R.
Axiom tanK : forall x, atn (tan x) = x.
Axiom atnK : forall x, - PI / 2 < x < PI/2 -> tan (atn x) = x.
Axiom atn_inv_plus : forall x, x > 0 -> atn(1 / x) + atn(x) = PI/2.
Axiom atn_inv_minus : forall x, x < 0 -> atn(1 / x) + atn(x) = -PI/2.
Axiom total_order_T : forall r1 r2:R, {r1 < r2} + {r1 = r2} + {r1 > r2}.
Lemma atn0: atn 0 = 0.
rewrite <- tan_0;rewrite tanK;rewrite tan_0.
auto.
Qed.\n"
;;

let begin_sphere_ml = 
        "let pi = (4. *. atan(1.));;\n
        let acs x = acos x;;\n
        let asn x = asin x;;\n
	let atn x = atan x;;\n"
;;

let grave = Str.regexp "`"
let egal = Str.regexp "=" 
let and_hol = Str.regexp "&" 
let minus_hol = Str.regexp "--"
let pow_hol = Str.regexp "pow"
let pow_hol_ml = Str.regexp "pow \\([0-9]+\\)" 
let pi_hol = Str.regexp "\\([/()\\.\\* ]\\)pi\\([`/)\\.\\* ]\\)" 
let real_hol = Str.regexp "real" 
let real_hol_ml=  Str.regexp ":real"
let abs_hol = Str.regexp "abs" 
let forall_hol = Str.regexp "![a-zA-Z0-9]\\." 
let imply_hol = Str.regexp "==>" 
(*let def_egal_hol = Str.regexp "Definition *[a-zA-Z0-9_
* ]*:=" in*)
let decimal_numbers = Str.regexp "#[0-9]*\\.?[0-9]*" 
let digit_numbers =  Str.regexp "&[0-9]+"
let let_hol = Str.regexp "let *\\(([0-9a-zA-Z, ]*)\\) *:= *\\((?[0-9a-zA-Z, \\*]*)?\\) *in" 
let max_hol = Str.regexp "max"

let regular_hol_to_coq s =
  try
    let definition = Str.global_replace imply_hol "->" s in 
    let definition = Str.global_replace egal ":="
                       definition in
    let definition = Str.global_replace (Str.regexp ":=>") "=>"
                       definition in
    let definition = Str.global_replace and_hol "" definition in
    let definition = Str.global_replace minus_hol "-" definition in
    let definition = Str.global_replace pow_hol "^" definition in
    let definition = pi_hol_2_coq pi_hol definition in
    let definition = Str.global_replace (Str.regexp ">:=") ">=" definition in
    let definition = Str.global_replace (Str.regexp "<:=") "<=" definition in
    let definition = Str.global_replace real_hol "R" definition in
    let definition = Str.global_replace abs_hol "Rabs" definition in
    let definition = Str.global_replace forall_hol "" definition in
    let definition = Str.global_replace max_hol "Rmax" definition in
    let list_decimal = Str.full_split decimal_numbers definition in 
    let definition = convert_list_post_split convert_decimal_number list_decimal in
      definition
  with Not_found -> ""               

let regular_hol_to_ml definition =
  try
    let definition = Str.global_replace imply_hol "->" definition in 
    let definition = Str.global_replace minus_hol "-" definition in
    let definition = Str.global_replace (Str.regexp "/") " /. " definition in
    let definition = Str.global_replace (Str.regexp "-") " -. " definition in
    let definition = Str.global_replace (Str.regexp "*") "*. " definition in
    let definition = Str.global_replace (Str.regexp "+") "+. " definition in

    let definition = Str.global_replace real_hol_ml "" definition in
    let definition = Str.global_replace abs_hol "abs_float" definition in
    let definition = Str.global_replace (Str.regexp "#") "" definition in
    let definition = Str.global_replace forall_hol "" definition in
    let definition = Str.global_replace max_hol "max_float" definition in
    (*			let definition = Str.global_replace and_hol " " definition in
     let definition = Str.global_replace pow_hol "**" definition in*)
    let list_pow = Str.full_split pow_hol_ml definition in 
    let definition = convert_list_post_split convert_pow_hol_to_ml list_pow in
    let list_digits = Str.full_split digit_numbers definition in 
    let definition = convert_list_post_split convert_digit_number list_digits in
    let definition = Str.global_replace and_hol " " definition in
    let definition = Str.global_replace (Str.regexp "/\\. \\" ) "&&" definition in
    let definition = Str.global_replace (Str.regexp "2\\*. s > 3") "2.*. s > 3." definition in
    let definition = Str.global_replace (Str.regexp "then 1 else 0") "then 1. else 0." definition in
    let definition = Str.global_replace (Str.regexp (" \\([0-9]+\\) ")) "  \\1  " definition in
    let definition = Str.global_replace (Str.regexp (" \\([0-9]+\\) ")) " \\1. " definition in
    let definition = Str.global_replace (Str.regexp (" \\([0-9]+\\))")) " \\1.) " definition in
      definition
  with Not_found -> ""               


let add_string_right s l= 
	 List.map (fun a -> a^s ) l

let replace_first_doubloon s l = 
  fold_right (fun doubloon str-> Str.replace_first (Str.regexp ("Definition "^doubloon^".*")) "" str ) l s

(* ineq.hl functions to generate inequalities *)
let template_F4 y3m y3M y4m y4M y5m y5M y6m y6M w m = 
   (
    " [(&2 * hminus, y1, &2 * hplus);
    (&2 ,y2, &2 *hminus);
    ("^y3m^",y3,"^y3M^");
    ("^y4m^",y4,"^y4M^");
    ("^y5m^",y5,"^y5M^");
    ("^y6m^",y6,"^y6M^")]
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / "^w^" + "^m^" *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \\/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2))")

let mk_ineq0 i3 i4 i5 i6  =
  let x i = List.nth ["&2"; "&2 * hminus";"sqrt8"] i in
  let big_x i = x (i+1) in
  let mid i = if (i=1) then 1 else 0 in
  let w = 1 + mid i3 + mid i4 + mid i5 + mid i6 in
  let m = if (w =2) && (i4 = 1) then 1 else 0 in
    template_F4 (x i3) (big_x i3) (x i4) (big_x i4) (x i5) (big_x i5) (x i6) (big_x i6)  (string_of_int w) (string_of_int m)

let lemma_names_F4 i3 i4 i5 i6 =  Printf.sprintf "ZTGIJCF4_%d_%d_%d_%d_1821661595" i3 i4 i5 i6

let template23d  y3m y3M y5m y5M y6m y6M w1 w2 = 
  " [(&2 *  hminus, y1, &2 * hplus);
  (&2 ,y2, &2 *hminus);
  ("^y3m^",y3,"^y3M^");
  (&2 ,y4, sqrt8 );
  ("^y5m^",y5,"^y5M^");
  ("^y6m^",y6,"^y6M^")]
((gamma23f_red_03 y1 y2 y3 y4 y5 y6 sqrt2 lmfun    >
    a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \\/
  (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < &2) \\/
   (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 > #0.14 ) \\/
    (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < &0 ) \\/
     (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 > #0.14)  \\/
      (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < &0)   )"


let template23b  y3m y3M y5m y5M y6m y6M w1 w2 = 
   " [(&2 *  hminus, y1, &2 * hplus);
    (&2 ,y2, &2 *hminus);
    ("^y3m^",y3,"^y3M^");
    (&2 ,y4, sqrt8 );
    ("^y5m^",y5,"^y5M^");
    ("^y6m^",y6,"^y6M^")]
    ( (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < #0.14 ) \\/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < #0.14) \\/
   (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < &2) \\/
  (gamma23f_n y1 y2 y3 y4 y5 y6 "^w1^" "^w2^" sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
   )"

let template23b' y3m y3M y5m y5M y6m y6M w1 w2= 
  " [(&2 *  hminus, y1, &2 * hplus);
    (&2 ,y2, &2 *hminus);
    ("^y3m^",y3,"^y3M^");
    (&2 ,y4, &2 );
    ("^y5m^",y5,"^y5M^");
    ("^y6m^",y6,"^y6M^")]
    ( (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < #0.14 ) \\/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < #0.14) \\/
   (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < &2) \\/
  (gamma23f_n y1 y2 y3 y4 y5 y6 "^w1^" "^w2^" sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
   )"


let template23c y3m y3M y5m y5M y6m y6M w1 w2 = 
 " [(&2 *  hminus, y1, &2 * hplus);
    (&2 ,y2, &2 *hminus);
    ("^y3m^",y3,"^y3M^");
    (&2 ,y4, &2 );
    ("^y5m^",y5,"^y5M^");
    ("^y6m^",y6,"^y6M^")]
    (
(delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < #0.14 ) \\/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 > #0.14)  \\/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < &0) \\/
(gamma23f_126_03_n y1 y2 y3 y4 y5 y6 "^w1^" sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
      )"

let mk_ineq23 i3 i5 i6 j =
  let template = List.nth [template23b;template23b';template23c;template23d] j in
  let x i = List.nth ["&2"; "&2 * hminus" ; "sqrt8"] i in
  let big_x i = x (i+1) in
  let mid i = if (i>0) then 1 else 0 in
  let w1 = 1 +  mid i6 in
  let w2 = 1 + mid i3 + mid i5 in
    template (x i3) (big_x i3) (x i5) (big_x i5) (x i6) (big_x i6) (string_of_int w1) (string_of_int w2);;

let lemma_names_F23 i3 i5 i6 j = 
  let ext = List.nth ["b";"b2";"c";"d"] j in
    Printf.sprintf "ZTGIJCF23_%d_%d_%d_7907792228_%s" i3 i5 i6 ext


let mk_QITNPEA i3 i4 i5 i6  =
  let template y3m y3M y4m y4M y5m y5M y6m y6M w m = 
  " [(&2 * hminus, y1, &2 * hplus);
    (&2 ,y2, &2 *hminus);
    ("^y3m^",y3,"^y3M^");
    ("^y4m^",y4,"^y4M^");
    ("^y5m^",y5,"^y5M^");
    ("^y6m^",y6,"^y6M^")]
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / "^w^" + "^m^" * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - #0.0105256 +  #0.00522841*dih_y y1 y2 y3 y4 y5 y6 > #0.0) \\/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > &2))" in
  let x i = List.nth ["&2"; "&2 * hminus"; "sqrt8"] i in
  let big_x i = x (i+1) in
  let mid i = if (i=1) then 1 else 0 in
  let w = 1 + mid i3 + mid i4 + mid i5 + mid i6 in
  let m = if (w =2) && (i4 = 1) then 1 else 0 in
  template (x i3)(big_x i3)( x i4)(big_x i4)( x i5)(big_x i5)( x i6 )(big_x i6)( string_of_int w)(string_of_int m)

let lemma_names_QITNPEA i3 i4 i5 i6 =  Printf.sprintf "QITNPEA4_%d_%d_%d_%d_3803737830" i3 i4 i5 i6

let mk_tm0 i3 i4  =
  let template y3m y3M y4m y4M w m = 
  " [(&2 * hminus, y1, &2 * hplus);
    (&2 ,y2, &2 *hminus);
    ("^y3m^",y3,"^y3M^");
    ("^y4m^",y4,"^y4M^");
    (&2 ,y5,&2 *hminus);
    (&2 ,y6,&2 * hminus)]
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / "^w^" + "^m^" *beta_bump_lb
         > #0.0057) \\/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > &2))" in
  let x i = List.nth ["&2"; "&2 * hminus"; "&2 * hplus"; "sqrt8"] i in
  let big_x i = x (i+1) in
  let mid i = if (i=1) then 1 else 0 in
  let w = 1 + mid i3 + mid i4 in
  let m = if (w =2) && (i4 = 1) then 1 else 0 in
  template (x i3)(big_x i3)( x i4)(big_x i4)( string_of_int w)(string_of_int m)

let lemma_names_0 i3 i4 = Printf.sprintf "QITNPEA1_%d_%d_9063653052" i3 i4 

let dart_template  y4min y4max=
"  [
      (#2.0, y1, #2.52);
      (#2.0, y2, #2.52);
      (#2.0, y3, #2.52);
      ("^y4min^", y4, "^y4max^");
      (#2.0, y5, #2.52);
      (#2.52, y6, sqrt8)]"

let dart_template_reverse  y4min y4max = 
"  [
      (#2.0, y1, #2.52);
      (#2.0, y2, #2.52);
      (#2.0, y3, #2.52);
      ("^y4min^", y4, "^y4max^");
      (#2.52, y5, sqrt8);
      (#2.0, y6, #2.52)]"

(*let tyR = R->R->R->R->R->R-> (R#R#R)list;;*)

let mk_dart rev t = match t with
	| (y,z) ->( 
(*  let x' = if (is_var x) then mk_var(fst(dest_var x),tyR) else x in*)
  	let plate = if (rev) then dart_template_reverse else dart_template in
   	plate y z)

let newdef rev t = mk_dart rev t

let apexffA = newdef false ("#2.52","sqrt8");;  (* NB ff comes before f on this *)
let apexfA = newdef true ("#2.52","sqrt8");;
let apexf4 = newdef false ("sqrt8","sqrt8");;
let apexff4 = newdef true ("sqrt8","sqrt8");;
let apexf5 = newdef false ("#2.52","#2.52");;
let apexff5 = newdef true ("#2.52","#2.52");;

let template_181212899  y4e y2' y3' y5' y6' bound_template = 
(bound_template)^
" (dih_y y1 y2 y3 y4 y5 y6 - #1.448 - 
(#0.266 * (y1 - #2.0)) + 
(#0.295 * ("^y2'^" - #2.0)) + 
(#0.57 * ("^y3'^" - #2.0)) - 
(#0.745 * ("^y4e^" - #2.52)) + 
(#0.268 * ("^y5'^" - #2.0)) + 
(#0.385 * ("^y6'^" - #2.52)) > #0.0)"



let regexp_add ineq= 
	let r = Str.regexp "\\(add *\n* *{ *\n* *idv *= *\"\\([0-9a-zA-Z', -]*\\)\" *; *\n\\)" in
	try
		let _ = Str.search_forward r ineq 0 in
		let _ = Str.matched_group 0 ineq in 
		let s1 = Str.matched_group 2 ineq in
(*		let s2 = String.sub ineq (String.length s0) (String.length ineq
		- String.length s0) in*)
    let s2 = concat_string (Str.split r ineq) in
		let lemma_name = Str.global_replace (Str.regexp " \\|-\\|'\\|,") "_" s1 in
		(lemma_name,s2)
                        
(*                "lemma name: "^lemma_name^"\n s2: "^s2^"\n" *)
  with Not_found -> 
    let r = Str.regexp( "\\(add *\n* *{ *\n* *ineq *=\\)" ^"\\|"^ "\\(let *i[0-9]+\\)" )in
    try let _ = Str.search_forward r ineq 0 in   
        let ineq_idv_doc_tags =  Str.split (Str.regexp ";") ineq in
        try
          let idv = nth ineq_idv_doc_tags 1 in
          let lemma_name = Str.global_replace (Str.regexp " \\|idv\\|\"\\|=\\|\n" ) "" idv in
          let ineq = nth ineq_idv_doc_tags 0 in
          (lemma_name,ineq)
        with Failure _ -> ("","")
    with Not_found -> ("","") 

(* Definition of regexps*)
(* 
let bound = "\\([0-9a-zA-Z\\.&#()\\+\\*\/\\ -]*\\)"
;;
** 

let ineq_expr = "\\([0-9a-zA-Z_\\.&#()\\+\\*\/\\=><\n -]*\\)"
;;


let usual_bound = "\\(("^bound^","^bound^","^bound^");? *\n* *\\)"
;;


let usuabox = "\\(\\[ *\n* *" ^
                        "\\(" ^ usual_bound ^ 
                        "*\\)" ^ " *\n* *\\]\\)"
;;

let alt_bounds = "\\(([0-9a-zA-Z_ ]\\)"
;;

let bounds = "\\("^usuabox ^ "\\|" ^ alt_bounds^"\\)"
;;

let r_ineq = Str.regexp (
                "\\(`ineq *\n* *" ^
                bounds ^ " *\n* *" ^ineq_expr ^ "` ? *;\\)"
                )
;;
*)
let r_ineq = Str.regexp ("\\(`ineq\n* *\\[\\)")

let mk_split r s = 
	let r = Str.regexp r in
	Str.split r s

let bound_template_list = ["dart_std4";"dart4_diag3_b";"dart_std3";"dartX";"dartY";"dart4_diag3";"apex_flat";"apex_A";"dart_std3_small";"dart_std3_big";"dart_std3_mini";"apex_sup_flat";"apex_flat_hll";"dart_std3_big_200_218";"apex_std3_hll";"apex_std3_lhh";"apex_std3_small_hll";"dart_mll_w";"dart_mll_n";"dart_Hll_n";"dart_Hll_w";"dart_std3_lw";"apex_flat_l";"apex_flat_h";"apex_std3_lll_xww";"apex_std3_lll_wxx"]

(*
let is_bound_template def =
  try 
    let let_begin = Str.search_forward (Str.regexp "let ") def 0 in
    let def_name = 
    let egal_begin = Str.search_forward egal def 0 in
    let def_name = String.sub def (let_begin+3) (egal_begin-let_begin-3) in
    let def_name = Str.global_replace (Str.regexp " ") "" def_name in
    if (List.mem def_name bound_template_list) then true else false 
  with Failure _ -> false
*)
let generate_intervals_aux_ml s =
	try
	  let bra_left = Str.search_forward (Str.regexp "(") s 0 in
  	let bra_right = Str.search_backward (Str.regexp ")" ) s (String.length s -1) in
  	let s = String.sub s (bra_left +1) (bra_right-bra_left-1) in
  	let s_list = Str.split (Str.regexp ",") s in
  	if List.length s_list = 3 then
    (" ( "^nth s_list 0 ^ " , " ^ List.nth s_list 2 ^" ) ", List.nth s_list 1 ^ " ")
  	else if List.length s_list = 2 then
  	(" ( " ^ List.nth s_list 0 ^ " , " ^ " nan " ^" ) ",List.nth s_list 1 ^ " ")
  	else "",""
	with Not_found -> "",""

let rec generate_intervals_ml s_list = map generate_intervals_aux_ml s_list

let normalize_ineq_ml ineq =
  let (delim_left,delim_right) = (
  try
(*  Printf.fprintf ineq_test_ml "before normalize: %s\n" ineq;*)
    let is_bra_left = Str.search_forward (Str.regexp "[ \n\t]*(") ineq 0 in
    let _ = Str.search_backward (Str.regexp ")[ \n\t]*") ineq (String.length ineq -1) in
      if (is_bra_left=0 && Str.match_end()=String.length ineq ) then  (
        let bra_left = Str.search_forward (Str.regexp "(") ineq 0 in
        let bra_right = Str.search_backward (Str.regexp ")") ineq ((String.length ineq)-1) in
          (bra_left,bra_right))
  else (*no additional brackets for this inequality *)
    -1, String.length ineq
  with Not_found -> (-1,String.length ineq) ) in
  let ineq = String.sub ineq (delim_left +1) (delim_right-delim_left-1) in
  Printf.fprintf ineq_test_ml "after bracket elimination: %s\n" ineq;
  let left_op_right = Str.full_split (Str.regexp "<=\\|>=\\|>\\|<") ineq in
  match left_op_right with
  | [Str.Text left;Str.Delim op;Str.Text right] ->( 
    match op with
    | "<=" -> (" ( " ^ right ^ " , " ^ left  ^ " ) ")
    | "<"  -> (" ( " ^ right ^ " , " ^ left  ^ " ) ")
    | ">=" -> (" ( " ^ left  ^ " , " ^ right ^ " ) ")
    | ">"  -> (" ( " ^ left  ^ " , " ^ right ^ " ) ")
    | _ -> failwith "Bad operator type"
    )
  | _ -> failwith "Bad inequality type"
  


let generate_alt_bounds_ml s = 
	try
    let bra_left = Str.search_forward (Str.regexp "(") s 0 in
    let bra_right = Str.search_forward (Str.regexp ")" ) s 0 in
    let b = String.sub s (bra_left +1) (bra_right-bra_left-1) in             (* b example: dart_std3 y1 y2 y3 y4 y5 y6      *)
    let bounds_template_var_list = Str.split (Str.regexp " +") b in          (* bounds_template_var_list example : [dart_std3; y1; y2; y3; y4; y5; y6]     *)
    let ineq = String.sub s (bra_right+1) (String.length s -bra_right -1) in (* ineq example: (  (f(x)>0) \/ (g(x)<=2) \/ ... )    *)

    let bra_left = Str.search_forward (Str.regexp "(") ineq 0 in
    let bra_right = Str.search_backward (Str.regexp ")") ineq ((String.length ineq)-1) in
    let ineq = String.sub ineq (bra_left +1) (bra_right-bra_left-1) in
    let ineq_disjunction = Str.split (Str.regexp_string "\\/") ineq in
    let ineq_list = map normalize_ineq_ml ineq_disjunction in
    match bounds_template_var_list with 
      | ( _ ::var_list) -> (concat_string_with_space var_list^" = " ^ b, concat_string_with_space var_list^" = " ^(string_of_variables ineq_list))
      | _ -> "",""
	with Not_found -> "",""

let generate_bounds_ml s = 
	let s_list = Str.split (Str.regexp ";") s in
  let bounds_var_list = (generate_intervals_ml s_list) in
	let bounds_list,var_list = split bounds_var_list in
	(concat_string var_list), (string_of_variables bounds_list)

    

let generate_ineq_ml s =
  Printf.fprintf ineq_test_ml "starting generate_ineq: %s\n" s; 
  let bra_left = Str.search_forward (Str.regexp "(") s 0 in
  let bra_right = Str.search_backward (Str.regexp ")") s ((String.length s)-1) in
  let s = String.sub s (bra_left +1) (bra_right-bra_left-1) in
  Printf.fprintf ineq_test_ml "after sub string: %s\n" s;
  let s_list = Str.split (Str.regexp_string "\\/") s in
  let ineq_list = map normalize_ineq_ml s_list in
  string_of_variables ineq_list

(* from the interval list under the form "[(m,x,M);...]" generates the ml bounds: "[yi,(mi,Mi)]"... and the list of normalized inequalities i: "[(i1,op1);...;(in,opn)]" where ; holds for disjunction, opi is either ge or gt *)

let generate_bounds_ineq_ml s = 
	try	
		let _ = Str.search_forward (Str.regexp "\\[\\|\\]") s 0 in
		try	
			let s_list = Str.split (Str.regexp "\\[\\|\\]") s  in
			if List.length s_list = 3 then 
			(	let s1 = List.nth s_list 1 in
				let (v,b) = generate_bounds_ml s1 in 
        Printf.fprintf ineq_test_ml "after generate_bounds: %s %s\n" v b;
				let s2 = List.nth s_list 2 in
        let ineq = generate_ineq_ml s2 in
        Printf.fprintf ineq_test_ml "after generate_ineq: %s %s %s\n" v b ineq;

			(v^" = "^b,v^" = "^ineq))
        
			else  ("","")	
		with Failure _ -> "",""	 		
	with Not_found -> 
			let (s1,s2) = generate_alt_bounds_ml s in
		(s1,s2)

let regexp_ineq_ml ineq_name_expr =
    try
      let (name,ineq) = regexp_add ineq_name_expr in
      (*Printf.printf  "finishing regexp_add with %s %s \n" name ineq;*)
	    Printf.fprintf ineq_test_ml "%s\n" name;
      try
		(*Printf.fprintf "%s\n" ineq;*)
		    let s_list = Str.split grave ineq  in
		(*Printf.printf "length of b: %s" (string_of_int (List.length s_list));*)
		(*let b = concat_string s_list  in*)
	  	  let s0 = List.nth s_list 1 in
		    let (bounds,ineq) = generate_bounds_ineq_ml s0 in
        let s_bounds = "let box_" ^ name ^ " " ^ bounds ^" ;;\n"  in       
        let s_ineq   = "let obj_" ^ name  ^ " " ^ ineq^" ;;\n" in
(*        Printf.printf "%s\n" s;*)
        s_bounds^s_ineq
      with Failure _-> ""        
    with Failure _ -> ""



let is_bound_template def =
  try 
    let words = Str.split (Str.regexp " +") def in
    let possible_template =  nth words 1 in
    if (List.mem possible_template bound_template_list) then true else false
  with Failure _ -> false
(*      
Input: "(#2.0,y1,&2 * h0)"
Output: "#2.0 <= y1 -> y1 <= &2 * h0 ->" and the string of variable "y1"      
*)

let generate_intervals_aux s =
	try
	  let bra_left = Str.search_forward (Str.regexp "(") s 0 in
  	let bra_right = Str.search_backward (Str.regexp ")" ) s (String.length s -1) in
  	let s = String.sub s (bra_left +1) (bra_right-bra_left-1) in
  	let s_list = Str.split (Str.regexp ",") s in
  	if List.length s_list = 3 then
  	(	List.nth s_list 0 ^ " <= " ^ List.nth s_list 1 ^ " -> " ^
  		List.nth s_list 1 ^ " <= " ^ List.nth s_list 2  ,List.nth s_list 1 ^ " ")
  	else if List.length s_list = 2 then
  	(       List.nth s_list 0 ^ " <= " ^ List.nth s_list 1 ,List.nth s_list 1 ^ " ")
  	else "",""
	with Not_found -> "",""


let rec generate_intervals s_list bounds_var_list =
  match s_list with 
     [] -> []
    | [s] ->  (generate_intervals_aux s)::bounds_var_list
    | s::tl ->  let (b,var) = generate_intervals_aux s in
                (b^" -> ",var)::(generate_intervals tl bounds_var_list)
   


let generate_alt_bounds s = 
	try
    let bra_left = Str.search_forward (Str.regexp "(") s 0 in
    let bra_right = Str.search_forward (Str.regexp ")" ) s 0 in
    let b = String.sub s (bra_left +1) (bra_right-bra_left-1) in
    let bounds_template_var_list = Str.split (Str.regexp " +") b in
    let ineq = String.sub s (bra_right+1) (String.length s -bra_right -1) in

    match bounds_template_var_list with 
(*      | ( _ ::var_list) -> ("forall "^concat_string_with_space var_list^", " ^ b ^ " -> " ^ ineq)*)
      | ( _ ::var_list) -> ("forall "^concat_string_with_space var_list^", " ^ b, ineq)
      | _ -> "",""
	with Not_found -> "",""

let generate_bounds s = 
	let s_list = Str.split (Str.regexp ";") s in
(*	let bounds_var_list = List.map generate_intervals s_list in*)
  let bounds_var_list = (generate_intervals s_list []) in
	let bounds_list = List.map fst bounds_var_list in
	let var_list = List.map snd bounds_var_list in
  (*let (bounds_list,var_list) = generate_intervals s_list [] in*)
	("forall "^concat_string var_list^", "), (concat_string bounds_list)

(* from the interval list under the form "[(m,x,M);...]" generates the coq inequalities: "forall x ..., m<=x -> x<=M ->... "*)

let generate_bounds_ineq s = 
	try	
		let _ = Str.search_forward (Str.regexp "\\[\\|\\]") s 0 in
		try	
			let s_list = Str.split (Str.regexp "\\[\\|\\]") s  in
			if List.length s_list = 3 then 
			(	let s1 = List.nth s_list 1 in
				let (b,v) = generate_bounds s1 in 
				let s2 = List.nth s_list 2 in
			(b^v,s2))
		(*else if List.length s_list = 1 then 
		(	let s = List.nth s_list 0 in
			let s1 = generate_bounds s in
		("",s1))*)
			else  ("","")	
		with Failure _ -> "",""	 		
	with Not_found -> 
			let (s1,s2) = generate_alt_bounds s in
		(s1,s2)

let regexp_ineq ineq_name_expr =
    try
      (*Printf.printf  "starting regexp_ineq \n"; *)
      let (name,ineq) = regexp_add ineq_name_expr in
      (*Printf.printf  "finishing regexp_add with %s %s \n" name ineq;*)
	    (*Printf.fprintf ineq_test "%s\n" name;*)
      try
		(*Printf.printf "%s\n" ineq;*)
		    let s_list = Str.split grave ineq  in
		(*Printf.printf "length of b: %s" (string_of_int (List.length s_list));*)
		(*let b = concat_string s_list  in*)
	  	  let s0 = List.nth s_list 1 in
		    let (bounds,ineq) = generate_bounds_ineq s0 in
        let s = "Lemma l_"^name^" : "^bounds^ " -> "^ineq^".\n" in
        (*Printf.printf "%s\n" s;*)
        s
      with Failure _-> ""        
    with Failure _ -> ""

let mk_bound_template def = 
  let grave_begin = Str.search_forward grave def 0 in
  let egal_begin =  Str.search_forward egal def grave_begin in
  let name = (String.sub def (grave_begin+1) (egal_begin-1-grave_begin)) in
  let bounds = (String.sub def (egal_begin+1) ( (String.length def) -1 -egal_begin )) in
  let b = if name = "dart_std3_big " then "dart_std3" else snd (generate_bounds bounds) in
  let s = "Definition "^name^" = "^b^".\n" in
  Printf.fprintf  ineq_test "template: %s\n" s;
  s

let mk_bound_template_ml def = 
  let grave_begin = Str.search_forward grave def 0 in
  let egal_begin =  Str.search_forward egal def grave_begin in
  let name = (String.sub def (grave_begin+1) (egal_begin-1-grave_begin)) in
  let bounds = (String.sub def (egal_begin+1) ( (String.length def) -1 -egal_begin )) in
  let (v,b) = if name = "dart_std3_big " then "","dart_std3" else (generate_bounds_ml bounds) in
  let s_bounds = "let "^name^" = "^b^" ;;\n"  in
  Printf.fprintf  ineq_test "template: %s\n" s_bounds;
  s_bounds


let type_of_item ineq_name_expr = 
  if (is_bound_template ineq_name_expr)   
  then (
    (*Printf.printf "template found \n";*)
    mk_bound_template ineq_name_expr, mk_bound_template_ml ineq_name_expr )
  else( 
    (*Printf.printf "add found \n";*)
    (*Printf.printf "%s\n" ineq_name_expr;*)
    let coq_s,ml_s = regexp_ineq ineq_name_expr,regexp_ineq_ml ineq_name_expr in
    (*Printf.printf "end of type_of_item\n";*)
    coq_s,ml_s
    )

let mk_comb_list_2 f l =
  match l with
  |[ a;b] -> f a b
  | _ -> failwith "length of list is not 2"

let mk_comb_list_4 f l = 
  match l with 
  |[ a;b;c;d] -> f a b c d 
  | _ -> failwith "length of list is not 4"

let rec cases_0_1 n = 
  if (n<=0) then [[]] 
  else 
    let c = cases_0_1 (n-1) in
    (map (fun l -> 0::l) c) @ (map (fun l -> 1::l) c)

let rec cases_0_2 n =
  if (n<=0) then [[]]
  else
    let c = cases_0_2 (n-1) in
    concat( map (fun k->  (map (fun l -> k::l) c))  [0;1;2] )

let rec cases_0_3 n =
  if (n<=0) then [[]]
  else
    let c = cases_0_3 (n-1) in
    concat( map (fun k->  (map (fun l -> k::l) c))  [0;1;2;3] )


let make_F4_aux i3 i4 i5 i6 = 
  let name = lemma_names_F4 i3 i4 i5 i6 in 
  Printf.fprintf ineq_test "%s\n" name;
  let (bounds,ineq) = generate_bounds_ineq (mk_ineq0 i3 i4 i5 i6) in
    "Lemma l_"^name^" : "^bounds^ " -> "^ineq^".\n"

let make_F4_aux_ml i3 i4 i5 i6 =
  let name = lemma_names_F4 i3 i4 i5 i6 in
  Printf.fprintf ineq_test_ml "%s\n" name;
  let (bounds,ineq) = generate_bounds_ineq_ml (mk_ineq0 i3 i4 i5 i6) in
  let s_bounds = "let box_"^name^ " " ^bounds^" ;;\n"  in       
  let s_ineq   = "let obj_"^name^" "  ^ineq^" ;;\n" in
  s_bounds^s_ineq

let make_F23_aux i3 i5 i6 j = 
  let name = lemma_names_F23 i3 i5 i6 j in
  Printf.fprintf ineq_test "%s\n" name;
  let (bounds,ineq) = generate_bounds_ineq (mk_ineq23 i3 i5 i6 j) in
    "Lemma l_"^name^" : "^bounds^ " -> "^ineq^".\n"

let make_F23_aux_aux j k = 
  let i356list = [(0,0,0);(0,0,1);(1,0,1);(0,1,1)] in 
  let (i3,i5,i6) = List.nth i356list k in
    make_F23_aux i3 i5 i6 j

let make_F23_aux_ml i3 i5 i6 j = 
  let name = lemma_names_F23 i3 i5 i6 j in
  Printf.fprintf ineq_test_ml "%s\n" name;
  let (bounds,ineq) = generate_bounds_ineq_ml (mk_ineq23 i3 i5 i6 j) in
  let s_bounds = "let box_"^name^" "^bounds^" ;;\n"  in
  let s_ineq   = "let obj_"^name^" "  ^ineq^" ;;\n" in
  s_bounds^s_ineq

let make_F23_aux_aux_ml j k = 
  let i356list = [(0,0,0);(0,0,1);(1,0,1);(0,1,1)] in 
  let (i3,i5,i6) = List.nth i356list k in
    make_F23_aux_ml i3 i5 i6 j

let make_QITNPEA_aux i3 i4 i5 i6 = if (not (i3+i4+i5+i6 = 0)) then ( 
    let name = lemma_names_QITNPEA i3 i4 i5 i6 in
    Printf.fprintf ineq_test "%s\n" name;
    let (bounds,ineq) = generate_bounds_ineq (mk_QITNPEA i3 i4 i5 i6) in
    "Lemma l_"^name^" : "^bounds^ " -> "^ineq^".\n") else ""

let make_QITNPEA_aux_ml i3 i4 i5 i6 = if (not (i3+i4+i5+i6 = 0)) then ( 
    let name = lemma_names_QITNPEA i3 i4 i5 i6 in
    Printf.fprintf ineq_test_ml "%s\n" name;
    let (bounds,ineq) = generate_bounds_ineq_ml (mk_QITNPEA i3 i4 i5 i6) in
    let s_bounds = "let box_"^name^" "^bounds^" ;;\n"  in
    let s_ineq   = "let obj_"^name^" "  ^ineq^" ;;\n" in
    s_bounds^s_ineq) else ""

let make_0_aux i3 i4 = if ((not (i3+i4 = 0))&&i3>0) then 
    let name = lemma_names_0 i3 i4 in
    Printf.fprintf ineq_test "%s\n" name;
    let (bounds,ineq) = generate_bounds_ineq (mk_tm0 i3 i4) in
    "Lemma l_"^name^" : "^bounds^ " -> "^ineq^".\n" else ""

let make_0_aux_ml i3 i4 = if ((not (i3+i4 = 0))&&i3>0) then (
    let name = lemma_names_0 i3 i4 in
    Printf.fprintf ineq_test "%s\n" name;
    let (bounds,ineq) = generate_bounds_ineq_ml (mk_tm0 i3 i4) in
    let s_bounds = "let box_"^name^" "^bounds^" ;;\n"  in
    let s_ineq   = "let obj_"^name^" "  ^ineq^" ;;\n" in
    s_bounds^s_ineq )else ""

let make_F4 = 
  let comb_0_1 = cases_0_1 4 in
  let s_list = map (fun l -> mk_comb_list_4 make_F4_aux l) comb_0_1 in
  s_list
 
let make_F4_ml =
  let comb_0_1 = cases_0_1 4 in
  let s_list = map (fun l -> mk_comb_list_4 make_F4_aux_ml l) comb_0_1 in
  s_list

let make_F23 = 
  let comb_0_3 = cases_0_3 2 in
  let s_list = map (fun l -> mk_comb_list_2 make_F23_aux_aux l) comb_0_3 in
  s_list

let make_F23_ml = 
  let comb_0_3 = cases_0_3 2 in
  let s_list = map (fun l -> mk_comb_list_2 make_F23_aux_aux_ml l) comb_0_3 in
  s_list

let make_QITNPEA = 
  let comb_0_1 = cases_0_1 4 in
  let s_list = map (fun l -> mk_comb_list_4 make_QITNPEA_aux l) comb_0_1 in 
  s_list

let make_QITNPEA_ml = 
  let comb_0_1 = cases_0_1 4 in
  let s_list = map (fun l -> mk_comb_list_4 make_QITNPEA_aux_ml l) comb_0_1 in 
  s_list

let make_0 =
  let comb_0_2 = cases_0_2 2 in
  let s_list = map (fun l -> mk_comb_list_2 make_0_aux l) comb_0_2 in
  s_list 

let make_0_ml =
  let comb_0_2 = cases_0_2 2 in
  let s_list = map (fun l -> mk_comb_list_2 make_0_aux_ml l) comb_0_2 in
  s_list 

let mk_iqd rev t = match t with 
	(d,dart,y4e) ->(
		let (y2', y3', y5', y6') = if rev then ("y3", "y2", "y6", "y5") else ("y2", "y3", "y5", "y6") in
  (*let ineq = template_181212899([dart;y4e] @ yy) in*)
		let ineq = template_181212899 y4e y2' y3' y5' y6' dart in
   	let name = Printf.sprintf "181212899_%d" d in
		let (bounds,ineq) = generate_bounds_ineq ineq in
		"Lemma l_"^name^" : "^bounds^ " -> "^ineq^".\n")

let mk_iqd_ml rev t = match t with 
	(d,dart,y4e) ->(
		let (y2', y3', y5', y6') = if rev then ("y3", "y2", "y6", "y5") else ("y2", "y3", "y5", "y6") in
  (*let ineq = template_181212899([dart;y4e] @ yy) in*)
		let ineq = template_181212899 y4e y2' y3' y5' y6' dart in
   	let name = Printf.sprintf "181212899_%d" d in
		let (bounds,ineq) = generate_bounds_ineq_ml ineq in
    let s_bounds = "let box_"^name^" "^bounds^" ;;\n"  in
    let s_ineq   = "let obj_"^name^" "  ^ineq^" ;;\n" in
    s_bounds^s_ineq   ) 

let templateC dart f fc f0 c1 c2 c3 c4 c5 c6 y1min y2min y3min y4min y5min y6min =
  "("^  dart ^ " y1 y2 y3 y4 y5 y6 )"^
  "   ( "^fc^" * "^f^" y1 y2 y3 y4 y5 y6 > "^f0^"
      + "^c1^" * (y1 - "^y1min^") + "^c2^" *(y2- "^y2min^") + "^c3^" * (y3 - "^y3min^") +
          "^c4^" * (y4 - "^y4min^") + "^c5^" *(y5- "^y5min^") + "^c6^" * (y6 - "^y6min^"))"

let yymin = ["#2.18";"&2";"&2";"&2";"&2";"&2"]
let yymin_plus = ["#2.36";"&2";"&2";"#2.25";"&2";"&2"]

let iqd s dart sym t = 
  let name = s in
  match t with 
  | [f; fc; f0; c1; c2; c3; c4; c5; c6; y1min; y2min; y3min; y4min; y5min; y6min] ->( 
    let ineq =  (templateC dart f fc f0 c1 c2 c3 c4 c5 c6 y1min y2min y3min y4min y5min y6min) in
    let (bounds,ineq) = generate_bounds_ineq ineq in
		"Lemma l_"^name^" : "^bounds^ " -> "^ineq^".\n")
  | _ -> failwith "bad t input for iqd"

let iqd_ml s dart sym t = 
  let name = s in
  match t with 
  | [f; fc; f0; c1; c2; c3; c4; c5; c6; y1min; y2min; y3min; y4min; y5min; y6min] ->( 
    let ineq =  (templateC dart f fc f0 c1 c2 c3 c4 c5 c6 y1min y2min y3min y4min y5min y6min) in
    let (bounds,ineq) = generate_bounds_ineq_ml ineq in
    let s_bounds = "let box_"^name^" "^bounds^" ;;\n"  in
    let s_ineq   = "let obj_"^name^" "  ^ineq^" ;;\n" in
    s_bounds^s_ineq)
  | _ -> failwith "bad t input for iqd"
   


let make_iqd = 
[
mk_iqd false (0,apexffA,"y4");
mk_iqd true (1,apexfA,"y4");
mk_iqd false (2,apexf4,"sqrt8");
mk_iqd true (3,apexff4,"sqrt8");
mk_iqd false (4,apexf5,"#2.52");
mk_iqd true (5,apexff5,"#2.52")
]
let make_iqd_ml = 
[
mk_iqd_ml false (0,apexffA,"y4");
mk_iqd_ml true (1,apexfA,"y4");
mk_iqd_ml false (2,apexf4,"sqrt8");
mk_iqd_ml true (3,apexff4,"sqrt8");
mk_iqd_ml false (4,apexf5,"#2.52");
mk_iqd_ml true (5,apexff5,"#2.52")
]

let make_iqd2 = 
[(iqd "2151506422" "apex_std3_hll" false 
 (["dih_y";"&1";"#1.2777"] @ 
  ["#0.281";"-- #0.278364";"-- #0.278364";"#0.7117";"-- #0.34336";"-- #0.34336"] @
  yymin));

(iqd "6836427086" "apex_std3_hll" false 
 (["dih_y";"-- &1";"-- #1.27799"] @ 
  ["-- #0.356217";"#0.229466";"#0.229466";"-- #0.949067";"#0.172726";"#0.172726"] @
  yymin));

(iqd "3636849632" "apex_std3_hll" false 
 (["taum";"&1";"#0.0345"] @ 
  ["#0.185545";"#0.193139";"#0.193139";"#0.170148";"#0.13195";"#0.13195"] @
  yymin));

(iqd "5298513205" "apex_std3_hll" true 
 (["dih2_y";"&1";"#1.185"] @ 
  ["-- #0.302913";"#0.214849";"-- #0.163775";"-- #0.443449";"#0.67364";"-- #0.314532"] @
  yymin));

(iqd "7743522046" "apex_std3_hll" true
 (["dih2_y";"-- &1";"-- #1.1865"] @ 
  ["#0.20758";"-- #0.236153";"#0.14172";"#0.263834";"-- #0.771203";"#0.0457292"] @
  yymin));

(iqd "8657368829" "apex_std3_small_hll" false 
 (["dih_y";"&1";"#1.277"] @ 
  ["#0.273298";"-- #0.273853";"-- #0.273853";"#0.708818";"-- #0.313988";"-- #0.313988"] @
  yymin));

(iqd "6619134733" "apex_std3_small_hll" false 
 (["dih_y";"-- &1";"-- #1.27799"] @ 
  ["-- #0.439002";"#0.229466";"#0.229466";"-- #0.771733";"#0.208429";"#0.208429"] @
  yymin));

(iqd "1284543870" "apex_std3_small_hll" true
 (["dih2_y";"&1";"#1.185"] @ 
  ["-- #0.372262";"#0.214849";"-- #0.163775";"-- #0.293508";"#0.656172";"-- #0.267157"] @
  yymin));

(iqd "4041673283" "apex_std3_small_hll" true
 (["dih2_y";"-- &1";"-- #1.1864"] @ 
  ["#0.20758";"-- #0.236153";"#0.14172";"#0.263109";"-- #0.737003";"#0.12047"] @
  yymin));

(iqd "3872614111" "dart_mll_w" false
 (["dih_y";"-- &1";"-- #1.542"] @ 
  ["-- #0.362519";"#0.298691";"#0.287065";"-- #0.920785";"#0.190917";"#0.219132"] @
  yymin_plus));

(iqd "3139693500" "dart_mll_n" false
 (["dih_y";"-- &1";"-- #1.542"] @ 
  ["-- #0.346773";"#0.300751";"#0.300751";"-- #0.702567";"#0.172726";"#0.172727"] @
  yymin_plus));

(iqd "4841020453" "dart_Hll_n" false
 (["dih_y";"-- &1";"-- #1.542"] @ 
  ["-- #0.490439";"#0.318125";"#0.32468";"-- #0.740079";"#0.178868";"#0.205819"] @
  yymin_plus));

(iqd "9925287433" "dart_Hll_w" false
 (["dih_y";"-- &1";"-- #1.542"] @ 
  ["-- #0.490439";"#0.321849";"#0.320956";"-- #1.00902";"#0.240709";"#0.218081"] @
  yymin_plus));

(iqd "7409690040" "dart_mll_w" true
 (["dih2_y";"&1";"#1.0494"] @ 
  ["-- #0.297823";"#0.215328";"-- #0.0792439";"-- #0.422674";"#0.647416";"-- #0.207561"] @
  yymin_plus));

(iqd "4002562507" "dart_mll_n" true
 (["dih2_y";"&1";"#1.0494"] @ 
  ["-- #0.29013";"#0.215328";"-- #0.0715511";"-- #0.267157";"#0.650269";"-- #0.295198"] @
  yymin_plus));

(iqd "5835568093" "dart_Hll_n" true
 (["dih2_y";"&1";"#1.0494"] @ 
  ["-- #0.404131";"#0.212119";"-- #0.0402827";"-- #0.299046";"#0.643273";"-- #0.266118"] @
  yymin_plus));

 (iqd "1894886027" "dart_Hll_w" true
 (["dih2_y";"&1";"#1.0494"] @ 
  ["-- #0.401543";"#0.207551";"-- #0.0294227";"-- #0.494954";"#0.605453";"-- #0.156385"] @
  yymin_plus))]


let make_iqd2_ml = 
[(iqd_ml "2151506422" "apex_std3_hll" false 
 (["dih_y";"&1";"#1.2777"] @ 
  ["#0.281";"-- #0.278364";"-- #0.278364";"#0.7117";"-- #0.34336";"-- #0.34336"] @
  yymin));

(iqd_ml "6836427086" "apex_std3_hll" false 
 (["dih_y";"-- &1";"-- #1.27799"] @ 
  ["-- #0.356217";"#0.229466";"#0.229466";"-- #0.949067";"#0.172726";"#0.172726"] @
  yymin));

(iqd_ml "3636849632" "apex_std3_hll" false 
 (["taum";"&1";"#0.0345"] @ 
  ["#0.185545";"#0.193139";"#0.193139";"#0.170148";"#0.13195";"#0.13195"] @
  yymin));

(iqd_ml "5298513205" "apex_std3_hll" true 
 (["dih2_y";"&1";"#1.185"] @ 
  ["-- #0.302913";"#0.214849";"-- #0.163775";"-- #0.443449";"#0.67364";"-- #0.314532"] @
  yymin));

(iqd_ml "7743522046" "apex_std3_hll" true
 (["dih2_y";"-- &1";"-- #1.1865"] @ 
  ["#0.20758";"-- #0.236153";"#0.14172";"#0.263834";"-- #0.771203";"#0.0457292"] @
  yymin));

(iqd_ml "8657368829" "apex_std3_small_hll" false 
 (["dih_y";"&1";"#1.277"] @ 
  ["#0.273298";"-- #0.273853";"-- #0.273853";"#0.708818";"-- #0.313988";"-- #0.313988"] @
  yymin));

(iqd_ml "6619134733" "apex_std3_small_hll" false 
 (["dih_y";"-- &1";"-- #1.27799"] @ 
  ["-- #0.439002";"#0.229466";"#0.229466";"-- #0.771733";"#0.208429";"#0.208429"] @
  yymin));

(iqd_ml "1284543870" "apex_std3_small_hll" true
 (["dih2_y";"&1";"#1.185"] @ 
  ["-- #0.372262";"#0.214849";"-- #0.163775";"-- #0.293508";"#0.656172";"-- #0.267157"] @
  yymin));

(iqd_ml "4041673283" "apex_std3_small_hll" true
 (["dih2_y";"-- &1";"-- #1.1864"] @ 
  ["#0.20758";"-- #0.236153";"#0.14172";"#0.263109";"-- #0.737003";"#0.12047"] @
  yymin));

(iqd_ml "3872614111" "dart_mll_w" false
 (["dih_y";"-- &1";"-- #1.542"] @ 
  ["-- #0.362519";"#0.298691";"#0.287065";"-- #0.920785";"#0.190917";"#0.219132"] @
  yymin_plus));

(iqd_ml "3139693500" "dart_mll_n" false
 (["dih_y";"-- &1";"-- #1.542"] @ 
  ["-- #0.346773";"#0.300751";"#0.300751";"-- #0.702567";"#0.172726";"#0.172727"] @
  yymin_plus));

(iqd_ml "4841020453" "dart_Hll_n" false
 (["dih_y";"-- &1";"-- #1.542"] @ 
  ["-- #0.490439";"#0.318125";"#0.32468";"-- #0.740079";"#0.178868";"#0.205819"] @
  yymin_plus));

(iqd_ml "9925287433" "dart_Hll_w" false
 (["dih_y";"-- &1";"-- #1.542"] @ 
  ["-- #0.490439";"#0.321849";"#0.320956";"-- #1.00902";"#0.240709";"#0.218081"] @
  yymin_plus));

(iqd_ml "7409690040" "dart_mll_w" true
 (["dih2_y";"&1";"#1.0494"] @ 
  ["-- #0.297823";"#0.215328";"-- #0.0792439";"-- #0.422674";"#0.647416";"-- #0.207561"] @
  yymin_plus));

(iqd_ml "4002562507" "dart_mll_n" true
 (["dih2_y";"&1";"#1.0494"] @ 
  ["-- #0.29013";"#0.215328";"-- #0.0715511";"-- #0.267157";"#0.650269";"-- #0.295198"] @
  yymin_plus));

(iqd_ml "5835568093" "dart_Hll_n" true
 (["dih2_y";"&1";"#1.0494"] @ 
  ["-- #0.404131";"#0.212119";"-- #0.0402827";"-- #0.299046";"#0.643273";"-- #0.266118"] @
  yymin_plus));

 (iqd_ml "1894886027" "dart_Hll_w" true
 (["dih2_y";"&1";"#1.0494"] @ 
  ["-- #0.401543";"#0.207551";"-- #0.0294227";"-- #0.494954";"#0.605453";"-- #0.156385"] @
  yymin_plus))]

 
(* Add all the inequalities from ineqdata3q1h.ml *)
let records = Ineqdata3q1h.Ineqdata3q1h.records
let mk_ineq = Ineqdata3q1h.Ineqdata3q1h.mk_ineq
let lemma_names_3q1h case r = Printf.sprintf "OXLZLEZ_6346351218_%d_%d" case r
let mk_3q1h case r =
  let d = nth records r in
  let ineq = mk_ineq case d in
  let name = lemma_names_3q1h case r in
  let (bounds,ineq) = generate_bounds_ineq (ineq) in
  Printf.fprintf ineq_test "%s\n" ineq;
  "Lemma l_"^name^" : "^bounds^ " -> "^ineq^".\n"

let make_3q1h = 
  let mk_3q1hc r = map (fun c -> mk_3q1h c r) (int_to_list 4) in
  let mk_3q1h_all = List.flatten(map (mk_3q1hc) (int_to_list ((length records)-1)) ) in
     mk_3q1h_all


(* Add all the inequalities from ineqdata3q1h.ml in ml file *)
let mk_3q1h_ml case r =
  let d = nth records r in
  let ineq = mk_ineq case d in
  let name = lemma_names_3q1h case r in
  let (bounds,ineq) = generate_bounds_ineq_ml (ineq) in
  Printf.fprintf ineq_test_ml "%s\n" ineq;
  let s_bounds = "let box_"^name^" "^bounds^" ;;\n"  in
  let s_ineq   = "let obj_"^name^" "  ^ineq^" ;;\n" in
  s_bounds^s_ineq
  
let make_3q1h_ml = 
  let mk_3q1hc r = map (fun c -> mk_3q1h_ml c r) (int_to_list 4) in
  let mk_3q1h_all = List.flatten(map (mk_3q1hc) (int_to_list ((length records)-1)) ) in
     mk_3q1h_all



let list_ineq s = 
	let list_add = mk_split ";;\n*"  s in
  (*Printf.printf "type_of_item \n";*)
	let basic_lemma_list = List.map type_of_item list_add in
  let coq_str,ml_str = split basic_lemma_list in
  (*Printf.printf "final string generated\n";	*)
  let lemma_list_coq = concat [coq_str;make_F4; make_F23; make_QITNPEA ;make_0;make_3q1h;make_iqd;make_iqd2] in
	let coq_s = concat_string (add_string_right "\n" lemma_list_coq) in
  let lemma_list_ml = concat [ml_str;make_F4_ml;make_F23_ml; make_QITNPEA_ml ;make_0_ml;make_3q1h_ml;make_iqd_ml;make_iqd2_ml] in
  let ml_s = concat_string (add_string_right "\n" lemma_list_ml) in
   (*Printf.printf "final string generated\n";*)
	let reg_coq = regular_hol_to_coq coq_s in
  let reg_ml = regular_hol_to_ml ml_s in
  let s_without_doubloon = replace_first_doubloon reg_coq doubloon_list in
  s_without_doubloon,reg_ml
  
;;	
let let_hol_2_coq def= 
        try
                (let _ = Str.search_forward let_hol def 0 in 
                 let s1 = Str.matched_group 1 def in
                 let s2 = Str.matched_group 2 def in 
                 let new_def = add_match_after_let s1 s2 in 
                 new_def )
        with Not_found -> def
 
(* returns (vernacular string,ml string) *)
let list_definitions s is_sphere=
        let split_coma_coma =  Str.regexp  "`)? ?;;" in
        let list_def = Str.split split_coma_coma s in
        
        let hol2coq_ml_def def =
          (*Printf.printf "def before parsing: %s\n" def;*)
                try
                let let_begin = Str.search_forward (Str.regexp "let ") def 0 in
                let egal_begin = Str.search_forward egal def let_begin in
                  try let def_name = String.sub def (let_begin+3)
                      (egal_begin-let_begin-3) in
                      let def_name = Str.global_replace (Str.regexp " ") "" def_name in
                      (*Printf.printf "def_name: %s\n"def_name;*)

                      if (List.mem def_name sphere_functions) then
                                                        try
                                let grave_begin = Str.search_forward grave def 0 in
                                let egal_begin =  Str.search_forward egal def grave_begin in
                                let definition_ml = "let "^ (String.sub def (grave_begin+1)(egal_begin-1-grave_begin))^"="^(String.sub def (egal_begin+1) ( (String.length def) -1
                                -egal_begin ))^ ";;\n" in

                                let def =  if_hol_to_coq def in 
                                let definition = "Definition "^ (String.sub def (grave_begin+1)(egal_begin-1-grave_begin))^"="^ (String.sub def (egal_begin+1) ( (String.length def) -1
                                -egal_begin ))^ ".\n" in

                                let definition = regular_hol_to_coq definition in
                                let definition_ml = regular_hol_to_ml definition_ml in 
 
                                let new_let_def = let_hol_2_coq definition in
                                let definition =  Str.global_replace let_hol new_let_def definition in        
                                let definition,definition_ml = lambda_fun_hol definition,lamda_fun_caml definition_ml in
(*                                Printf.printf "ml lambda string: %s\n"
 *                                (make_by_hand definition_ml); *)
(*                                Printf.printf "coq lambda string: %s\n"
 *                                (make_by_hand definition); *)
   
                                make_by_hand definition,make_by_hand_ml definition_ml
                                with Not_found -> "","" 
                    else ("","" )
                  with Invalid_argument _ -> "",""
                with Not_found -> "",""
        in
        let list_coq_ml = List.map hol2coq_ml_def list_def in
        let list_coq,list_ml = split list_coq_ml in
(*        Printf.printf "lists created\n";*)
        let result,result_ml = concat_string list_coq,concat_string list_ml in
(*        Printf.printf "coq result string: %s\n" (result); *)
  
        let result = Str.replace_first (Str.regexp_string "Definition sqrt3 := sqrt(3).") "" result in
        let result = Str.replace_first (Str.regexp_string "Definition rad2_y := y_of_x rad2_x.") "" result in
        
        (if is_sphere then begin_sphere_v else "")^ result,(if is_sphere then begin_sphere_ml else "")^result_ml 
;;        



let rec numer n1 n2 = 
        if n2>=n1 then (numer n1 (n2-1))@[n2]
  else []
;;  

(*
let string_to_definitions s =
  let spaces = " \t\n\r"
  and separators = ",;"
  and brackets = "()[]{}"
  and symbs = "\\!@#$%^&*-+|\\<=>/?~.:"
  and alphas = "'abcdefghijklmnopqrstuvwxyz_ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  and nums = "0123456789" in 
  let inside_hol_def = "\\(["^nums^alphas^spaces^symbs^"*]\\)" in 
  let definition = Str.regexp ( "\\(let [a-zA-Z0-9_]* = new definition ?(?`[a-zA-Z0-9_]* "^ inside_hol_def^"`)?;;\\)" )in 
  let defs = Str.string_match definition s 0 in
  Pervasives.print_string (Str.matched_group 0 s); 
  (*let _ = Str.string_match sos_regexp s 0 in

(*  let full_sos = Str.matched_group 0 s in*)
  let coeff_sos = Str.matched_group 1 s in
  let under_square = Str.matched_group 3 s in  

(*  let add_plus = Str.regexp " *\\+ *" in*)
  let without_blank = Str.regexp " " in  
  let mon_add_list = Str.split without_blank under_square in
  let mul_ = Str.regexp " *\\* *"in
  let mon_mult_list =  List.map (Str.split mul_) mon_add_list in
  Product(Rational_lt(num_of_string coeff_sos),Square (string_to_poly_add mon_mult_list))
*)
  ""
;;
*)
(*
let string_to_poly s =
  let poly_regexp = Str.regexp "\\([a-zA-Z0-9\\+ -\\*\\^/]*\\)"in 
  let _ = Str.string_match poly_regexp s 0 in

  let poly_eq = Str.matched_group 0 s in

  let without_blank = Str.regexp " " in  
  let mon_add_list = Str.split without_blank poly_eq in
  let mul_ = Str.regexp " *\\* *"in
  let mon_mult_list =  List.map (Str.split mul_) mon_add_list in
  string_to_poly_add mon_mult_list
;;
*)

let parse_definitions hol_file sphere_bool =
  let hol_string  = string_of_file hol_file in
  let new_string = remove_comments hol_string in
  let new_string = list_definitions new_string sphere_bool in
  new_string
;;

let parse_ineq hol_file = 
  let hol_string = string_of_file hol_file in
  let new_string = remove_comments hol_string in
  let new_string = list_ineq new_string in
  new_string
;;

let main () =
 
  let sphere_bool = [true;false;false;false] in
  let s= (map2 parse_definitions [sphere_hol;cayleyR_def_hol;muR_def_hol;enclosed_def_hol] sphere_bool  ) in
  let coq_s,ml_s = split s in
  Printf.fprintf sphere_final "%s" (concat_string coq_s);
  Printf.fprintf sphere_final_ml "%s" (concat_string ml_s);

  let coq_s,ml_s = parse_ineq ineq_hol in
	Printf.fprintf ineq_final "%s" coq_s;
  Printf.fprintf ineq_final_ml "%s" (begin_ineq_ml^ml_s); 
  exit 0 

;;
let _ = main () in ()
(* Local Variables: *)
(* coding: utf-8 *)
(* End: *)
