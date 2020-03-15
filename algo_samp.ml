    let get_tm2 =  if Config.Config.linear_tm2 then Tm.lin_pol_of_tm2 else if Config.Config.minor_tm2 then Tm.quadr_pol_of_tm2 else Tm.pol_of_tm2 

    let get_x0_cmp lambda_min_method t tm2 tbl tbl_loc  var_list vars t bounds x0 lmin lmax =
      let x0_cmp = Tm.compute_grad_hess vars tbl tbl_loc t tm2 x0 N.zero_i N.zero_i in
      let new_lmin, new_lmax = if Config.Config.minor_lambda_min then
        begin
          let lmin_hx0 = Tm.lambda_min_of_hess  (Tm.hess_of_x0_cmp x0_cmp) in
          let lmax_hx0 = Tm.lambda_max_of_hess  (Tm.hess_of_x0_cmp x0_cmp) in
            N.sub_i lmin lmax_hx0, N.sub_i lmax lmin_hx0
        end
      else 
          Tm.compute_lambda_min lambda_min_method tbl tbl_loc tm2 x0_cmp  var_list (Array.to_list vars) bounds false
      in
      let x0_cmp = Tm.assign_lmin new_lmin x0_cmp in
      let x0_cmp = Tm.assign_lmax new_lmax x0_cmp in
        x0_cmp

    let rec add_quadr_cuts get_semialg_min t tm2 samp_min (samp_max: fw_pol list)  var_list vars t bounds x0 lmin lmax = 
      let tbl = Tb.get_tbl var_list bounds vars in 
      let tbl_loc = Hashtbl.create 2 in
      let x0_cmp = get_x0_cmp get_semialg_min t tm2 tbl tbl_loc  var_list (Array.of_list vars) t bounds x0 lmin lmax in 
      let f_min, f_max, _, _ = get_tm2 get_semialg_min tm2 x0_cmp  var_list vars bounds [||] true in

      let f_min, f_max = 
        if Config.Config.check_samp then
          begin
            let tbl_I =  Hashtbl.create 1 in
            let check_min_I = Ia.interval_T get_semialg_min tbl_I tbl_loc var_list vars [bounds] (O.sub_T t (O.poly_T (P.pol_of_fw f_min))) in
            let check_max_I = Ia.interval_T get_semialg_min tbl_I tbl_loc var_list vars [bounds] (O.sub_T (O.poly_T (P.pol_of_fw f_max)) t) in
              U._pr_ (Printf.sprintf "Check f_min: %s f_max: %s" (I.string_I check_min_I) (I.string_I check_max_I)) true true; Fu.fw_add f_min (Fu.mk_Pw (P.Pc (I.inf_I check_min_I))), Fu.fw_sub f_max (Fu.mk_Pw (P.Pc (I.inf_I check_max_I)))
          end
        else f_min, f_max in

      let samp_approx_min = Fu.assign_max (f_min :: samp_min) in
      let samp_approx_max = Fu.assign_min (f_max :: samp_max) in

      let lower_bound, _, x_min, _ = get_semialg_min (*~force:true*)~relax_order:1 ~incr_cliques:false tbl samp_approx_min [] [] (* (f_max::samp_max) *) true in
      let upper_bound, _, x_max, _ = get_semialg_min (*~force:true*)~relax_order:1 ~incr_cliques:false tbl samp_approx_max [] [] false in
        U._pr_ (N.string_of_i upper_bound) true false;


      let next_x = if !xopt_is_min then x_min else x_min in
      xopt_is_min := not (!xopt_is_min);
        U._pr_ (Printf.sprintf "%i min: %.4e %s" (!cuts + 1) (N.float_of_num lower_bound) (I.string_of_list_i x_min)) true true;
        U._pr_ (Printf.sprintf "%i max: %.4e %s\n" (!cuts + 1) (N.float_of_num upper_bound) (I.string_of_list_i x_max)) true true;

      let lo, up = lower_bound, upper_bound in
      let number = N.num_of_float 10. in
      let larger_interval = I.mk_I (N.minus_i number, number) in
      let interval = I.mk_I (lo, up) in (* To get a bounded POP problem : we assign this interval to the samp *)
        if (not (I.ge_I interval I.zero_I)) && !cuts < cuts_max then 
          begin
            let e_min = N.div_i (N.sub_i (I.inf_I !true_interval) (I.inf_I interval)) (N.max_i (I.inf_I !true_interval) N.one_i) in
            let e_max = N.div_i (N.sub_i (I.sup_I interval) (I.sup_I !true_interval)) (I.sup_I !true_interval) in

          cuts := !cuts + 1; 
          let e = if Config.Config.cmp_true_min then U.m_I e_min e_max else e_min in
          errors := e::!errors;
          add_quadr_cuts get_semialg_min t tm2 ((Fu.ai larger_interval f_min)::samp_min) ((Fu.ai larger_interval f_max)::samp_max)  var_list vars t bounds next_x lmin lmax
          end
          else if Config.Config.get_rnd_cuts then
          begin
            let x0_list = U.pick_rnd_in_box 1000 bounds in
            let x0_cmp_list =  List.map (fun x -> get_x0_cmp get_semialg_min t tm2 tbl tbl_loc  var_list (Array.of_list vars) t bounds x lmin lmax) x0_list in
            let pol_list = List.map (fun cmp -> match get_tm2 get_semialg_min tm2 cmp  var_list vars bounds [||] true with | f_min, f_max, _, _ -> f_min, f_max) x0_cmp_list in
            let samp_min_list, samp_max_list = List.split pol_list in
            let samp_approx_min = Fu.assign_max (samp_min @ samp_min_list) in
            let samp_approx_max = Fu.assign_min (samp_max @ samp_max_list) in
            let lo, _, _, _ = get_semialg_min (*~force:true*)~relax_order:1 ~incr_cliques:false tbl samp_approx_min [] [] (* (f_max::samp_max) *) true in
            let up, _, _, _ = get_semialg_min (*~force:true*)~relax_order:1 ~incr_cliques:false tbl samp_approx_max [] [] false in 
              I.mk_I (lo, up)
          end
        else interval

    let max_plus tm2 get_semialg_min var_list vars t bounds  relax_order : interval = 
      cuts := 0; errors := []; true_interval := I.zero_I;
      let tbl = Tb.get_tbl var_list bounds vars in 
      let tbl_loc = Hashtbl.create 2 in
      let _, _, x0 = O.min_heuristic t tbl tbl_loc bounds vars in

        let _ = if Config.Config.cmp_true_min then begin
          (*
          let tbl_I =  Hashtbl.create 1 in        
          true_interval := Ia.interval_T get_semialg_min tbl_I tbl_loc var_list vars [bounds] t;
             *)
          true_interval := fst (A.algo_optim get_semialg_min [""] tbl tbl_loc vars t [x0] bounds);
          U._pr_ (Printf.sprintf "SparsePOP lower bound: %.4e upper bound: %.4e" (N.float_of_num (I.inf_I !true_interval)) (N.float_of_num (I.sup_I !true_interval))) true true; () end
        else () in
        let x0_cmp = Tm.compute_grad_hess (Array.of_list vars) tbl tbl_loc t tm2 x0 N.zero_i N.zero_i in
      let lmin, lmax = Tm.compute_lambda_min get_semialg_min tbl tbl_loc tm2 x0_cmp  var_list vars bounds false in
        U._pr_ ("\nStarting max_plus...") true true; 
        let interval = add_quadr_cuts get_semialg_min t tm2 [] []  var_list vars t bounds x0 lmin lmax in 
        let e_min = N.div_i (N.sub_i (I.inf_I !true_interval) (I.inf_I interval)) (N.max_i (I.inf_I !true_interval) N.one_i) in
        let e_max = N.div_i (N.sub_i (I.sup_I interval) (I.sup_I !true_interval)) (I.sup_I !true_interval) in

          U._pr_ (Printf.sprintf "EMin: %f EMax: %f" (N.float_of_num e_min) (N.float_of_num e_max) ) false false; 
          interval

