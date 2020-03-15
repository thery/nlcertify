module type T = 
sig
  type num_i 
  type interval 
  type fw_pol
  type algo_semi_alg
  type taylor_model 
  type x0_cmp
  type positive
  type fold_poly_tree
  type func_tree
  type cut = No_cut | Cut of num_i list
  val hard_boxes : (num_i * num_i) list list ref
  val x0_cut_n : int ref
  val bool_of_cut : cut -> bool
  val pbs_solved : int ref
  val n_cuts : int ref
  val x0_of_cut : cut -> num_i list
  val x0_cut_tbl : (num_i list, int ref) Hashtbl.t
  val pop_sym : bool array
  val cuts_heur_max : int
  val tol_tight : num_i
  val tol_min : num_i
  val tol_r : num_i
  val tol_r_rect : num_i
  val tol_tm2 : num_i
  val get_rect_cut_tm2 : algo_semi_alg -> string list -> positive list -> fold_poly_tree -> taylor_model -> x0_cmp -> (num_i * num_i) list -> num_i array -> num_i -> num_i -> int -> (num_i * num_i) list * (num_i * num_i) list list list
  val stretch_cube : algo_semi_alg -> string list -> positive list -> fold_poly_tree -> taylor_model -> x0_cmp -> (num_i * num_i) list -> num_i -> (num_i * num_i) list list
  val get_cut_tm2 : algo_semi_alg -> string list ->  positive list -> fold_poly_tree  -> taylor_model -> x0_cmp -> (num_i * num_i) list -> num_i -> num_i -> (num_i * num_i) list list
  val algo_cut : taylor_model -> algo_semi_alg -> string list -> positive list -> fold_poly_tree -> (num_i * num_i) list -> int -> int ref -> cut -> interval
  val init_algo_cut : func_tree -> func_tree -> string list -> (num_i * num_i) list -> bool -> bool -> in_channel -> out_channel -> int -> interval * interval
  val custom_algo_cut : bool -> bool -> in_channel -> out_channel -> int -> interval * interval

end


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
  (Tb: Algo_tables.T with type num_i = N.t and type p = P.positive and type pol = P.pol with type eval_tbl = Ty.eval_tbl and type fw_tbl = Ty.fw_tbl and type p = P.positive)  
  (O: Operations.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Tb.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive and type rewrite_tbl = Ty.rewrite_tbl) 
  (Approx : Approx_func.T with type num_i = N.t and type f = Fun.f and type interval = I.interval and type fw_pol = P.fw_pol) 
  (Tm : Taylor_cut.T with type num_i = N.t and type positive = P.positive and type fw_pol = P.fw_pol and type algo_semi_alg = Ty.algo_semi_alg and type eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type fold_poly_tree = Ty.fold_poly_tree with type positive = P.positive)
  (Sergei: Sergei.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Ty.eval_tbl and type val_tbl = Ty.val_tbl  ) 
  (Sparsepop : Sparsepop.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type eval_tbl = Ty.eval_tbl and type val_tbl = Ty.val_tbl and type rt = Fu.relax_type and type cert_pop = P.cert_pop)
   (Oracle: Oracle.T with type num_i = N.t and type pol = P.pol with type term = P.term)
  (A: Algo_disj.T with type num_i = N.t and type positive = P.positive and type interval = I.interval and type algo_semi_alg = Ty.algo_semi_alg and type eval_tbl = Ty.eval_tbl and type rewrite_tbl = Ty.rewrite_tbl and type fold_poly_tree = Ty.fold_poly_tree)
  = struct 

    type num_i = N.t
    type interval = I.interval
    type fw_pol = P.fw_pol
    type algo_semi_alg = Ty.algo_semi_alg
    type taylor_model = Tm.taylor_model 
    type x0_cmp = Tm.x0_cmp
    type positive = P.positive
    type fold_poly_tree = Ty.fold_poly_tree
    type func_tree = F.func_tree


    type cut = | No_cut | Cut of num_i list
    let hard_boxes = ref []
    let x0_cut_n = ref 0
    let bool_of_cut = function | No_cut -> false | Cut _ -> true
    let pbs_solved = ref 0
    let n_cuts = ref 0


    let x0_of_cut = function | No_cut -> failwith "No_cut, no x0 available" | Cut x0 -> x0
    let x0_cut_tbl = Hashtbl.create 10

    let pop_sym = Config.Config.pop_sym
    let cuts_heur_max = Config.Config.cuts_heur_max
    let tol_tight = N.num_of_float Config.Config.tol_tight
    let tol_min   = N.num_of_float Config.Config.tol_min
    let tol_r     = N.num_of_float Config.Config.tol_r
    let tol_r_rect = N.num_of_float Config.Config.tol_r_rect
    let tol_tm2 = N.num_of_float Config.Config.tol_tm2

    let rec get_rect_cut_tm2 (get_pol_min : algo_semi_alg) var_list vars t tm2 x0_cmp bounds radius_array r1 r2 direction = 
      let tbl = Tb.get_tbl var_list bounds vars in
      let rd = U.m_I r1 r2 in
      let d = direction in
      let wd = I.width_I (I.mk_I (List.nth bounds d)) in
      let r2 = N.min_i r2 wd in
        radius_array. (d) <- r2;
        let f_min, _, sub_box, partitions = Tm.pol_of_tm2 get_pol_min tbl tm2 x0_cmp vars radius_array false in
        let min_tm2, _, _, _, _, _  = get_pol_min tbl f_min [] [] [] true false false in
        let mess = Printf.sprintf "r%d = %s min = %s" (d + 1) (N.string_of_i r2) (N.string_of_i min_tm2) in
          U._pr_ mess true true; 
          if (N.ge_i min_tm2 tol_tm2) then
            begin
              if (N.le_i (N.rel_err_i r1 r2) tol_r_rect || N.ge_i r2 wd) then (radius_array. (d) <- r2; sub_box, partitions)
              else get_rect_cut_tm2 get_pol_min var_list vars t tm2 x0_cmp bounds radius_array rd r2 d 
            end
          else 
            begin
              get_rect_cut_tm2 get_pol_min var_list vars t tm2 x0_cmp bounds radius_array r1 rd d 
            end

    let stretch_cube get_pol_min var_list vars t tm2 x0_cmp bounds rm = 
      let n = List.length bounds in
      let hx0 = Tm.hess_of_x0_cmp x0_cmp in

      let diag_hx0 = Array.map  N.abs_i (M.diag_of_matrix hx0 N.zero_i) in
      let d_idx = U.sort_idx (Array.to_list diag_hx0) in
      let d_idx = Array.of_list (List.rev d_idx) in
      (* 
       let d_idx = Array.of_list (int_to_list n) in
       *)
      let radius_array = Tm.norm_with_hess_using_sym bounds rm hx0 pop_sym in
      let partitions = ref [] in
      let sub_box = ref [] in
        (*let d_idx = [|2; 1; 0|] in*)
        for i = 0 to n - 1 do
          let d = d_idx. (i) in
            if not pop_sym. (d) then
              begin
                let rd1, rd2 = radius_array. (d), I.max_list (M.get_widths bounds) in
                let rect_sub_box, rect_partitions = get_rect_cut_tm2 get_pol_min var_list vars t tm2 x0_cmp bounds radius_array rd1 rd2 d in
                  partitions := rect_partitions;
                  sub_box := rect_sub_box;
              end
            else ()
        done;
        if List.mem !sub_box !hard_boxes then 
          begin
            let radius_array = Array.map (fun r -> N.div_i r N.two_i) radius_array in
            let tbl = Tb.get_tbl var_list bounds vars in
              let _, _, rect_sub_box, rect_partitions = Tm.pol_of_tm2 get_pol_min tbl tm2 x0_cmp vars radius_array false in
              partitions := rect_partitions;
              sub_box := rect_sub_box;
          end
        else (); 
        let p = Tm.get_min_partition !partitions in
          U._pr_ ("Cut Box:" ^ (U.string_of_cut_box (!sub_box::p)) ^ "\n") true true; 
          !sub_box::p


(* gets the biggest cubic infinite ball around a point where the inequality is tight by
 * using Taylor Model approximation of the tree around the point, the TM approx
 * being positive on this box, then gets the biggest rectangular one*)                
let rec get_cut_tm2 (get_pol_min:algo_semi_alg) var_list vars t tm2 x0_cmp bounds r1 r2 =
  let rm = U.m_I r1 r2 in
  let hx0 = Tm.hess_of_x0_cmp x0_cmp in
    (*
  let radius_array = norm_with_hess rm hx0 in
     *)
  let radius_array = Tm.norm_with_hess_using_sym bounds r2 hx0 pop_sym in
  let tbl = Tb.get_tbl var_list bounds vars in
  let f_min, _, sub_box, partitions = Tm.pol_of_tm2 get_pol_min tbl tm2 x0_cmp vars radius_array false in
  let min_tm2, _, _, _, _, _  = get_pol_min tbl f_min [] [] [] true false false in
  let mess = Printf.sprintf "rm = %s min = %s" (N.string_of_i r2) (N.string_of_i min_tm2) in
    U._pr_ mess true true; 
   if (N.ge_i min_tm2 tol_tm2) then
     begin
       if (N.le_i (N.rel_err_i r1 r2) tol_r) then 
         begin
           (*
           let p = get_min_partition get_pol_min vars t tm2 var_list partitions in
             U._pr_ ("Cut Box:" ^ (string_of_cut_box p) ^ "\n") true true; 
             p
            *)
           stretch_cube get_pol_min var_list vars t tm2 x0_cmp bounds r2 
         end
       else get_cut_tm2 get_pol_min var_list vars t tm2 x0_cmp bounds rm r2 
     end
   else 
     begin
         get_cut_tm2 get_pol_min var_list vars t tm2 x0_cmp bounds r1 rm 
     end

       

let rec algo_cut tm2 (get_semialg_min:algo_semi_alg) var_list vars t bounds  relax_order n_pbs cut : interval =
  let cuts_heur = ref 0 in
  let tbl = Tb.get_tbl var_list bounds vars in 
  let tbl_loc = Hashtbl.create 2 in
   (* 
  let r1, r2 = zero_i, norm_of_array (Array.of_list (get_widths bounds)) in
    *)
  let r1, r2 = N.zero_i, I.max_list (M.get_widths bounds) in

  let min_guess, _, x0 = O.min_heuristic t tbl tbl_loc bounds vars in

  let x0 = (*if le_i min_guess tol_tight then x0 else *)if bool_of_cut cut then x0_of_cut cut else x0 in
(*  let x0 = [4.5; 4.5; 4.5; 7.2; 4.5; 4.5] in*)
  let x0_cmp = Tm.compute_grad_hess (Array.of_list vars) tbl tbl_loc t tm2 x0 N.zero_i N.zero_i in
   (* 
  let x0 = [4.0000235000 ; 4.0005095000 ; 4.0005095000 ; 4.0005549000] in 
  let x0_cmp = compute_grad_hess vars tbl tbl_loc t tm2 x0 in
    *)
  let deja_vu_x0 = Hashtbl.mem x0_cut_tbl x0 in
    if not deja_vu_x0 then 
      begin
        x0_cut_n := !x0_cut_n + 1;
        Hashtbl.add x0_cut_tbl x0 x0_cut_n;
      end
    else U._pr_ ("deja-vu: " ^ (I.string_of_list_i x0)) true true; ();
    let box_list =
    if (((*(le_i min_guess tol_tight  && !cuts_heur <= cuts_heur_max) || *)bool_of_cut cut) (*&& not deja_vu_x0 *)) then
      begin
        cuts_heur := !cuts_heur + 1;
        n_cuts := !n_cuts + 1;
        let fx0 = Tm.f_of_x0_cmp x0_cmp in
        let gx0 = Tm.grad_of_x0_cmp x0_cmp in
        let hx0 = Tm.hess_of_x0_cmp x0_cmp in
          U._pr_ (Printf.sprintf "x0 = %s Grad (x0) = %s DiagHess (x0) = %s" (I.string_of_list_i x0) (I.string_of_list_i (Array.to_list gx0)) (I.string_of_list_i (Array.to_list (M.diag_of_matrix hx0 N.zero_i))))  true true;
          U._pr_ (Printf.sprintf "Local min too big: %s -> TM2" (N.string_of_i fx0)) true true;
            n_pbs := !n_pbs - 1;
            (*
            get_cut_boxes get_semialg_min vars t tm2 x0_cmp var_list bounds 
             *)
            get_cut_tm2 get_semialg_min var_list vars t tm2 x0_cmp bounds r1 r2 
      end
    else []
  in

  let s = U.plural !n_cuts in
    match box_list with
      | [] -> 
          begin
           (* 
             let radius_array = Array.of_list (get_widths bounds) in
             let min_tm2, _, _ = pol_of_tm2 get_semialg_min vars t tm2 x0_cmp var_list bounds radius_array one_i true in
             U._pr_ (Printf.sprintf "TM2 try: min = %f" min_tm2) true true;
            *)
            let min_tm2 = N.minus_i N.one_i in
              U._pr_ (Printf.sprintf "TM2 try: min = %s" (N.string_of_i min_tm2)) false false;
              let interval = 
                if N.ge_i min_tm2 N.zero_i then 
                  begin
                    n_pbs := !n_pbs - 1;
                    U._pr_ (Printf.sprintf "%i problems remaining, %i cut%s done" !n_pbs !n_cuts s) true true;
                    I.mk_I (min_tm2, min_tm2)
                  end
                else
                  begin
                    U._pr_ ("Solving on Box: " ^ U.string_of_tuple_list bounds) true true;
                    let algo_I, x, _ = A.algo_optim get_semialg_min [] tbl tbl_loc vars t [x0] bounds (ref []) in
                      if I.le_I algo_I I.zero_I then
                        begin
                          hard_boxes := bounds::!hard_boxes;
                          U._pr_ (Printf.sprintf "Hard boxes: %s" (U.string_of_cut_box (List.rev !hard_boxes))) true true;
                          U._pr_ (Printf.sprintf "%i problems remaining, %i problems solved, %i cut%s done " !n_pbs !pbs_solved !n_cuts s) true true;
                          (*
                           let corner = Unfold_eval_tree.project_x_on_corner x bounds in
                           *)
                          let corner = x in
                            algo_cut tm2 get_semialg_min var_list vars t bounds relax_order n_pbs (Cut corner)
                        end
                      else
                       begin
                         pbs_solved := !pbs_solved + 1;
                         n_pbs := !n_pbs - 1;
                         U._pr_ (Printf.sprintf "%i problems remaining, %i problems solved, %i cut%s done" !n_pbs !pbs_solved !n_cuts s) true true;
                         algo_I
                       end
                  end
              in
                interval
          end
      | _ -> 
          begin
            n_pbs := !n_pbs + List.length box_list; U._pr_ (Printf.sprintf "%i problems remaining, %i problems solved, %i cut%s done" !n_pbs !pbs_solved !n_cuts s) true true;
            I.union_list_I (List.map (fun b -> algo_cut tm2 get_semialg_min var_list vars t b relax_order n_pbs No_cut) box_list)
          end

 open O.Infixes

    let cert0 = P.cert_pop_null
    let custom_algo_cut xconvert norm oc_in oc_out relax_order =
      let get_pol_min tbl p is_min = Sergei.get_bound_poly p tbl is_min in
      let p0 = P.Pc N.zero_i in
      let get_semialg_min ?(incr_cliques = true) ?(incr_relax_order = false) ?(relax_order = 2) ?(force = false) tbl p cstr eqcstr cstr_major_min is_min is_top_level_bound is_L1 =
        if force && P.is_Pol p && List.length cstr = 0 then
          try 
            let m, x = get_pol_min tbl (P.pol_of_fw p) is_min, [] in
              m, m, x, x, p0, cert0
          with Sergei.Sergei_error -> Sparsepop.get_bound_poly incr_cliques incr_relax_order p cstr eqcstr cstr_major_min tbl is_min oc_in oc_out relax_order 1 (Fu.relax_type_of_string Config.Config.relax_type) is_top_level_bound is_L1
          else
            begin 
              Sparsepop.get_bound_poly incr_cliques incr_relax_order p cstr eqcstr cstr_major_min tbl is_min oc_in oc_out relax_order 1 (Fu.relax_type_of_string Config.Config.relax_type) is_top_level_bound is_L1 
            end
      in
        U._pr_ ("Starting custom algo_cut...") true true; 
        let nvars = 3 in 
        let bounds = U.init_list nvars ( N.zero_i, N.one_i) in
        let box_list = [bounds] in
        let var_list = Oracle.gen_constraints_names nvars "x"  in 
        let vars = Tb.array_indexes nvars in 
        let n_pbs = ref (List.length box_list) in 
          U._pr_ ("Starting algo_cut...") true true; 
          let tm2_lhs, tm2_rhs = Tm.tm2_zero nvars, Tm.tm2_zero nvars in
          let module R = Random_quadr_forms.Make (N)(I)(U)(P) in


            (*
(* hack1 to define atan(q) + atan (Sum_i x_i^2) with q = Sum_i (1 - rnd_i x_i)^2*)
          let q = R.random_quadr_sos nvars in
          let scale = N.inv_i (N.num_of_int_i nvars) in
          let q = P.p_mulC q scale in
          let sum = P.monomial_sum (Array.to_list vars) in
          let sum = P.p_mulC sum scale in
          let lhs = O.atan_T (O.poly_T q) <+> O.atan_T (O.poly_T sum) in
             *)
(*
 (* hack2 to define directly atan(q) + l with q quadratic form and l linear
      * form *)
      let p, q = R.random_quadr_linear_forms nvars 1.0 true in
      let lhs = (O.atan_T (O.poly_T p)) <+> (O.poly_T q) in
 *)
      
 (* hack3 to define directly Sum_i atan(l_i) with l_i linear
      * form *)
      let l_list = R.random_linear_forms_list nvars 0.01 5 in
      let lhs = O.fold_add_T (List.map (fun l -> O.atan_T (O.poly_T l)) l_list) in
       
        (*
(* hack4 to define Rosenbrock function*)
      (*      
          let x = P.mkX_i 1 in
      
          let xx = P.p_square x in
             *)
         *)
          
(* hack5 for atan (x) + atan (-x) *)
            (*
          let x = P.mkX_i 1 in
         (* let xx = P.p_square x in*)
         (* let eps = N.pow_i N.ten_i (N.minus_i N.six_i) in*)
          let lhs = O.atan_T (O.poly_T x) <+> O.atan_T (O.poly_T (P.p_opp x)) (*<+> O.poly_T (P.p_mulC xx eps)*) in
             *)
           (*
          let lhs = O.atan_T (O.poly_T (P.p_opp x))  <+>  O.poly_T x <+> O.poly_T xx in
             
          let max_ros = N.inv_i (N.num_of_float 1.0) in
          let ros = P.p_opp (R.rosenbrock nvars) in
          let lhs = O.atan_T (O.poly_T (P.p_mulC ros max_ros )) <+> O.poly_T (P.monomial_sum (Array.to_list vars)) in
            *)

(* hack6 to define atan(q) + Sum_i x_i^2 with q = Sum_i (1 - rnd_i x_i)^2 (1 -
* rnd_i x_{i+1})^2 *)
           (* 
          let module R = Random_quadr_forms.Make (N)(I)(U)(P) in
          let q = R.random_quadr_sos_sparse nvars in
          let scale = N.inv_i (N.num_of_int_i nvars) in
          let q = P.p_mulC q scale in
          let sum = P.monomial_sum (Array.to_list vars) in
          let sum = P.p_mulC sum scale in
          let lhs = O.atan_T (O.poly_T q) <+> O.atan_T (O.poly_T sum) in
            *)
        (*
          let x = P.mkX_i 1 in
          let p = P.p_mulC x (N.num_of_float 0.2) in
          let lhs = O.atan_T (O.poly_T x) <+> O.poly_T (P.p_opp p) in
         *)
            U._pr_ (Ty.string_T lhs) true true;
           let lhs_I_f bounds = algo_cut tm2_lhs get_semialg_min var_list (Array.to_list vars) lhs bounds relax_order n_pbs No_cut in
            let lhs_I = I.union_list_I (List.map lhs_I_f box_list) in
            let rhs_I = I.zero_I in
              U._pr_ ("...Ending custom algo_cut") true true; 
              lhs_I, rhs_I



(* t1, t2: lhs, rhs tree *)                
let init_algo_cut t1 t2 var_list bounds xconvert norm oc_in oc_out relax_order =
  let bounds = M.xconvert_bounds bounds xconvert in
  let var_map = List.combine var_list bounds in
  let singletons, new_var_map = List.partition Tb.is_singleton var_map in 
  let nvars = List.length new_var_map in
  let vars = Tb.array_indexes nvars in
  let fold_tbl = Tb.get_fold_tbl singletons new_var_map in
  let f t = [] in
  let (nl_tree1, hmap_tree1),  (nl_tree2, hmap_tree2) = R.extract_tame_hypermap t1 ,  R.extract_tame_hypermap t2 in
  let nl1, nl2 = R.fold_poly f fold_tbl xconvert nl_tree1, R.fold_poly f fold_tbl xconvert nl_tree2 in
  let hmap1, hmap2 = R.fold_poly f fold_tbl false hmap_tree1, R.fold_poly f fold_tbl false hmap_tree2 in
  let hmap1_xconvert, hmap2_xconvert = R.fold_poly f fold_tbl xconvert hmap_tree1, R.fold_poly f fold_tbl xconvert hmap_tree2 in
    U._pr_ (Ty.string_T nl1) true false;    U._pr_ ("\n") true false; U._pr_ (Ty.string_T hmap1) true false;
  let lhs, rhs = if norm then (nl1 <+> hmap1_xconvert) <-> (nl2 <+> hmap2_xconvert), O.zero_T else nl1 <+> hmap1_xconvert, nl2 <+> hmap2_xconvert in


  let var_list, bounds = List.split new_var_map in
  let tm2_lhs = Tm.initiate_tm2 vars nl1 hmap1 xconvert in
  let tm2_rhs = if norm then Tm.tm2_zero nvars else Tm.initiate_tm2 vars nl2 hmap2 xconvert in
  let p0 = P.Pc N.zero_i in
  let get_pol_min tbl p is_min = Sergei.get_bound_poly p tbl is_min in
  let get_semialg_min ?(incr_cliques = true) ?(incr_relax_order = false) ?(relax_order = 2) ?(force = false) tbl p cstr eqcstr cstr_major_min is_min is_top_level_bound is_L1 =
    if force && P.is_Pol p && List.length cstr = 0 then
     try 
      let m, x = get_pol_min tbl (P.pol_of_fw p) is_min, [] in
        m, m, x, x, p0, cert0
     with Sergei.Sergei_error -> Sparsepop.get_bound_poly incr_cliques incr_relax_order p cstr eqcstr cstr_major_min tbl is_min oc_in oc_out relax_order 1 (Fu.relax_type_of_string Config.Config.relax_type) is_top_level_bound is_L1 
    else
         begin 
           Sparsepop.get_bound_poly incr_cliques incr_relax_order p cstr eqcstr cstr_major_min tbl is_min oc_in oc_out relax_order 1 (Fu.relax_type_of_string Config.Config.relax_type) is_top_level_bound false 
         end
  in
  let box_list = [bounds] in
    U._pr_ (Ty.string_T lhs) true true;
    let n_pbs = ref (List.length box_list) in 

    let lhs_I_f bounds = algo_cut tm2_lhs get_semialg_min var_list (Array.to_list vars) lhs bounds relax_order n_pbs No_cut in
    let lhs_I = I.union_list_I (List.map lhs_I_f box_list) in
    let rhs_I = if norm then I.zero_I else algo_cut tm2_rhs get_semialg_min var_list (Array.to_list vars) rhs bounds relax_order n_pbs No_cut in
      U._pr_ ("...Ending algo_cut") true true; 

      lhs_I, rhs_I
  end
