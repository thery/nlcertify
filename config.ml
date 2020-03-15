module Config = struct

  let strings_of_file filename =
    let fd = try 
      begin 
        Pervasives.open_in filename
      end
    with Sys_error _ ->
      failwith("strings_of_file: can't open "^filename) in
    let rec suck_lines acc =
      try 
        begin
          let l = Pervasives.input_line fd in
            suck_lines (l::acc)
        end
      with End_of_file -> List.rev acc in
    let data = suck_lines [] in
      (Pervasives.close_in fd; data)

  let param_values = strings_of_file "param.transc" 
  let param_tbl = Hashtbl.create (List.length param_values) 

  let is_comment s = String.contains s '*'
  let is_spaces s = 
    let w = Str.global_substitute (Str.regexp "[ \t]+") (fun _ -> "") s in
      w = ""


  let parse_config_file () =
    let split w = 
      let w = Str.global_substitute (Str.regexp "[ \t]+") (fun _ -> "") w in
      let l = Str.split (Str.regexp "=") w in 
        match l with | [param; value] -> param, value | _ -> print_string "pb with parameter: \""; print_string w; print_string "\" "; failwith "Error while parsing configuration file"
    in
    let param_values = List.filter (fun s -> (not (is_spaces s)) && (not (is_comment s))) param_values in
    let param_values = List.map split param_values in
      List.iter (fun (k, v) -> Hashtbl.replace param_tbl k v) param_values; 
      ()

  let _ = parse_config_file ()
  let find p = 
    try Hashtbl.find param_tbl p
    with Not_found -> print_string p; failwith "Not found in parameters table"
  let stob s = try bool_of_string s with Invalid_argument mess -> print_string (s ^ ": ");  invalid_arg mess
  let stoi = int_of_string
  let stof = float_of_string

(* For samp approx: xconvert_variables = false, samp_iters = 0->3, max_degree_pol
* = 4;  cut_at_first = true, bound_squares_variables = true, bb = false,
* approx_minimax = false, minimax_sqrt = false, refine_bounds_cuts = true *)

(* For flyspeck ineq: xconvert_variables = true, samp_iters = 0, max_degree_pol
* = 8;  cut_at_first = false, bound_squares_variables = true, bb = true,
* approx_minimax = true, minimax_sqrt = true , refine_bounds_cuts = false *)

(* General paramaters*)
  let compute_max_ineq = stob (find "compute_max_ineq")
  let input_ineqs_filename = find "input_ineqs_filename"
  let ineq_name = if Array.length (Sys.argv) < 2 then begin
    print_endline ("Please enter an inequality identifier, for instance:\n./nlcertify 3318775219\n./nlcertify MC\nFlyspeck inequalities are defined in flyspeck_dir/ineq_final.ml\nYou can define your own inequalities in " ^input_ineqs_filename); exit 0 
    end else Sys.argv. (1)

  let normalize_ineqs = stob (find "normalize_ineqs")
  let xconvert_variables = stob (find "xconvert_variables")
  let heuristic_corners = stob (find "heuristic_corners")
  let n_stat = stoi (find "n_stat")
  let check_points = stoi (find "check_points")
  let common_denum = stob (find "common_denum")

(* Sollya parameters *)
  let use_sollya = false (* dummy option: should be always false *)
  let approx_minimax = stob (find "approx_minimax")
  let minimax_degree_sqrt = stoi (find "minimax_degree_sqrt")
  let minimax_degree = stoi (find "minimax_degree")
  let minimax_precision = stoi (find "minimax_precision")
  let minimax_sqrt = stob (find "minimax_sqrt")


(* Max-Plus parameters *)
  let samp_iters = let tmp = stoi (find "samp_iters") in if approx_minimax then 0 else if tmp <= 0 then -1 else tmp
  let iter_min = samp_iters
  let iter_max = samp_iters
  let shor_max_degree = 2 (* dummy option: not used in the code yet *)
  let samp_root = stob (find "samp_root")
  let ia_sos = samp_iters < 0
  let n_activate_template = stoi (find "n_activate_template")

(* SDP/SOS parameters *)
  let relax_order = stoi (find "relax_order")
  let degree_L1 = stoi (find "degree_L1")
  let vars_L1 = stoi (find "vars_L1")
  let is_L1 = stob (find "is_L1")
  let use_cliques = stob (find "use_cliques")
  let loc_support_clique = stob (find "loc_support_clique")
  let reduce_sos = stob (find "reduce_sos")
  let use_matlab = stob (find "use_matlab")
  let use_mypop = stob (find "use_mypop")
  let round_maxplus_error = stob (find "round_maxplus_error")
  let relax_type = find "relax_type" 
  let sergei_acc = stoi (find "sergei_acc")
  let interval_acc = stof (find "interval_acc")
  let eig_tol = stof (find "eig_tol")
  let eq_tol = stof (find "eq_tol")
  let scale_pol = stob (find "scale_pol")
  let norm_magnitude = stob (find "norm_magnitude")
  let fix_vars = stob (find "fix_vars")
  let bound_squares_variables = stob (find "bound_squares_variables")
  let mk_archimedean = stob (find "mk_archimedean")
  let sdp_solver_epsilon = stoi (find "sdp_solver_epsilon")
  let sdp_solver_print = stoi (find "sdp_solver_print")
  let relative_obj_tol = stof (find "relative_obj_tol")
  let erase_sparsepop_files = stob (find "erase_sparsepop_files")
  let erase_sdpa_files = stob (find "erase_sdpa_files")
  let erase_coq_files = stob (find "erase_coq_files")
  let erase_sollya_files = stob (find "erase_sollya_files")

(* The type of polynomial coefficients for verification (float / flocaml /
 * zarith) *)
  let coeff_type = find "coeff_type"

(* dm_psatz parameters *)
  let check_certif_coq = stob (find "check_certif_coq")
  let check_certif_coq_fsa = stob (find "check_certif_coq_fsa")
  let check_certif_coq_pop = stob (find "check_certif_coq_pop")

  let dm_psatz_path = find "dm_psatz_path"
  let coq_sage_tmp_dir = find "coq_sage_tmp_dir" 

(* Lambda_min parameters *)                   
  let lambda_min_heuristic = stob (find "lambda_min_heuristic") (* if true then eval lambda_min by evaluating the hessian at many points otherwise, compute hessian coarse bounds by get_semialg_min algorithm )*)
  let linear_tm2 = stob (find "linear_tm2")
  let minor_tm2 = stob (find "minor_tm2") || linear_tm2
  let minor_lambda_min =  minor_tm2 || stob (find "minor_lambda_min") (* if true, then minor lambda_min(a - b) by lambda_min(a) - lambda_max (b)*)
  let approx_lambda_min = stob (find "approx_lambda_min")

(* Adding cuts conditions *)
  let max_degree_pol = stoi (find "max_degree_pol")
  let cut_at_first = stob (find "cut_at_first")
  let cut_poly = cut_at_first || stob (find "cut_poly")
  let lift_lc_sqrt =  stob (find "lift_lc_sqrt")
  let approx_func_centered = stob (find "approx_func_centered")
  let do_samp = false (* dummy option: should be always false *)
  let check_samp = stob (find "check_samp")
  let check_templates = (n_activate_template < samp_iters) && lambda_min_heuristic
  let samp_leaves = stob (find "samp_leaves")
  let cmp_samp_max = stob (find "cmp_samp_max")
  let cmp_true_min = stob (find "cmp_true_min")
  let get_rnd_cuts = stob (find "get_rnd_cuts")
  let rnd_cuts = stoi (find "rnd_cuts")
  let refine_bounds_cuts = stob (find "refine_bounds_cuts")
  let mmm_relax = stob (find "mmm_relax")

(* Verbose settings *)
  let parab_verb = stob (find "parab_verb")
  let sos_verb  = stob (find "sos_verb")
  let coq_verb  = stob (find "coq_verb")
  let pop_verb  = stob (find "pop_verb")
  let sdp_verb  = stob (find "sdp_verb")
  let box_verb = stob (find "box_verb")
  let problem_verb = stob (find "problem_verb")
  let semialg_verb = stob (find "semialg_verb")
  let time_verb = stob (find "time_verb")
  let string_I_verb = stob (find "string_I_verb")
  let print_precision = stoi (find "print_precision")
(* Binary Problems settings *)
  let binary = stob (find "binary")
                 
(* Branch and Bound settings *)
  let check_derivatives = stob (find "check_derivatives")
  let bb = stob (find "bb")
  let inverse_hessian_diag = stob (find "inverse_hessian_diag")
  let tolerance_cut_box = stof (find "tolerance_cut_box")
  let pop_sym = [|false; false; false; false; false; false|]
  let cuts_heur_max = stoi (find "cuts_heur_max")
  let tol_tight = stof (find "tol_tight")
  let tol_min   = stof (find "tol_min")
  let tol_r     = stof (find "tol_r")
  let tol_r_rect = stof (find "tol_r_rect") *. tol_r 
  let tol_tm2 = stof (find "tol_tm2")

(* OCP Parameters *)
  let nb_templates = stoi (find "nb_templates")
  let nb_eqcstr = stoi (find "nb_eqcstr")

end
