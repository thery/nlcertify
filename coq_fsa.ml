module Make
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (M: Mesh_interval.T with type num_i = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval)
  (Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval)
  = struct
   (* certificate built with the remainder, the lambda list and the Putinar certificate *)             
    let debug s = if Config.Config.coq_verb  then U.debug s else ()

    let pos = Numbers.T.Translation.positive
    let ntoint = Numbers.T.Translation.n
    let to_string_coq = N.string_of_i_coq
    let rec string_of_pexpr_ast : P.pExpr -> string = function      
      | P.PEc c -> Printf.sprintf "PEc (%s)" (to_string_coq c)
      | P.PEX i -> Printf.sprintf "PEX %i" (pos i)  
      | P.PEadd (p1, p2) -> Printf.sprintf "PEadd (%s) (%s)" (string_of_pexpr_ast p1) (string_of_pexpr_ast p2) 
      | P.PEsub (p1, p2) -> Printf.sprintf "PEsub (%s) (%s)" (string_of_pexpr_ast p1) (string_of_pexpr_ast p2) 
      | P.PEmul (p1, P.PEc c) | P.PEmul (P.PEc c, p1)   when N.eq_i c N.one_i -> Printf.sprintf "(%s)" (string_of_pexpr_ast p1)
      | P.PEmul (p1, p2) -> Printf.sprintf "PEmul (%s) (%s)" (string_of_pexpr_ast p1) (string_of_pexpr_ast p2) 
      | P.PEopp p ->  Printf.sprintf "PEopp (%s)" (string_of_pexpr_ast p) 
      | P.PEpow (p, n) when (ntoint n) = 1 -> Printf.sprintf "(%s)" (string_of_pexpr_ast p)
      | P.PEpow (p, n) -> Printf.sprintf "PEpow (%s) %i" (string_of_pexpr_ast p) (ntoint n)

    let rec string_of_pexpr = function      
      | P.PEc c -> Printf.sprintf "opaque_IQR (%s)" (to_string_coq c)
      | P.PEX i -> Printf.sprintf "x%i" (pos i)  
      | P.PEadd (p1, p2) -> Printf.sprintf "(%s) + (%s)" (string_of_pexpr p1) (string_of_pexpr p2) 
      | P.PEsub (p1, p2) -> Printf.sprintf "(%s) - (%s)" (string_of_pexpr p1) (string_of_pexpr p2) 
      | P.PEmul (p1, p2) -> Printf.sprintf "(%s) * (%s)" (string_of_pexpr p1) (string_of_pexpr p2) 
      | P.PEopp p ->  Printf.sprintf "- (%s)" (string_of_pexpr p) 
      | P.PEpow (p, n) -> let i = ntoint n in (if i = 1 then Printf.sprintf "%s" (string_of_pexpr p)  else Printf.sprintf "%s^ %i" (string_of_pexpr p) i)

    let rec string_of_pol_ast = function
      | P.Pc c -> Printf.sprintf "Pc (%s)" (to_string_coq c)
      | P.Pinj (i, p) -> Printf.sprintf "Pinj %i (%s)" (pos i)  (string_of_pol_ast p) 
      | P.PX (p, i, q) -> Printf.sprintf "PX (%s) %i (%s)" (string_of_pol_ast p) (pos i) (string_of_pol_ast q)

    let rec size_of_pol_ast = function
      | P.Pc c -> N.size_i c
      | P.Pinj (i, p) -> size_of_pol_ast p
      | P.PX (p, i, q) -> size_of_pol_ast p + size_of_pol_ast q

    let str_of_sos_block_certif eigenvalues = function
      | P.Sos_block (lambda_idx, pol) when N.eq_i N.zero_i (eigenvalues. (lambda_idx))-> Printf.sprintf "P0"      
      | P.Sos_block (lambda_idx, pol) ->  Printf.sprintf  "pmulC (psquare (%s)) (%s)" (string_of_pol_ast pol) (to_string_coq (eigenvalues. (lambda_idx))) 

   let fold_left_psatz f acc m = 
      if M.size m = 0 then acc else
        begin
          let res = ref acc in
            for i = 0 to M.size m - 2 do
              res := !res ^ (f m. (i)) ^ " ++ (";
            done;
            !res ^ f (m. (M.size m - 1)) ^ U.concat_string (U.init_list (M.size m - 1 ) ")")
        end


    let str_of_kkt_certif eigenvalues = function
      | P.Sos sos_block_array -> fold_left_psatz (str_of_sos_block_certif eigenvalues) "" sos_block_array
      | P.Eq_coeff pol | P.L1 pol -> P.string_of_pol pol

   let str_of_putinar_psatz_certif eigenvalues ineqs eqs = function 
      | P.Putinar_psatz kkt_ineq_array -> fold_left_psatz (fun (kkt, idx) -> (
          let pol = match kkt with | P.Sos _ -> ineqs. (idx) | P.Eq_coeff _ ->  eqs. (idx) | P.L1 _ -> P.Pc (N.one_i) in
            Printf.sprintf "pmul (%s) (%s)" (str_of_kkt_certif eigenvalues kkt) (string_of_pol_ast pol))) "" kkt_ineq_array

    let str_of_ssreflect_pos i = string_of_int (i + 1) ^ "%positive"

    let str_of_sos_block = function
      | P.Sos_block (lambda_idx,  pol) -> "(" ^ string_of_int lambda_idx ^ ", " ^ (string_of_pol_ast pol) ^ ")"
    let str_of_kkt = function
      | P.Sos sos_block_array -> M.string_of_array_ssreflect_seq sos_block_array str_of_sos_block
      | P.Eq_coeff pol | P.L1 pol -> "" (*TODO*)

    let str_of_putinar_psatz n = function
      | P.Putinar_psatz kkt_ineq_array -> 
          let str_of_summand (pol, ineq_idx) = 
            let ineq_idx_lift = if ineq_idx >= 2 * n + 1 && not Config.Config.bound_squares_variables then ineq_idx + n else ineq_idx in
            "(" ^ (str_of_kkt pol) ^ ", " ^ (string_of_int ineq_idx_lift) ^ ")" in 
            M.string_of_array_ssreflect_seq kkt_ineq_array str_of_summand

    let size_of_sos_block = function
      | P.Sos_block (_,  pol) -> size_of_pol_ast pol

    let size_of_kkt = function
      | P.Sos sos_block_array -> M.add_array_int (Array.map size_of_sos_block sos_block_array)
      | P.Eq_coeff pol | P.L1 pol -> 0 (*TODO*)

    let size_of_putinar_psatz = function
      | P.Putinar_psatz kkt_ineq_array -> 
          let size_of_summand (kkt, _) = size_of_kkt kkt in
            M.add_array_int (Array.map size_of_summand kkt_ineq_array)


    let str_of_pqarray str a = 
      let s =  ref ("Definition " ^ str ^ " : seq PExpr := [::") in
      let l = Array.length a in
        for i = 0 to l - 2 do
          let ai = a. (i) in
            s := !s ^ (Printf.sprintf "%s;" (string_of_pexpr_ast (P.denorm ai)));
        done;
        if l = 0 then !s ^"].\n" else !s ^ (Printf.sprintf "%s].\n" (string_of_pexpr_ast (P.denorm ((a. (l - 1))) )))

    let remove_sqrbounds ineqs_box = 
      if Config.Config.bound_squares_variables then Array.sub ineqs_box 0 (Array.length ineqs_box * 2 / 3) else ineqs_box


    let str_of_coq_eig_pos eigenvalues = 
      let s = ref "[::" in
      let l = Array.length eigenvalues in
        for i = 0 to l - 2 do
          let eig = eigenvalues. (i) in
            s := !s ^ (Printf.sprintf "%s;" (to_string_coq eig) );
        done; 
        !s ^ (Printf.sprintf "%s]" (to_string_coq (eigenvalues. (l - 1))) ) 

               (* This does not include sqr_bnds_ineqs *)
    let str_of_coq_bnds bnds = str_of_pqarray "bnds" bnds
    let str_of_coq_hyps hyps = str_of_pqarray "hyps" hyps

    (* Actually used in the framework *)
    let write_coq_data coq_data : unit =
      let prefix_name = "ineq_" ^ Config.Config.ineq_name in
      let input_s = Filename.temp_file ~temp_dir:U.tmp_dir prefix_name ".v" in
      let _ = if Config.Config.check_certif_coq then debug input_s else () in
        let input_file = open_out_gen [Open_creat; Open_trunc; Open_wronly] 0o666 input_s in
          Printf.fprintf input_file "%s" coq_data;
          close_out input_file;
          let show_output = if Config.Config.coq_verb then "" else " > /dev/null" in
          let cmd = "cd coq; coqc " ^ input_s ^ show_output ^ "; cd .." in
          let _ = if Config.Config.check_certif_coq then Sys.command cmd else 0 in
          let _ = if Config.Config.erase_coq_files then Sys.command ("rm -f " ^ input_s) else 0 in
            ()

    let norm_box n = U.init_list n (N.zero_i, N.one_i)

    let ineqs_box vars box : P.pol array = 
      let ineqs_tuple var bound = 
        let lo, up = bound in
        let lo, up = P.Pc lo, P.Pc up in
        let x = P.mk_X var in
         [P.p_sub x lo; P.p_sub up x]
      in
      Array.of_list (List.concat (List.map2 ineqs_tuple vars box))

    let mk_bnds vars box = 
      let n = List.length box in
      let box = if Config.Config.scale_pol then (norm_box n) else box in
        ineqs_box vars box

    let str_coq_cert_pop (c : P.cert_pop) n : string = 
      match c with 
        | P.Cert_pop (r, eigs, sos) -> 
            Printf.sprintf "mk_cert_pop (%s) (%s) (%s)"
            (string_of_pol_ast r) (str_of_coq_eig_pos eigs) (str_of_putinar_psatz n sos)


    let str_itv = function
      | I.Int (a, b) -> Printf.sprintf "Itv %s %s" (to_string_coq a) (to_string_coq b)
      | I.Void_i -> failwith "cannot handle void interval inside Coq"

    let str_coq_cert_itv (c : P.cert_itv) n = "(" ^ str_coq_cert_pop (fst c) n ^ ", " ^ str_coq_cert_pop (snd c) n ^ ")"

    let size_cert_pop (c : P.cert_pop) : int = 
      match c with 
        | P.Cert_pop (r, _, sos) -> size_of_pol_ast r + size_of_putinar_psatz sos

    let size_cert_itv (c : P.cert_itv) = size_cert_pop (fst c) + size_cert_pop (snd c)

    let scale_pol vars box p : P.pol = 
      let n = List.length vars in
      let fixed = [] in
      let tbl_scaling_list = List.combine vars box in
      let tbl_scaling = Hashtbl.create n in
        U.add_list_table tbl_scaling tbl_scaling_list;
       if Config.Config.scale_pol then fst (P.scale_pol tbl_scaling fixed p true) else p

    let str_poly p i c n =  let _ = if Config.Config.check_certif_coq_pop then debug (P.string_of_pol_zarith p) else () in Printf.sprintf "Poly (%s) (%s) (%s)" (string_of_pexpr_ast (P.denorm p)) (str_itv i) (str_coq_cert_itv c n)
    let str_poly_verb p i c idx n = let _ = if Config.Config.check_certif_coq_fsa then debug (P.string_of_pol_zarith p) else () in Printf.sprintf "Definition p%s := %s.\nDefinition i%s := %s.\nDefinition cert%s := %s.\nDefinition pe%s:= Poly p%s i%s cert%s.\n" idx (string_of_pexpr_ast (P.denorm p)) idx (str_itv i) idx (str_coq_cert_itv c n) idx idx idx idx

    let div_itv f1 f2 = I.div_I (Fu.ifw f1) (Fu.ifw f2)

    let rec str_fsa vars box n = function 
      | P.Fw (( P.Pw (p1, i1, c1)  , P.Sqrt (P.Pw (p2, i2, c2), isqrt )), i, c) -> str_poly_verb (scale_pol vars box p1) i1 c1 "1" n ^ str_poly_verb (scale_pol vars box p2) i2 c2 "2" n ^ Printf.sprintf "Definition certpop1 := %s.\n Definition certpop2 := %s.\n" (str_coq_cert_pop (fst c) n) (str_coq_cert_pop (snd c) n) ^ Printf.sprintf "Definition isqrt := %s.\nDefinition idiv := %s.\nDefinition isos := %s.\n" (str_itv isqrt) (str_itv (I.div_I i1 isqrt)) (str_itv i) ^ "Definition fe := Fdiv pe1 (Fsqrt pe2 isqrt) idiv isos (certpop1, certpop2).\n"
(*
      | P.Fw (( P.Pw (p1, i1, c1)  , P.Pw (p2, i2, c2)), i, c) -> str_poly_verb (P.denorm (scale_pol vars box p1)) i1 c1 "1" ^ str_poly_verb (P.denorm (scale_pol vars box p2)) i2 c2 "2" ^ Printf.sprintf "Definition certpop1 := %s.\n Definition certpop2 := %s.\n" (str_coq_cert_pop (fst c)) (str_coq_cert_pop (snd c)) ^ Printf.sprintf "Definition f := Fdiv pe1 pe2 (%s) (%s) (certpop1, certpop2).\n" (str_itv (I.div_I i1 i2)) (str_itv i)
 *)
      | P.Pw (p, i, c) ->  str_poly (scale_pol vars box p) i c n
      | P.Fw ((f1, f2), i, c) ->  Printf.sprintf "Fdiv (%s) (%s) (%s) (%s) (%s)" (str_fsa vars box n f1) (str_fsa vars box n f2) (str_itv (div_itv f1 f2)) (str_itv i) (str_coq_cert_itv c n)
      | P.Plus ((p1, p2), i, c) | P.Mult ((p1, p2), i, c) ->  ""
      | P.Minus (p, i) ->  ""
      | P.Sqrt (f, i) -> Printf.sprintf "Fsqrt (%s) (%s)" (str_fsa vars box n f) (str_itv i)
      | P.Max (fw_l, i, _) | P.Min (fw_l, i, _) -> failwith "cannot handle Max/Min with Coq"
      | P.MaxMin ((f1, f2), i, _) -> failwith "cannot handle MaxMin with Coq"
      | P.Comp ((a, p), i, _) -> failwith "cannot handle Comp with Coq"

    let rec size_cert_fsa = function 
      | P.Fw (( P.Pw (p1, i1, c1)  , P.Sqrt (P.Pw (p2, i2, c2), isqrt )), i, c) -> size_cert_itv c1 + size_cert_itv c2 + size_cert_itv c
      | P.Pw (p, i, c) ->  size_cert_itv c
      | P.Fw ((f1, f2), i, c) -> size_cert_fsa f1 + size_cert_fsa f2 + size_cert_itv c
      | P.Plus ((p1, p2), i, c) | P.Mult ((p1, p2), i, c) ->  0
      | P.Minus (p, i) ->  0
      | P.Sqrt (f, i) -> size_cert_fsa f
      | P.Max (fw_l, i, _) | P.Min (fw_l, i, _) -> failwith "cannot handle Max/Min with Coq"
      | P.MaxMin ((f1, f2), i, _) -> failwith "cannot handle MaxMin with Coq"
      | P.Comp ((a, p), i, _) -> failwith "cannot handle Comp with Coq"

    let test_checker_fsa n = 
      Printf.sprintf "Time Eval vm_compute in checker_fsa_itv bnds [::] f (%i" n ^ "%positive) true.\n"

    let str_checker_itv vars bounds (f : P.fw_pol) interval idx =
      let bnds : P.pol array = mk_bnds vars bounds in
      let n = List.length vars in
      let str_ineqs_bnds = str_of_coq_bnds bnds in
      let prelude = "Require Import sos_horner remainder fsa.\nRequire Export BigQ.\nNotation \"n # d\" := (n # d)%bigQ.\nDefinition PEX := sos_horner.PEX bigQ.\nRequire Import seq.\n" in
        Printf.sprintf "%s%sDefinition obj_itv := %s.\n%s"
          prelude str_ineqs_bnds 
          (str_itv interval)
          (str_fsa vars bounds n f)
          (*
          (string_of_pexpr_ast (P.denorm pol)) 
           (str_coq_cert_itv c idx)
           *)
          (*
let comment = Printf.sprintf "(* Check the SOS decomposition of %s *)\n" (P.string_of_pol (P.psubC pol obj_min_norm)) in
Definition obj0 := PEsub obj (PEc obj_bound).\n
Time Eval vm_compute in checker_pop bnds hyps obj0 cert%i.\n
           *)

    let str_checker_pol vars bounds hyps (obj : P.pol) mu_rat c =
      let bnds : P.pol array = mk_bnds vars bounds in
      let n = List.length vars in
      let str_ineqs_bnds = str_of_coq_bnds bnds in
      let str_ineqs_hyps = str_of_coq_hyps hyps in
         let _ = if Config.Config.check_certif_coq then debug ("Proving non-negativity of " ^ P.string_of_pol_zarith obj ^ " inside Coq") else () in

      let prelude = if Config.Config.coeff_type = "zarith" then
        "Require Import sos_horner remainder fsa.\nRequire Export BigQ.\nNotation \"n # d\" := (n # d)%bigQ.\nDefinition PEX := sos_horner.PEX bigQ.\nRequire Import seq.\n" 
      else "Require Import sos_horner Fremainder Ffsa Interval_float_sig Interval_generic Interval_xreal Interval_definitions seq.\nDefinition cO := Ifr.cO.\nReserved Notation \"m # e\" (at level 70, no associativity).\nNotation \"m # e\" := (Float Ifr.beta false m e).\nReserved Notation \"- m ## e\" (at level 70, no associativity).\nNotation \"- m ## e\" := (Float Ifr.beta true m e).\n"
      in
        Printf.sprintf "%s%s%sDefinition obj := %s.\nDefinition obj_bound := %s.\nDefinition obj0 := PEsub obj (PEc obj_bound).\nDefinition cert := %s.\nTime Eval vm_compute in checker_pop bnds hyps obj0 cert."
          prelude str_ineqs_bnds str_ineqs_hyps
          (string_of_pexpr_ast (P.denorm obj))
          (to_string_coq mu_rat)
            (str_coq_cert_pop c n)
           
          (*
let comment = Printf.sprintf "(* Check the SOS decomposition of %s *)\n" (P.string_of_pol (P.psubC pol obj_min_norm)) in
Definition obj0 := PEsub obj (PEc obj_bound).\n
Time Eval vm_compute in checker_pop bnds hyps obj0 cert%i.\n
           *)

    let check_pop vars bounds hyps obj mu_rat c  : unit = 
      let coq_data =  str_checker_pol vars bounds hyps obj mu_rat c in
        write_coq_data coq_data; ()

    let check_fsa vars bounds f interval : unit = 
      let coq_data =  str_checker_itv vars bounds f interval 0 in
      let str_bench = test_checker_fsa (List.length vars) in
        write_coq_data (coq_data ^ str_bench); ()
  end
