
module Make 
  (N: Numeric.T) 
  (Fun: Functions.T with type num_i = N.t) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t and type f = Fun.f)  
  (M: Mesh_interval.T with type num_i = N.t and type interval = I.interval) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval) 
  (Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval)
  (F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) 
  (Ty: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node = F.node and type inter_mut = I.inter_mut and type interval = I.interval)  
 (R: Rewrite.T with type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type pol = P.pol and type func_tree = F.func_tree) 
  (Tb: Algo_tables.T with type num_i = N.t and type interval = I.interval and type p = P.positive and type pol = P.pol with type eval_tbl = Ty.eval_tbl and type fw_tbl = Ty.fw_tbl and type p = P.positive)  
  (O: Operations.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Tb.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive and type rewrite_tbl = Ty.rewrite_tbl) 
  (Approx : Approx_func.T with type num_i = N.t and type f = Fun.f and type interval = I.interval and type fw_pol = P.fw_pol) 
  (Tm : Taylor_cut.T with type num_i = N.t and type algo_semi_alg = Ty.algo_semi_alg and type eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type fold_poly_tree = Ty.fold_poly_tree with type positive = P.positive)
  (Sergei: Sergei.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Ty.eval_tbl and type val_tbl = Ty.val_tbl  ) 
  (Sparsepop : Sparsepop.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type eval_tbl = Ty.eval_tbl and type val_tbl = Ty.val_tbl and type rt = Fu.relax_type)
  (A: Algo_disj.T with type num_i = N.t and type positive = P.positive and type interval = I.interval and type algo_semi_alg = Ty.algo_semi_alg and type eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type fold_poly_tree = Ty.fold_poly_tree)
   (Ia : Interval_arith.T with type num_i = N.t and type interval = I.interval and type positive = P.positive and type interval = I.interval and type eval_tbl = Ty.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type algo_semi_alg = Ty.algo_semi_alg) 

  = struct 

    type num_i = N.t
    type interval = I.interval
    type algo_semi_alg = Ty.algo_semi_alg
    type taylor_model = Tm.taylor_model 
    type x0_cmp = Tm.x0_cmp
    type positive = P.positive
    type fold_poly_tree = Ty.fold_poly_tree
    type func_tree = F.func_tree

    open O.Infixes

    let rec algo_moore grad get_semialg_min var_list vars t bounds  relax_order start_bounds : interval = 
      (* First try to solve the inequality or <=> get a positive lower bound of
 * the min *)
      let tbl = Tb.get_tbl var_list bounds vars in 
      let tbl_loc = Hashtbl.create 2 in
      let _, _, x0 = O.min_heuristic t tbl tbl_loc bounds vars in

      let algo_I, x = A.algo_optim get_semialg_min [] tbl tbl_loc vars t [x0] bounds (ref []) in
(* Secondly, if it positive then we're done otherwise, we check the sign of the
* partial derivatives of t *)
        if I.ge_I algo_I I.zero_I then algo_I (* We won :) *)
        else (* We lost :'( *)
          begin
            let k = 0 in (* direction for partial derivation *)
            let pos_k =  P.Translation.positive_n (k + 1) in
            (*
            let partial_deriv = List.nth k (Tm.grad_of_tm2 tm2) in
             *)
            let partial_deriv = List.nth grad k in
            let tbl_I = Hashtbl.create 30 in
            let dummy_tbl_loc = Hashtbl.create 2 in (* I need to change this, this table is always useless *)
            let partial_deriv_I = Ia.interval_T get_semialg_min tbl tbl_I dummy_tbl_loc vars partial_deriv in
              U._pr_ ("partial derivatives interval: " ^ (I.string_I partial_deriv_I)) true true;
              if (*I.ge_I partial_deriv_I I.zero_I*) true then (* the min may lies in the kth projection of bounds *)
                begin
                  if U.boxes_share_lower_bound bounds start_bounds k then (* the min lies in the kth projection of bounds *)
                    begin
                      let value = fst (List.nth bounds k) in
                      let proj_grad, proj_var_list, proj_bounds = U.remove_from_list k grad, U.remove_from_list k var_list, U.remove_from_list k bounds in                    
                      let proj_t, proj_grad = O.eval_T_num pos_k value t,  List.map (O.eval_T_num pos_k value) proj_grad in
                        U._pr_ (Ty.string_T t) true true;
                        U._pr_ (Ty.string_T proj_t) true true;
                      algo_moore proj_grad get_semialg_min proj_var_list vars t proj_bounds  relax_order bounds 
                    end
                  else I.Void_i (* the box defined by bounds does not contain the min *) 
                end
              else if I.le_I partial_deriv_I I.zero_I then
                begin
                  if U.boxes_share_upper_bound bounds start_bounds k then (* the min lies in the kth projection of bounds *)
                    begin
                      I.Void_i
                    end
                  else I.Void_i (* the box defined by bounds does not contain the min *) 
                end
              else
                begin
                  I.Void_i
                end
          end

    let init_trees t1 t2 var_list bounds xconvert norm  oc_in oc_out relax_order =
      U._pr_ ("Initializing trees...") true true; 
      let bounds = M.xconvert_bounds bounds xconvert in
      let var_map = List.combine var_list bounds in
      let singletons, new_var_map = List.partition Tb.is_singleton var_map in 
      let nvars = List.length new_var_map in
      let vars = Tb.array_indexes nvars in
      let fold_tbl = Tb.get_fold_tbl singletons new_var_map in
      let f t = [] in
      let (nl_tree1, hmap_tree1),  (nl_tree2, hmap_tree2) = R.extract_tame_hypermap t1 ,  R.extract_tame_hypermap t2 in
      let nl1, nl2 = R.fold_poly f fold_tbl xconvert nl_tree1, R.fold_poly f fold_tbl xconvert nl_tree2 in
      let hmap1, hmap2 = R.fold_poly f fold_tbl xconvert hmap_tree1, R.fold_poly f fold_tbl xconvert hmap_tree2 in
      let hmap1_xconvert, hmap2_xconvert = R.fold_poly f fold_tbl xconvert hmap_tree1, R.fold_poly f fold_tbl xconvert hmap_tree2 in
        U._pr_ (Ty.string_T nl1) true false;    U._pr_ ("\n") true false; U._pr_ (Ty.string_T hmap1) true false;
        let lhs, rhs = if norm then (nl1 <+> hmap1_xconvert) <-> (nl2 <+> hmap2_xconvert), O.zero_T else nl1 <+> hmap1_xconvert, nl2 <+> hmap2_xconvert in

        let var_list, bounds = List.split new_var_map in
        let tm2_lhs = Tm.initiate_tm2 vars nl1 hmap1 xconvert in
        let tm2_rhs = if norm then Tm.tm2_zero nvars else Tm.initiate_tm2 vars nl2 hmap2 xconvert in
        let p0 = P.Pc N.zero_i in
        let get_pol_min tbl p is_min = Sergei.get_bound_poly p tbl is_min  in
        let get_semialg_min ?(incr_cliques = true) ?(incr_relax_order = false) ?(relax_order = 2) ?(force = false) tbl p cstr eqcstr cstr_major_min is_min is_top_level_bound is_L1 =
          if force && P.is_Pol p && List.length cstr = 0 then
            try 
              let m, x = get_pol_min tbl (P.pol_of_fw p) is_min, [] in
                m, m, x, x, p0
            with Sergei.Sergei_error -> Sparsepop.get_bound_poly incr_cliques incr_relax_order p cstr eqcstr cstr_major_min tbl is_min oc_in oc_out relax_order 1 (Fu.relax_type_of_string Config.Config.relax_type) is_top_level_bound is_L1
            else
              begin 
                Sparsepop.get_bound_poly incr_cliques incr_relax_order p cstr eqcstr cstr_major_min tbl is_min oc_in oc_out  relax_order 1 (Fu.relax_type_of_string Config.Config.relax_type) is_top_level_bound is_L1
              end
        in
          U._pr_ (Ty.string_T lhs) true false; 
    
          let box_list = [bounds] in
            (*
          let n_pbs = ref (List.length box_list) in
             *)
          let grad_lhs, grad_rhs = Array.to_list (Tm.grad_of_tm2 tm2_lhs), Array.to_list (Tm.grad_of_tm2 tm2_rhs) in
            (*
            grad_lhs, grad_rhs, get_semialg_min, var_list, vars, lhs, rhs, bounds, n_pbs
             *)
            U._pr_ ("Starting algo_moore...") true true; 
            let lhs_I_f bounds : interval = algo_moore grad_lhs get_semialg_min var_list (Array.to_list vars) lhs bounds  relax_order bounds in
            let lhs_I = I.union_list_I (List.map lhs_I_f box_list) in
            let rhs_I = if norm then I.zero_I else algo_moore grad_rhs get_semialg_min var_list (Array.to_list vars) rhs bounds  relax_order bounds in
              U._pr_ ("...Ending algo_moore") true true; 
              lhs_I, rhs_I

  end
