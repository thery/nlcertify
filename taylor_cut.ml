module type T = 
sig
  type num_i 
  type grad 
  type hess
  type pol 
  type fw_pol
  type interval 
  type algo_semi_alg 
  type fold_poly_tree
  type eval_tbl
  type rewrite_tbl
  type poly_interval
  type positive

  type xO = num_i list
  type lambda = Lm of num_i | LM of num_i
  type taylor_model = TM2 of xO * grad * hess * lambda * lambda
  type x0_cmp = X0_CMP of xO * num_i * num_i array * num_i array array * pol array * num_i * num_i
  val string_of_lambda : lambda -> string
  val string_of_cmp : x0_cmp -> string
  val cmp_of_x0 : x0_cmp -> xO * num_i * num_i array * num_i array array * pol array * num_i * num_i
  val hess_of_x0_cmp : x0_cmp -> num_i array array
  val x0_of_x0_cmp : x0_cmp -> xO
  val grad_of_x0_cmp : x0_cmp -> num_i array
  val f_of_x0_cmp : x0_cmp -> num_i
  val lambda_min_of_x0_cmp : x0_cmp -> num_i 
  val lambda_max_of_x0_cmp : x0_cmp -> num_i 
  val tm2_zero : int -> taylor_model
  val hess_of_tm2 : taylor_model -> fold_poly_tree array array
  val grad_of_tm2 : taylor_model -> fold_poly_tree array
  val eval_grad : taylor_model -> positive list -> num_i list -> eval_tbl -> rewrite_tbl -> num_i array
  val eval_hess : taylor_model -> positive list -> num_i list -> eval_tbl -> rewrite_tbl -> num_i array array
  val ia_grad : algo_semi_alg -> taylor_model -> eval_tbl -> (string, poly_interval) Hashtbl.t -> positive list -> interval array
  val ia_hess : algo_semi_alg -> taylor_model -> eval_tbl -> (string, poly_interval) Hashtbl.t -> positive list ->  interval array array
  val sym_hess_I : algo_semi_alg -> taylor_model -> eval_tbl -> (string, poly_interval) Hashtbl.t -> positive list ->  interval array array
  val norm_with_hess : num_i -> num_i array array -> num_i array
  val norm_with_hess_using_sym : (num_i * num_i) list -> num_i -> num_i array array -> bool array -> num_i array
  val gen_H_bounds : num_i array array -> (num_i * num_i) list
  val gen_tau_bounds : num_i list -> num_i array -> num_i * num_i
  val cst_of_TM2 : num_i array -> num_i -> num_i array -> num_i array array -> num_i
  val delta_h : positive array -> num_i list -> pol array
  val inner_prod_num_pol : num_i array -> pol array -> pol
  val inner_prod_pol_pol : pol array -> pol array -> pol
  val norm_sqr_pol : pol array -> pol
  val mat_pol_prod : num_i array array -> pol array -> pol array
  val array_pol_prod : num_i array -> pol array -> pol array
  val lambda_min_of_hess : num_i array array -> num_i
  val lambda_max_of_hess : num_i array array -> num_i
  val initiate_tm2 : positive array -> fold_poly_tree -> fold_poly_tree -> bool -> taylor_model
  val proj_tm2 : int -> positive -> num_i -> taylor_model -> taylor_model
  val compute_grad_hess : positive array -> eval_tbl -> rewrite_tbl -> fold_poly_tree -> taylor_model -> xO -> num_i -> num_i -> x0_cmp
  val assign_lmin : num_i -> x0_cmp -> x0_cmp
  val assign_lmax : num_i -> x0_cmp -> x0_cmp
  val compute_lm_hx0 : x0_cmp -> num_i
  val compute_lambda_min : algo_semi_alg -> eval_tbl -> rewrite_tbl -> (taylor_model, interval array array ) Hashtbl.t -> taylor_model -> x0_cmp -> ?var_list:string list -> positive list -> ?sub_box:(num_i * num_i) list -> bool -> num_i * num_i
  val lin_pol_of_tm2 : algo_semi_alg  -> eval_tbl -> taylor_model -> x0_cmp -> ?var_list:string list -> positive list -> ?bounds: (num_i * num_i) list -> num_i array -> bool -> fw_pol * fw_pol * (num_i * num_i) list * (num_i * num_i) list list list
  val quadr_pol_of_tm2 : algo_semi_alg  -> eval_tbl -> taylor_model -> x0_cmp -> ?var_list:string list -> positive list -> ?bounds: (num_i * num_i) list -> num_i array -> bool -> fw_pol * fw_pol * (num_i * num_i) list * (num_i * num_i) list list list
  val pol_of_tm2 : algo_semi_alg  -> eval_tbl -> taylor_model -> x0_cmp -> ?var_list:string list -> positive list -> ?bounds: (num_i * num_i) list -> num_i array -> bool -> fw_pol * fw_pol * (num_i * num_i) list * (num_i * num_i) list list list
  val get_min_partition : (num_i * num_i) list list list -> (num_i * num_i) list list
end


module Make 
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (M: Mesh_interval.T with type num_i = N.t and type interval = I.interval) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval) 
  (Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval) 
  (F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) 
  (Ty: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol) 
  (D: Derivatives.T with type num_i = N.t and type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive) 
  (Tb: Algo_tables.T with type num_i = N.t and type p = P.positive and type eval_tbl = Ty.eval_tbl) 
  (Ia : Interval_arith.T with type num_i = N.t and type positive = P.positive and type interval = I.interval and type eval_tbl = Ty.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type poly_interval = Ty.poly_interval and type algo_semi_alg = Ty.algo_semi_alg) 
  (C: Cut_box.T with type num_i = N.t) 
  (O: Operations.T with type num_i = N.t and type pol = P.pol and type eval_tbl = Tb.eval_tbl and type fold_poly_tree = Ty.fold_poly_tree and type positive = P.positive and type rewrite_tbl = Ty.rewrite_tbl) = struct 

    type num_i = N.t
    type grad = D.grad
    type hess = D.hess
    type pol = P.pol
    type fw_pol = P.fw_pol 
    type interval = I.interval
    type algo_semi_alg = Ty.algo_semi_alg
    type fold_poly_tree = Ty.fold_poly_tree
    type eval_tbl = Ty.eval_tbl
    type rewrite_tbl = Ty.rewrite_tbl
    type poly_interval = Ty.poly_interval
    type positive = P.positive
     
    type xO = num_i list
    type lambda = Lm of num_i | LM of num_i
    type taylor_model = TM2 of xO * grad * hess * lambda * lambda
    type x0_cmp = X0_CMP of xO * num_i * num_i array * num_i array array * pol array * num_i * num_i 

    let string_of_lambda = function
      | Lm i -> N.string_of_i i
      | LM i -> N.string_of_i i

    let lambda_min, lambda_min_robust = 
      let module Nf =  (val (Numeric.of_string ("float")): Numeric.T) in
      let module Uf = Tutils.Make (Nf) in
      let module Funf = Functions.Make (Nf) in
      let module If = Interval.Make (Nf)(Funf)(Uf) in 
      let module Pf = Polynomial.Make (Nf)(Uf)(If) in 
      let module Mf = Mesh_interval.Make (Nf)(Uf)(If) in
      let module Sdp = Sdp_aux.Make (Nf)(Uf)(Mf) in 
      let module Convert = Floatrat.Make (Nf)(If)(Pf)(N)(I)(P) in
        (fun (a, b) -> 
           let af, bf = Convert.array_to_float a, Convert.matrix_list_to_float b in
             Convert.float_to_num_box (Sdp.lambda_min af bf)),
        (fun (a, b) -> 
           let af, bf = Convert.matrix_to_float a, Convert.matrix_to_float b in
        Convert.float_to_num_box (Sdp.lambda_min_robust af bf))
      

    let string_of_cmp = function
      | X0_CMP (x0, fx0, gx0, hx0, delta, lmin, lmax) -> 
          begin
            let sx = I.string_of_list_i x0 in
            let sf = N.string_of_i fx0 in
            let sg = M.string_of_array gx0 in
            let sh = M.string_of_matrix hx0 in
            let sd = M.string_of_array_f delta P.string_of_pol in
            let slmin = N.string_of_i lmin in
            let slmax = N.string_of_i lmax in
              Printf.sprintf "x0 = %s, fx0 = %s, gx0 = %s, hx0 = %s, delta = %s, lambda_min = %s lambda_max = %s" sx sf sg sh sd slmin slmax
          end 

    let cmp_of_x0 = function
      | X0_CMP (x0, fx0, gx0, hx0, delta, lmin, lmax) -> x0, fx0, gx0, hx0, delta, lmin, lmax
    let hess_of_x0_cmp = function
      | X0_CMP (_, _, _, hx0, _, _, _) -> hx0 
    let x0_of_x0_cmp = function
      | X0_CMP (x0, _, _, _, _, _, _) -> x0 
    let grad_of_x0_cmp = function
      | X0_CMP (_, _, gx0, _, _, _, _) -> gx0 
    let f_of_x0_cmp = function
      | X0_CMP (_, fx0, _, _, _, _, _) -> fx0 
    let lambda_min_of_x0_cmp = function
      | X0_CMP (_, _, _, _, _, lmin, _) -> lmin
    let lambda_max_of_x0_cmp = function
      | X0_CMP (_, _, _, _, _, _, lmax) -> lmax


    let tm2_zero n = 
      let x = U.init_list n N.zero_i in
      let lambda_min = Lm N.zero_i in
      let lambda_max = LM N.zero_i in
      let g = D.grad_zero_T n in
      let h = D.hessian_zero_T n in 
        TM2 (x, g, h, lambda_min, lambda_max) 

    let hess_of_tm2 = function
      | TM2 (_, _, D.Hess h, _, _) -> h

    let grad_of_tm2 = function
      | TM2 (_, D.Grad g, _, _, _) -> g

    let string_of_grad_T g = M.string_of_array_f g Ty.string_T
    let string_of_hess_T h = M.string_of_matrix_f h Ty.string_T

    let eval_grad tm2 vars x0 tbl tbl_loc : num_i array = 
      let g =  Array.map (fun t -> O.eval_T (Tb.get_tbl_pol vars x0) tbl tbl_loc t) (grad_of_tm2 tm2) in
        g

    let eval_hess tm2 vars x0 tbl tbl_loc : num_i array array = M.map_matrix N.zero_i (O.eval_T (Tb.get_tbl_pol vars x0) tbl tbl_loc) (hess_of_tm2 tm2)

    let ia_grad get_semialg_min tm2 tbl tbl_loc vars : interval array = 
      let tbl_I = Hashtbl.create 30 in
        Array.map (fun t -> Ia.interval_T get_semialg_min tbl tbl_I tbl_loc vars t false) (grad_of_tm2 tm2)

    let ia_hess get_semialg_min tm2 tbl tbl_loc vars : interval array array = 
      (* 
      * if degree of second partial derivatives fij are less than 4 then use
       * interval_T, otherwise for each fij initialize tm2 and use max_plus
       * function
      *
      *
      * *)
      let tbl_I = Hashtbl.create 30 in
      let prev = Unix.gettimeofday () in
      let result = M.map_sym_matrix I.zero_I (fun t -> Ia.interval_T get_semialg_min tbl tbl_I tbl_loc vars t false) (hess_of_tm2 tm2) in
      let current = Unix.gettimeofday () in 
      let time_mess = Printf.sprintf "ia hess time: %f" (current -. prev) in 
        U._pr_ time_mess true true;
        result

    let sym_hess_I get_semialg_min tm2 tbl tbl_loc vars : interval array array = 
      let hx = ia_hess get_semialg_min tm2 tbl tbl_loc vars in
      let n = M.size hx in
        for i = 0 to (n -1) do
          for j = i to (n - 1) do
            let hx_ij = I.intersection_I (hx. (i). (j))  (hx. (j). (i)) in
              hx. (i). (j) <- hx_ij; hx. (j). (i) <- hx_ij; 
          done;
        done;
        hx

    let norm_with_hess rm hx0 : num_i array = 
      let d' = M.inv_of_diag (M.diag_of_matrix hx0 N.zero_i) in
      let sqrt_d' = M.sqrt_diag d' in
        U._pr_ (M.string_of_array sqrt_d') true false;
        Array.map (N.mult_i rm) sqrt_d'

    let norm_with_hess_using_sym bounds rm hx0 sym_array : num_i array = 
      let widths = M.get_widths bounds in 
      let widths = Array.of_list widths in
      let d' = M.inv_of_diag (M.diag_of_matrix hx0 N.zero_i) in
      let n = M.size d' in
      let result = Array.make n N.zero_i in
      (*
       let sqrt_d' = sqrt_diag d' in
       *)
      let sqrt_d' = Array.make n N.one_i in
        U._pr_ (M.string_of_array sqrt_d') true false;
        for i = 0 to (n -1) do
          result. (i) <- if sym_array. (i) then widths. (i) else N.mult_i sqrt_d'. (i) rm;
        done;
        result

    let gen_H_bounds (*x0 gx0*) hx0 : (num_i * num_i) list = 
      let n = Array.length hx0 in
      let bounds = Array.make n (N.zero_i, N.zero_i) in
        for i = 0 to (n -1) do
          for j = 0 to (n - 1) do
            let c_ij = (if i = j then N.minus_i else N.abs_i) hx0. (i). (j) in
              (*
               let c_ij = add_i c_ij (abs_i (sub_i gx0. (i) (nth x0 i))) in
               *)
              bounds. (i) <- N.add_i (fst (bounds. (i))) (N.div_i c_ij N.two_i), N.pow_i N.ten_i N.two_i;
          done;
          bounds.(i) <- N.max_i N.zero_i (fst bounds. (i)), snd bounds. (i);
        done;
        Array.to_list bounds

    let gen_tau_bounds x0 gx0 : num_i * num_i = 
      let tau = ref N.zero_i in
      let n = Array.length gx0 in
        for i = 0 to (n -1) do
          tau := N.add_i !tau (N.abs_i (N.sub_i gx0. (i) (List.nth x0 i)))
        done;
        (*
         div_i !tau two_i, 100.0
         *)
        N.zero_i, N.pow_i N.ten_i N.two_i

    let cst_of_TM2 x0 fx0 gx0 hx0 : num_i = 
      let q = M.matrix_array_mult2_i x0 hx0 in
      let q = N.div_i (M.inner_product x0 q) N.two_i in
      let l = M.inner_product x0 gx0 in
      let cst = N.add_i (N.sub_i fx0 l) q in
        U._pr_ (N.string_of_i cst) true false;
        cst

(*
let delta_h x y = matrix_sub N.zero_i minus_i add_i (matrix_of_list N.zero_i y) (matrix_of_list N.zero_i x)
 *)

    let delta_h vars x0 : pol array = 
      let nvars = M.size vars in
      let x0 = Array.of_list x0 in
        assert (nvars = M.size x0);
        let pols = Array.map P.mk_X vars in
        let res = Array.make nvars (P.p0 N.zero_i) in
          for i = 0 to (nvars - 1) do
            res. (i) <- P.p_subC  (pols. (i)) (x0. (i));
          done;
          res

    let inner_prod_num_pol num_tbl pol_tbl : pol = 
      let n = M.size num_tbl in
      let r = ref (P.p0 N.zero_i) in
        assert (n = M.size pol_tbl);
        for i = 0 to (n -1) do
          r := P.p_add !r (P.p_mulC (pol_tbl. (i)) (num_tbl. (i)));
        done;
        !r

    let inner_prod_pol_pol (p1 : pol array) (p2 : pol array) : pol = 
      let n = M.size p1 in
      let r = ref (P.p0 N.zero_i) in
        assert (n = M.size p2);
        for i = 0 to (n -1) do
          r := P.p_add !r (P.p_mul (p1. (i)) (p2. (i)));
        done;
        !r

    let norm_sqr_pol pol_tbl : pol = inner_prod_pol_pol pol_tbl pol_tbl

    let mat_pol_prod m p :  pol array = 
      let n = M.size m in
      let r = Array.make n (P.p0 N.zero_i) in
        for i = 0 to (n -1) do
          r. (i) <- inner_prod_num_pol (m. (i)) p;
        done;
        r
    let array_pol_prod d p : pol array = 
      let n = M.size d in
      let r = Array.make n (P.p0 N.zero_i) in
        for i = 0 to (n -1) do
          r. (i) <- P.p_mulC (p. (i)) (d. (i));
        done;
        r

    let lambda_min_of_hess hx = 
      let n = M.size hx in
      let c = [| N.minus_i N.one_i|] in
      let f0 = M.matrix_opp N.zero_i N.minus_i hx in
      let f1 = M.matrix_opp N.zero_i N.minus_i (M.matrix_id N.zero_i N.one_i n) in
      let mat_list = [f0; f1] in
        lambda_min (c, mat_list)

    let lambda_max_of_hess  hx =
      let hx_opp = M.matrix_opp N.zero_i N.minus_i hx in
        N.minus_i (lambda_min_of_hess  hx_opp)

    let approx_lambda_min m = 
      let m = M.matrix_rho_I m in
      let n = M.size m in
      let sum_array = Array.make n N.zero_i in
        for i = 0 to (n -1) do
          for j = 0 to (n -1) do
            sum_array. (i) <- N.add_i (sum_array. (i)) (m. (i). (j));
          done;
        done;
        I.max_list (Array.to_list sum_array)

    let initiate_tm2 vars nl hmap xconvert = 
      let tbl' = Hashtbl.create 20 in
      let n = M.size vars in
      let x = U.init_list n N.zero_i in
      let g = D.grad_T vars tbl' nl hmap xconvert in
      let h = D.hessian_T vars tbl' nl xconvert in
      let lmin = Lm N.zero_i in
      let lmax = LM N.zero_i in
        TM2 (x, g, h, lmin, lmax)

    let proj_tm2 dir_idx pos_k value = function
      | TM2 (x, g, h, _, _) -> 
          begin
            let n = List.length x in
            let proj_x = U.init_list (n - 1) N.zero_i in
            let proj_g = D.proj_grad_T dir_idx pos_k value g in
            let proj_h = D.proj_hess_T dir_idx pos_k value h in
            let lmin = Lm N.zero_i in
            let lmax = LM N.zero_i in
              TM2 (proj_x, proj_g, proj_h, lmin, lmax)
          end
 

    let compute_grad_hess vars tbl tbl_loc t tm2 x0 lmin lmax : x0_cmp = 
      let vars = Array.to_list vars in
      U._pr_ "eval f at x0" true false;
      let fx0 = O.eval_T (Tb.get_tbl_pol vars x0) tbl tbl_loc t in
        U._pr_ "eval grad at x0" true false;
        let gx0 = eval_grad tm2 vars x0 tbl tbl_loc in
          U._pr_ "compute vars - x0" true false;
          let delta = delta_h (Array.of_list vars) x0 in
            U._pr_ "eval hessian at x0" true false;
            let hx0 = eval_hess tm2 vars x0 tbl tbl_loc in
              U._pr_ (M.string_of_matrix hx0) true false;
              X0_CMP (x0, fx0, gx0, hx0, delta, lmin, lmax)

    let assign_lmin lmin = function
      | X0_CMP (x0, fx0, gx0, hx0, delta, _, lmax) ->  X0_CMP (x0, fx0, gx0, hx0, delta, lmin, lmax)

    let assign_lmax lmax = function
      | X0_CMP (x0, fx0, gx0, hx0, delta, lmin, _) ->  X0_CMP (x0, fx0, gx0, hx0, delta, lmin, lmax)

    let compute_lm_hx0 x0_cmp  = 
      let hx0 =  hess_of_x0_cmp x0_cmp in
      let n = M.size hx0 in
      let zero_matrix = Array.make_matrix n n N.zero_i in
      let hess_I = M.map_matrix I.Void_i I.mk_i_I hx0 in
      let center_hess_I, center_hx0 = M.center_sum_matrix_I (M.matrix_minus_I hess_I) zero_matrix in
      let b0 = M.matrix_rho_I center_hess_I in
        lambda_min_robust (b0, center_hx0)


(* fst: Returns a lower bound of lambda_min (hx) by SDP where hx is the hessian matrix interval *)
(* snd: Returns an upper bound of lambda_max (hx) by SDP where hx is the hessian matrix interval *)

    let compute_lambda_min lambda_min_method tbl tbl_loc tbl_hess_I tm2 x0_cmp  ?(var_list = []) vars ?(sub_box = []) do_scaling =
      let hx0 = hess_of_x0_cmp x0_cmp in
      let n = M.size hx0 in
      let zero_matrix = Array.make_matrix n n N.zero_i in      
      let cmp_hess_I () =     
        if Config.Config.lambda_min_heuristic then
          begin
            let mesh =  M.mesh_of_point sub_box 2 in
            let mesh_hx = List.map (fun x -> eval_hess tm2 vars x tbl tbl_loc) mesh in
              U._pr_ (U.string_of_tuple_list sub_box) true false;
              M.matrix_list_to_matrix_I n n mesh_hx
          end
        else 
          begin
          (*
           let get_min t = U.fst_fst_fst (lambda_min_method tbl (Fu.mk_Pw t) [] true) in
           let get_max t = U.fst_fst_fst (lambda_min_method tbl (Fu.mk_Pw t) [] false) in
           let min_matrix = M.map_matrix N.zero_i get_min (hess_of_tm2 tm2) in
           let max_matrix = M.map_matrix N.zero_i get_max (hess_of_tm2 tm2) in
           *)
            ia_hess lambda_min_method tm2 tbl tbl_loc vars 
          end in
      let hess_I = if Config.Config.approx_lambda_min then try Hashtbl.find tbl_hess_I tm2 with Not_found -> cmp_hess_I () else cmp_hess_I () in
        Hashtbl.replace tbl_hess_I tm2 hess_I;
      (* if minor_tm2 then minor_lambda_min, hence we actually don't use hx0
       * in this function *)
      let snd_matrix = if Config.Config.minor_lambda_min then zero_matrix else hx0 in
(* WARNING: center_hess_I + center_hx0 = h''(x0) - h''(x) WARNING *)
      let center_hess_I, center_hx0 = M.center_sum_matrix_I (M.matrix_minus_I hess_I) snd_matrix in

      (* Under approx of lmin (h''(x) - h''(x0)) = lmin (- center_hess_I - center_hx0) by 
       * lmin (- center_hx0) - max_i Sum_j |center_hess_I|_ij *)
      let center_hx0_opp =  M.matrix_opp N.zero_i N.minus_i center_hx0 in
      let lmin_x, lmax_x = lambda_min_of_hess center_hx0_opp, lambda_max_of_hess center_hx0_opp in
      let lmax_y = approx_lambda_min center_hess_I in
      let lmin_approx, lmax_approx = N.sub_i lmin_x lmax_y, N.add_i lmax_x lmax_y in
 
    (* Better under approx by robust sdp *)
      let b0 = M.matrix_rho_I center_hess_I in
      let lmin = if Config.Config.approx_lambda_min then lmin_approx else lambda_min_robust (b0, center_hx0) in

      let time_start =  Unix.gettimeofday () in 
      let lmax = if Config.Config.approx_lambda_min then lmax_approx else N.minus_i (lambda_min_robust( b0, center_hx0_opp)) in

        let time_end = Unix.gettimeofday () in 
        let final_mess = Printf.sprintf "Lmax Robust time: %f" (time_end -. time_start) in
          U._pr_ final_mess true true; 


      let (*scale_lambda*) _ = if do_scaling then 
        let d = M.diag_of_matrix hx0 N.zero_i in
        let d' = M.inv_of_diag d in
        let sd = if Config.Config.inverse_hessian_diag then M.sqrt_diag d' else M.sqrt_diag d in
        let d'_hess_I = M.array_matrix_mult_I (Array.map I.mk_num_I sd) center_hess_I in
        let d'_hess_I_d' = M.matrix_array_mult_I (Array.map I.mk_num_I sd) d'_hess_I in
        let d'_hx0 = M.array_matrix_mult sd center_hx0 in
        let d'_hx0_d' = M.matrix_array_mult sd d'_hx0 in
        let d'_b0_d' = M.matrix_rho_I d'_hess_I_d' in
        lambda_min_robust (d'_b0_d', d'_hx0_d')
      else lmin 
      in
        U._pr_ (Printf.sprintf "lambda_min approx: %s lambda_max approx: %s" (N.string_of_i lmin_approx) (N.string_of_i lmax_approx)) true true;
        U._pr_ (Printf.sprintf "lambda_min: %s lambda_max: %s" (N.string_of_i lmin) (N.string_of_i lmax)) true true;
        lmin, lmax


    let lin_pol_of_tm2 (get_semialg_min:algo_semi_alg) tbl tm2 x0_cmp  ?(var_list=[]) vars ?(bounds=[]) radius_array pre_algo_test =
      let x0, fx0, gx0, hx0, delta, lmin, lmax = cmp_of_x0 x0_cmp in
      let sub_box, partitions = 
        if pre_algo_test then bounds, []
        else C.mk_box_list_hess bounds x0 hx0 radius_array 
      in
        let pol_g = inner_prod_num_pol gx0 delta in
        let curve = N.div_i lmin N.two_i in
        let pol_lambda =  P.p_mulC (norm_sqr_pol delta) curve in
        let curve_max = N.div_i lmax N.two_i in
        let pol_lambda_max =  P.p_mulC (norm_sqr_pol delta) curve_max in
        (*let tbl = Tb.get_tbl var_list bounds vars in*)
        let tbl_I, tbl_loc =  Hashtbl.create 1, Hashtbl.create 2 in
        let quadr_min = I.inf_I (Ia.interval_T get_semialg_min tbl tbl_I tbl_loc vars (O.poly_T  pol_lambda) false) in
        let quadr_max = I.sup_I (Ia.interval_T get_semialg_min tbl tbl_I tbl_loc vars (O.poly_T  pol_lambda_max) false) in
        let p_min = P.p_addC pol_g (N.add_i fx0 quadr_min) in
        let f_min = Fu.mk_Pw p_min in
        let p_max = P.p_addC pol_g (N.add_i fx0 quadr_max) in
        let f_max = Fu.mk_Pw p_max in
            f_min, f_max, sub_box, partitions


    let quadr_pol_of_tm2 (get_semialg_min:algo_semi_alg) tbl tm2 x0_cmp ?(var_list=[]) vars ?(bounds=[]) radius_array pre_algo_test =
      let x0, fx0, gx0, hx0, delta, lmin, lmax = cmp_of_x0 x0_cmp in
      let sub_box, partitions = 
        if pre_algo_test then bounds, []
        else C.mk_box_list_hess bounds x0 hx0 radius_array 
      in
        let pol_g = inner_prod_num_pol gx0 delta in
        let curve = N.div_i lmin N.two_i in
        let pol_lambda =  P.p_mulC (norm_sqr_pol delta) curve in
        let p_min = P.p_addC (P.p_add pol_g pol_lambda) fx0 in
        let curve_max = N.div_i lmax N.two_i in
        let pol_lambda_max =  P.p_mulC (norm_sqr_pol delta) curve_max in
        let p_max = P.p_addC (P.p_add pol_g pol_lambda_max) fx0 in
          let f_min = Fu.mk_Pw p_min in
          let f_max = Fu.mk_Pw p_max in
            f_min, f_max, sub_box, partitions


    let pol_of_tm2 (get_semialg_min:algo_semi_alg) tbl tm2 x0_cmp ?(var_list=[]) vars ?(bounds=[]) radius_array pre_algo_test =
      let do_scaling = false in
      let x0, fx0, gx0, hx0, delta, lmin, lmax = cmp_of_x0 x0_cmp in
      let sub_box, partitions = 
        if pre_algo_test then bounds, []
        else C.mk_box_list_hess bounds x0 hx0 radius_array 
      in
        U._pr_ (U.concat_string_with_string (List.map U.string_of_cut_box partitions) "next partition\n\n") false false;
          U._pr_ ("Sub box: " ^ U.string_of_tuple_list sub_box) true false;
          (*let scale_lm = lm in*)
          (*
           let lambda, scale_lambda = compute_lambda_min get_semialg_min tbl tbl_loc tm2 x0_cmp  var_list sub_box do_scaling in
           *)
          U._pr_ (string_of_cmp x0_cmp) true false;
          let pol_g = inner_prod_num_pol gx0 delta in
          let pol_h = inner_prod_pol_pol delta (mat_pol_prod hx0 delta) in
          let pol_h = P.p_mulC pol_h (N.inv_i N.two_i) in
          let curve = N.div_i lmin N.two_i in
          let pol_lambda =  P.p_mulC (norm_sqr_pol delta) curve in
          let p_min = P.p_addC (P.p_add pol_g (P.p_add pol_h pol_lambda)) fx0 in
          let curve_max = N.div_i lmax N.two_i in
          let pol_lambda_max =  P.p_mulC (norm_sqr_pol delta) curve_max in
          let p_max = P.p_addC (P.p_add pol_g (P.p_add pol_h pol_lambda_max)) fx0 in
            U._pr_ (P.string_of_pol p_min) false false;
            let f_min = Fu.mk_Pw p_min in
            let f_max = Fu.mk_Pw p_max in
              
            let p_scale =  if do_scaling then
              begin
                let d = M.diag_of_matrix hx0 N.zero_i in
                let d' = M.inv_of_diag d in
                let sd = if Config.Config.inverse_hessian_diag then M.sqrt_diag d else M.sqrt_diag d' in
                let d_delta = array_pol_prod sd delta in
                let pol_scale_lambda = P.p_mulC (norm_sqr_pol d_delta) curve in
                let p_scale  = P.p_addC (P.p_add pol_g (P.p_add pol_h pol_scale_lambda)) fx0 in
                let (*p_quadr_terms*) _ = P.p_addC (P.p_add pol_g pol_h) fx0 in
                  p_scale
              end
            else p_min in
              U._pr_ (P.string_of_pol p_scale) true false;              
              f_min, f_max, sub_box, partitions

    and get_min_partition partitions =
      let p = List.nth partitions 0 in
      let p = M.filter_singleton_box p in
        p

  end
