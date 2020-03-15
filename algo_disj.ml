module type T = 
sig
  type num_i 
  type positive
  type interval 
  type cert_itv
  type fold_poly_tree 
  type algo_semi_alg 
  type eval_tbl 
  type rewrite_tbl 
  type fw_tbl 
  type poly_interval 
  type pol
  type fw_pol 
  type taylor_model
  type x0_cmp
  val br_count : int ref
  val br_tbl : (fold_poly_tree, int ref) Hashtbl.t
  val eval_ref : interval ref
  val clean_tree : fold_poly_tree -> fold_poly_tree
  val sqr_optim_guess : num_i list -> bool -> num_i list
  val algo_semi_alg : algo_semi_alg -> int -> pol list -> fold_poly_tree -> eval_tbl -> rewrite_tbl ->  (fold_poly_tree, taylor_model * x0_cmp * num_i * num_i * fw_pol list * fw_pol list) Hashtbl.t ->  positive list -> (num_i * num_i) list -> num_i list list -> bool -> int -> poly_interval list
  val algo_bundle_aux : (fold_poly_tree -> num_i list list -> int -> poly_interval list) -> algo_semi_alg -> pol list -> eval_tbl -> int -> num_i list list -> num_i -> fold_poly_tree -> int -> num_i list ref -> cert_itv -> fw_pol -> num_i * num_i list * cert_itv * fw_pol
  val algo_optim : algo_semi_alg -> pol list -> eval_tbl -> rewrite_tbl -> positive list -> fold_poly_tree -> num_i list list -> (num_i * num_i) list -> num_i list ref -> interval * num_i list * fw_pol
end

module Make
  (N: Numeric.T) (Fun: Functions.T with type num_i = N.t) (U: Tutils.T with
  type t = N.t) (I: Interval.T with type num_i = N.t and type f = Fun.f)
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval)
  (Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol
  = P.fw_pol and type interval = I.interval and type cert_itv = P.cert_itv)
  (F:Flyspeck_types.T with type
  num_i = N.t and type inter_mut = I.inter_mut) 
  (Ty: Algo_types.T with type
  num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node
  = F.node and type inter_mut = I.inter_mut and type interval = I.interval and type cert_pop = P.cert_pop)
  (Tb: Algo_tables.T with type num_i = N.t and type p = P.positive and type
  eval_tbl = Ty.eval_tbl and type fw_tbl = Ty.fw_tbl) 
  (O: Operations.T with
  type num_i = N.t and type pol = P.pol and type eval_tbl = Tb.eval_tbl and
  type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive
  and type rewrite_tbl = Ty.rewrite_tbl) 
  (Approx : Approx_func.T with type
  num_i = N.t and type positive = P.positive and type f = Fun.f and type
  interval = I.interval and type fw_pol = P.fw_pol) 
  (Ia : Interval_arith.T
  with type num_i = N.t and type positive = P.positive and type interval =
  I.interval and type eval_tbl = Ty.eval_tbl and type fold_poly_tree =
  Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type
  algo_semi_alg = Ty.algo_semi_alg) 
  (Tm : Taylor_cut.T with type num_i =
  N.t and type positive = P.positive and type fw_pol = P.fw_pol and type
  eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type
  algo_semi_alg = Ty.algo_semi_alg and type fold_poly_tree = Ty.fold_poly_tree)
  (Template : Template.T with type num_i =  N.t and type positive = P.positive and type fw_pol = P.fw_pol and type  eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type algo_semi_alg = Ty.algo_semi_alg and type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type taylor_model = Tm.taylor_model and type x0_cmp = Tm.x0_cmp)
  (S : Sparsepop.T with type num_i = N.t)= struct

    type num_i = N.t
    type positive = P.positive
    type interval = I.interval
    type cert_itv = P.cert_itv
    type fold_poly_tree = Ty.fold_poly_tree
    type algo_semi_alg = Ty.algo_semi_alg
    type eval_tbl = Ty.eval_tbl
    type rewrite_tbl = Ty.rewrite_tbl
    type fw_tbl = Ty.fw_tbl
    type poly_interval = Ty.poly_interval
    type fw_pol = P.fw_pol
    type pol = P.pol
    type taylor_model = Tm.taylor_model
    type x0_cmp = Tm.x0_cmp
    let prec = Config.Config.print_precision 
    let cert0 = P.cert_null
    let br_count = ref 0 
    let br_tbl = Hashtbl.create 2
    let eval_ref = ref (I.mk_i_I N.ten_i)
    let xopt_is_min = ref true
    let verb = Config.Config.semialg_verb
    let debug s = if verb then U.debug s else ()
    let activate_template = ref false
    let n_activate_template = Config.Config.n_activate_template
    exception Refine

    module H = Template.H
  
    let add_monomials_main_tbl vars bounds main_tbl = 
      let f v b = 
        let mon = P.mk_X v in
        let i = I.mk_I b in
        H.add main_tbl (O.x_T v, 0) (Ty.Poly_Int ( Fu.mk_Pw_I mon i, Fu.mk_Pw_I mon i)); ()
      in
      List.iter2 f vars bounds


    let rec clean_tree : fold_poly_tree -> fold_poly_tree = function
      | Ty.Varloc (s, _) -> Ty.Varloc (s, F.void_im())
      | Ty.Pol (p, _) -> Ty.Pol (p, F.void_im ())
      | Ty.Br_poly ((n, _), t) -> Ty.Br_poly ((n, F.void_im()), List.map clean_tree t)

    let sqr_optim_guess optim_guess xconvert = 
      let f = if xconvert then List.map N.sqr_i else (fun x -> x) in
        f optim_guess

let algo_semi_alg (get_semialg_min:algo_semi_alg) ellips_nb (ellips_cstr : pol list) (start_tree : fold_poly_tree) (tbl:eval_tbl) (tbl_loc:rewrite_tbl) tm2_tbl (vars : positive list) bounds x0 init_iter br : poly_interval list =
  let get_cuts tm2_tbl tree = 
    try
      let _, _, _, _, samp_min, samp_max = Hashtbl.find tm2_tbl tree in
        Ty.get_result (Fu.assign_min samp_min, Fu.assign_max samp_max) 
    with Not_found -> invalid_arg ("get_cuts impossible, this key is not binded in tm2_tbl: " ^ (Ty.string_T tree)) in 
  let rnd_bool = Config.Config.get_rnd_cuts (*&& init_iter*) in
  let add_cuts_algo tree : poly_interval list = 
    let _ = Template.add_cuts_algo get_semialg_min tbl tbl_loc tm2_tbl tree (List.hd x0) (Array.of_list vars) bounds ellips_nb rnd_bool in
    [get_cuts tm2_tbl tree] in
  let main_tbl = Template.main_tbl in
  let dfs tree f = 
    if Config.Config.samp_root then add_cuts_algo tree
    else if init_iter || O.is_semialg_T tree then try [H.find main_tbl (tree, ellips_nb)] with Not_found -> f tree
    (*
    else if Config.Config.samp_leaves && (O.is_semialg_T tree) && (not (O.is_pol_T tree) || Config.Config.cut_poly) && not (O.is_sqrt_lc_T tree) then add_cuts_algo tree
     *)
    else if O.is_pol_T tree && Config.Config.cut_poly then add_cuts_algo tree
                                                             (*
    else if (O.is_semialg_T tree) then (try [H.find main_tbl (tree, ellips_nb)] with Not_found -> check_keys (); U._pr_ (Ty.string_T tree) true true; failwith "should find the poly_int in main_tbl after one iteration")
                                                              *)
    else  f tree 
  in

  let f_aux f poly_couple : fw_pol * fw_pol = 
    match poly_couple with
      | Ty.Poly_Int (pmin, pmax)-> f pmin pmax 
      | _ -> failwith "In f_aux, Has to be Ty.Poly_Int"
  in
  let f_aux2 f pc1 pc2 = 
    match pc1, pc2 with
      | Ty.Poly_Int (pmin1, pmax1), Ty.Poly_Int (pmin2, pmax2) -> f pmin1 pmax1 pmin2 pmax2
      | _ -> failwith "In f_aux2, Has to be Ty.Poly_Int"
  in
  let void_tbl1, void_tbl2, void_tbl3 = Hashtbl.create 0, Hashtbl.create 0, Hashtbl.create 0 in
    if O.is_const_T start_tree then 
      begin
        let c = O.eval_T void_tbl1 void_tbl2 void_tbl3 start_tree in
        let p = P.Pw (P.Pc c, I.mk_i_I c, cert0) in
          [Ty.get_result (p, p)] 
      end
    else
      begin      
        let rec alg tree x0 br = 
          begin
            let alg_f tree : poly_interval list(* * num_i*) = alg tree x0 br in

              (* bound_poly finds lower and upper bounds of fw_pol functions using
              * semialgebraic optimization (e.g. SparsePOP or mypop )*)
            let bound_sa fmin fmax ?(coarse_interval = I.zero_I) is_L1  : poly_interval =                            
              let get_min f is_min : num_i * P.cert_pop = 
                let f_I = if is_min then I.inf_I else I.sup_I in 
                  if P.is_Pol f && P.is_degree_one (P.pol_of_fw f) then f_I (P.basic_pol_I tbl (P.pol_of_fw f)), P.cert_pop_null else let bnd, _, _, _, _, (c:P.cert_pop)  = get_semialg_min ~relax_order:Config.Config.relax_order ~force:false  ~incr_cliques:false tbl f ellips_cstr [] [] is_min false false in bnd, c in              
              let get_L1 f is_min = 
                let _, _, _, _, under_L1, _ = get_semialg_min ~relax_order:Config.Config.relax_order ~force:false  ~incr_cliques:false tbl f ellips_cstr [] [] is_min false true in under_L1 in
              let p_I, (cI: P.cert_itv) = if is_L1 then coarse_interval, P.cert_null else if P.fw_eq fmin fmax then begin
                if  P.is_Pol fmin && P.is_degree_one (P.pol_of_fw fmin) then P.basic_pol_I tbl (P.pol_of_fw fmin), P.cert_null else let lo, clo =  get_min fmin true in let up, cup =  get_min fmax false in  I.Int (lo, up), (clo, cup) end
              else let lo, clo =  get_min fmin true in let up, cup =  get_min fmax false in  I.Int (lo, up), (clo, cup) in
              let fmin, fmax = 
                if false then begin                 
                  let new_fmin = Fu.aic p_I  (Fu.mk_Pw (get_L1 fmin true)) P.cert_null in                   
                   (*
                  let new_fmin = fmin in
                    *)
                  let new_fmax = Fu.aic p_I  (Fu.mk_Pw (get_L1 fmax false)) P.cert_null in
                    (*
                  let new_fmax = fmax in 
                     *)
                    new_fmin, new_fmax end
                  else fmin, fmax in
                    Ty.Poly_Int (Fu.aic p_I fmin cI, Fu.aic p_I fmax cI)
            in

              match tree with
                | Ty.Varloc (s, (*i_var*) _) ->
                    begin
                      try [Hashtbl.find tbl_loc s]
                      with Not_found -> 
                        begin
                          try
                            let (p1, p2), (i1, i2) = Hashtbl.find tbl s in
                              [Ty.Poly_Int (p1, p2)](*, I.abs_sup_I (I.union_I i1 i2)*)
                          with Not_found -> failwith "Ty.Varloc not found in naive algo"
                        end
                    end
                | Ty.Pol (P.Pc c, _) -> let i_c = I.Int (c, c) in [Ty.Poly_Int (P.Pw (P.Pc c, i_c, cert0), P.Pw (P.Pc c, i_c, cert0))](*, N.abs_i c*)
                | Ty.Pol (p, _) ->
                  (* If one of the two conditions hold: 
                  * 1) the degree of p is not too large 
                  * 2) it is the initial algorithm iteration and the polynomial approx by quadratic
                  * cuts is not mandatory
                  * then we check if this polynomial has been previously bounded
                  * and if not we compute an enclosing interval *)
                  (* Otherwise, we add an initial cut *)
                  begin
                    let result = begin
                    if P.degree_pol p <= Config.Config.max_degree_pol || (init_iter && not Config.Config.cut_at_first ) then 
                    try [H.find main_tbl (tree, ellips_nb)]
                    with Not_found -> U._pr_ "Bounding polynomial:" true false; let result = bound_sa (Fu.mk_Pw p) (Fu.mk_Pw p) false in H.add main_tbl (tree, ellips_nb) result; U._pr_ "End of Bounding" true false; [result]
                    else add_cuts_algo tree end in
                      result(*, I.abs_sup_I (Ty.ipi_of_list result)*)
                  end                           
              | Ty.Br_poly ((F.Ffunc "and", _), [t1; t2]) -> 
                  begin 
                    let b1 = alg t1 x0 br and b2 = alg t2 x0 br in 
                      match b1, b2 with 
                        | [Ty.Bool_Int bool1], [Ty.Bool_Int bool2] -> [Ty.Bool_Int (bool1 && bool2)](*, N.zero_i*)
                        | _ -> failwith "Has to be Ty.Bool_Int"
                  end
              | Ty.Br_poly ((F.Ffunc "cnd", cnd_interv), [Ty.Br_poly ((F.Ffunc "if", _),  [t1]); Ty.Br_poly((F.Ffunc "then", _), [t2]); Ty.Br_poly((F.Ffunc "else", _), [t3])]) -> 
                  begin
                    let bool_cnd = alg t1 x0 br in
                      match bool_cnd with
                        | [Ty.Bool_Int bool1] -> 
                            begin
                              let node_result = alg (if bool1 then t2 else t3) x0 br in
                                node_result(*, I.abs_sup_I (Ty.ipi_of_list result)*)
                            end
                        | _ -> failwith "No such case for if then else"
                  end
              | Ty.Br_poly ((F.Ffunc "mult_i", _), [a; Ty.Br_poly ((F.Ffunc "inv_i",  _), [b])    ]) -> 
                  begin
                    U._pr_ ("At: /") true false;
                    let result1 = dfs a alg_f in
                    let result2 = dfs b alg_f in
                      try begin
                        let f = Fu.approx_fw_div in
                        let result = U.combine_f (f_aux2 f) result1 result2 in
                        let result = Ty.list_result result in                      
                          H.replace main_tbl (tree, ellips_nb) (List.hd result);
                          result end
                      with Fu.Div_refine -> raise Refine
                  end
              | Ty.Br_poly ((F.Ffunc s, (*i_func*) _), [h]) when s = "minus_i" || s = "inv_i" || (s = "sqrt" && (not (O.is_sqrt_lc_T tree) || Config.Config.lift_lc_sqrt )) -> 
                  begin
                    U._pr_ ("At: " ^ s) true false;                    
                    let node_result = dfs h alg_f in
                    let f = if s = "minus_i" then Fu.approx_fw_minus else if s = "inv_i" then Fu.approx_fw_inv else Fu.approx_fw_sqrt in                                            
                    let result = List.map (f_aux f) node_result in
                    let result = Ty.list_result result in
                      H.replace main_tbl (tree, ellips_nb) (List.hd result);
                      result
                      end
              | Ty.Br_poly ((F.Ffunc s, (*i_func*)_), [a; b]) when s = "mult_i" || s = "add_i" || s = "sub_i" || s = "div_i" -> 
                  begin
                    let result1, result2 = dfs a alg_f, dfs b alg_f in
                    let f = if s = "add_i" then Fu.approx_fw_add else if s = "sub_i" then Fu.approx_fw_sub else if s = "mult_i" then Fu.approx_fw_mult else Fu.approx_fw_div in
                    let result = U.combine_f (f_aux2 f) result1 result2 in
                    let result = Ty.list_result result in    
                      H.replace main_tbl (tree, ellips_nb) (List.hd result);
                      result
                  end
              | Ty.Br_poly ((F.Ffunc "pow_i", i_func), [a; Ty.Pol (P.Pc b, _)]) -> failwith "Unsupported case pow_i"
                  (*
                  begin
                    let result1 = alg a x0 br in
                    let result = List.map (f_aux (Fu.approx_fw_pow (N.float_of_num b))) result1 in
                      U._pr_ (Printf.sprintf "%s ^ %s" (Ty.string_fold_tree a) (N.string_of_i b)) true true;
                    let result = Ty.list_result result in
                    let s_interval = I.union_list_I (List.map Ty.ipi result) in
                      i_func.I.i <- I.narrow_I i_func.I.i s_interval;                      
                      result
                  end
                   *)
              | Ty.Br_poly ((F.Ffunc s, _), [h])  when Hashtbl.mem I.func_basic s ->  
                  begin
                    U._pr_ ("eval at: "^ s) true false;
                    try 
                      begin
                      let transc = Hashtbl.find I.func_basic s in
                      let prop_list = Hashtbl.find I.func_check_prop_list s in
                      let transc' = Hashtbl.find I.func_derivative_basic s in
                      (*let transc'' = Hashtbl.find I.func_deriv_order2 s in
                       let transc_3 =  Hashtbl.find I.func_deriv_order3 s in*)
                      let f_interval = Hashtbl.find I.func_interval_basic s in
                      let min_c, max_c = 
                        try Hashtbl.find I.func_min_c s, Hashtbl.find I.func_max_c s 
                        with Not_found -> (fun _ -> N.zero_i), (fun _ -> N.zero_i) in
                      let node_result = dfs h alg_f in
                        U._pr_ (I.string_float_list (List.map (fun x -> O.eval_T (Tb.get_tbl_pol vars x) tbl tbl_loc h) x0) prec) true false;
                        let node_result = List.hd node_result in
                          (*
                        let coarse_interval = Ty.ipi node_result in
                        let pmin, pmax = Ty.get_pmin node_result, Ty.get_pmax node_result in 
                           *)
                          (*
                                    (* Disjonctive version *)
                                    | [Ty.Poly_Int (pmin, pmax)] ->
                                        begin
                                          (*
                                           let _, x0_pos, _, x0_neg = min_heuristic_disj start_tree h tbl tbl_loc bounds in 
                                           *)
                                          (*
                                           let optim_disj = Unfold_eval_tree.init_algo_optim_disj initial_tree var_list bounds pmin (List.map (fun (a, b) -> N.sqr_i a, N.sqr_i b ) bounds) in
                                           *)
                           *)
                        let node_result = 
                          if (init_iter) && not (O.is_pol_T h) && (not (O.is_sqrt_lc_T h) || ( Config.Config.approx_minimax)) then
                            begin
                              let pmin, pmax = Ty.get_pmin node_result, Ty.get_pmax node_result in  
                              let low = U.fst_fst_fst (get_semialg_min ~incr_cliques:false tbl pmin ellips_cstr [] [] true false false) in
                              let up = U.fst_fst_fst (get_semialg_min ~incr_cliques:false tbl pmax ellips_cstr [] [] false false false) in
                              let interval = I.Int (low, up) in
                              let node_result = Ty.aipi interval node_result in
                              (*let up = N.min_i up N.zero_i in*)
                               (* for 3318 
                              let low, up = if s = "atan" then N.num_of_float (-4.4498912e-01), N.num_of_float 8.7406038e-01 else low, up in
                                *)
                                (* for 7394 
                              let low, up = if s = "atan" then N.num_of_float (*(-8.7407206e-01)*) 0., N.num_of_float 3.3330921e-01 else low, up in*)
                              (*let low, up = 0.06, 0.065  in
                              let low, up = N.num_of_float low, N.num_of_float up in*)
                              
                               
                              (*
                              let is_L1 = s = "atan" in
                               
                              let new_node_result = bound_sa pmin pmax  ~coarse_interval:coarse_interval  is_L1  in
                               *)
                                H.replace main_tbl (h, ellips_nb) node_result; 
                                node_result
                            end
                          else (*Ty.ipi (H.find main_tbl (h, ellips_nb))*) node_result in
                        let interval = Ty.ipi node_result in
                        let pmin, pmax = Ty.get_pmin node_result, Ty.get_pmax node_result in 
                          let func_I = f_interval interval in                    
                          debug ("Computing approximation of " ^ s ^ " on " ^ (I.string_float_I interval prec));
                          let _ = if init_iter then debug ("Minimizer candidate x = " ^ (I.string_float_list (List.hd x0) prec)) else () in
                        let (p1, p2), (eval_min, eval_max) =  try Approx.approx_transc_with_poly s pmin pmax transc transc' min_c max_c prop_list interval vars x0 with Fu.Compose_refine -> raise Refine in
                        let eval = I.abs_I eval_min in
                          eval_ref := eval;
                            let p1, p2 = Fu.fw_addC (N.minus_i (I.inf_I eval_min)) p1 ,  Fu.fw_addC (I.sup_I eval_max) p2 in
                          let p1_I = I.intersection_I  (Fu.ifw p1) func_I in
                          let p2_I = I.intersection_I  (Fu.ifw p2) func_I in
                            (*
                          let p1_I = I.mk_I (N.minus_i N.one_i, N.one_i)  in
                          let p2_I = I.mk_I (N.minus_i N.one_i, N.one_i)  in
                             *)
                          let p1, p2 = Fu.ai p1_I p1, Fu.ai p2_I p2 in
                          let result = Ty.get_result (p1, p2) in
                            H.replace main_tbl (tree, ellips_nb) result;
                          if !activate_template then [Template.recut get_semialg_min x0 tree tbl tbl_loc tm2_tbl (Array.of_list vars) bounds ellips_nb rnd_bool] else [result]
                      end
                    with Not_found -> failwith ("problem in alg at " ^ s)
                  end
              | Ty.Br_poly ((F.Ffunc s, i_func), [a; b])  when Hashtbl.mem I.func_interval_bool s ->  
                  begin
                    try 
                        let g = Hashtbl.find I.func_interval_bool s in
                          match alg a x0 br ,alg b x0 br with
                            | r1, r2 ->
                                begin
                                  let interv1, interv2 = I.union_list_I (List.map Ty.ipi r1), I.union_list_I (List.map Ty.ipi r2) in
                                  let g_interval = g interv1 interv2 in
                                    U._pr_ ("Boolean Interval function: " ^ s ^ " " ^ (I.string_I interv1) ^ (I.string_I interv2)) true false ;
                                    if g_interval 
                                    then [Ty.Bool_Int g_interval]
                                    else
                                      begin
                                        let result = U.combine_f (f_aux2 Fu.approx_fw_sub) r1 r2 in
                                        let result = Ty.list_result result in
                                        let min_max_I r = 
                                          let p_m, p_M = Ty.get_pmin r, Ty.get_pmax r in
                                            try 
                                              begin
                                                let f_m, f_M = H.find main_tbl ((*p_m*)a, ellips_nb), H.find main_tbl ((*p_M*)b, ellips_nb) in
                                                let p_I = I.union_I (Ty.ipi f_m) (Ty.ipi f_M) in
                                                  p_I
                                              end
                                            with Not_found ->
                                             U._pr_ "Computing intervals" true true; 
                                              begin
                                                let p_I = I.Int (U.fst_fst_fst (get_semialg_min ~incr_cliques:false tbl p_m ellips_cstr [] [] true false false), U.fst_fst_fst (get_semialg_min ~incr_cliques:false tbl p_M ellips_cstr [] [] false false false)) in
                                                let f_m, f_M = Fu.ai p_I p_m, Fu.ai p_I p_M in
                                                let result = Ty.Poly_Int (f_m, f_M) in
                                                  H.replace main_tbl (a, ellips_nb) result; H.replace main_tbl (b, ellips_nb) result;
                                                  p_I
                                              end
                                        in
                                        let list_I = List.map min_max_I result in
                                        let s_interval = I.union_list_I list_I in
                                        let result =  Ty.Bool_Int (g s_interval (I.mk_i_I N.zero_i)) in
                                          U._pr_ (Printf.sprintf "Verif of intervals: %s" (I.string_I s_interval)) true true ;
                                          [result]
                                      end
                                end
                      with Not_found -> Printf.printf "In alg, at %s:" s; failwith "problem with boolean function"
                  end
              | _ -> failwith "unsupported case for naive algo"
            end
        in
          alg start_tree x0 br
      end

let rec algo_bundle_aux alg (get_semialg_min:algo_semi_alg) ellips_cstr tbl br_i x_i m t n_iter errors cert pmin : num_i * num_i list * cert_itv * fw_pol = 
  debug ("Minimizer candidate x = " ^ (I.string_float_list (List.hd x_i) prec));
  if n_iter >= n_activate_template then activate_template := true else ();
(*  if N.ge_i (N.sub_i m (I.inf_I !eval_ref)) N.zero_i || n_iter >=
 *  Config.Config.iter_max (*|| (n_iter > Config.Config.iter_min && ge_i (abs_i
                            *  m) !eval_ref) *)then *)
  if N.ge_i m N.zero_i || n_iter >= Config.Config.iter_max - 1 (*|| (n_iter > Config.Config.iter_min && ge_i (abs_i m) !eval_ref) *)then 
    begin
      U._pr_ (Printf.sprintf "samp iters = %d EvalMin = %s min = %s x = %s" n_iter (I.string_I !eval_ref) (N.string_of_i m) (I.string_float_list (List.hd x_i) prec )) true false;
       m, (List.hd x_i), cert, pmin
    end
  else
    begin
      let _ = if n_iter >= 0 then debug ("Iteration " ^ (string_of_int (n_iter + 2))) else () in
      let result_list = alg t x_i br_i in     
      let p_result = List.nth result_list br_i in
      let pmin = Ty.get_pmin p_result in
      let incr_order = (n_iter <= Config.Config.iter_max - 1) in
      let m, _, _, x_next, _, cert = get_semialg_min ~incr_relax_order:incr_order ~incr_cliques:false ~relax_order:Config.Config.relax_order tbl pmin ellips_cstr [] [] true true false in
        U.debug (Printf.sprintf ("Lower bound = %s") (N.string_of_i_coq m));
        errors := m::!errors;
        let x_list = x_next::x_i in
        let n_save = min (List.length x_list) Config.Config.samp_iters in 
        let x_n = U.sub_list x_list 0 (n_save) in
          algo_bundle_aux alg get_semialg_min ellips_cstr tbl br_i x_n m t (n_iter + 1) errors (cert, cert) pmin
    end

let algo_optim (get_semialg_min:algo_semi_alg) ellips_cstr (tbl:eval_tbl) (tbl_loc:rewrite_tbl) vars tree optim_guess bounds errors : interval * num_i list * fw_pol =
  eval_ref := I.mk_i_I N.ten_i;
  try
    begin
      let init_iter = ref true in
      activate_template := false;
      let tree = clean_tree tree in
      let ellips_nb = 0 in
      let is_bounds_ellips = true in
      let cstrs = if is_bounds_ellips then ellips_cstr else [] in
    (*
  let cstrs = [".. x1 * x1 - x1 * x2 - x1 * x3 + 2.0 * x1 * x4 - x1 * x5 - x1 * x6 + x2 * x3 - x2 * x5 - x3 * x6 + x5 * x6  =G= 0;\n"; ] in
     *)
    (*
  let main_tbl = Tb.get_main_tbl bounds ellips_nb in
     *)
    (*
  let main_tbl, tm2_tbl = H.create 6, Hashtbl.create 10 in
     *)
        H.clear Template.main_tbl; Hashtbl.clear Template.tbl_hess_I; 
        add_monomials_main_tbl vars bounds Template.main_tbl; 
        let tm2_tbl =  Hashtbl.create 10 in
        let alg t x0 br = algo_semi_alg get_semialg_min ellips_nb cstrs t tbl tbl_loc tm2_tbl vars bounds  x0 (!init_iter) br in
        (*let n, m_list, max_list, optim_next_list, certlo_list, certup_list,
         * pmin =*)
          if not (O.is_pol_T tree) then begin
          debug "Bounding semialgebraic components";
          let result = alg tree optim_guess (-1) in
            debug "Semialgebraic components bounded\n";
            let n = List.length result in
              debug "Iteration 1";
              let m_list, _, optim_next_list, _, _, certlo_list = U.split6 (List.map (fun p -> get_semialg_min tbl ~incr_relax_order:false ~incr_cliques:false ~relax_order:Config.Config.relax_order (Ty.get_pmin p) cstrs [] [] true true false) result) in
              let max_list, certup_list = if Config.Config.compute_max_ineq then let max_list, _, _, _, _, certup_list = U.split6 (List.map (fun p -> get_semialg_min tbl ~incr_relax_order:false ~incr_cliques:false ~relax_order:Config.Config.relax_order (Ty.get_pmax p) cstrs [] [] false true false) result) in max_list, certup_list else m_list, certlo_list in
                debug (Printf.sprintf "Lower bound = %s" (N.string_of_i_coq (List.hd m_list)));
                errors := (I.min_list m_list)::!errors;
                init_iter := false;
                let min_disj, x_disj, cert_disj, pmin_disj = U.split4 (List.map (fun br_i -> algo_bundle_aux alg get_semialg_min cstrs tbl br_i [List.nth optim_next_list br_i; List.nth optim_guess br_i] (List.nth m_list br_i) tree 0 errors (List.nth certlo_list br_i, List.nth certup_list br_i) (Ty.get_pmin (List.nth result br_i))) (U.int_to_list n)) in
                let min_bound = I.min_list min_disj in                
                let x_index = U.index_of_elt min_disj min_bound in
                let x = List.nth x_disj x_index in
                  let max_bound = if Config.Config.compute_max_ineq then List.hd max_list else min_bound in
                  (*let certlo, certup = List.hd certlo_list, List.hd
                   * certup_list in*)
                  let certlo = List.hd cert_disj in
                  let pmin = List.hd pmin_disj in
                  let interval = I.Int (min_bound, max_bound) in
                    Ty.ait interval tree;
                    interval, x , Fu.aic interval pmin certlo
          end 
          else (*1, [N.minus_i N.one_i], [N.minus_i N.one_i], optim_guess, [P.cert_pop_null], [P.cert_pop_null], Fu.fw_0*) begin
            let pmin = match tree with Ty.Pol (p, _) -> Fu.mk_Pw p | _ -> (*Fu.fw_0*) failwith "Tree should be a polynomial" in
            let m, x, cert = match tree with 
                Ty.Pol (P.Pc c, _) -> c, List.hd optim_guess, P.cert_pop_null
              | _ -> let m, _, _, x, _, cert =  get_semialg_min tbl ~incr_relax_order:false ~incr_cliques:false ~relax_order:Config.Config.relax_order pmin cstrs [] [] true true false in m, x, cert 
            in
            let interval = I.Int (m, m) in
              interval, x , Fu.aic interval pmin (cert, cert)
          end 
    end
  with 
    | S.UnfeasPOP s -> U._pr_ ("WARNING: Unfeasible POP " ^ s) true true; I.Int (N.minus_i N.one_i, N.minus_i N.one_i), U.init_list (List.length bounds) N.zero_i, Fu.fw_0
    | Refine -> U._pr_ ("Subdivision required for refinement (division or square root issue) ") true true; I.Int (N.minus_i N.one_i, N.minus_i N.one_i), U.init_list (List.length bounds) N.zero_i, Fu.fw_0
    | S.Scale_refine -> U._pr_ ("Subdivision required for refinement (scaling issue) ") true true; I.Int (N.minus_i N.one_i, N.minus_i N.one_i), U.init_list (List.length bounds) N.zero_i, Fu.fw_0


end
