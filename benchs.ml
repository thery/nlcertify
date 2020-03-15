
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
  (Tb: Algo_tables.T with type num_i = N.t and type pol = P.pol with type eval_tbl = Ty.eval_tbl and type fw_tbl = Ty.fw_tbl and type p = P.positive)  
  (O: Operations.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Tb.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive and type rewrite_tbl = Ty.rewrite_tbl) 
  = struct

    (*
    type num_i = N.t
    type interval = I.interval
    type fw_pol = P.fw_pol
    type positive = P.positive
    type fold_poly_tree = Ty.fold_poly_tree
    type func_tree = F.func_tree
    type poly_interval = Ty.poly_interval
     *)
    open O.Infixes

    let h3_17 ()  = 
      let h3_func = ref O.zero_T in
      let c = [|1.;1.2;3.;3.2|] in
      let a = [| [|3.;10.;30.|]; [|0.1;10.;35.|]; [|3.;10.;30.|]; [|0.1;10.;35.|]  |] in
      let p = [| [|0.3689;0.117;0.2673|]; [|0.4699;0.4387;0.747|]; [|0.1091;0.8732;0.5547|]; [|0.03815;0.5743;0.8828|]  |] in
        for i = 0 to 3 do
          let exp_arg = ref (P.Pc N.zero_i) in
            for j = 0 to 2 do
              let xj = P.mkX_i (j + 1) in
              let aij, pij = N.num_of_float (a. (i). (j)), N.num_of_float (p. (i). (j)) in
              let pol = P.p_mulC (P.p_square (P.p_subC xj pij)) aij in
                exp_arg := P.p_sub !exp_arg pol;
            done;
            let ci = N.num_of_float (c. (i)) in
            let ci_T = O.const_T ci in
            let tree = ci_T <*> O.exp_T (O.poly_T !exp_arg) in
              h3_func := !h3_func <-> tree;
        done;
        !h3_func <+> O.const_T (N.num_of_float 3.863) 

    let h3_18 ()  = 
      let h3_func = ref O.zero_T in
      let c = [|1.;1.2;3.;3.2|] in
      let a = [| [|10.;3.;17.;3.5;1.7;8.|]; [|0.05;10.;17.;0.1;8.;14.|]; [|3.;3.5;1.7;10.;17.;8.|]; [|17.;8.;0.05;10.;0.1;14.|]  |] in
      let p = [| [|0.1312;0.1696;0.5569;0.0124;0.8283;0.5886|]; [|0.2329;0.4135;0.8307;0.3736;0.1004;0.9991|]; [|0.2348;0.1451;0.3522;0.2883;0.3047;0.665|]; [|0.4047;0.8828;0.8732;0.5743;0.1091;0.0381|]  |] in
        for i = 0 to 3 do
          let exp_arg = ref (P.Pc N.zero_i) in
            for j = 0 to 5 do
              let xj = P.mkX_i (j + 1) in
              let aij, pij = N.num_of_float (a. (i). (j)), N.num_of_float (p. (i). (j)) in
              let pol = P.p_mulC (P.p_square (P.p_subC xj pij)) aij in
                exp_arg := P.p_sub !exp_arg pol;
            done;
            let ci = N.num_of_float (c. (i)) in
            let ci_T = O.const_T ci in
            let tree = ci_T <*> O.exp_T (O.poly_T !exp_arg) in
              h3_func := !h3_func <-> tree;
        done;
        !h3_func <+> O.const_T (N.num_of_float 4.) 

    let mc_24 () = 
      let x1, x2 = P.mkX_i 1, P.mkX_i 2 in
      let cx1, cx2 = P.p_mulC x1 (N.num_of_float 1.5),  P.p_mulC x2 (N.num_of_float 2.5) in
      let lin_pol = P.p_sub (P.p_addC cx2 N.one_i) cx1 in
      let pol = P.p_add (P.p_square (P.p_sub x1 x2)) lin_pol in
        O.sin_T (O.poly_T (P.p_add x1 x2)) <+> O.poly_T pol <+> O.const_T (N.num_of_float 1.92)

    let ml_27 n =
      let c = [|0.806; 0.517; 0.1; 0.908; 0.965|] in 
      let a = [| [|9.681; 0.667; 4.783; 9.095; 3.517; 9.325; 6.544; 0.211; 5.122; 2.020|]; 
                 [|9.400; 2.041; 3.788; 7.931; 2.882; 2.672; 3.568; 1.284; 7.033; 7.374|];
                 [|8.025; 9.152; 5.114; 7.621; 4.564; 4.711; 2.99; 6.126; 0.734; 4.982|];
                 [|2.196; 0.415; 5.649; 6.979; 9.510; 9.166; 6.304; 6.054; 9.377; 1.426|];
                 [|8.074; 8.777; 3.467; 1.867; 6.708; 6.349; 4.534; 0.276; 7.633; 1.567|]|] in
      let ml_func = ref O.zero_T in
        for j = 0 to 5 - 1 do          
          let dj = ref (P.Pc N.zero_i) in
            for i = 0 to n - 1 do
              let xi = P.mkX_i (i + 1) in
              let aji = N.num_of_float a. (j). (i) in
                dj := P.p_add !dj (P.p_square (P.p_subC xi aji));
            done;
            let c_T = O.const_T (N.num_of_float c. (j)) in
              (*
            let pi = I.pi in
            let cos_arg = P.p_mulC !dj (N.inv_i pi) in
            let exp_arg = P.p_mulC !dj (N.minus_i pi) in
            ml_func := !ml_func <-> (c_T <*> O.cos_T (O.poly_T cos_arg) <*> O.exp_T (O.poly_T exp_arg));
               *)
              ml_func := !ml_func <-> ((c_T) <*> O.fun_T (O.poly_T !dj) "ml_27")
        done;
        !ml_func <+> O.const_T (N.num_of_float 0.9651) 

    let pp_33 n = 
      let pp_33_func = ref O.zero_T in
      let sum_log = ref O.zero_T in
        for i = 0 to n - 1 do
          let xi = P.mkX_i (i + 1) in
          let xi2 = P.p_subC xi N.two_i in
          let xi10 = P.p_opp (P.p_subC xi N.ten_i) in            
            pp_33_func := !pp_33_func <+> O.fun_T (O.poly_T xi2) "pp_33" <+> O.fun_T (O.poly_T xi10) "pp_33";     
             (*
            pp_33_func := !pp_33_func <+> O.square_T (O.log_T (O.poly_T xi2)) <+> O.square_T (O.log_T (O.poly_T xi10));
              *)
            sum_log := !sum_log <+> O.log_T (O.poly_T xi);
        done;
      let exp_func = O.exp_T (O.const_T (N.num_of_float 0.2) <*> !sum_log) in
        !pp_33_func <-> exp_func <+> O.const_T (N.num_of_float 46.) 

    let sbt_42 n = 
      let sbt_func = ref O.one_T in
        for i = 0 to n - 1 do
          let x = P.mkX_i (i + 1) in
          let sum = ref O.zero_T in
            for j = 1 to 5 do
              let cos_arg = P.p_addC (P.p_mulC x (N.num_of_int (j + 1))) (N.num_of_int j) in
              let term = O.const_T (N.num_of_int j) <*> O.cos_T (O.poly_T cos_arg)  in
                sum := !sum <+> term;
            done;
            sbt_func := !sbt_func <*> !sum;
        done;
        !sbt_func <+> O.const_T (N.num_of_float 190.)

    let swf_43 n  =
      let modify = false in
      let swf_func = ref O.zero_T in
      let sgn_bool = ref false in
      for j = 0 to n - 1 do
        let x = P.mkX_i (j + 1) in                  
        let x_modif = if j = n - 1 then P.mkX else P.mkX_i (j + 2) in        
        let px_modif = O.poly_T (if modify then (if !sgn_bool then P.padd else P.p_add) x x_modif  else x) in
        let px = O.poly_T x in         
          (*
        let term = px_modif <*> (O.sin_T  (O.sqrt_T px)) in (* x sin(sqrt(x)) *)           
           *)
          
        let term = px_modif <*>  O.fun_T px "swf_43" in
           
          swf_func := O.sub_T !swf_func term;
          sgn_bool := not (!sgn_bool);
      done;      
      !swf_func <+> O.const_T (N.mult_i (N.num_of_int n) (N.num_of_float 430.(*(488. +. 420.)*)))

(* we consider the ocp system with x = position, y = xdot, h = discrete time step u: control

Example 1:
                                                                 
x_{k + 1} = x_k + h y_k
y_{k + 1} = - h x_k + (1 - h) y_k + h u_k x_k

Example 2 when is_cubic = true :

x_{k + 1} = x_k + h y_k
y_{k + 1} = - h x_k - 2 h x_k^3 + (1 - h) y_k + h u_k

*)        
    let rec control_harmonic_bivar_interval is_cubic bounds_x bounds_y h_step get_semialg_min iter iter_max =
     if iter = iter_max then bounds_x, bounds_y 
     else 
       let ( + ), ( - ), ( * ), ( ^ ) = P.p_add, P.p_sub, P.p_mul, P.p_pow in 
      let x_I, y_I, h_I = I.mk_I bounds_x, I.mk_I bounds_y, I.mk_i_I h_step in
      let xnext_I = I.add_I x_I (I.mult_I h_I y_I) in
      let x, y, u, h, one_minus_h = P.mkX_i 1, P.mkX_i 2, (*P.mkX_i 3 *) P.Pc N.zero_i, P.Pc h_step, P.Pc (N.sub_i N.one_i h_step) in 
      let two_P = P.Pc N.two_i in
      let pol_hux, pol_hx, pol_hu = h * u * x, h * x, u * h in
      let pol_1_h_y = one_minus_h * y in
      let pol_h_x_cube = two_P * h * (x^3) in
      let pol_y = if is_cubic then pol_hu + pol_1_h_y - pol_hx - pol_h_x_cube else pol_hux + pol_1_h_y - pol_hx in
      let vars = Tb.array_indexes 2 in
      let var_list = ["x1"; "x2"(*; "x3" *)] in
      let (*bounds_u*) _ = N.minus_i N.two_i, N.two_i in
      let bounds = [bounds_x; bounds_y] in
      let tbl = Tb.get_tbl var_list bounds (Array.to_list vars) in
      let p = Fu.mk_Pw pol_y in
      let bounds_ynext = get_semialg_min tbl p true, get_semialg_min tbl p false in
       control_harmonic_bivar_interval is_cubic (I.tuple_of_I xnext_I) bounds_ynext h_step get_semialg_min (succ iter) iter_max

(* bounds_x = [(min x_0, max x_0); ...; (min x_k, max x_k) ] *)
(* bounds_y = [(min y_0, max y_0); ...; (min y_k, max y_k) ] *)

    let rec control_harmonic_bivar_lift_max is_cubic bounds ineqcstr eqcstr varpol_list h_step get_semialg_min iter iter_max =
      let partial_lift = Config.Config.nb_eqcstr in
     if iter = iter_max then bounds 
     else 
       let n = List.length bounds in
       let idx_lift = partial_lift -1 in
       let nb_ineqs = 2 * Config.Config.nb_templates - 1 in
       let x, y, h, coh = List.nth varpol_list (n - 2), List.nth varpol_list (n - 1),  P.Pc h_step, P.Pc (N.sub_i N.one_i h_step) in
       let vars = Tb.array_indexes n in
       let xnext, ynext = P.mkX_i (n + 1), P.mkX_i (n + 2) in
       let ( + ), ( - ), ( * ), ( ^ ) = P.p_add, P.p_sub, P.p_mul, P.p_pow in 
       let two_P = P.Pc N.two_i in
       let u = P.Pc N.zero_i in
       let hux, hx, hu, hy, cohy = h * u * x, h * x, u * h, h * y, coh * y in       
       let poly = hu + cohy - hx - (two_P * h * (x^3)) in
       let polx = x + hy in
       let fx, fy = Fu.mk_Pw polx, Fu.mk_Pw poly in
       let var_list = List.map P.string_of_pol varpol_list in      
        U.debug (U.string_of_list var_list);
        U.debug (U.string_of_tuple_list  bounds);
        U.debug (U.string_of_list (List.map P.string_of_pol eqcstr)); 
       let tbl = Tb.get_tbl var_list bounds (Array.to_list vars) in
       let eqcstr = U.sub_list eqcstr 0 idx_lift in
       let ineqcstr = U.sub_list ineqcstr 0 nb_ineqs in
         U.debug (U.string_of_list var_list);
         U.debug (U.string_of_tuple_list  bounds);
         U.debug (U.string_of_list (List.map P.string_of_pol eqcstr));
         
         let template_list = [(*(y^2) - (x^2) (* + (x^4)*); (y^2) + (x^2); (x^2) + (two_P * y);*) (*(x^3) + (two_P * y);*)  x + (two_P * y); y + (two_P * x)] in
         let get_template_ineqs template = 
           let eqcstr = U.sub_list eqcstr 0 (idx_lift / 4) in
           let ineqcstr = U.sub_list ineqcstr 0 (nb_ineqs / 4) in
           let fk = Fu.mk_Pw template in         
           let lo_k, up_k = get_semialg_min tbl fk ineqcstr eqcstr true, get_semialg_min tbl fk ineqcstr eqcstr false in 
             [(P.Pc up_k) - template; template - (P.Pc lo_k)]
         in
         let template_ineqs = List.concat (List.map get_template_ineqs template_list) in
         (*           
         let template_ineqs = [] in            
          *)
         let ineqcstr = (List.rev template_ineqs) @ ineqcstr in
         let ineqcstr = U.sub_list ineqcstr 0 nb_ineqs in
         let bounds_xnext = get_semialg_min tbl fx ineqcstr eqcstr true, get_semialg_min tbl fx ineqcstr eqcstr false in
         let bounds_ynext = get_semialg_min tbl fy ineqcstr eqcstr true, get_semialg_min tbl fy ineqcstr eqcstr false in
         let eqcstr = (ynext - poly)::(xnext - polx)::eqcstr in
         let bounds = bounds @ [bounds_xnext; bounds_ynext] in
         let varpol_list= varpol_list @ [xnext; ynext] in 
           control_harmonic_bivar_lift_max is_cubic bounds ineqcstr eqcstr varpol_list h_step get_semialg_min (succ iter) iter_max 

    let mk_templ_nonlinear_cube h lo up = 
      let ( + ), ( - ), ( * ), ( ** ) = N.add_i, N.sub_i, N.mult_i, N.pow_i in
      let one, two, three = N.one_i, N.two_i, N.three_i in
      let f x = (h - (h ** two) - one ) * x - two * (h ** two) * (x ** three) in
        f up, f lo

    let rec nonlinear_sequence bounds ineqcstr eqcstr varpol_list h_step get_semialg_min iter iter_max partial_lift use_templates =
     if iter = iter_max then bounds 
     else 
       let n = List.length bounds in
       let x0, x1, h1, h0, h0_cube, h = List.nth varpol_list (n - 2), List.nth varpol_list (n - 1),  P.Pc (N.sub_i N.two_i h_step), P.Pc (N.sub_i h_step (N.add_i N.one_i (N.sqr_i h_step))) , P.Pc (N.mult_i N.two_i (N.sqr_i h_step)), P.Pc h_step in
       let vars = Tb.array_indexes n in
       let x2 = P.mkX_i (n + 1) in
       let idx_prevx = n - 3 in
       let ( + ), ( - ), ( * ), ( ^ ) = P.p_add, P.p_sub, P.p_mul, P.p_pow in 
       let two_P = P.Pc N.two_i in
       let _ = P.Pc N.zero_i in
       let polx = (h1 * x1) + (h0 * x0) - (h0_cube * (x0 ^ 3)) in
       let fx = Fu.mk_Pw polx in
       let var_list = List.map P.string_of_pol varpol_list in
       let tbl = Tb.get_tbl var_list bounds (Array.to_list vars) in
       let eqcstr = U.sub_list eqcstr 0 partial_lift in
       let templ_cstr =  if List.length bounds < 3 then [] else 
         begin
           let lo, up = List.nth bounds idx_prevx in
           let ineq_rhs_lo, ineq_rhs_up = mk_templ_nonlinear_cube h_step lo up in
           let ineq_lhs = x1 - ((two_P - h) * x0) in
             [ineq_lhs - (P.Pc ineq_rhs_lo); (P.Pc ineq_rhs_up) - ineq_lhs]
         end in
       let ineqcstr = if use_templates then templ_cstr @ ineqcstr else ineqcstr in
       let ineqcstr = U.sub_list ineqcstr 0 partial_lift in
       let bounds_x2 = get_semialg_min tbl fx ineqcstr eqcstr true, get_semialg_min tbl fx ineqcstr eqcstr false in
       let eqcstr = (x2 - polx)::eqcstr in
       let bounds = bounds @ [bounds_x2] in
       let varpol_list= varpol_list @ [x2] in 
         nonlinear_sequence bounds ineqcstr eqcstr varpol_list h_step get_semialg_min (succ iter) iter_max partial_lift use_templates
  end
