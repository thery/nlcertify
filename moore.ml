
module Make 
  (N: Numeric.T) 
  (Fun: Functions.T with type num_i = N.t) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t and type f = Fun.f)  
  (M: Mesh_interval.T with type num_i = N.t and type interval = I.interval) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval) 
  (Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval)
  (F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) 
  (Ty: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node = F.node and type inter_mut = I.inter_mut and type interval = I.interval and type cert_pop = P.cert_pop)  
  (R: Rewrite.T with type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type pol = P.pol and type func_tree = F.func_tree) 
  (Tb: Algo_tables.T with type num_i = N.t and type interval = I.interval and type pol = P.pol with type eval_tbl = Ty.eval_tbl and type fw_tbl = Ty.fw_tbl and type p = P.positive)  
  (O: Operations.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Tb.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive and type rewrite_tbl = Ty.rewrite_tbl) 
  (Approx : Approx_func.T with type num_i = N.t and type f = Fun.f and type interval = I.interval and type fw_pol = P.fw_pol) 
  (Ia : Interval_arith.T with type num_i = N.t and type interval = I.interval and type positive = P.positive and type interval = I.interval and type eval_tbl = Ty.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type algo_semi_alg = Ty.algo_semi_alg)
  (Tm : Taylor_cut.T with type num_i = N.t and type interval = I.interval and type pol = P.pol and type fw_pol = P.fw_pol and type algo_semi_alg = Ty.algo_semi_alg and type eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type fold_poly_tree = Ty.fold_poly_tree with type positive = P.positive and type poly_interval = Ty.poly_interval)
  (Sergei: Sergei.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Ty.eval_tbl and type val_tbl = Ty.val_tbl  ) 
  (Sparsepop : Sparsepop.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type eval_tbl = Ty.eval_tbl and type val_tbl = Ty.val_tbl and type rt = Fu.relax_type and type cert_pop = P.cert_pop)
  (Oracle: Oracle.T with type num_i = N.t and type pol = P.pol with type term = P.term)
  (A: Algo_disj.T with type num_i = N.t and type positive = P.positive and type interval = I.interval and type pol = P.pol and type algo_semi_alg = Ty.algo_semi_alg and type eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type fw_pol = P.fw_pol)
  (C: Cut_box.T with type num_i = N.t) 
  = struct 

    type num_i = N.t
    type interval = I.interval
    type fw_pol = P.fw_pol
    let n_pbs = ref 0
    let n_cuts = ref 0
    let n_pbs = ref 0
    let pbs_solved = ref 0
    let cuts = ref 0 
    let errors : num_i list ref = ref []

    let verb = Config.Config.problem_verb
    let time_verb = Config.Config.time_verb
    let debug s = if verb then U.debug s else ()
    let debug_sos s = if Config.Config.sos_verb then U.debug s else ()
    let time_debug s = if time_verb then U.debug s else ()


    type algo_semi_alg = Ty.algo_semi_alg
    type taylor_model = Tm.taylor_model 
    type x0_cmp = Tm.x0_cmp
    type positive = P.positive
    type fold_poly_tree = Ty.fold_poly_tree
    type func_tree = F.func_tree
    type poly_interval = Ty.poly_interval
 
    let prec = Config.Config.print_precision

    let rec algo_moore tm2 get_semialg_min var_list vars t bounds relax_order start_bounds : interval = 
      (* First try to solve the inequality or <=> get a positive lower bound of
 * the min *)
       debug (Printf.sprintf "%i problem%s remaining, %i cuts done" !n_pbs (if !n_pbs <= 1 then "" else "s") !n_cuts);
       debug ("Sub box " ^ U.string_float_box bounds prec);
       let algo_I, cert_fsa = if Config.Config.do_samp then I.zero_I, Fu.fw_0 (*max_plus tm2 get_semialg_min var_list (Array.to_list vars) t bounds  relax_order*)
       else 
         begin
           let time_start = Unix.gettimeofday () in
           let tbl_loc = Hashtbl.create 2 in
(*
          let tbl_I =  Hashtbl.create 1 in  
          let interval = Ia.interval_T get_semialg_min tbl_I tbl_loc var_list (Array.to_list vars) [bounds] t false in
 *)        
           let tbl = Tb.get_tbl var_list bounds (Array.to_list vars) in

           let _, _, x0 = O.min_heuristic t tbl tbl_loc bounds (Array.to_list vars) in
           let time_end = Unix.gettimeofday() in 
           let time_mess = Printf.sprintf "Heuristics time: %f" (time_end -. time_start) in
             U._pr_ time_mess true time_verb;
           let tbl_I =  Hashtbl.create 1 in 
           let interval, cert_fsa = 
             if Array.length Sys.argv > 3 && Sys.argv. (2) = "fp" then 
               begin 
                 let n_exact = int_of_string (Sys.argv. (3)) in
                 let module Real2float = Real2float.Make (N)(Fun)(U)(I)(M)(P)(Fu)(F)(Ty)(R)(Tb)(O)(Approx)(Ia)(Tm)(Sergei)(Sparsepop)(Oracle) in
                 let t_linear, t_nonlinear = Real2float.decompose t vars n_exact tm2 in
                 let i_linear, _, c = A.algo_optim get_semialg_min [] tbl tbl_loc (Array.to_list vars) t_linear [x0] bounds errors in 
                   U.debug (I.string_I i_linear);
                 let i_nonlinear = Ia.interval_T get_semialg_min tbl tbl_I tbl_loc (Array.to_list vars) t_nonlinear true in
                  U.debug (I.string_I i_nonlinear);
                 I.add_I i_linear i_nonlinear, c
               end
             else if Config.Config.ia_sos then 
               begin
                   Ia.interval_T get_semialg_min tbl tbl_I tbl_loc (Array.to_list vars) t false, Fu.fw_0
               end
             else 
               begin 
               let i, _, c = A.algo_optim get_semialg_min [] tbl tbl_loc (Array.to_list vars) t [x0] bounds errors in i, c end
           in
           let time_end = Unix.gettimeofday() in 
           let time_mess = Printf.sprintf "Algo samp time: %f" (time_end -. time_start) in
             time_debug time_mess; 
             U._pr_ (U.string_blanks (List.length start_bounds - Array.length vars) ^  N.string_of_i (I.inf_I interval)) true false;
             interval, cert_fsa
         end
      in
       let module Coq_fsa = Coq_fsa.Make (N)(U)(M)(I)(P)(Fu) in               
         debug_sos "Bit-size of the certificate";
         debug_sos (string_of_int (Coq_fsa.size_cert_fsa cert_fsa));


(* Secondly, if it positive then we're done with the informal algorithm, and we generate the Coq proof script
 * otherwise, we check the sign of the partial derivatives of t and perform branch and bound *)
        if I.ge_I algo_I I.zero_I || not Config.Config.bb then  
          begin
            n_pbs :=  !n_pbs - 1; pbs_solved := !pbs_solved + 1;
              if Config.Config.check_certif_coq_fsa then Coq_fsa.check_fsa (Array.to_list vars) bounds cert_fsa algo_I;
              U._pr_ (I.string_float_I algo_I prec) true false; debug "\n";
            algo_I (* We won informally. A vernacular file is generated from cert_fsa *)
          end
        else (* We lost informally *)
          begin
            let widths = M.get_widths bounds in
            let max_width = I.max_list widths in
            let tbl = Tb.get_tbl var_list bounds (Array.to_list vars) in 
            let dummy_tbl_loc = Hashtbl.create 2 in (* I need to change this, this table is always useless *)
            let grad_I = if Config.Config.check_derivatives then Tm.ia_grad get_semialg_min tm2 tbl dummy_tbl_loc (Array.to_list vars) else Array.make (Array.length vars) (I.mk_I (N.minus_i N.infty, N.infty)) in

              Array.iter (fun i -> U._pr_ (I.string_float_I i prec) true false;) grad_I;

              let grad_I = Array.to_list grad_I in
              let dir_idx = 
                try 
                  let partial_deriv_I = List.find (fun d -> I.ge_I d I.zero_I || I.le_I d I.zero_I) grad_I in
                    U.index_of_elt grad_I partial_deriv_I 

                with Not_found -> U.index_of_elt widths max_width in (* direction for partial derivation *) 
              let partial_deriv_I = List.nth grad_I dir_idx in
                U._pr_ ("deriv: " ^ (I.string_I partial_deriv_I)) true false;
                let pos_k = vars. (dir_idx) in


              (*
            let lo, up, x0 = O.min_heuristic partial_deriv tbl dummy_tbl_loc bounds (Array.to_list vars) in
 
            let partial_deriv_I = I.mk_I (lo, up) in
              U._pr_ ("deriv by heuristics: " ^ (I.string_I partial_deriv_I)) true true;
               

            let partial_deriv_I = if I.belongs_I N.zero_i partial_deriv_I 
            then partial_deriv_I
            else 
              begin
                (* c'est faux! car cela renvoie un intervalle singleton 
                let deriv_I = fst (A.algo_optim get_semialg_min [""] tbl dummy_tbl_loc (Array.to_list vars) partial_deriv [x0] bounds) in
                 *)
                let tbl_I = Hashtbl.create 10 in
                let deriv_I = Ia.interval_T get_semialg_min tbl tbl_I dummy_tbl_loc (Array.to_list vars) partial_deriv false in 
                  deriv_I
              end
            in
               *)
              if I.ge_I partial_deriv_I I.zero_I then (* the min may lies in the kth projection of bounds *)
                begin
                  if U.boxes_share_lower_bound bounds start_bounds dir_idx then (* the min lies in the kth projection of bounds *)
                    begin
                      let value = fst (List.nth bounds dir_idx) in
                        U._pr_ (N.string_of_i value) true true;                        
                      let proj_var_list, proj_vars, proj_bounds = U.remove_from_list dir_idx var_list, U.remove_from_list dir_idx (Array.to_list vars), U.remove_from_list dir_idx bounds in                    
                      let proj_t = O.eval_T_num pos_k value t in
                      let proj_tm2 = Tm.proj_tm2 dir_idx pos_k value tm2 in
                        U._pr_ (Ty.string_T proj_t) true true;
                      algo_moore proj_tm2 get_semialg_min proj_var_list (Array.of_list proj_vars) proj_t proj_bounds  relax_order proj_bounds 
                    end
                  else (n_pbs :=  !n_pbs - 1; pbs_solved := !pbs_solved + 1;I.Void_i) (* the box defined by bounds does not contain the min *) 
                end
              else if I.le_I partial_deriv_I I.zero_I then
                begin
                  if U.boxes_share_upper_bound bounds start_bounds dir_idx then (* the min lies in the kth projection of bounds *)
                    begin
                      let value = snd (List.nth bounds dir_idx) in
                        U._pr_ (N.string_of_i value) true true;                        
                      let proj_var_list, proj_vars, proj_bounds = U.remove_from_list dir_idx var_list, U.remove_from_list dir_idx (Array.to_list vars), U.remove_from_list dir_idx bounds in                    
                      let proj_t = O.eval_T_num pos_k value t in
                      let proj_tm2 = Tm.proj_tm2 dir_idx pos_k value tm2 in
                        U._pr_ (Ty.string_T proj_t) true true;
                        algo_moore proj_tm2 get_semialg_min proj_var_list (Array.of_list proj_vars) proj_t proj_bounds relax_order proj_bounds 
                    end
                  else (n_pbs :=  !n_pbs - 1; pbs_solved := !pbs_solved + 1; I.Void_i) (* the box defined by bounds does not contain the min *) 
                end
              else
                begin
                   n_pbs :=  !n_pbs + 1; n_cuts := !n_cuts + 1;

              U._pr_ "before cut" true false; debug "\n";
                   let box_list = C.cut_box dir_idx bounds in
                  let interval_list = List.map (fun b -> algo_moore tm2 get_semialg_min var_list vars t b  relax_order bounds) box_list in
                    I.union_list_I interval_list
                end
          end
 open O.Infixes

    let solve_ineq norm t1 t2 var_list bounds  oc_in oc_out relax_order = 

      let xconvert = Config.Config.xconvert_variables in
      let bounds = M.xconvert_bounds bounds xconvert in
      let var_map = List.combine var_list bounds in
      let singletons, new_var_map = List.partition Tb.is_singleton var_map in 
      let nvars = List.length new_var_map in
      let vars = Tb.array_indexes nvars in
      let fold_tbl = Tb.get_fold_tbl singletons new_var_map in
      let p0 = P.Pc N.zero_i in

      let get_pol_min tbl p is_min = Sergei.get_bound_poly p tbl is_min  in
      let get_semialg_min ?(incr_cliques = true) ?(incr_relax_order = false) ?(relax_order = 1) ?(force = false) tbl p cstr eqcstr cstr_major_min is_min is_top_level_bound is_L1 =
        if force && P.is_Pol p && List.length cstr = 0 then
          try 
            let m, x = get_pol_min tbl (P.pol_of_fw p) is_min, [] in
              m, m, x, x, p0, P.cert_pop_null
          with Sergei.Sergei_error -> Sparsepop.get_bound_poly incr_cliques incr_relax_order p cstr  eqcstr cstr_major_min tbl is_min oc_in oc_out  relax_order 1 (Fu.relax_type_of_string Config.Config.relax_type) is_top_level_bound is_L1
          else
            begin 
              Sparsepop.get_bound_poly incr_cliques incr_relax_order p cstr eqcstr cstr_major_min tbl is_min oc_in oc_out  relax_order 1 (Fu.relax_type_of_string Config.Config.relax_type) is_top_level_bound is_L1
            end
      in

      let tbl, tbl_loc, tm2_tbl = Tb.get_tbl var_list bounds (Array.to_list vars), Hashtbl.create 0, Hashtbl.create 0 in
      let f (t : fold_poly_tree) : poly_interval list =  A.algo_semi_alg get_semialg_min 0 [] t tbl tbl_loc tm2_tbl (Array.to_list vars) bounds [] false (-1) in 
      let (nl_tree1, hmap_tree1),  (nl_tree2, hmap_tree2) = R.extract_tame_hypermap t1 ,  R.extract_tame_hypermap t2 in
      let nl1, nl2 = R.fold_poly f fold_tbl xconvert nl_tree1, R.fold_poly f fold_tbl xconvert nl_tree2 in
      let hmap1, hmap2 = R.fold_poly f fold_tbl xconvert hmap_tree1, R.fold_poly f fold_tbl xconvert hmap_tree2 in

      let hmap1_xconvert, hmap2_xconvert = R.fold_poly f fold_tbl xconvert hmap_tree1, R.fold_poly f fold_tbl xconvert hmap_tree2 in
        U._pr_ (Ty.string_T nl1) true false;    U._pr_ ("\n") true false; U._pr_ (Ty.string_T hmap1) true false;
        let lhs, rhs = if norm then (nl1 <+> hmap1_xconvert) <-> (nl2 <+> hmap2_xconvert), O.zero_T else nl1 <+> hmap1_xconvert, nl2 <+> hmap2_xconvert in
        let var_list = List.map (fun v -> P.string_of_pol (P.mk_X v)) (Array.to_list vars) in
        let _, bounds = List.split new_var_map in
        let tm2_lhs = Tm.initiate_tm2 vars lhs O.zero_T Config.Config.xconvert_variables in
          debug ("Proving that " ^ (Ty.string_float_T prec lhs) ^ " >= 0 over the box " ^ U.string_float_box bounds prec ^ "\n\n");  

        let lhs_I_f bounds =  
          n_pbs := 1; pbs_solved := 0; n_cuts := 0;
          let result = algo_moore tm2_lhs get_semialg_min var_list vars lhs bounds  relax_order bounds in
            debug (Printf.sprintf "%i problem%s solved, %i cuts done"  !pbs_solved (if !pbs_solved <= 1 then "" else "s")!n_cuts);
            result in
        let lhs_I = I.union_list_I (List.map lhs_I_f [bounds]) in
        let rhs_I = I.zero_I in
        let end_message = if Config.Config.approx_minimax then "End of minimax algorithm" else "End of maxplus algorithm" in
          U._pr_ end_message true true;         
          (lhs_I, rhs_I), List.rev (!errors)

(* End of solve_ineq function*)

    let get_semialg_min oc_in oc_out relax_order = 
      let p0 = P.Pc N.zero_i in
      let get_pol_min tbl p is_min = Sergei.get_bound_poly p tbl is_min  in
      let get_semialg_min ?(incr_cliques = true) ?(incr_relax_order = false) ?(relax_order = relax_order) ?(force = false) tbl p cstr eqcstr cstr_major_min is_min is_top_level_bound is_L1 =        
        if force && P.is_Pol p && List.length cstr = 0 then
          try 
            let m, x = get_pol_min tbl (P.pol_of_fw p) is_min, [] in
              m, m, x, x, p0, P.cert_pop_null
          with Sergei.Sergei_error -> Sparsepop.get_bound_poly incr_cliques incr_relax_order p cstr eqcstr cstr_major_min tbl is_min oc_in oc_out  relax_order 1 (Fu.relax_type_of_string Config.Config.relax_type) is_top_level_bound is_L1
          else
            begin 
              Sparsepop.get_bound_poly incr_cliques incr_relax_order p cstr eqcstr cstr_major_min tbl is_min oc_in oc_out  relax_order 1 (Fu.relax_type_of_string Config.Config.relax_type) is_top_level_bound is_L1
            end
      in
        get_semialg_min 

    let control_pol oc_in oc_out relax_order =
      let module B = Benchs.Make (N)(Fun)(U)(I)(M)(P)(Fu)(F)(Ty)(R)(Tb)(O) in
      let ocp_precision = 0.1 in
      let final_time = 3.0 in
      let is_L1 = false in
      let h, iter_max = N.num_of_float ocp_precision, int_of_float (final_time /. ocp_precision) in
      let get_semialg_min = get_semialg_min oc_in oc_out relax_order in
      let get_semialg_min tbl p ineqcstr eqcstr is_min = U.fst_fst_fst (get_semialg_min tbl p ineqcstr eqcstr [] is_min false is_L1) in 
      let bounds_x0 = N.minus_i N.one_i, N.one_i in
      let x0, x1 = P.mkX_i 1, P.mkX_i 2 in
        (*
      let bounds_x1 = N.minus_i (N.add_i N.one_i h), N.add_i N.one_i h in    
      let cstr1, cstr2 = P.p_addC (P.p_sub x1 x0) h, P.p_addC (P.p_sub x0 x1) h in
      let bounds = B.nonlinear_sequence [bounds_x0; bounds_x1] [cstr1; cstr2] [] [x0; x1] h get_semialg_min 0 (iter_max - 1) (iter_max + 10) false in
       *) 
      let bounds = B.control_harmonic_bivar_lift_max true [bounds_x0; bounds_x0] [] [] [x0; x1] h get_semialg_min 0 iter_max in
        
      let bounds_x, bounds_y = List.nth bounds (List.length bounds - 2) , List.nth bounds (List.length bounds - 1) in
        (I.mk_I bounds_x, I.mk_I bounds_y), [] 

    let rnd_pol norm  oc_in oc_out relax_order nvars degree =      
      let get_semialg_min = get_semialg_min oc_in oc_out relax_order in
        U._pr_ ("Starting random polynomial max-plus approximations algo...") true true; 
           
        let module Rand = Random_quadr_forms.Make (N)(I)(U)(P) in
        let module B = Benchs.Make (N)(Fun)(U)(I)(M)(P)(Fu)(F)(Ty)(R)(Tb)(O) in
        let lhs = B.swf_43 nvars in
          
        let bounds = U.init_list nvars (N.num_of_float (1.0), N.num_of_float 500.0) in 
           
          (*
        let bounds = [(N.num_of_float (-1.5), N.num_of_float (4.)); (N.num_of_float (-3.), N.num_of_float (3.))] in
           *)
          (*
        let bounds = [(N.num_of_float  (-1.5000000000),N.num_of_float  (-0.8125000000)) ; (N.num_of_float (-2.6250000000), N.num_of_float (-2.2500000000))] in
           *)
        let box_list = [bounds] in
        let var_list = Oracle.gen_constraints_names nvars "x"  in 
        let vars = Tb.array_indexes nvars in 
          U._pr_ (Ty.string_T lhs) true true;
          let prev = Unix.gettimeofday () in
                            
          let tm2_lhs = if Config.Config.samp_root || Config.Config.check_derivatives then Tm.initiate_tm2 vars lhs O.zero_T Config.Config.xconvert_variables else Tm.tm2_zero nvars in
          let current = Unix.gettimeofday () in 
          let time_mess = Printf.sprintf "tm2 time: %f" (current -. prev) in 
            U._pr_ time_mess true true;          
           (* let tm2_lhs = Tm.tm2_zero nvars in *)
             (* 
          let lhs_I_f bounds = max_plus tm2_lhs get_semialg_min var_list vars lhs bounds  relax_order in
            *)
            errors := [];
            let lhs_I_f bounds =  algo_moore tm2_lhs get_semialg_min var_list vars lhs bounds  relax_order bounds in
            let lhs_I = I.union_list_I (List.map lhs_I_f box_list) in
            let rhs_I = I.zero_I in
              U._pr_ ("...Ending max-plus") true true; 
              (lhs_I, rhs_I), List.rev (!errors)
  end
(* Interesting GO Pbs 12 17 18 24 27 32 33 42 43 *)
(* SAMP marche mieux sur: 24 43 et Flyspeck 9922 *)
