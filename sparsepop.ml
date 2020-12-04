module type T = sig
  type num_i 
  type positive
  type pol 
  type fw_pol 
  type term 
  type val_tbl 
  type eval_tbl 
  type rt
  type bound
  type cert_pop
  exception Unbounded
  exception Scale_refine
  val pt_s : string
  val eq_s : string
  val le_s : string
  val ge_s : string
  val param : string -> int -> int -> string
  val mk_param_sdpa : int -> unit
  val gen_param_pop : int -> int -> string
  val gen_output_s : string -> string
  val minor_var : pol -> num_i -> (positive, num_i * num_i) Hashtbl.t -> string
  val major_var : pol -> num_i -> (positive, num_i * num_i) Hashtbl.t -> string
  val fix_var : pol -> num_i -> (positive, num_i * num_i) Hashtbl.t -> string
  val bound_meth_box : pol -> num_i -> num_i -> (positive, num_i * num_i) Hashtbl.t -> string
  val equals_cstr : pol -> pol -> string
  val equals_cstr_term : term -> term -> string
  val major_cstr : pol -> pol  -> string
  val minor_cstr : pol -> pol  -> string
  val norm_meth_box : pol -> pol -> num_i -> num_i -> string
  val write_sparsepop_problem : fw_pol -> pol list -> pol list -> fw_pol list -> (string, val_tbl) Hashtbl.t -> bool -> out_channel -> string -> rt (*-> num_i list *)-> num_i * int * int list
  val parse_aux : string -> int -> num_i * num_i
  val parse_optimum : string -> int list -> num_i list * num_i list
  exception UnfeasPOP of string
  val parse_sparsepop_output_aux : string -> int list -> num_i * num_i * num_i list * num_i list * string * num_i * num_i
  val read_oc_in : Unix.file_descr -> string list
  val parse_sparsepop_output : in_channel -> int list -> num_i * num_i * num_i list * num_i list * string * num_i * num_i
  val get_bound_poly_conj : fw_pol -> pol list -> pol list -> fw_pol list ->  (string, val_tbl) Hashtbl.t -> bool -> in_channel -> out_channel -> int -> int -> rt (*-> num_i list*) -> num_i * num_i * num_i list * num_i list * num_i
  val get_bound_poly_conj_sparsepopcpp : fw_pol -> pol list -> pol list ->  fw_pol list ->  (string, val_tbl) Hashtbl.t -> bool -> in_channel -> out_channel -> int -> int -> rt -> bool -> num_i * num_i * num_i list * num_i list * num_i * pol * cert_pop
  val get_bound_poly : bool -> bool -> fw_pol -> pol list ->  pol list -> fw_pol list ->  (string, val_tbl) Hashtbl.t -> bool -> in_channel -> out_channel -> int -> int -> rt -> bool -> bool -> num_i * num_i * num_i list * num_i list * pol * cert_pop
end


module Make 
  (Nq: Numeric.T)  
  (Uq: Tutils.T with type t = Nq.t) 
  (Iq: Interval.T with type num_i = Nq.t) 
  (Pq: Polynomial.T with type num_i = Nq.t and type interval = Iq.interval) 
  (Fu: Fw_utils.T with type num_i = Nq.t and type pol = Pq.pol and type fw_pol = Pq.fw_pol and type interval = Iq.interval) 
  (A: Algo_types.T with type num_i = Nq.t and type pol = Pq.pol and type fw_pol = Pq.fw_pol) 
  (O: Oracle.T with type num_i = Nq.t and type positive = Pq.positive and type pol = Pq.pol and type fw_pol = Pq.fw_pol and type term = Pq.term and type val_tbl = A.val_tbl) 
  (L: Fw2oracle_lasserre.T with type num_i = Nq.t and type positive = Pq.positive and type interval = Iq.interval and type pol = Pq.pol and type fw_pol = Pq.fw_pol and type rt = Fu.relax_type and type bound = O.bound)= struct

    type num_i = Nq.t
    type positive = Pq.positive
    type pol = Pq.pol
    type fw_pol = Pq.fw_pol
    type term = Pq.term
    type val_tbl = A.val_tbl
    type eval_tbl = A.eval_tbl
    type rt = Fu.relax_type
    type cert_pop = Pq.cert_pop
    type bound = O.bound
    exception Unbounded
    let verb = Config.Config.pop_verb 
    let debug s = if verb then Uq.debug s else ()
    let prec = Config.Config.print_precision
    let add_bounds = ref Config.Config.bound_squares_variables 
(* bound_transc indicates wether or not the polynomial list is the upper or lower
 * bound of the transcendental function: if bound_transc then min else max*) 
    let pt_s = ".." 
    let eq_s = " =E= 0 ;\n"
    let le_s = " =L= 0 ;\n" 
    let ge_s = " =G= 0 ;\n" 
(*let param output_s = "param.printLevel= [0 0];\n param.printFileName='" ^
 * output_s ^ "';\n param.mex = 1;\n" ^ "param.POPsolver = 'interior-point';\n"
 * *)

(* Auxiliary functions to handle Sage-mathematics lists and strings *)
    let dm_psatz_path = Config.Config.dm_psatz_path
    let to_str_sage s = "\'" ^ s ^ "\'"
    let str_list_sage_before str_list str_before list_separator = "[" ^ str_before ^ (Uq.concat_string_with_string str_list list_separator) ^ "]"
    let str_list_sage_after str_list str_after list_separator = "[" ^ (Uq.concat_string_with_string str_list list_separator) ^ str_after ^ "]"
    let str_list_sage str_list list_separator = str_list_sage_before str_list "" list_separator
    let sage_string_of_pol p = to_str_sage (Pq.string_of_pol_rat p)

(* Functions to write IO for the solver of David Monniaux, written in
 * Sage-mathetmatics *)
                                 (*
    let sage_file_begin = "import os \nos.chdir(os.path.dirname(__file__)) \nload \'solve_sos_equation.sage\'\n"
                                  *)
  let sage_file_begin = "load \'solve_sos_equation.sage\'\n"

    let sage_indeterminates (vars : pol list) =  "indeterminates = " ^ (str_list_sage (List.map sage_string_of_pol vars) ", ") ^ "\n"
    let sage_pring = "polynomial_ring=PolynomialRing(QQ, indeterminates)\n"

    let sage_monomial_list vars pos_or_eq relax_order = 
      (*let k = Config.Config.relax_order in*)
      let k = relax_order in
      let n = List.length vars in
      let exp_list = O.gen_constraints_names n "a" in
      let gen_monomial xi ai = "polynomial_ring(" ^ (sage_string_of_pol xi) ^ ")^" ^ ai in
      let pol_ring_list = Uq.concat_string_with_string (List.map2 gen_monomial vars exp_list) " * " in
      let gen_for ai = Printf.sprintf "for %s in range(%i)" ai (k + 1) in
      let for_list = Uq.concat_string_with_string (List.map gen_for exp_list) " " in
      let if_str = Printf.sprintf "if %s <= %i" (Uq.concat_string_with_string exp_list " + ") k in
        Printf.sprintf "%s_monomial_list=[%s %s %s]\n" pos_or_eq pol_ring_list for_list if_str

    let sage_pols ineqs pos_or_eq = 
      let str_list = List.map (fun p -> "polynomial_ring(" ^ (sage_string_of_pol p) ^ ")") ineqs in
       (Printf.sprintf "%s_polynomials=[" pos_or_eq) ^ (Uq.concat_string_with_string str_list  ", ") ^ "]\n"

    let sage_mon_lists pos_or_eq = Printf.sprintf "%s_monomial_lists=[%s_monomial_list for p in %s_polynomials]\n" pos_or_eq pos_or_eq pos_or_eq

    let sage_rhs_pol pol = Printf.sprintf "rhs_polynomial = polynomial_ring(%s)\n" (sage_string_of_pol pol)
    let sage_solve coq_file vars = 
Printf.sprintf "solution = solve_sos_equation_sos(polynomial_ring, positive_polynomials, positive_monomial_lists, equality_polynomials, equality_monomial_lists, rhs_polynomial)\n
def apply_sos_solution(pblocks, eblocks):\n
  assert(len(pblocks) == len(positive_monomial_lists))\n
  assert(len(pblocks) == len(positive_polynomials))\n
  assert(len(eblocks) == len(equality_monomial_lists))\n
  assert(len(eblocks) == len(equality_polynomials))\n
  total = polynomial_ring(0)\n
  for (sos, poly, monomials) in zip(pblocks, positive_polynomials, positive_monomial_lists):\n
    total += poly * apply_sos(sos, monomials)\n
  for (lin, poly, monomials) in zip(eblocks, equality_polynomials, equality_monomial_lists):\n
    total += poly * (lin * vector(monomials))\n
  return total\n
if solution == ():\n
  f_out = open(\"sage_out\", \'w\')\n
  f_out.write(\"NO SOLUTION\")\n
  f_out.close()\n
  print \'NO SOLUTION\'\n
else:\n
  f_out = open(\"sage_out\", \'w\')\n
  f_out.write(\"SUCCESS\")\n
  f_out.close()\n
  (pblocks, eblocks) = solution\n
  assert(apply_sos_solution(pblocks, eblocks)==rhs_polynomial)\n
  f = open(\"%s\", \'w\')
  f.write (\"Require Import Reals ZArith.\\nOpen Scope R_scope.\\n\\nGoal forall %s : R, \")
  f.write (\"%s = \" %s rhs_polynomial)
  for i in xrange(len(positive_polynomials)):
    f.write (\"(%s)*(\" %s positive_polynomials[i])
    counter = 0
    if len(pblocks[i]) == 0:                
      f.write (\"0\")
    else:
      for coeff, sos in pblocks[i]:      
        f.write (\"%s\" %s coeff)
        f.write (\"*(%s)^2\" %s sum([a*b for a, b in zip(sos, positive_monomial_lists[i])]) )
        if counter < len(pblocks[i]) - 1:
          f.write (\"+\")
        else :
          f.write (\"\")
        counter = counter + 1
    if i < len(positive_polynomials) - 1:
      f.write (\")+\")
    else :
      f.write (\")\")
  f.write (\".\\nintros;field.\\nQed.\")
  f.close()" coq_file (Uq.concat_string_with_string (List.map Pq.string_of_pol vars) " ") "%s" "%"  "%s" "%"  "%s" "%"  "%s" "%"
    let dm_psatz_string vars coq_file rhs_pol ineqs eqs relax_order =
      sage_file_begin ^ sage_indeterminates vars ^ sage_pring ^ 
      sage_monomial_list vars "positive" relax_order ^  sage_pols ineqs "positive" ^ sage_mon_lists "positive" ^ 
      sage_monomial_list vars "equality" relax_order ^  sage_pols eqs  "equality" ^ sage_mon_lists "equality" ^ 
      sage_rhs_pol rhs_pol ^ sage_solve coq_file vars 


(* Matlab functions *)
    let param output_s relax_order cliques : string = 
    "clear all;\n param.printLevel= [2 0];\n param.printFileName='"^ output_s ^ 
    "';\n param.mex = 1;\n param.relaxOrder="^ (string_of_int relax_order)^ 
    ";\n param.multiCliquesFactor=" ^ (string_of_int cliques)^
    ";\n param.SDPsolver='sdpa';\n param.SDPsolverEpsilon = 1e-6;\n param.POPsolver = 'interior-point';\n  param.eqTolerance = 0;\n"


(* sdpa file parameters function: writes out param.sdpa*)      
    let mk_param_sdpa sdp_solver_print : unit =
      let param_sdpa_content : string = (Printf.sprintf  
      "100	unsigned int maxIteration;
      1.0E-7	double 0.0 < epsilonStar;
      1.0E2   double 0.0 < lambdaStar;
      2.0   	double 1.0 < omegaStar;
-1.0E5  double lowerBound;
1.0E5   double upperBound;
0.1     double 0.0 <= betaStar <  1.0;
0.2     double 0.0 <= betaBar  <  1.0, betaStar <= betaBar;
0.9     double 0.0 < gammaStar  <  1.0;
1.0E-7	double 0.0 < epsilonDash;
%s+8.%ie     char*  xPrint   (default %s+8.3e,   NOPRINT skips printout)
%s+8.%ie     char*  XPrint   (default %s+8.3e,   NOPRINT skips printout)
%s+8.%ie     char*  YPrint   (default %s+8.3e,   NOPRINT skips printout)
%s+10.16e   char*  infPrint (default %s+10.16e, NOPRINT skips printout)" "%"  sdp_solver_print "%" "%" sdp_solver_print "%" "%" sdp_solver_print "%" "%" "%")
    in
    let param_sdpa_s = Uq.pwd ^ "/param.sdpa" in
    let param_sdpa_file = open_out_gen [Open_creat; Open_trunc; Open_wronly] 0o666 param_sdpa_s in
      Printf.fprintf param_sdpa_file "%s\n" param_sdpa_content; close_out param_sdpa_file;()


(* SparsePOP file parameters functions: writes out param.pop *)
  let gen_param_pop relax_order cliques  : string = 
    Printf.sprintf 
"relaxOrder,		int,	%i;        
sparseSW,		int,	1;
multiCliquesFactor,	int,	%i;
scalingSW,		int,	1;
boundSW, 		int,	2;
eqTolerance,		double, 0;
perturbation,		double,	0;
reduceMomentMatSW,	int,	1;
complementaritySW,	int,	0;
SquareOneSW,		int,	1;
binarySW,		int,	1;
reduceAMatSW,		int,	1;
SDPsolverSW,		int,	1;
SDPolverEpsilon,	double,	1.0e-%i;
SDPsolverOutFile,	string, ;
SDPAOnScreen,		int,	1;
sdpaDataFile,		string,	;
detailedInfFile,	string,	;
printOnScreen,		int,	1;
printFileName,		string,	;
printLevel1,		int,	2;
printLevel2,		int,	2;
Method,			string,	symamd;" relax_order cliques Config.Config.sdp_solver_epsilon 
 
  let gen_output_s input_s =  O.gen_output_s input_s 4
                        
(*
let minor c1 c2 = moins_op c1 c2 ^ " =L= 0 ;\n" and major c1 c2 = moins_op c1 c2 ^ " =G= 0 ;\n" and equals c1 c2 = moins_op c1 c2 ^ " =E= 0 ;\n"
 *)
  let minor_var var value tbl_scaling = 
    let lo, up = Hashtbl.find tbl_scaling (Pq.idx_of_varpol var) in
    let value = Nq.div_i (Nq.sub_i value lo) up in
    let value = if Nq.eq_i (Nq.abs_i value) Nq.infty then (*Nq.num_of_float (-1000000.)*)  Nq.minus_i (Nq.infty) else value in
      (Pq.string_of_pol var) ^ ".lo = " ^ (Nq.string_of_i value) ^ ";\n" 

  let major_var var value tbl_scaling =
    let lo, up = Hashtbl.find tbl_scaling (Pq.idx_of_varpol var) in
    Uq._pr_ (Printf.sprintf "lo: %s up: %s value: %s" (Nq.string_of_i lo) (Nq.string_of_i up) (Nq.string_of_i value)  ) false false;
    let value = Nq.div_i (Nq.sub_i value lo)  up in
Uq._pr_ (Printf.sprintf "new upper value: %s" (Nq.string_of_i value)  ) false false;
    let value = if  Nq.eq_i (Nq.abs_i value) Nq.infty  then (*Nq.num_of_float 20000.*) Nq.infty else value in
      (Pq.string_of_pol var) ^ ".up = " ^ (Nq.string_of_i value) ^ ";\n"

  let fix_var var value tbl_scaling =
   if Config.Config.fix_vars then 
    let lo, up = Hashtbl.find tbl_scaling (Pq.idx_of_varpol var) in
    let value = Nq.div_i (Nq.sub_i value lo) up in
    (Pq.string_of_pol var) ^ ".fx = " ^ (Nq.string_of_i value) ^ ";\n"
    else ""
  let bound_meth_box var lo up tbl_scaling = (major_var var up tbl_scaling) ^ (minor_var var lo tbl_scaling)

  let equals_cstr p1 p2 = O.gen_cstr pt_s (Pq.term_of_pol (Pq.p_sub p1 p2))  eq_s
  let equals_cstr_term c1 c2 = O.gen_cstr pt_s (O.moins_op c1 c2)  eq_s

  let major_cstr p1 p2 =  O.gen_cstr pt_s (Pq.term_of_pol (Pq.p_sub p1 p2))  ge_s
  let minor_cstr p1 p2 =  O.gen_cstr pt_s (Pq.term_of_pol (Pq.p_sub p1 p2))  le_s 

  let bound_meth_box_sqr var lo up tbl_scaling =
    if Nq.eq_i (Nq.abs_i lo) Nq.infty || Nq.eq_i (Nq.abs_i up) Nq.infty then raise Unbounded
    else
      begin
        try
          begin
            let lo_s, up_s = Hashtbl.find tbl_scaling (Pq.idx_of_varpol var) in
            let lo, up = Nq.div_i (Nq.sub_i lo lo_s) up_s, Nq.div_i (Nq.sub_i up lo_s) up_s in
            let center = Uq.m_I lo up in
            let var_centred = Pq.p_subC var center in
            let up = Nq.sqr_i (Nq.sub_i up center) in
            let up = (*Nq.upper_i*) up in
            let p1, p2 = Pq.p_square var_centred, Pq.Pc up in
            let p1, p2 = Pq.p_sub p1 p2, Pq.Pc Nq.zero_i in
            let p1 = Pq.pmulC p1 (Nq.inv_i (Pq.pol_norm_inf p1)) in
              (*
            let p1, p2 = 
              if Nq.ge_i up Nq.ten_i then Pq.p_mulC p1 (Nq.inv_i up), Pq.p_mulC p2 (Nq.inv_i up) else p1, p2
            in
               *)
              minor_cstr p1 p2 
          end
        with Not_found -> (Uq._pr_ (Pq.string_of_pol var) true true;failwith "bound_meth_box_sqr problem" )
      end

    let norm_meth_box var norm_var f1 f2 = 
      equals_cstr (O.norm_meth01 norm_var f1 f2) var

    let rec sparsepop_bounds = function
      | [] -> []
      | hd::tl ->
         begin 
          let bounds_tl = sparsepop_bounds tl in
            match hd with 
              | O.Fx (var, value) -> ((Pq.string_of_pol_float var 10) ^ ".fx = " ^ ( string_of_float (Nq.float_of_num value)) ^ ";\n") :: bounds_tl
              | O.LoUp (var, (lo, up)) -> ((Pq.string_of_pol_float var 10) ^ ".lo = " ^ string_of_float (Nq.float_of_num lo) ^ ";\n" ^ (Pq.string_of_pol_float var 10) ^ ".up = " ^ string_of_float (Nq.float_of_num up) ^ ";\n")::bounds_tl
              | _ -> bounds_tl
         end

    let rec sparsepop_bounds_ineqs = function
      | [] -> []
      | hd::tl ->
         begin 
          let bounds_tl = sparsepop_bounds_ineqs tl in
            match hd with 
              | O.LoUp (var, (lo, up)) -> (Pq.p_subC var lo) :: (Pq.p_opp (Pq.p_subC var up)) :: bounds_tl
              | _ -> bounds_tl
         end


    let rec squares_of_bounds = function 
      | [] -> []
      | hd::tl ->
         begin 
          let bound_tl = squares_of_bounds tl in
            match hd with 
              | O.LoUp (var, (lo, up)) -> 
                  begin
                    if Nq.eq_i (Nq.abs_i lo) Nq.infty || Nq.eq_i (Nq.abs_i up) Nq.infty then raise Unbounded
                    else
                      begin
                        try
                          begin
                            let center = Uq.m_I lo up in
                            let var_centred = Pq.p_subC var center in
                            let up = Nq.sqr_i (Nq.sub_i up center) in
                            let p1, p2 = Pq.p_square var_centred, Pq.Pc up in
                            let p1, p2 = Pq.p_sub p1 p2, Pq.Pc Nq.zero_i in
                            let p1 = Pq.pmulC p1 (Nq.inv_i (Pq.pol_norm_inf p1)) in                      
                              Pq.p_sub p2 p1::bound_tl
                          end
                        with Not_found -> (Uq._pr_ (Pq.string_of_pol var) true true;failwith "bound_meth_box_sqr problem" )
                      end
                  end
              | _ -> bound_tl
         end

    let tau = Nq.pow_i Nq.ten_i (Nq.minus_i Nq.three_i)
    let scaling_ref : (num_i * num_i) list ref = ref []
    let first_solve_sdp = ref true
    let max_abs_scale () = 
      let f = function (s1, s2) -> s1, Nq.max_i (Nq.abs_i s2) Nq.one_i 
      in
        scaling_ref := List.map f !scaling_ref;()
(*
    let eval_fix_vars tbl_scaling p = 
      let var_num_list = Hashtbl.fold (fun k v acc -> if Nq.eq_i (fst v) (snd v) then (k, fst v)::acc else acc ) tbl_scaling [] in
        Uq._pr_ "Length:" true true;
        Uq._pr_ (string_of_int (List.length var_num_list)) true true;
      let vars, nums = List.split var_num_list in
        List.fold_right2 Pq.eval_pol_num vars nums p
 *)
    exception Scale_refine

    let tuple_I i = try Iq.tuple_I i with Iq.Refine -> raise Scale_refine 

    let relax_pop p cstr eqcstr var_hashtbl bound_transc rt =
      Hashtbl.clear L.fw_vars_tbl; L.eq_cstr_tbl := []; L.ineq_cstr_tbl := []; L.nvars :=0; L.vars_of_tree_aux rt p;
      let cstr_list = cstr @ eqcstr in
      let cstr_list_fw  = List.map Fu.mk_Pw cstr_list in
      let box_tbl = O.divide_hashtbl var_hashtbl (p::cstr_list_fw) in
      let sorted_box = List.sort (fun a b -> String.compare (fst a) (fst b)) box_tbl in
      let scaling_box = List.map (fun i -> snd (snd i)) sorted_box in
      let varpol_idx = O.varpol_index box_tbl in
      let varpol_list = List.sort compare (List.map Numbers.T.Translation.positive varpol_idx) in        
      let n_box =  Uq.max_list_int varpol_list in 
        L.ineq_cstr_list:= cstr; L.eq_cstr_list := eqcstr; Hashtbl.clear L.fw_nvars_tbl; Hashtbl.clear L.fw_cvars_tbl;  
        let norm_vars = L.norm_vars_of_tree () in
          (*
        let n_vars_aux = List.length norm_vars in
        let varpol_aux = O.gen_variables_names n_vars_aux n_box in
        let idx_list = (List.map Numbers.T.Translation.positive_n varpol_list) @ (List.map Pq.idx_of_varpol varpol_aux) in
           *)
        let compare a b = compare (fst a) (fst b) in
        let norm_vars_intervals = List.sort compare norm_vars in
        let scaling_box_aux = List.map (fun i -> tuple_I (snd i))  norm_vars_intervals in
        let n_total = n_box + List.length norm_vars in
          (*
        let var_num_list = List.combine idx_list (scaling_box @ scaling_box_aux) in
        let fixed_var_num_list, var_num_list = List.partition (fun (_, b) -> Nq.eq_i (fst b) (snd b)) var_num_list in
        let idx_list : positive list = List.map fst var_num_list in
           *)
        let root_expr = L.constraints_of_tree p bound_transc n_box rt in
          L.ineq_cstr_list := !L.ineq_cstr_list @ ( !L.ineq_cstr_tbl);
          L.eq_cstr_list := !L.eq_cstr_list @ (!L.eq_cstr_tbl);
          (*
          let fixed_var_num_list = List.map (fun (v, b) -> v, fst b ) fixed_var_num_list in
           *)
            n_total, (if bound_transc then root_expr else Pq.p_opp root_expr), !L.ineq_cstr_list, !L.eq_cstr_list, (scaling_box @ scaling_box_aux), n_box

    (* Change the index of variables within the polynomials pol, ineqs, eqs. 
     * n is the highest variable index and n_total = n + number of auxiliary variables
     * For instance the problem min_{x1, x3 \in [0, 1]} x1 + 2 * x3 should be changed into min_{x1, x2 \in [0, 1]} x1 + 2 * x2. At first n = 3 but should be n' = 2 after change. At the end one has n_total = n' + nb of aux variables.
     * *)
    let change_variables n_total pol ineqs eqs n = 
      let p_list = pol :: ineqs @ eqs in
      let vars_list = List.map Pq.vars_of_pol p_list in        
      let vars = Uq.avoid_duplicata  Numbers.T.Pos.compare_int (List.concat vars_list) in
      let n_total' = List.length vars in
      let pol = Pq.change_vars_pol vars pol in
      let ineqs = List.map (Pq.change_vars_pol vars) ineqs in
      let eqs = List.map (Pq.change_vars_pol vars) eqs in
      let n_aux = n_total - n in
      let n' = n_total - n_aux in 
        n_total', pol, ineqs, eqs, n', vars

    let change_variables_opt opt optL vars zero n_total = 
      let vars = List.map (fun i -> (Numbers.T.Translation.positive i - 1)) vars in
      let vars, opt, optL = Array.of_list vars, Array.of_list opt,  Array.of_list optL in
      let newopt, newoptL = Array.make n_total zero,  Array.make n_total zero in
        Array.iteri (fun i vari -> newopt. (vari) <- opt. (i) ) vars;
        Array.iteri (fun i vari -> newoptL. (vari) <- optL. (i) ) vars;
        Array.to_list opt, Array.to_list optL 

    let write_sparsepop_problem p cstr eqcstr cstr_root_major_min var_hashtbl bound_transc input_file output_s rt =
      Hashtbl.clear L.fw_vars_tbl; L.eq_cstr_tbl:=[]; L.ineq_cstr_tbl:=[]; L.nvars :=0; L.vars_of_tree_aux rt p;
      let cstr_list = cstr @ eqcstr in
      let cstr_list_fw  = List.map Fu.mk_Pw cstr_list in
      let box = O.divide_hashtbl var_hashtbl (p::cstr_list_fw) in
      let sorted_box = List.sort (fun a b -> String.compare (fst a) (fst b)) box in
      let scaling_box = List.map (fun i -> snd (snd i)) sorted_box in
      let varpol_idx = O.varpol_index box in
      let varpol_list = List.sort compare (List.map Numbers.T.Translation.positive varpol_idx) in        
      let n_box =  Uq.max_list_int varpol_list in
        (*
      let scale_swf = Nq.num_of_float (1./.419.) in
      let sum = List.fold_left Pq.p_add (Pq.p0 Nq.zero_i) (List.map (fun i -> Pq.p_mulC (Pq.mk_X i) scale_swf ) varpol_idx) in
      let eq_sum_cstr = [Pq.p_subC sum Nq.one_i] in
         *)
        L.ineq_cstr_list:= cstr; L.eq_cstr_list := eqcstr; Hashtbl.clear L.fw_nvars_tbl; Hashtbl.clear L.fw_cvars_tbl;  
        let norm_vars = L.norm_vars_of_tree () in
        let n_vars_aux = List.length norm_vars in
        let varpol_aux = O.gen_variables_names n_vars_aux n_box in
        let idx_list = (List.map Numbers.T.Translation.positive_n varpol_list) @ (List.map Pq.idx_of_varpol varpol_aux) in
        let compare a b = compare (fst a) (fst b) in
        let norm_vars_intervals = List.sort compare norm_vars in
        let scaling_box_aux = List.map (fun i -> tuple_I (snd i))  norm_vars_intervals in
        let var_num_list = List.combine idx_list (scaling_box @ scaling_box_aux) in
        let fixed_var_num_list, var_num_list = List.partition (fun (_, b) -> Nq.eq_i (fst b) (snd b)) var_num_list in
        let idx_list : positive list = List.map fst var_num_list in
        let tbl_scaling = Hashtbl.create (List.length var_num_list) in 
        let scaling_ref_content = if Config.Config.scale_pol then List.map snd var_num_list else Uq.init_list (List.length var_num_list) (Nq.zero_i, Nq.one_i) in
          scaling_ref := scaling_ref_content;


          (*
        let _ = 
          if !first_solve_sdp then
            begin
              first_solve_sdp := false; 
              let _ = if Config.Config.scale_pol then (scaling_ref := List.map snd var_num_list(*scaling_box @ scaling_box_aux*); ())
              else (scaling_ref := Uq.init_list (List.length var_num_list) (Nq.zero_i, Nq.one_i);()) in ()
            end
          else ()
        in  
           *)

          (*max_abs_scale ();*)
          let list_scaling = !scaling_ref in
            Uq.add_list_table tbl_scaling (List.combine idx_list list_scaling);
            (* b : list of variables bounds v.lo = ... v.up = ...  *)
            (* bsquare : list of variables square bounds v^2 <= ...*)
            (* b_lift : list of lifting variables bounds vaux.lo = ... vaux.up = ...  *)
            (* bsquare_lift : list of liting variables square bounds vaux^2 <= ...*)
            let bounds_vars : bound list = List.map (fun b -> O.bound_of_interval b tbl_scaling) box in
            let bounds_vars_lift : bound list = L.norm_constraints_of_tree norm_vars_intervals n_box tbl_scaling in 
            let bsquares, bsquares_lift = squares_of_bounds bounds_vars, squares_of_bounds bounds_vars_lift in
            let b, b_lift = sparsepop_bounds bounds_vars, sparsepop_bounds bounds_vars_lift in
            
            let root_expr = L.constraints_of_tree p bound_transc n_box rt in
              L.ineq_cstr_list := !L.ineq_cstr_list @ (!L.ineq_cstr_tbl);
              L.eq_cstr_list := !L.eq_cstr_list @ (!L.eq_cstr_tbl);
              let fixed_var_num_list = List.map (fun (v, b) -> v, fst b ) fixed_var_num_list in
              let root_expr, obj_norm = Pq.scale_pol tbl_scaling fixed_var_num_list root_expr true in
                
              let ineqs, eqns = List.map (fun i -> fst (Pq.scale_pol tbl_scaling fixed_var_num_list  i false))  L.(!ineq_cstr_list),  List.map (fun e -> fst (Pq.scale_pol tbl_scaling fixed_var_num_list e false)) L.(!eq_cstr_list) in
              let root_expr_term = Pq.term_of_pol root_expr in
              let first_eq = if bound_transc then equals_cstr_term root_expr_term O.objvar else equals_cstr_term root_expr_term (O.minus_op O.objvar) in
              let eqns = List.map (fun p -> equals_cstr p (Pq.Pc Nq.zero_i)) eqns in
              let eqns = first_eq :: eqns in
              let c_num = List.length eqns + List.length ineqs in
              let ineqs = if !add_bounds then ineqs @ bsquares @ bsquares_lift else ineqs in
              let ineqs = List.map (fun p -> major_cstr p (Pq.Pc Nq.zero_i)) ineqs in
        (* only if we need to major objvar by a min of polynomials *)
              let root_major_min =  List.map (fun p -> major_cstr (Pq.pol_of_fw p) root_expr) cstr_root_major_min in
              let cstr_names = O.gen_constraints_names c_num "c" in
              let cstr_names_bsquares = if !add_bounds then O.gen_constraints_names (List.length bsquares) "cx" else [] in
              let cstr_names_bsquares_lift = if !add_bounds then O.gen_constraints_names (List.length bsquares_lift) "cax" else [] in
              let cstr_names_major_min = O.gen_constraints_names (List.length cstr_root_major_min) "cmin" in

              let variables_s = O.variables_string (*n_vars_aux box*) var_num_list "Variables objvar, " ", " in
              let binary_variables_s = O.binary_variables_string box "binary variables " ", " in
              let equations_s = "Equations " ^ (Uq.concat_string_with_string (cstr_names @ cstr_names_bsquares @ cstr_names_bsquares_lift @ cstr_names_major_min) ", ") ^ ";\n" in

              let cstr_list =  List.map2 (fun ci cstr -> ci ^ cstr) (cstr_names @ cstr_names_bsquares @ cstr_names_bsquares_lift @ cstr_names_major_min) (eqns @ ineqs @ root_major_min) in

              let cstr_string = Uq.concat_string cstr_list in
              let box_string = Uq.concat_string (b @ b_lift) in
         
              let result = variables_s ^ binary_variables_s ^ equations_s ^ cstr_string  ^ box_string  in
              let result = Str.global_replace (Str.regexp "\\+ -") " - " result in
                Printf.fprintf input_file "%s\n" result;
                obj_norm, List.length box, (*O.var_idx_list var_num_list *) List.map (fun i -> i + 1) (Uq.int_to_list (List.length var_num_list))

    let write_dm_psatz_problem p cstr cstr_root_major_min var_hashtbl bound_transc input_file output_s rt relax_order =
      Hashtbl.clear L.fw_vars_tbl; L.eq_cstr_tbl:=[]; L.ineq_cstr_tbl:=[]; L.nvars :=0; L.vars_of_tree_aux rt p;
      let box = O.divide_hashtbl var_hashtbl (p::(List.map Fu.mk_Pw cstr)) in
      let sorted_box = List.sort (fun a b -> String.compare (fst a) (fst b)) box in
      let scaling_box = List.map (fun i -> snd (snd i)) sorted_box in
      let varpol_idx = O.varpol_index box in
      let varpol_list = List.sort compare (List.map Numbers.T.Translation.positive varpol_idx) in        
      let n_box =  Uq.max_list_int varpol_list in        
        L.ineq_cstr_list:= cstr; L.eq_cstr_list := []; Hashtbl.clear L.fw_nvars_tbl; Hashtbl.clear L.fw_cvars_tbl;  
        let norm_vars = L.norm_vars_of_tree () in
        let n_vars_aux = List.length norm_vars in
        let varpol_aux = O.gen_variables_names n_vars_aux n_box in
        let idx_list = (List.map Numbers.T.Translation.positive_n varpol_list) @ (List.map Pq.idx_of_varpol varpol_aux) in
        let compare a b = compare (fst a) (fst b) in
        let norm_vars_intervals = List.sort compare norm_vars in
        let scaling_box_aux = List.map (fun i -> tuple_I (snd i))  norm_vars_intervals in
        let var_num_list = List.combine idx_list (scaling_box @ scaling_box_aux) in
        let fixed_var_num_list, var_num_list = List.partition (fun (_, b) -> Nq.eq_i (fst b) (snd b)) var_num_list in
        let idx_list = List.map fst var_num_list in
        let tbl_scaling = Hashtbl.create (List.length var_num_list) in 

        let _ = if !first_solve_sdp then
          begin
            first_solve_sdp := false; 
            let _ = if Config.Config.scale_pol then (scaling_ref := List.map snd var_num_list(*scaling_box @ scaling_box_aux*); ())
            else (scaling_ref := Uq.init_list (List.length var_num_list) (Nq.zero_i, Nq.one_i);()) in ()
          end
        else ()
        in
          max_abs_scale ();
          let list_scaling = !scaling_ref in
            Uq.add_list_table tbl_scaling (List.combine idx_list list_scaling);
            let root_expr = L.constraints_of_tree p bound_transc n_box rt in
              L.ineq_cstr_list := !L.ineq_cstr_list @ (!L.ineq_cstr_tbl);
              L.eq_cstr_list := !L.eq_cstr_list @ (!L.eq_cstr_tbl);
              let fixed_var_num_list = List.map (fun (v, b) -> v, fst b ) fixed_var_num_list in
              let root_expr, obj_norm = Pq.scale_pol tbl_scaling fixed_var_num_list root_expr true in
               

              let ineqs, eqns = List.map (fun i -> fst (Pq.scale_pol tbl_scaling fixed_var_num_list  i false))  L.(!ineq_cstr_list),  List.map (fun e -> fst (Pq.scale_pol tbl_scaling fixed_var_num_list e false)) L.(!eq_cstr_list) in
              let bounds_vars : bound list = List.map (fun b -> O.bound_of_interval b tbl_scaling) box in
              let bounds_vars_lift : bound list = L.norm_constraints_of_tree norm_vars_intervals n_box tbl_scaling in 
              let bsquares, bsquares_lift = squares_of_bounds bounds_vars, squares_of_bounds bounds_vars_lift in
              let b, b_lift = sparsepop_bounds_ineqs bounds_vars, sparsepop_bounds_ineqs bounds_vars_lift in
              let ineqs = ineqs @ b @ b_lift in
              let ineqs = if !add_bounds then ineqs @ bsquares @ bsquares_lift else ineqs in
              let result = dm_psatz_string (List.map Pq.mk_X idx_list) output_s root_expr ineqs eqns relax_order in                
                Printf.fprintf input_file "%s\n" result;
                obj_norm, List.length box, (*O.var_idx_list var_num_list *) List.map (fun i -> i + 1) (Uq.int_to_list (List.length var_num_list))


  let parse_aux file_content i = 
    let opt_component = " " ^ (string_of_int i) ^ "[ \t]*:[ \t]*\\([-+][0-9\\.]+e[-+][0-9][0-9]\\)" in
    let s = Str.regexp opt_component in
    let c, pos = 
      try 
        let pos = Str.search_forward s file_content 0 in
        let c = Str.matched_group 1 file_content in
          Nq.num_of_float (float_of_string c), pos 
      with Not_found -> (Uq._pr_ (string_of_int i) true true; failwith "Not enough components for POPq.xVect")
    in
    let cL =
      try 
        let _ = Str.search_forward s file_content (pos+10) in
        let cL = Str.matched_group 1 file_content in
          Nq.num_of_float (float_of_string cL)
      with Not_found -> c
    in
      c, cL

  let parse_optimum file_content optim_index = List.split (List.map (parse_aux file_content) optim_index)

  exception UnfeasPOP of string

  let parse_sparsepop_output_aux s var_index : num_i * num_i * num_i list * num_i list * string * num_i * num_i =
    let file_content = Uq.string_of_file s in
    let scientific_notation =  "[-+][0-9\\.]+e[-+][0-9][0-9]" in
    (*
     let pop_obj_value_regexp = Str.regexp ("POP\\.objValue[ \t]*=[ \t]*\\(" ^ scientific_notation ^ "\\)") in
     *)
    let sdp_obj_value_regexp = Str.regexp ("SDPobjValue[ \t]*=[ \t]*\\(" ^ scientific_notation ^ "\\)") in
    let pop_objL_value_regexp = Str.regexp ("POP\\.objValueL[ \t]*=[ \t]*\\(" ^ scientific_notation ^ "\\)") in
    let pop_scaled_error_regexp = Str.regexp ("POP\\.scaledError[ \t]*=[ \t]*\\(" ^ scientific_notation ^ "\\)") in
    let rel_obj_error_regexp = Str.regexp ("obj error[ \t]*=[ \t]*\\(" ^ scientific_notation ^ "\\)") in

    (*  let sdp_issues_regexp = Str.regexp ("\\(phase value = dUNBD\\)\\|\\(phase
     *  value = pdINF\\)") in*)
    let sdp_status =  Str.regexp ("phase value = \\([a-zA-Z]*\\)") in
    let status = 
      try
        let  _ = Str.search_forward sdp_status file_content 0 in
        let status = Str.matched_group 1 file_content in
          status
      with Not_found -> failwith "No SDP status in SparsePOP result file"
    in
    let obj = 
      try
        let _ = Str.search_forward sdp_obj_value_regexp file_content 0 in
        let objValue = Str.matched_group 1 file_content in
        let objValue = Nq.num_of_float (float_of_string objValue) in
          objValue
      with Not_found -> raise (UnfeasPOP s)
    in
    let objL = 
      try
        let _ = Str.search_forward pop_objL_value_regexp file_content 0 in
        let objValueL = Str.matched_group 1 file_content in
        let objValueL = Nq.num_of_float (float_of_string objValueL) in
          objValueL
      with Not_found -> obj
    in
    let scalE = 
      try
        let _ = Str.search_forward pop_scaled_error_regexp file_content 0 in
        let scalE = Str.matched_group 1 file_content in
        let scalE = Nq.num_of_float (float_of_string scalE) in
          scalE
      with Not_found -> raise (UnfeasPOP s)
    in
    let relO = 
      try
        let _ = Str.search_forward rel_obj_error_regexp file_content 0 in
        let relO = Str.matched_group 1 file_content in
        let relO = Nq.num_of_float (float_of_string relO) in
          relO
      with Not_found -> raise (UnfeasPOP s)
    in
    let optimum, optimumL = parse_optimum file_content var_index in
      obj, objL, optimum, optimumL, status, scalE, relO

  let read_oc_in fd = 
    let rec suck_oc_in fd acc = 
      match Unix.select [fd] [] [] (-.1.0) with
        | [fd_ready], [], [] -> 
            begin 
              let buffer = Bytes.create 100 in
              let n = Unix.read fd buffer 0 100 in
              let _ = if n = 0 then Uq.wait 10 else () in
              let s = Bytes.sub_string buffer 0 n in
                try 
                  let _ = Str.search_forward (Str.regexp "\\$") s 0 in
                    List.rev (s :: acc)
                with Not_found -> suck_oc_in fd (s :: acc)
            end
        | _ -> acc
    in
      suck_oc_in fd [] 

    let rec parse_sparsepop_output oc_in var_index =      
      let fd = Unix.descr_of_in_channel oc_in in
      let s_list = read_oc_in fd in
        parse_sparsepop_output_aux (Uq.end_itlist (fun s t -> s^t) s_list) var_index


    let must_rescale optimum status = false
                                        (*
      not (List.for_all (fun y -> Nq.le_i (Nq.abs_i (Nq.sub_i (Nq.abs_i y) Nq.one_i)) tau ) optimum)
                                         *)

    let rescale optimum = 
      let scale y = if Nq.le_i (Nq.abs_i y) tau then tau else y in
      let next_scaling : num_i list =  List.map scale optimum in
        scaling_ref := List.map2 (fun i s -> Nq.mult_i i (fst s), Nq.mult_i i (snd s)) next_scaling !scaling_ref;()
                                                                                                                 (*
    let descale optimum = List.map2 (fun b i -> Nq.add_i (Nq.mult_i (snd b) i) (fst b) ) !scaling_ref optimum
                                                                                                                  *)
    let descale optimum = List.map2 (fun b i -> Nq.add_i (Nq.mult_i (Nq.sub_i (snd b) (fst b)) i) (fst b) ) !scaling_ref optimum

  let get_bound_poly_conj p cstr eqcstr cstr_major_min var_hashtbl bound_transc oc_in oc_out relax_order cliques rt =
    flush oc_out;
    let prefix_name = "sparsepop_" ^ Config.Config.ineq_name ^"_" in
    let input_s = Filename.temp_file ~temp_dir:Uq.tmp_dir prefix_name ".gms" in
    let output_s = gen_output_s input_s in 
    let input_file = open_out_gen [Open_creat; Open_trunc; Open_wronly] 0o666 input_s in
    let obj_norm, _, var_index = write_sparsepop_problem p cstr eqcstr cstr_major_min var_hashtbl bound_transc input_file output_s rt in
        close_out input_file;
        let cmd_param = param output_s relax_order cliques in
          output_string oc_out cmd_param; flush oc_out;
          let cmd = "sparsePOP('" ^ input_s ^ "',param);\n" in
            output_string oc_out cmd; flush oc_out;
            Uq.debug input_s;
            let final_cmd = "fprintf('$');\n" in
              output_string oc_out final_cmd; flush oc_out;
              let obj, objL, optimum, optimumL, status, scalE, relO = parse_sparsepop_output oc_in var_index in
              let m = if bound_transc then obj else (Nq.minus_i obj) in
              let mL = if bound_transc then objL else (Nq.minus_i objL) in
              let m, mL = Nq.mult_i m obj_norm,  Nq.mult_i mL obj_norm in
                Uq._pr_ (Printf.sprintf "%s: sdpmin = %e for sdpx0 = %s localmin = %e" input_s (Nq.float_of_num m) (Iq.string_of_list_i optimum) (Nq.float_of_num mL)) true verb;
                Uq._pr_ (Printf.sprintf "status = %s for scaledError = %e" status (Nq.float_of_num  scalE)) true verb;
                Uq._pr_ (Printf.sprintf "sdpmin = %e for sdpx0 = %s" (Nq.float_of_num m) (Iq.string_of_list_i optimum)) false verb;
                flush oc_out;
                m, mL, optimum, optimumL, relO

    let coq_sage_tmp_dir = Config.Config.coq_sage_tmp_dir

    let rec check_certif_coq m p cstr cstr_major_min var_hashtbl bound_transc rt relax_order = 
      let input_sage_s = Filename.temp_file ~temp_dir:coq_sage_tmp_dir (Config.Config.ineq_name ^ "_") ".sage" in
      let sage_input_file =  open_out_gen [Open_creat; Open_trunc; Open_wronly] 0o666 input_sage_s in          
      let coq_file =  Filename.temp_file ~temp_dir:coq_sage_tmp_dir ("ineq" ^ Config.Config.ineq_name ^ "_") ".v" in
      let acc = 2 in
        debug (Nq.string_of_i m);
        let m = if bound_transc then Nq.lower_bound m acc else  Nq.upper_bound m acc in
          debug (Nq.string_of_i m);
          let rhs_fw_pol = if bound_transc then Fu.fw_addC (Nq.minus_i m) p else Fu.fw_minus  (Fu.fw_addC (Nq.minus_i m) p) in
          let _ = write_dm_psatz_problem rhs_fw_pol cstr cstr_major_min var_hashtbl bound_transc sage_input_file coq_file rt relax_order in
            close_out sage_input_file;
            let pwd = Sys.getcwd () in
              Sys.chdir dm_psatz_path;
              let sage_time_start = Unix.gettimeofday () in 
              let sage_cmd = "sage " ^ input_sage_s ^ " > /dev/null" in
              let _ = Sys.command sage_cmd in
              let str_sage = Uq.string_of_file "sage_out" in
                debug (Printf.sprintf "relax order: %i" relax_order);
              let m = if (not (str_sage = "SUCCESS")) then 
                (if Nq.eq_i m Nq.zero_i then (debug "Projection failed!";Nq.minus_i Nq.infty)
                 else check_certif_coq m p cstr cstr_major_min var_hashtbl bound_transc rt relax_order)  
              else (debug "Projection succeeded!"; m) in                
              let coq_time_start = Unix.gettimeofday () in 
              let coq_cmd = "coqc " ^ coq_file in
              let _ = Sys.command coq_cmd in
                debug "coq proof done";
                let coq_time_end = Unix.gettimeofday () in 
                let final_mess = Printf.sprintf "Sage Time: %f Coq time: %f" (coq_time_end -. coq_time_start) (coq_time_start -. sage_time_start) in
                  Uq._pr_ final_mess true true;
                Sys.chdir pwd;
                m

    let relax_and_solve_pop p cstr eqcstr var_hashtbl bound_transc rt is_L1 relax_order is_top_level_bound (*:  num_i * num_i * num_i list * num_i list * num_i * pol *) =
      let n_total, pol, ineqs, eqs, box, n = relax_pop p cstr eqcstr var_hashtbl bound_transc rt in
        debug (Printf.sprintf "Box: %s" (Uq.string_of_tuple_list box));

      let n_total', pol, ineqs, eqs, n', vars = change_variables n_total pol ineqs eqs n in

      let module N =  (val (Numeric.of_string ("float")): Numeric.T) in
      let module U = Tutils.Make (N) in
      let module Fun = Functions.Make (N) in
      let module I = Interval.Make (N)(Fun)(U) in
      let module P = Polynomial.Make (N)(U)(I) in 
      let module M = Mesh_interval.Make (N)(U)(I) in
      let module Mq = Mesh_interval.Make (Nq)(Uq)(Iq) in
      let module Sdp = Sdp_aux.Make (N)(U)(M) in
      let module Convert = Floatrat.Make (N)(I)(P)(Nq)(Iq)(Pq) in
      let module Sos = Sos.Make (N)(U)(M)(I)(P) (Nq)(Uq)(Mq)(Iq)(Pq)(Sdp) in
      let float_to_num_box = Convert.float_to_num_box in
                
      let _, _, opt, optL, rel0, pol_L1, mu_rat, c = Sos.solve_pop n_total' pol ineqs eqs box is_L1 relax_order is_top_level_bound in
        
      let mu_rat = if bound_transc then mu_rat else (Nq.minus_i mu_rat) in
      let pol_L1 = if bound_transc then pol_L1 else (Pq.popp pol_L1) in
      let opt, optL = List.map float_to_num_box opt, List.map float_to_num_box optL in
      let opt = Sos.rescale_optimum opt box in
      let optL = Sos.rescale_optimum optL box in

      let zero = Nq.zero_i in
      let opt, optL = change_variables_opt opt optL vars zero n_total in
      let opt = Uq.sub_list opt 0 (n - 1) in
      let optL = Uq.sub_list opt 0 (n - 1) in

        (* Previously with floating points: m, mL, opt, optL, rel0, pol_L1 *)
        mu_rat, mu_rat, opt, optL, Nq.zero_i (* rel0*), pol_L1, c


  let rec get_bound_poly_conj_sparsepopcpp p cstr eqcstr cstr_major_min var_hashtbl bound_transc oc_in oc_out relax_order cliques rt is_top_level_bound =
    let p0 = Pq.Pc Nq.zero_i in
    let prefix_name = "sparsepop_" ^ Config.Config.ineq_name ^ "_" in
    let input_s = Filename.temp_file ~temp_dir:Uq.tmp_dir prefix_name ".gms" in
    let output_s = gen_output_s input_s in
    let param_pop_s = Uq.pwd ^ "/param.pop" in
      let param_pop_content = gen_param_pop relax_order cliques in 
      let param_pop_file = open_out_gen [Open_creat; Open_trunc; Open_wronly] 0o666 param_pop_s in
        Printf.fprintf param_pop_file "%s\n" param_pop_content;
        let input_file = open_out_gen [Open_creat; Open_trunc; Open_wronly] 0o666 input_s in
        let obj_norm, n_box, var_index = write_sparsepop_problem p cstr eqcstr cstr_major_min var_hashtbl bound_transc input_file output_s rt in          
          close_out input_file; close_out param_pop_file;
            let cmd = "sparsePOP " ^ input_s ^ " > " ^ output_s in 
              Uq._pr_ input_s true false;
              let _ = Sys.command cmd in
              let obj, objL, optimum, optimumL, status, scalE, relO = parse_sparsepop_output_aux output_s var_index in
              let m = if bound_transc then obj else (Nq.minus_i obj) in
              let mL = if bound_transc then objL else (Nq.minus_i objL) in
              let m, mL = Nq.mult_i m obj_norm,  Nq.mult_i mL obj_norm in
                Uq.debug (Printf.sprintf "%s sdpmin = %.4e for sdpx0 = %s, localmin = %e" input_s (Nq.float_of_num m) (Iq.string_of_list_i optimum) (Nq.float_of_num mL));
                Uq._pr_ (Printf.sprintf "status = %s for scaledError = %e" status (Nq.float_of_num scalE)) false false;
                Uq._pr_ (Printf.sprintf "%s status = %s relObjError = %e scaledError = %e sdpmin = %e for sdpx0 = %s" input_s  status (Nq.float_of_num relO) (Nq.float_of_num scalE) (Nq.float_of_num m) (Iq.string_of_list_i optimum)) true true;
                flush oc_out;
                let m, mL, opt, optL, relO, p0, c = 
                  if must_rescale optimum status then 
                    begin
                      rescale optimum;
                      Uq._pr_ (Printf.sprintf "%s status = %s scaledError = %e sdpmin = %e for sdpx0 = %s" input_s status (Nq.float_of_num scalE) (Nq.float_of_num m) (Iq.string_of_list_i optimum)) false false;
                      get_bound_poly_conj_sparsepopcpp p cstr eqcstr cstr_major_min var_hashtbl bound_transc oc_in oc_out relax_order cliques rt is_top_level_bound
                    end
                  else m, mL, Uq.sub_list (descale optimum) 0 (n_box - 1) , Uq.sub_list (descale optimum) 0 (n_box - 1), relO, p0, Pq.cert_pop_null
                in
                  Uq._pr_ (Printf.sprintf "%s status = %s scaledError = %e sdpmin = %e for sdpx0 = %s" input_s status (Nq.float_of_num scalE) (Nq.float_of_num m) (Iq.string_of_list_i opt)) true verb;
                  let _ = if Config.Config.erase_sparsepop_files then Sys.command ("rm -f " ^ input_s ^ " " ^ output_s) else 0 in
(* we check psatz certificates first by calling the sos solver of David Monniaux
 * and then by normalizing in Coq with the field tactic, the value of m can be decreased *)
                  let m = if Config.Config.check_certif_coq && is_top_level_bound && Nq.ge_i m Nq.zero_i then
                    check_certif_coq Nq.zero_i p cstr cstr_major_min var_hashtbl bound_transc rt relax_order 
                  else if Config.Config.check_certif_coq && (not is_top_level_bound) then
                    check_certif_coq m p cstr cstr_major_min var_hashtbl bound_transc rt relax_order
                  else m in
                    m, mL, opt, optL, relO, p0, Pq.cert_pop_null 

    let get_bound_poly incr_cliques incr_relax_order p cstr eqcstr cstr_major_min var_hashtbl bound_transc oc_in oc_out relax_order cliques rt is_top_level_bound is_L1 =
      debug (" Computing " ^ (if bound_transc then "lower" else "upper") ^ " bound of " ^ (Fu.string_fw prec p));
      scaling_ref := [];first_solve_sdp := true;
      (*
       let identity_scaling =  Uq.init_list ( Hashtbl.length var_hashtbl + L.(!nvars)) Nq.one_i in
     *)
      let get_bound relax_order cliques p = if Config.Config.use_mypop then relax_and_solve_pop p cstr eqcstr var_hashtbl bound_transc rt is_L1 relax_order is_top_level_bound else get_bound_poly_conj_sparsepopcpp p cstr eqcstr cstr_major_min var_hashtbl bound_transc oc_in oc_out relax_order cliques rt is_top_level_bound in
        add_bounds := Config.Config.bound_squares_variables;
        let rec f relax_order cliques p = 
(*          let relax_order = if is_top_level_bound (*|| is_L1*) then 2 else relax_order in*)
          let m, mL, opt, optL, relO, pol_L1, c =  get_bound relax_order cliques p in
           debug ("  Lower Bound with SOS of degree at most " ^ string_of_int (2 * relax_order) ^ " = " ^ Nq.string_of_i_coq m);

          if (Nq.ge_i relO (Nq.num_of_float Config.Config.relative_obj_tol) && relax_order < 3 && (not !add_bounds)) then
            begin
              let mess =  Printf.sprintf "Adding bounds to square variables because relative obj error too high: %s" (Nq.string_of_i relO) in
                Uq._pr_ mess true true; add_bounds := true;
                f relax_order 1 p
            end
          else if (Nq.ge_i relO (Nq.num_of_float Config.Config.relative_obj_tol) && relax_order < 2 && !add_bounds) then
            begin
              let mess =  Printf.sprintf "Increasing relax order to %i because relative obj error too high: %s" (relax_order + 1) (Nq.string_of_i relO) in
                Uq._pr_ mess true true;
                f (relax_order + 1) 1 p
            end
          else if (not incr_relax_order && Nq.sgn_i m = Nq.sgn_i mL && relax_order = 2 && cliques = 2)
          then m, mL, opt, optL, pol_L1, c
          else if (Nq.sgn_i m <> Nq.sgn_i mL (*&&  Nq.le_i m Nq.zero_i*) && incr_cliques && relax_order = 2 && cliques = 1)
          then
            begin 
              Uq._pr_ ("cliquesNumber increased: " ^ string_of_int (cliques + 1)) true true;
              f relax_order (cliques + 1) p
            end
          else m, mL, opt, optL, pol_L1, c in
        f relax_order cliques p 
     

(*          
      else if (incr_relax_order && Nq.le_i m Nq.zero_i  && Nq.le_i mL Nq.zero_i && relax_order = 2 && cliques = 2)
      then
        begin 
         Uq. _pr_ ("relaxOrder increased: " ^ string_of_int (relax_order + 1)) true true;
          let m, mL, opt, optL = get_bound_poly incr_cliques incr_relax_order p cstr cstr_major_min var_hashtbl bound_transc oc_in oc_out (relax_order + 1) 1 rt in
            m, mL, opt, optL
        end
 *)


 (* 
  Oracle.get_bound_poly get_bound_poly_conj p var_hashtbl bound_transc oc_out relax_order
  *)
end
