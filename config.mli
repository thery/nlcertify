module Config : sig 
  val ineq_name : string
  val relax_order : int
  val max_degree_pol : int
  val shor_max_degree : int
  val cut_at_first : bool
  val cut_poly : bool
  val lift_lc_sqrt : bool
  val dm_psatz_path : string
  val refine_bounds_cuts : bool
  val common_denum : bool
  val normalize_ineqs : bool
  val xconvert_variables : bool
  val scale_pol : bool
  val norm_magnitude : bool
  val heuristic_corners : bool
  val approx_func_centered : bool
  val use_matlab : bool 
  val use_mypop : bool 
  val relax_type : string 
  val fix_vars : bool
  val bound_squares_variables : bool
  val mk_archimedean: bool
  val sergei_acc : int 
  val interval_acc : float
  val ia_sos : bool
  val erase_sparsepop_files : bool
  val erase_sdpa_files : bool
  val erase_sollya_files : bool
  val input_ineqs_filename : string
  val erase_coq_files : bool
  val relative_obj_tol : float
  val n_activate_template : int
  val check_points : int
  val inverse_hessian_diag : bool
  val tolerance_cut_box : float
  val samp_iters : int
  val samp_root : bool
  val check_derivatives : bool
  val check_templates : bool
  val bb : bool
  val iter_min : int
  val iter_max : int
  val minor_tm2 : bool
  val linear_tm2 : bool
  val minor_lambda_min : bool
  val lambda_min_heuristic : bool
  val approx_lambda_min : bool
  val do_samp : bool
  val sdp_solver_epsilon : int
  val sdp_solver_print : int
  val check_samp : bool
  val samp_leaves : bool
  val cmp_samp_max : bool
  val cmp_true_min : bool
  val get_rnd_cuts : bool
  val rnd_cuts : int
  val mmm_relax : bool
  val n_stat : int
  val pop_sym : bool array 
  val cuts_heur_max : int
  val tol_tight : float
  val tol_min : float  
  val tol_r : float     
  val tol_r_rect : float
  val tol_tm2 : float 
  val compute_max_ineq : bool
  val parab_verb : bool
  val sos_verb : bool
  val coq_verb : bool
  val pop_verb : bool
  val sdp_verb : bool
  val box_verb : bool
  val problem_verb : bool
  val print_precision : int 
  val semialg_verb : bool
  val time_verb : bool
  val string_I_verb : bool
  val use_sollya : bool
  val minimax_degree_sqrt : int
  val minimax_degree : int
  val minimax_precision : int
  val approx_minimax : bool
  val minimax_sqrt : bool
  val binary : bool
  val check_certif_coq : bool  
  val check_certif_coq_fsa : bool  
  val check_certif_coq_pop : bool  
  val coq_sage_tmp_dir : string 
  val nb_templates : int
  val degree_L1 : int
  val vars_L1 : int
  val is_L1 : bool
  val nb_eqcstr : int
  val loc_support_clique  : bool
  val reduce_sos : bool
  val eq_tol : float
  val eig_tol : float
  val use_cliques : bool
  val round_maxplus_error : bool
  val coeff_type : string
end
