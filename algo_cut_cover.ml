open List
open Interval
open Taylor
open Tutils 
open Mesh_interval
open Algo_disj
open Operations
open Rewrite
open Algo_types
open Algo_tables

type cut = | No_cut | Cut of num_i list
let hard_boxes = ref []
let x0_cut_n = ref 0
let bool_of_cut = function | No_cut -> false | Cut _ -> true
                                                         
let x0_of_cut = function | No_cut -> failwith "No_cut, no x0 available" | Cut x0 -> x0
let x0_cut_tbl = Hashtbl.create 10

let tol_tight = 0.0006
let tol_min   = 0.01
let tol_r     = 0.2
let tol_r_rect = mult_i 2.0 tol_r 
let n_cuts = ref 0

let delta_sym = [|false; false; false; false; false; false|]
(*
let rec get_rect_cut_tm2 get_pol_min var_list vars t tm2 x0_cmp  bounds radius_array r1 r2 direction = 
  let rd = m_I r1 r2 in
  let d = direction in
  let wd = width_I (mk_I (nth bounds d)) in
  let r2 = min_i r2 wd in
    radius_array. (d) <- r2;
    let min_tm2, sub_box, partitions = pol_of_tm2 get_pol_min vars t tm2 x0_cmp  var_list bounds radius_array false in
    let mess = Printf.sprintf "r%d = %f min = %f" (d + 1) r2 min_tm2 in
      _pr_ mess true true; 
      if (ge_i min_tm2 zero_i) then
        begin
          if (le_i (rel_err_i r1 r2) tol_r_rect || ge_i r2 wd) then (radius_array. (d) <- r2; sub_box, partitions)
          else get_rect_cut_tm2 get_pol_min var_list vars t tm2 x0_cmp  bounds radius_array rd r2 d 
        end
      else 
        begin
          get_rect_cut_tm2 get_pol_min var_list vars t tm2 x0_cmp  bounds radius_array r1 rd d 
        end

let stretch_cube get_pol_min var_list vars t tm2 x0_cmp  bounds rm = 
  let n = length bounds in
  let radius_array = norm_with_hess_using_sym bounds rm (hess_of_x0_cmp x0_cmp) delta_sym in
  let partitions = ref [] in
  let sub_box = ref [] in
  for d = 0 to n - 1 do
    if not delta_sym. (d) then
      begin
    let rd1, rd2 = radius_array. (d), max_list (get_widths bounds) in
    let rect_sub_box, rect_partitions = get_rect_cut_tm2 get_pol_min var_list vars t tm2 x0_cmp  bounds radius_array rd1 rd2 d in
      partitions := rect_partitions;
      sub_box := rect_sub_box;
      end
    else ()
  done;
  let p = get_min_partition get_pol_min vars t tm2  var_list !partitions in
    _pr_ ("Cut Box:" ^ (string_of_cut_box (!sub_box::p)) ^ "\n") true true; 
    !sub_box::p
 *)

(* gets the biggest cubic infinite ball around a point where the inequality is tight by
 * using Taylor Model approximation of the tree around the point, the TM approx
 * being positive on this box, then gets the biggest rectangular one*)
let rec get_cut_tm2 (get_pol_min:algo_semi_alg) var_list vars t tm2 x0_cmp  bounds r1 r2 =
  let rm = m_I r1 r2 in
  let hx0 = hess_of_x0_cmp x0_cmp in
  let radius_array = norm_with_hess_using_sym bounds r2 hx0 delta_sym in
  let q_i = pol_of_tm2 get_pol_min vars t tm2 x0_cmp  var_list bounds radius_array false in
    q_i

let rec algo_cut tm2 (get_semialg_min:algo_semi_alg) var_list vars t bounds  relax_order n_pbs cut : interval =
  let tbl = get_tbl var_list bounds in 
  let tbl_loc = Hashtbl.create 2 in
  let r1, r2 = zero_i, max_list (get_widths bounds) in
  let min_guess, x0 = min_heuristic t tbl tbl_loc bounds in
  let x0 = (*if le_i min_guess tol_tight then x0 else*) if bool_of_cut cut then x0_of_cut cut else x0 in
  let x0_cmp = compute_grad_hess vars tbl tbl_loc t tm2 x0 in
    
  let deja_vu_x0 = Hashtbl.mem x0_cut_tbl x0 in
    if not deja_vu_x0 then 
      begin
        x0_cut_n := !x0_cut_n + 1;
        Hashtbl.add x0_cut_tbl x0 x0_cut_n;
      end
    else ();
  let ellips =
    if ((le_i min_guess tol_tight || bool_of_cut cut) && (not deja_vu_x0)) then
      begin
        n_cuts := !n_cuts + 1;
        let fx0 = f_of_x0_cmp x0_cmp in
        let gx0 = grad_of_x0_cmp x0_cmp in
          _pr_ (Printf.sprintf "x0 = %s Grad (x0) = %s" (string_of_list_i x0) (string_of_list_i (Array.to_list gx0)))  true true;
          _pr_ (Printf.sprintf "Local min too big: %f -> TM2" fx0) true true;
            n_pbs := !n_pbs - 1;
            get_cut_tm2 get_semialg_min var_list vars t tm2 x0_cmp  bounds r1 r2              
      end
    else Polynomial.Pc zero_i
  in
 
  let s = plural !n_cuts in
    match ellips with
      |  Polynomial.Pc zero_i -> 
          begin
            n_pbs := !n_pbs + 1; _pr_ (Printf.sprintf "%i problems remaining, %i cut%s done" !n_pbs !n_cuts s) true true;
            algo_cut tm2 get_semialg_min var_list vars t bounds  relax_order n_pbs No_cut
          end

      | _ -> 
          begin
            let interval = 
              begin
                _pr_ ("Solving on Ellipsoid: " ^ Polynomial.string_of_pol ellips ^ " >=0 ") true true;
                let ellips_cstr = Sparsepop.major_cstr (Polynomial.term_of_pol ellips) (Polynomial.Const zero_i) in 
                let algo_I, x = algo_optim (get_semialg_min:algo_semi_alg) ellips_cstr tbl tbl_loc t  [x0] bounds in
                  if le_I algo_I zero_I then
                    begin
                      hard_boxes := ellips::!hard_boxes;
                      _pr_ (Printf.sprintf "%i problems remaining, %i cut%s done" !n_pbs !n_cuts s) true true;
                      (*
                       let corner = Unfold_eval_tree.project_x_on_corner x bounds in
                       *)
                      let corner = x in
                        algo_cut tm2 get_semialg_min var_list vars t bounds  relax_order n_pbs (Cut corner)
                    end
                  else
                    begin
                      n_pbs := !n_pbs - 1;
                      _pr_ (Printf.sprintf "%i problems remaining, %i cut%s done" !n_pbs !n_cuts s) true true;
                      algo_I
                    end
              end
            in
              interval
          end

(* t1, t2: lhs, rhs tree *)                
let init_algo_cut t1 t2 var_list bounds xconvert norm  oc_in oc_out relax_order =
  let bounds = xconvert_bounds bounds xconvert in
  let var_map = combine var_list bounds in
  let singletons, new_var_map = partition is_singleton var_map in 
  let nvars = length new_var_map in
  let vars = array_indexes nvars in
  let fold_tbl = get_fold_tbl singletons new_var_map in

  let (nl_tree1, hmap_tree1),  (nl_tree2, hmap_tree2) = extract_tame_hypermap t1 ,  extract_tame_hypermap t2 in
  let nl1, nl2 = fold_poly fold_tbl xconvert nl_tree1, fold_poly fold_tbl xconvert nl_tree2 in
  let hmap1, hmap2 = fold_poly fold_tbl false hmap_tree1, fold_poly fold_tbl false hmap_tree2 in
  let hmap1_xconvert, hmap2_xconvert = fold_poly fold_tbl xconvert hmap_tree1, fold_poly fold_tbl xconvert hmap_tree2 in
    _pr_ (string_T nl1) true false;    _pr_ ("\n") true false; _pr_ (string_T hmap1) true false;

    let lhs, rhs = if norm then (nl1 <+> hmap1_xconvert) <-> (nl2 <+> hmap2_xconvert), zero_T else nl1 <+> hmap1_xconvert, nl2 <+> hmap2_xconvert in

    let var_list, bounds = split new_var_map in
    let tm2_lhs = initiate_tm2 vars nl1 hmap1 xconvert in
    let tm2_rhs = if norm then tm2_zero nvars else initiate_tm2 vars nl2 hmap2 xconvert in

    let get_pol_min tbl p is_min = Sergei.get_bound_poly p tbl is_min  in
    let get_semialg_min ?(relax_order = 2) ?(force = true) tbl p cstr is_min =
      if (not force && Polynomial.is_Pol p && length cstr = 0) then
        let m, x = get_pol_min tbl (Polynomial.pol_of_fw p) is_min, [] in
          m, m, x, x
      else Sparsepop.get_bound_poly p cstr tbl is_min oc_in oc_out  relax_order 1 
    in

      _pr_ (string_T lhs) true false; 

      let box_list = [bounds] in
      let n_pbs = ref (length box_list) in

      let lhs_I_f bounds = algo_cut tm2_lhs get_semialg_min var_list vars lhs bounds  relax_order n_pbs No_cut in
      let lhs_I = union_list_I (map lhs_I_f box_list) in
      let rhs_I = if norm then zero_I else algo_cut tm2_rhs get_semialg_min var_list vars rhs bounds  relax_order n_pbs No_cut in
        lhs_I, rhs_I

