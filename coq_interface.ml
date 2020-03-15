module type T = sig
  type positive
  type num_i
  type numq
  type polf
  type polq
  type pexprq
  type cert_pop
  val mk_coq_cert :  polq -> polq list -> polq list -> polq list ->  numq list -> numq list -> (num_i array * num_i array array) array -> ((int list) array array) array -> num_i array array -> ((int list) array array) array -> num_i -> numq -> int array -> bool -> string -> (polq list) * pexprq * polq * numq * cert_pop
end

module Make
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (M: Mesh_interval.T with type num_i = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval)
  (Nq: Numeric.T) 
  (Uq: Tutils.T with type t = Nq.t) 
  (Mq: Mesh_interval.T with type num_i = Nq.t) 
  (Iq: Interval.T with type num_i = Nq.t) 
  (Pq: Polynomial.T with type num_i = Nq.t and type interval = Iq.interval)
  = struct

    (* the int of sos_block is the eigenvalue index of the sdp matrix
     * the pol is the inner product betoween the monomials support and the eigenvector of the sdp matrix *)
    type num_i = N.t type numq = Nq.t
    type polf = P.pol type polq = Pq.pol type pexprq = Pq.pExpr
    type positive = P.positive
    type cert_pop = Pq.cert_pop type cert_itv = Pq.cert_itv
    (* the int is the index of the ineq or eq constraint, the kkt being the multiplier of this constraint in the positivity certificate *)

    let debug s = if Config.Config.sos_verb then U.debug s else ()
    let num_of_numq = let module Convert = Floatrat.Make (N)(I)(P)(Nq)(Iq)(Pq) in Convert.num_of_numq 
    let pol_float_to_num = let module Convert = Floatrat.Make (N)(I)(P)(Nq)(Iq)(Pq) in
       Convert.pol_float_to_num Convert.float_to_num_box 

    let block_eigs_float_to_num, array_float_to_num, float_to_num = let module Convert = Floatrat.Make (N)(I)(P)(Nq)(Iq)(Pq) in
 Convert.block_eigs_float_to_num, Convert.array_float_to_num, Convert.float_to_num 

    let pol_of_sos_block eigenvalues = function
      | Pq.Sos_block (lambda_idx, pol) -> let res = Pq.p_mulC (Pq.p_square pol) (eigenvalues. (lambda_idx)) in debug (Printf.sprintf " pol_of_sos_block: %s\n" (Pq.string_of_pol (Pq.p_square  pol )));  res

    let pol_of_kkt eigenvalues : Pq.kkt -> Pq.pol = function
      | Pq.Sos sos_block_array -> let res = Array.fold_left (fun acc sos_block -> Pq.p_add acc (pol_of_sos_block eigenvalues sos_block))  (Pq.Pc Nq.zero_i) sos_block_array in (*debug (Printf.sprintf "pol_of_kkt: %s\n" (Pq.string_of_pol res));*) res
      | Pq.Eq_coeff pol -> pol
      | Pq.L1 pol -> pol

    let pol_of_putinar_psatz eigenvalues ineqs = function 
      | Pq.Putinar_psatz kkt_ineq_array -> Array.fold_left (fun acc (pol, ineq_idx) -> Pq.p_add acc (Pq.p_mul (ineqs. (ineq_idx)) (pol_of_kkt eigenvalues pol))) (Pq.Pc Nq.zero_i) kkt_ineq_array

(*                                          
    let str_of_sos_block_certif eigenvalues = function
      | Sos_block (lambda_idx, pol) when Nq.eq_i Nq.zero_i (eigenvalues. (lambda_idx))-> Printf.sprintf "0"      
      | Sos_block (lambda_idx, pol) -> Printf.sprintf (*"%s * (%s)^2"*) "%s * (%s) * (%s)" (Nq.string_of_i (eigenvalues. (lambda_idx))) (Pq.string_of_pol pol) (Pq.string_of_pol pol)
 *)
    let pol_to_float =  let module Convert = Floatrat.Make (N)(I)(P)(Nq)(Iq)(Pq) in
      Convert.pol_to_float

    let str_of_sos_block_float eigenvalues = function
      | Pq.Sos_block (lambda_idx, pol) when Nq.eq_i Nq.zero_i (eigenvalues. (lambda_idx))-> Printf.sprintf "0"      
      | Pq.Sos_block (lambda_idx, pol) ->  Printf.sprintf  "%s * (%s)^2"  (N.string_of_i (num_of_numq (eigenvalues. (lambda_idx)))) (P.string_of_pol (pol_to_float pol))

 
   let fold_left_psatz f acc m = 
      if Mq.size m = 0 then acc else
        begin
          let res = ref acc in
            for i = 0 to Mq.size m - 2 do
              res := !res ^ (f m. (i)) ^ " ++ (";
            done;
            !res ^ f (m. (Mq.size m - 1)) ^ Uq.concat_string (Uq.init_list (Mq.size m - 1 ) ")")
        end

    let str_of_kkt_float eigenvalues = function
      | Pq.Sos sos_block_array -> fold_left_psatz (str_of_sos_block_float eigenvalues) "" sos_block_array
      | Pq.Eq_coeff pol | Pq.L1 pol -> P.string_of_pol (pol_to_float pol)

(*
    (* ineqs_eqs = Array.append ineqs eqs *)
    let str_of_putinar_psatz_certif eigenvalues ineqs eqs = function 
      | Putinar_psatz kkt_ineq_array -> fold_left_psatz (fun (kkt, idx) -> (
          let pol = match kkt with | Sos _ -> ineqs. (idx) | Eq_coeff _ -> eqs. (idx) in
          Printf.sprintf "(%s) * (%s)" (str_of_kkt_certif eigenvalues kkt) (Pq.string_of_pol pol))) "" kkt_ineq_array
 *)
     let str_of_putinar_psatz_float eigenvalues ineqs eqs = function 
      | Pq.Putinar_psatz kkt_ineq_array -> fold_left_psatz (fun (kkt, idx) -> (
          let pol = match kkt with | Pq.Sos _ -> ineqs. (idx) | Pq.Eq_coeff _ ->  eqs. (idx) | Pq.L1 _ -> Pq.Pc (Nq.one_i) in
            Printf.sprintf "(%s) * (%s)" (str_of_kkt_float eigenvalues kkt) (P.string_of_pol (pol_to_float pol)))) "" kkt_ineq_array

    let str_of_ssreflect_pos i = string_of_int (i + 1) ^ "%positive"

    let rec string_of_pol_ast = function
      | Pq.Pc c -> Printf.sprintf "Pc (%s)" (Nq.string_of_i c)
      | Pq.Pinj (i, p) -> Printf.sprintf "Pinj %i (%s)" (Numbers.T.Translation.positive i)  (string_of_pol_ast p) 
      | Pq.PX (p, i, q) -> Printf.sprintf "PX (%s) %i (%s)" (string_of_pol_ast p) (Numbers.T.Translation.positive i) (string_of_pol_ast q)


    let str_of_sos_block = function
      | Pq.Sos_block (lambda_idx,  pol) -> "(" ^ string_of_int lambda_idx ^ ", " ^ (string_of_pol_ast pol) ^ ")"
    let str_of_kkt = function
      | Pq.Sos sos_block_array -> Mq.string_of_array_ssreflect_seq sos_block_array str_of_sos_block
      | Pq.Eq_coeff pol | Pq.L1 pol -> "" (*TODO*)

    let str_of_putinar_psatz = function
      | Pq.Putinar_psatz kkt_ineq_array -> let str_of_summand (pol, ineq_idx) = "(" ^ (str_of_kkt pol) ^ ", " ^  (*str_of_ssreflect_pos*) (string_of_int ineq_idx) ^ ")" in Mq.string_of_array_ssreflect_seq kkt_ineq_array str_of_summand

    let rescale_blockeigs block_eigs magns_ineqs = 
      let nblocks = Array.length block_eigs in 
      let magns = (*array_float_to_num*) (Array.of_list magns_ineqs) in
      let n_magns = Array.length magns in
        for i = 0 to n_magns -1 do
          let eigenvalues, eigenvectors = block_eigs. (nblocks - n_magns + i) in 
          let eigenvalues = Array.map (fun e -> Nq.div_i e (magns. (i))) eigenvalues in
            block_eigs. (nblocks - n_magns + i) <- eigenvalues, eigenvectors;
        done;
       block_eigs


     let alpha_to_mon alpha = 
      let rec alpha_to_mon idx = function
        | [] -> P.Pc N.one_i
        | hd::tl -> 
            begin
              let x_pow_hd = P.p_pow (P.mkX_i (idx + 1)) hd in
                P.p_mul (alpha_to_mon (idx + 1) tl) x_pow_hd 
            end
      in
        alpha_to_mon 0 alpha

    let mons_support_rat pol n = 
      let mons = Pq.monomials pol in
        Array.map (Pq.monomial_support n) (Array.of_list mons)

   (* computes a coarse lower bound of a normalized (i.e. forall i, 0 <= x_i <= 1)
     * polynomial with zarith coefficients *)
    let norm_pol_zarith_I pol = 
      let nvars = List.length (Pq.vars_of_pol pol) in
      let mons_support =  Array.map snd (mons_support_rat pol nvars) in
        Array.fold_left (fun acc c -> Nq.add_i (Nq.min_i Nq.zero_i c) acc) Nq.zero_i mons_support 

(* Needs p0 p1 padd pmulC (float pol -> zarith pol) pmul psquare 
 * (float array -> zarith array) (float matrix -> zarith matrix) *)

    let mk_sos_from_block eigenvalue_idx eigenvector monomials = 
      let deg = Array.length monomials in
      let idx = ref 0 in
      let pol_certif = ref (Pq.Pc Nq.zero_i) in
        for d = 0 to deg - 1 do
          let md = monomials. (d) in
          for mon_idx = 0 to Array.length md - 1 do
            let mon = alpha_to_mon md. (mon_idx) in
            let monq = pol_float_to_num mon in
            let coeff = eigenvector. (!idx) in
              incr idx;
              pol_certif := Pq.p_add !pol_certif (Pq.p_mulC monq coeff);
          done;
        done;
        debug (Printf.sprintf "Sos component array: %s\n" (Pq.string_of_pol !pol_certif));
        Pq.Sos_block (eigenvalue_idx, !pol_certif)

    let mk_sos eigenvalues eigenvectors monomials current_idx : Pq.kkt =
      debug (Printf.sprintf "Eigenvalues array: %s\n" (Mq.string_of_array eigenvalues));
      debug (Printf.sprintf "Eigenvectors array: %s\n" (Mq.string_of_matrix eigenvectors));

      let array_size = Array.length eigenvectors in
      let array_idx = Array.of_list (U.int_to_list array_size) in
        Pq.Sos (Array.map (fun idx -> mk_sos_from_block (idx + current_idx) eigenvectors. (idx) monomials) array_idx)

    let mk_eq_coeff eigenvalues monomials is_L1 : Pq.kkt = 
      let deg = Array.length monomials in
      let idx = ref 0 in
      let pol_certif = ref (Pq.Pc Nq.zero_i) in
        for d = 0 to deg - 1 do
          let md = monomials. (d) in
          for mon_idx = 0 to Array.length md - 1 do
            let mon = alpha_to_mon md. (mon_idx) in
            let monq = pol_float_to_num mon in
          
            let coeff = eigenvalues. (!idx) in
            let coeff = if Nq.ge_i (Nq.num_of_float Config.Config.eig_tol) (Nq.abs_i coeff) then Nq.zero_i else coeff in
              incr idx;
              pol_certif := Pq.p_add !pol_certif (Pq.p_mulC monq coeff);
          done;
        done;
        if is_L1 then Pq.L1 !pol_certif else Pq.Eq_coeff !pol_certif



    let mk_putinar_psatz allineqs eqs block_eigs block_monomials block_eigs_eqs block_monomials_eqs bLOCKsTRUCT is_L1 = 
      let moment_mat_nblocks = Array.length block_monomials - List.length allineqs in
      let trivial_ineqs = U.init_list moment_mat_nblocks (Pq.Pc Nq.one_i) in (* 1 >= 0 for each sdp moment matrix block *)
      let ineq1_allineqs = trivial_ineqs @ allineqs in
      let ineq1_allineqs, eqs = Array.of_list ineq1_allineqs, Array.of_list eqs in
      let ineqs_size = Array.length ineq1_allineqs in
      let ineqs_idx = Array.of_list (Uq.int_to_list ineqs_size) in

      let eqs_size = Array.length eqs in
      let l1_size = if is_L1 then 1 else 0 in
      let eqs_idx = Array.of_list (Uq.int_to_list eqs_size) in
      let l1_idx =  Array.of_list (Uq.int_to_list l1_size) in

      let current_idx = ref 0 in

      let create_ineq_sos ineq_idx = 
        let block_idx = ineq_idx in
        (* TODO pour une ineq_sos donnée, il faut mapper ça sur plusieurs
         * block_eigs et block_monomials (match bLOCKsTRUCT)
         * e.g. si la matrice de moment a été block diagonalisée *)
        let eigenvalues, eigenvectors = block_eigs. (block_idx) in                         
        let res = mk_sos eigenvalues eigenvectors block_monomials. (block_idx) !current_idx, ineq_idx in
          current_idx := !current_idx + (Array.length eigenvalues); 
          res in

      let create_eq_coeff eq_idx = 
        let eigenvalues = block_eigs_eqs. (eq_idx) in 
          mk_eq_coeff eigenvalues block_monomials_eqs. (eq_idx) false, eq_idx 
      in
      let create_l1_coeff l1_idx = 
        let eigenvalues = block_eigs_eqs. (l1_idx + eqs_size) in 
          mk_eq_coeff eigenvalues block_monomials_eqs. (l1_idx + eqs_size) true, l1_idx
      in
      let ineqs_sos = Array.map create_ineq_sos ineqs_idx in
      let eqs_coeffs = Array.map create_eq_coeff eqs_idx in
      let l1_coeffs =  Array.map create_l1_coeff l1_idx in
      let all_blocks = Array.append (Array.append ineqs_sos eqs_coeffs) l1_coeffs in
           Array.of_list trivial_ineqs, eqs, Pq.Putinar_psatz all_blocks

    let extract_L1 = function 
         Pq.Putinar_psatz kkt_array -> 
           begin
             let l1 = fst (kkt_array. (Array.length kkt_array - 1)) in
               match l1 with | Pq.L1 pol -> pol | _ -> failwith "cannot extract L1 polynomial"
           end
   let print_zarith_as_float i = debug (N.string_of_i (num_of_numq i));()
    let print_zarithpol_as_floatpol pol = 
         debug (P.string_of_pol (pol_to_float pol));()

    (* Input are pol ineqs eqs with floating points coeffs,
     * obj_min_norm is a floating point guess of a lower bound of pol 
     * Convert into zarith coeffs polynomials and zarith lower bound mu, then check
     * with coq the correctness of mu *)
    let mk_coq_cert pol ineqs_scale ineqs_box eqs (magns_ineqs : Nq.t list) magns_eqs block_eigs block_monomials block_eigs_eqs block_monomials_eqs lower_bound pol0_rat bLOCKsTRUCT is_L1 prefix_name =
      let ineqs = List.map2 (fun p i -> Pq.pmulC p i) ineqs_scale magns_ineqs in
(*      let pol, ineqs, ineqs_box, eqs = pol_float_to_num pol, List.map pol_float_to_num ineqs, List.map pol_float_to_num ineqs_box, List.map pol_float_to_num eqs in *)
      let allineqs = ineqs_box @ ineqs in
      let block_eigs = block_eigs_float_to_num block_eigs in
      let block_eigs_eqs = Array.map array_float_to_num block_eigs_eqs in
      let block_eigs_rescaled = rescale_blockeigs block_eigs magns_ineqs in
      let lower_bound = float_to_num lower_bound in
      let trivial_ineqs, eqs, sos_putinar = mk_putinar_psatz allineqs eqs block_eigs_rescaled block_monomials block_eigs_eqs block_monomials_eqs bLOCKsTRUCT is_L1 in
      let eigenvalues = Array.concat (Array.to_list (Array.map fst block_eigs_rescaled)) in
(*      debug (Printf.sprintf "Eigenvalues array: %s\n" (Mq.string_of_array eigenvalues));*)
      debug (Printf.sprintf "Sos_putinar: %s\n" (str_of_putinar_psatz_float eigenvalues (Array.append trivial_ineqs (Array.of_list allineqs)) eqs sos_putinar));

      let sos_pol = pol_of_putinar_psatz eigenvalues (Array.append trivial_ineqs (Array.of_list allineqs)) sos_putinar in
      let pol_L1 = if is_L1 then extract_L1 sos_putinar else Pq.Pc Nq.zero_i in
      let eps_pol = if is_L1 then  Pq.p_sub pol sos_pol else Pq.p_sub (Pq.p_subC (pol) lower_bound) sos_pol in
        debug (Printf.sprintf "sos_pol:%s\neps_pol: %s\n"  
                 (Pq.string_of_pol sos_pol)
                 (Pq.string_of_pol eps_pol)
        );  

        let eps_pol_bound = norm_pol_zarith_I eps_pol in
          if is_L1 then (debug "L1 eps_pol:"; print_zarithpol_as_floatpol eps_pol);
          if is_L1 then (debug "L1 Underestimator:"; print_zarithpol_as_floatpol (Pq.p_addC pol_L1  (eps_pol_bound)));
          (*
           obj_min_norm = m + eps_pol_bound
           pol - obj_min_norm = sos_pol + eps_pol - eps_pol_bound *) 
          debug (Printf.sprintf "lower_bound: %s\npol0: %s\neps_pol_bound: %s\n"  
                   (Nq.string_of_i lower_bound)
                   (Nq.string_of_i pol0_rat)
                   (Nq.string_of_i_coq eps_pol_bound)         
          );  
          let c = Pq.mk_cert_pop eps_pol eigenvalues sos_putinar in
                  (*
        let coq_data_ring = mk_coq_data_ring vars pol eigenvalues ineqs eqs sos_putinar eps_pol eps_pol_bound lower_bound in
        *)  if is_L1 then ineqs, Pq.denorm pol, Pq.p_addC pol_L1  (eps_pol_bound), Nq.zero_i, c else ineqs, Pq.denorm pol, (Pq.Pc Nq.zero_i), Nq.add_i eps_pol_bound (Nq.add_i lower_bound pol0_rat), c



  end

