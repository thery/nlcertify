open Tutils
open Interval
open Polynomial
open Poly_num
open Flyspeck_types
open Algo_types
open Algo_tables
open Operations
open Derivatives
open Sdp_aux
open List
open Mesh_interval
open Interval_arith

type xO = num_i list
type lambda = Lm of num_i
type taylor_model = TM2 of xO * grad * hess * lambda
type x0_cmp = X0_CMP of xO * num_i * num_i array * num_i array array * (num_i pol) array 
let inverse = false

let mk_partitions = Cut_box.mk_box_list_hess 
let cut_box = Cut_box.cut_box

let string_of_cmp = function
  | X0_CMP (x0, fx0, gx0, hx0, delta) -> 
     begin
       let sx = string_of_list_i x0 in
       let sf = string_of_i fx0 in
       let sg = string_of_array gx0 in
       let sh = string_of_matrix hx0 in
       let sd = string_of_array_f delta string_of_pol in
       Printf.sprintf "x0 = %s, fx0 = %s, gx0 = %s, hx0 = %s, delta = %s" sx sf sg sh sd
     end 

let cmp_of_x0 = function
  | X0_CMP (x0, fx0, gx0, hx0, delta) -> x0, fx0, gx0, hx0, delta
let hess_of_x0_cmp = function
  | X0_CMP (_, _, _, hx0, _) -> hx0 
let x0_of_x0_cmp = function
  | X0_CMP (x0, _, _, _, _) -> x0 
let grad_of_x0_cmp = function
  | X0_CMP (_, _, gx0, _, _) -> gx0 
let f_of_x0_cmp = function
  | X0_CMP (_, fx0, _, _, _) -> fx0 

let tm2_zero n = 
  let x = init_list n zero_i in
  let lambda = Lm zero_i in
  let g = grad_zero_T n in
  let h = hessian_zero_T n in 
    TM2 (x, g, h, lambda) 

let hess_of_tm2 = function
  | TM2 (_, _, Hess h, _) -> h

let grad_of_tm2 = function
  | TM2 (_, Grad g, _, _) -> g

let eval_grad tm2 x0 tbl tbl_loc : num_i array = 
 let g =  Array.map (fun t -> eval_T x0 tbl tbl_loc t) (grad_of_tm2 tm2) in
   g

let eval_hess tm2 x0 tbl tbl_loc : num_i array array = map_matrix zero_i (eval_T x0 tbl tbl_loc) (hess_of_tm2 tm2)

let ia_grad tm2 tbl tbl_loc  var_list box_list : interval array = 
  let tbl_I = Hashtbl.create 30 in
    Array.map (interval_T tbl_I tbl tbl_loc  var_list box_list) (grad_of_tm2 tm2)

let ia_hess tm2 tbl tbl_loc  var_list box_list : interval array array = 
  let tbl_I = Hashtbl.create 30 in
  let prev = Unix.gettimeofday() in
    (*
  let box_list =  mesh_of_interval (hd box_list) 2 in
     *)
  let result = map_sym_matrix zero_I (interval_T tbl_I tbl tbl_loc  var_list box_list) (hess_of_tm2 tm2) in
  let current = Unix.gettimeofday() in 
  let time_mess = Printf.sprintf "ia hess time: %f" (current -. prev) in 
    _pr_ time_mess true false;
    result

let sym_hess_I tm2 tbl tbl_loc  var_list box_list : interval array array = 
  let hx = ia_hess tm2 tbl tbl_loc  var_list box_list in
  let n = size hx in
    for i = 0 to (n -1) do
      for j = i to (n - 1) do
        let hx_ij = intersection_I (hx. (i). (j))  (hx. (j). (i)) in
          hx. (i). (j) <- hx_ij; hx. (j). (i) <- hx_ij; 
      done;
    done;
    hx

let norm_with_hess rm hx0 : num_i array = 
  let d' = inv_of_diag (diag_of_matrix hx0 zero_i) in
  let sqrt_d' = sqrt_diag d' in
    _pr_ (string_of_array sqrt_d') true false;
    Array.map (mult_i rm) sqrt_d'

let norm_with_hess_using_sym bounds rm hx0 sym_array : num_i array = 
  let widths = get_widths bounds in 
  let widths = Array.of_list widths in
  let d' = inv_of_diag (diag_of_matrix hx0 zero_i) in
  let n = size d' in
  let result = Array.make n zero_i in
  let sqrt_d' = sqrt_diag d' in
    _pr_ (string_of_array sqrt_d') true false;
    for i = 0 to (n -1) do
      result. (i) <- if sym_array. (i) then widths. (i) else mult_i sqrt_d'. (i) rm;
    done;
    result

let gen_H_bounds x0 gx0 hx0 : (num_i * num_i) list = 
  let n = Array.length hx0 in
  let bounds = Array.make n (zero_i, zero_i) in
  for i = 0 to (n -1) do
    for j = 0 to (n - 1) do
      let c_ij = (if i = j then minus_i else abs_i) hx0. (i). (j) in
        (*
      let c_ij = add_i c_ij (abs_i (sub_i gx0. (i) (nth x0 i))) in
         *)
        bounds. (i) <- add_i (fst (bounds. (i))) (div_i c_ij two_i), 100.0;
    done;
    bounds.(i) <- max_i zero_i (fst bounds. (i)), snd bounds. (i);
  done;
  Array.to_list bounds

let gen_tau_bounds x0 gx0 : num_i * num_i = 
  let tau = ref zero_i in
  let n = Array.length gx0 in
    for i = 0 to (n -1) do
      tau := add_i !tau (abs_i (sub_i gx0. (i) (nth x0 i)))
    done;
    (*
    div_i !tau two_i, 100.0
     *)
    zero_i, 100.0
 
let cst_of_TM2 x0 fx0 gx0 hx0 : num_i = 
  let q = matrix_array_mult2_i x0 hx0 in
  let q = div_i (inner_product x0 q) two_i in
  let l = inner_product x0 gx0 in
  let cst = add_i (sub_i fx0 l) q in
    _pr_ (string_of_i cst) true true;
    cst

(*
let delta_h x y = matrix_sub zero_i minus_i add_i (matrix_of_list zero_i y) (matrix_of_list zero_i x)
 *)

let delta_h vars x0 : (num_i pol) array = 
  let nvars = size vars in
  let x0 = Array.of_list x0 in
    assert (nvars = size x0);
    let pols = Array.map (mk_X zero_i one_i) vars in
    let res = Array.make nvars (p0 zero_i) in
      for i = 0 to (nvars - 1) do
        res. (i) <- p_subC  (pols. (i)) (x0. (i));
      done;
      res

let inner_prod_num_pol num_tbl pol_tbl : num_i pol = 
  let n = size num_tbl in
  let r = ref (p0 zero_i) in
    assert (n = size pol_tbl);
    for i = 0 to (n -1) do
      r := p_add !r (p_mulC (pol_tbl. (i)) (num_tbl. (i)));
    done;
    !r

let inner_prod_pol_pol (p1 : (num_i pol) array) (p2 : (num_i pol) array) : num_i pol = 
  let n = size p1 in
  let r = ref (p0 zero_i) in
    assert (n = size p2);
    for i = 0 to (n -1) do
      r := p_add !r (p_mul (p1. (i)) (p2. (i)));
    done;
    !r

let norm_sqr_pol pol_tbl : num_i pol = inner_prod_pol_pol pol_tbl pol_tbl

let mat_pol_prod m p : (num_i pol) array = 
  let n = size m in
  let r = Array.make n (p0 zero_i) in
    for i = 0 to (n -1) do
      r. (i) <- inner_prod_num_pol (m. (i)) p;
    done;
    r
let array_pol_prod d p : (num_i pol) array = 
  let n = size d in
  let r = Array.make n (p0 zero_i) in
    for i = 0 to (n -1) do
      r. (i) <- p_mulC (p. (i)) (d. (i));
    done;
    r

let lambda_min_of_hess  hx = 
  let n = size hx in
  let c = [| minus_i one_i|] in
  let f0 = matrix_opp zero_i minus_i hx in
  let f1 = matrix_opp zero_i minus_i (matrix_id zero_i one_i n) in
  let mat_list = [f0; f1] in
    lambda_min c mat_list 

let initiate_tm2 vars nl hmap xconvert = 
 let tbl' = Hashtbl.create 20 in
 let n = size vars in
 let x = init_list n zero_i in
 let g = grad_T vars tbl' nl hmap xconvert in
 let h = hessian_T vars tbl' nl xconvert in
 let lambda = Lm zero_i in
   TM2 (x, g, h, lambda)

let compute_grad_hess vars tbl tbl_loc t tm2 x0 : x0_cmp = 
  _pr_ "eval f at x0" true false;
  (*
  let x1 = [
    [4.0 ; 4.0 ; 4.0 ; 6.3504 ; 4.0; 4.0]; 
    [4.0 ; 4.0 ; 4.0 ; 6.4 ; 4.0; 4.0]; 
    [4.0 ; 4.0 ; 4.0 ; 6.5 ; 4.0; 4.0];
    [4.0 ; 4.0 ; 4.0 ; 6.6 ; 4.0; 4.0];
    [4.0 ; 4.0 ; 4.0 ; 6.7 ; 4.0; 4.0];
    [4.0 ; 4.0 ; 4.0 ; 6.8 ; 4.0; 4.0];
    [4.0 ; 4.0 ; 4.0 ; 6.9 ; 4.0; 4.0]; 
    [4.0 ; 4.0 ; 4.0 ; 7.90 ; 4.0; 4.0]; 
    [4.0 ; 4.0 ; 4.0 ; 7.91 ; 4.0; 4.0]; 
    [4.0 ; 4.0 ; 4.0 ; 7.92 ; 4.0; 4.0]; 
    [4.0 ; 4.0 ; 4.0 ; 7.93 ; 4.0; 4.0]; 
    [4.0 ; 4.0 ; 4.0 ; 7.94 ; 4.0; 4.0];
    [4.0 ; 4.0 ; 4.0 ; 7.95 ; 4.0; 4.0];
    [4.0 ; 4.0 ; 4.0 ; 7.96 ; 4.0; 4.0];
    [4.0 ; 4.0 ; 4.0 ; 7.97 ; 4.0; 4.0];
    [4.0 ; 4.0 ; 4.0 ; 7.98 ; 4.0; 4.0];
    [4.0 ; 4.0 ; 4.0 ; 7.99 ; 4.0; 4.0]; 
    [4.0 ; 4.0 ; 4.0 ; 8.0 ; 4.0; 4.0]; 

  ] 
  in
  let fx1 =  map (fun x -> eval_T x tbl tbl_loc t) x1 in
    _pr_ (string_of_list_i fx1) true false;
   *)
    let fx0 = eval_T x0 tbl tbl_loc t in
    _pr_ "eval grad at x0" true false;
    let gx0 = eval_grad tm2 x0 tbl tbl_loc in
      _pr_ "compute vars - x0" true false;
      let delta = delta_h vars x0 in
        _pr_ "eval hessian at x0" true false;
        let hx0 = eval_hess tm2 x0 tbl tbl_loc in
          _pr_ (string_of_matrix hx0) true false;
          X0_CMP (x0, fx0, gx0, hx0, delta)

let compute_lambda_min vars tbl tbl_loc t tm2 x0_cmp  var_list sub_box do_scaling =
    let hx0 = hess_of_x0_cmp x0_cmp in
    let d = diag_of_matrix hx0 zero_i in
    let d' = inv_of_diag d in
    let n = size hx0 in
    let sd = if inverse then sqrt_diag d' else sqrt_diag d in
     (* 
      if do_scaling then
        begin
          let hess_I = sym_hess_I tm2 tbl tbl_loc  var_list [sub_box] in
          let center_hess_I, center_hx0 = center_sum_matrix_I (matrix_minus_I hess_I) hx0 in
          (*
           let hx_sub_hx0_I = matrix_sub_I hess_I (matrix_I hx0) in
           *)
          let d'_hess_I = array_matrix_mult_I (Array.map mk_num_I sd) center_hess_I in
          let d'_hess_I_d' = matrix_array_mult_I (Array.map mk_num_I sd) d'_hess_I in
          let d'_hx0 = array_matrix_mult sd center_hx0 in
          let d'_hx0_d' = matrix_array_mult sd d'_hx0 in

            (*
             _pr_ (string_of_interval_matrix hx_sub_hx0_I) true true;
             *)
            _pr_ (string_of_interval_matrix hess_I) true false;
            _pr_ (string_of_interval_matrix center_hess_I) true false;
            _pr_ (string_of_matrix center_hx0) true false;

            _pr_ (string_of_interval_matrix d'_hess_I_d') true false;

            let b0 = matrix_rho_I center_hess_I in

            let d'_b0_d' = matrix_rho_I d'_hess_I_d' in
            (*
             _pr_ (string_of_array b0. (0)) true false;
             _pr_ (string_of_array d'_b0_d'. (0)) true false;
             *)


            let prev = Unix.gettimeofday() in
            (*
             _pr_ (string_of_array center_hx0. (0)) true false;
             _pr_ (string_of_array d'_hx0_d'. (0)) true false;
             *)
            let lambda = lambda_min_robust b0 center_hx0  in

            let scale_lambda = lambda_min_robust d'_b0_d' d'_hx0_d'  in

            let current = Unix.gettimeofday() in 
            let time_mess = Printf.sprintf "lambda min box time: %f" (current -. prev) in 
              _pr_ time_mess true false;
              lambda, scale_lambda
        (*
         _pr_ (Printf.sprintf "lambda: %s scale_lambda: %s" (string_of_i lambda) (string_of_i scale_lambda)) true false;
         *)
        end
      *)
          let mesh =  mesh_of_point sub_box 2 in
          let mesh_hx = map (fun x -> eval_hess tm2 x tbl tbl_loc) mesh in
          _pr_ (string_of_tuple_list sub_box) true true;
          let hess_I = matrix_list_to_matrix_I n n mesh_hx in
          let center_hess_I, center_hx0 = center_sum_matrix_I (matrix_minus_I hess_I) hx0 in
          let b0 = matrix_rho_I center_hess_I in
          let lambda = lambda_min_robust b0 center_hx0  in

          let d'_hess_I = array_matrix_mult_I (Array.map mk_num_I sd) center_hess_I in
          let d'_hess_I_d' = matrix_array_mult_I (Array.map mk_num_I sd) d'_hess_I in
          let d'_hx0 = array_matrix_mult sd center_hx0 in
          let d'_hx0_d' = matrix_array_mult sd d'_hx0 in
          let d'_b0_d' = matrix_rho_I d'_hess_I_d' in
          let scale_lambda = if do_scaling then lambda_min_robust d'_b0_d' d'_hx0_d'  else lambda in

           (* 
          let mesh_hx_hx0 = map (fun h -> matrix_sub_i h hx0) mesh_hx in
          let mesh_hx_hx0_scaled = map (array_matrix_mult sd) mesh_hx_hx0 in
          let mesh_hx_hx0_scaled = map (matrix_array_mult sd) mesh_hx_hx0_scaled in
            
          let prev = Unix.gettimeofday() in
          let lambda_list = map (lambda_min_of_hess ) mesh_hx_hx0 in
          let lambda_list_scaled = map (lambda_min_of_hess ) mesh_hx_hx0_scaled in
          let current = Unix.gettimeofday() in
          let time_mess = Printf.sprintf "lambda min corners time: %f" (current -. prev) in 
            _pr_ time_mess true false;
            let min_lambda, min_lambda_scaled = min_list lambda_list, min_list lambda_list_scaled in
               _pr_ (Printf.sprintf "lambda_list: %s \n lambda_list_scaled on corners: %s" (string_of_list_i lambda_list) (string_of_list_i lambda_list_scaled)) true false;
          
              _pr_ (Printf.sprintf "lambda: %s lambda_min on corners: %s lambda_min_scaled on corners: %s" (string_of_i lambda) (string_of_i min_lambda) (string_of_i min_lambda_scaled)) true true;
            *)
              _pr_ (Printf.sprintf "lambda: %s scale_lambda: %s" (string_of_i lambda) (string_of_i scale_lambda)) true true;
              lambda, scale_lambda


let rec pol_of_tm2 (get_min_pol:algo_semi_alg) vars t tm2 x0_cmp  var_list bounds radius_array pre_algo_test =
  let do_scaling = false in
  let x0, fx0, gx0, hx0, delta = cmp_of_x0 x0_cmp in
  let tbl_loc = Hashtbl.create 2 in
    (*
  let sub_box, partitions = 
    if pre_algo_test then bounds, []
    else mk_partitions bounds x0 hx0 radius_array
  in
     

    _pr_ (concat_string_with_string (map string_of_cut_box partitions) "next partition\n\n") false false;
    let tbl = get_tbl var_list sub_box in
      _pr_ ("Sub box: " ^ string_of_tuple_list sub_box) true false;
      (*
      let lambda, scale_lambda = compute_lambda_min vars tbl tbl_loc t tm2 x0_cmp  var_list sub_box do_scaling in
       *)
     *)
    _pr_ (string_of_cmp x0_cmp) true false;
    let pol_g = inner_prod_num_pol gx0 delta in
    let pol_h = inner_prod_pol_pol delta (mat_pol_prod hx0 delta) in
    let pol_h = p_mulC pol_h (inv_i two_i) in
    let d = diag_of_matrix hx0 zero_i in
    let d' = inv_of_diag d in
    let sd = if inverse then sqrt_diag d else sqrt_diag d' in

    let d_delta = array_pol_prod sd delta in
    (*
     let pol_lambda =  p_mulC (norm_sqr_pol delta) (div_i lambda two_i) in

     let pol_scale_lambda = p_mulC (norm_sqr_pol d_delta) (div_i scale_lambda two_i) in


     let p = p_addC (p_add pol_g (p_add pol_h pol_lambda)) fx0 in
     let p_scale = p_addC (p_add pol_g (p_add pol_h pol_scale_lambda)) fx0 in
     *)
    let p_quadr_terms = p_addC (p_add pol_g pol_h) fx0 in
    (*
     _pr_ (string_of_pol p_quadr_terms) true false; _pr_ (string_of_pol (p_mulC (norm_sqr_pol delta) (inv_i two_i))) true false;
     _pr_ (string_of_pol p) true false;
     *)
    let p = p_quadr_terms in
    let p_scale = p in
      (*
    let min = fst_fst (get_min_pol tbl (Fw_utils.mk_Pw p) [] true) in
    let min_scale = if do_scaling then fst_fst (get_min_pol tbl (Fw_utils.mk_Pw p_scale) [] true) else min in
      _pr_ (Printf.sprintf "min: %s scale_min: %s" (string_of_i min) (string_of_i min_scale)) true true;
       *)
      p
(*
and min_box_tm2 get_min_pol vars t tm2  var_list bounds : num_i = 
  let tbl = get_tbl var_list bounds in
  let tbl_loc = Hashtbl.create 2 in
  let _, x0 = min_heuristic t tbl tbl_loc bounds in
  let x0_cmp = compute_grad_hess vars tbl tbl_loc t tm2 x0 in
  let radius_array = Array.make (length x0) zero_i in
    fst (pol_of_tm2 get_min_pol vars t tm2 x0_cmp  var_list bounds radius_array true)
 *)
and get_min_partition get_min_pol vars t tm2  var_list partitions =
  (*
  let min_p p = min_list (map (min_box_tm2 get_min_pol vars t tm2  var_list) p) in
  let values = map min_p partitions in
  let max_min = min_list values in
  let p_index = index_of_elt values max_min in
  let p = nth partitions p_index in
   *)
  let p = nth partitions 0 in
    filter_singleton_box p
    (*
    _pr_ (Printf.sprintf "Best partition: %i tm2min = %f, values = %s" (p_index+1) max_min (string_of_list_i values)) true true;
     *)
    
  (*
  _pr_ (concat_string_with_string (map string_of_cut_box partitions) "partition") true true;
  nth partitions 3
   *)

(* Given a tm2 in x0_cmp, returns the corresponding quadratic form, its gradient and its
 * constant hessian matrix *)      
let pgh_of_tm2 vars x0_cmp = 
 let x0, fx0, gx0, hx0, delta = cmp_of_x0 x0_cmp in
 let pol_g = inner_prod_num_pol gx0 delta in
 let pol_h = inner_prod_pol_pol delta (mat_pol_prod hx0 delta) in
 let pol_h = p_mulC pol_h (inv_i two_i) in
 let p = p_addC (p_add pol_g pol_h) fx0 in
   x0, p, grad_pol vars p, hx0 


let data_for_min_curve p g h var_list bounds = 
  let n = length var_list in
  let var_list = Oracle.gen_variables_names "x" (2 * n) in
  let pos_list = pos_indexes (2 * n) in
  let x_indexes, y_indexes = sub_list pos_list 0 (n - 1), sub_list pos_list n (2 * n - 1) in
  let x, y = map (mk_X zero_i one_i) x_indexes, map (mk_X zero_i one_i) y_indexes in
  let x, y = Array.of_list x,  Array.of_list y in
  let y_bounds = init_list n (minus_i one_i, one_i) in
  let x_bounds = bounds in
  let bounds = x_bounds @ y_bounds in
  let tbl = get_tbl var_list bounds in
  let q_i = inner_prod_pol_pol y (mat_pol_prod h y) in
  let p_eq_zero = Sparsepop.equals_cstr p (Pc zero_i) in
  let y_dot_g_eq_zero = Sparsepop.equals_cstr (term_of_pol (inner_prod_pol_pol y g)) (Pc zero_i) in
  let y_dot_y_eq_one = Sparsepop.equals_cstr (inner_prod_pol_pol y y) (Pc one_i) in
    q_i, p_eq_zero::y_dot_g_eq_zero::y_dot_y_eq_one::[], tbl 


let rec get_polyhedral_cstr (get_min_pol:algo_semi_alg) p g vars tbl cstr q_i curve_cstr curve_tbl = 
  let p_fw = Fw_utils.mk_Pw_I p Void_i in
  let m, _, _, _ =  get_min_pol tbl p_fw cstr true in
    _pr_ (string_of_i m) true true;
  if ge_i m zero_i then cstr
  else 
    begin
      let n = size vars in
      let q = Fw_utils.mk_Pw_I q_i Void_i in
      let _, _, x_y_opt, _ = get_min_pol ~relax_order:1 curve_tbl q (cstr @ curve_cstr) true in   
      let x_opt = sub_list x_y_opt 0 (n - 1) in
      let g_m = eval_grad_pol x_opt g in
      let g_m_pol = Array.map (fun c -> Pc c) g_m in
      let delta_x = delta_h vars x_opt in 
      let p_m = inner_prod_pol_pol g_m_pol delta_x in
      let p_m_ge_zero =  Sparsepop.major_cstr (term_of_pol p_m) (Const 0.001) in
      let cstr = p_m_ge_zero::cstr in        
        get_polyhedral_cstr get_min_pol p g vars tbl cstr q_i curve_cstr curve_tbl
    end

let get_cut_boxes get_min_pol vars t tm2 x0_cmp  var_list bounds = 
  let x0, p, g, h = pgh_of_tm2 vars x0_cmp in
  let q_i, curve_cstr, curve_tbl = data_for_min_curve p g h var_list bounds in
  let tbl = get_tbl var_list bounds in
  let cstr = [] in
  let polyhedron = get_polyhedral_cstr get_min_pol p g vars tbl cstr q_i curve_cstr curve_tbl in
  let deltas = init_list (size vars) zero_i in
  let sub_box, partitions = mk_partitions bounds x0 h (Array.of_list deltas) in
  let partition = get_min_partition get_min_pol vars t tm2  var_list partitions in
    sub_box::partition


let get_cut_boxes_old (get_min_pol:algo_semi_alg) vars t tm2 x0_cmp  var_list bounds = 
  let x0, fx0, gx0, hx0, delta = cmp_of_x0 x0_cmp in
  let n = length var_list in
  let var_list = Oracle.gen_variables_names "x" (2 * n + 1) in
    (*
  let lambda_list, delta_list =  sub_list var_list 0 (n - 1), sub_list var_list n (2 * n - 1) in
     *)
  let pos_list = pos_indexes (2 * n + 1) in
  let lambda_indexes, delta_indexes = sub_list pos_list 0 (n - 1), sub_list pos_list n (2 * n - 1) in
  let tau_index = nth pos_list (2 * n) in
  let lambda_bounds, delta_bounds = gen_H_bounds x0 gx0 hx0, map (fun (a, b) -> sqr_i a, sqr_i b) bounds in
  let tau_bounds = gen_tau_bounds x0 gx0 in
  let hx0_x0 =  matrix_array_mult2_i (Array.of_list x0) hx0 in
  let hx0_half = map_matrix zero_i (fun i -> div_i i two_i) hx0 in
  let sub_array = map2_array zero_i (fun a b -> div_i (sub_i a b) two_i) gx0 hx0_x0 in
    _pr_  (string_of_matrix hx0_half) true true;
    _pr_  (string_of_array sub_array) true true;

  let tbl = get_tbl var_list (lambda_bounds @ delta_bounds @ [tau_bounds]) in
  let delta_bounds_I = map mk_I delta_bounds in
  let p = Fw_utils.mk_Pw_I (monomial_sum delta_indexes) (fold_left add_I zero_I delta_bounds_I) in
  let p_lambdas, p_deltas = map (mk_X zero_i one_i) lambda_indexes, map (mk_X zero_i one_i) delta_indexes in
  let p_tau = mk_X zero_i one_i tau_index in
  let lambdas_deltas_inner_product = inner_prod_pol_pol (Array.of_list p_lambdas) (Array.of_list p_deltas) in
  let lambdas_deltas_inner_product = p_add lambdas_deltas_inner_product p_tau in
  let cstr_lhs = term_of_pol lambdas_deltas_inner_product in
  let cst = cst_of_TM2 (Array.of_list x0) fx0 gx0 hx0 in
  let cstr_rhs = Const cst in
  let cstr =  Sparsepop.major_cstr cstr_lhs cstr_rhs in
    _pr_ cstr true true; 
  let max_volume, _, lambdas_deltas, _ = get_min_pol tbl p [cstr] false in
    _pr_ (string_of_list_i lambdas_deltas) true false;
  let deltas = sub_list lambdas_deltas n (2 * n - 1) in
  let sub_box, partitions = mk_partitions bounds x0 hx0 (Array.of_list deltas) in
  let partition = get_min_partition get_min_pol vars t tm2  var_list partitions in
    sub_box::partition

