

let test_eval_func_with_eval_interval tree var_list bounds = 
  let var_map = List.combine var_list bounds in
  print_endline (Tutils.string_of_tuple_list bounds);
  let l = length var_map in
  let var_hash_table = Hashtbl.create l in
    Tutils.add_list_table var_hash_table var_map;
    let result = Unfold_eval_tree.eval_interval var_hash_table tree in
      match result with
        | Unfold_eval_tree.Num_interval interv -> interv 
        | _ -> failwith "Has to be Num_interval"

let test_evals ineq_name base  = 
  let (var_list, (full_ineqs, bounds)) = select_flyspeck_bounds_ineq ineq_name true in
  let ineqs, op = split full_ineqs in
  let tree = List.hd ineqs in
  let mesh = mesh_of_point bounds base in
  let mesh = map tuple_of_num_list mesh in
    map (test_eval_func_with_eval_interval tree var_list) mesh

let test_sparse_horner () =
  let poly_X1 = mk_X cO cI XH in
  let poly_X2 = mk_X cO cI (XO XH) in
  let poly_Sum = p_add poly_X1 poly_X2 in
  let poly_Sum = p_sub poly_Sum poly_X1 in
    _pr_ (string_of_pol poly_X1) true false;
    _pr_ (string_of_pol poly_Sum) true false;
    ()

let test_approx_atn2 () = 
  let poly_X1 = mk_X cO cI XH in
  let poly_X2 = mk_X cO cI (XO XH) in
  let interval_x = Int (60.,80. ) and interval_y = Int (40., 50.) in
  let px1 = [poly_X1] and px2 = [poly_X1] and py1 = [poly_X2] and py2 = [poly_X2] in
  let p1, p2 = approx_atn2 interval_x interval_y px1 px2 py1 py2 true in
(*  let p1, p2 = approx_atn2_tangent_plane interval_x interval_y px1 px2 py1 py2 in*)
(*  let p1, p2 = approx_inverse interval_x interval_y px1 px2 py1 py2 in*)
  let _ = 
    match p1, p2 with
      | [pol1], [pol2] -> _pr_ ("p1 = " ^ string_of_pol pol1 ^ "p2 = " ^ string_of_pol pol2) true false;
      | _ -> failwith " test approx func ";
  in
    ()


let test_approx_func s = 
  let poly_X = mkX cO cI in
  let transc = Hashtbl.find func_basic s in
  let prop_list = Hashtbl.find func_check_prop_list s in
  let transc' = Hashtbl.find func_derivative_basic s in
  let transc'' = Hashtbl.find func_deriv_order2 s in
  let transc_3 = Hashtbl.find func_deriv_order3 s in
  let iv = Int(4., 6.) in
  let pw = Pw (poly_X, iv) in
  let (p1, p2), eval_tuple = approx_transc_with_poly s pw pw transc transc' transc'' transc_3 min_c_atan max_c_atan prop_list iv 1 [[4.]]  in
    _pr_ ("p1 = " ^ string_of_fw p1 ^ "p2 = " ^ string_of_fw p2) true false;
    ()

let main () = 
  (*
         * let unfold_bool = bool_of_string (Sys.argv.(2)) in
       * Printf.printf "%s\n" (string_flyspeck_ineq Sys.argv.(1) unfold_bool);
       *)
      (*let  result = extract_check_flyspeck_ineq Sys.argv.(1) (int_of_string Sys.argv.(2)) in 
        print_endline result; 
      let _ = benchmarks_eval_interval (Sys.argv.(1)) (int_of_string (Sys.argv.(2))) in*)
      let prev = Unix.gettimeofday() in
      let xconvert, norm = Config.Config.xconvert_variables, Config.Config.normalize_ineqs in
      let _ = start_algo (Sys.argv.(1)) xconvert norm in
(*      let _ = test_approx_atn2 () in*)
      (*let map_eval = test_evals (Sys.argv.(1)) (int_of_string (Sys.argv.(2))) in
      let eval_strings = map string_I map_eval in
        _pr_ (concat_string eval_strings) true false*)
      let current = Unix.gettimeofday() in 
      let final_mess = Printf.sprintf "Total time: %f" (current -. prev) in 
               close_log_file(); 

      (* let _ = initialize_bb (Sys.argv.(1)) in*)
        (* let result = extract_check_flyspeck_ineq Sys.argv.(1) (int_of_string
         * Sys.argv.(2)) in
         * print_string result;*)
        (*
         * let prev = Unix.gettimeofday() in
         * let result_ocaml = Ineq_final.l_OXLZLEZ_6346351218_1_38_ineq 2.5854 2. 2. 2. 2. 2. in
         * let current = Unix.gettimeofday() in
         * Printf.printf "Total extraction time with ocaml: %f\n" (current -. prev);
         *)
        (*
         * let len = Array.length Sys.argv in
         * if (len>1) then 
         * Printf.printf "%s\n" (string_of_hash_key sphere_table Sys.argv.(1));
         * print_newline(); print_newline();
         * Printf.printf "%s\n" (print_unfold_tree true sphere_table Sys.argv.(1));
         * else failwith "input contains no argument";
         *)
        (*      
         * Printf.printf "%s\n" (string_of_float (eval_func  Sys.argv.(1) (dump_string_of_list Sys.argv.(2))));
         *)
        (*
         * if (len >2) 
         * then  Printf.printf "%s\n" (string_of_float (eval_func_unfold  Sys.argv.(1) (dump_string_of_list Sys.argv.(2))));
         * else failwith "input contains one argument";
         *)
        (*	
         * let result =  (eval_interval_unfold  Sys.argv.(1) (dump_string_of_tuple_list Sys.argv.(3))) in
         * Printf.printf "%f ,  %f\n" (fst result) (snd result);
         *)
        (*
         * let (bb_result, ncut) = (branch_and_bound_naive  Sys.argv.(1) (dump_string_of_tuple_list Sys.argv.(3)) 0) in
         * Printf.printf "%s\n" (string_I bb_result);
         * Printf.printf "number of cuts: %i\n" ncut;
         *)       
        (* 
         * let (bb_result, ncut) = (multi_bb_naive  Sys.argv.(1) (dump_string_of_tuple_list Sys.argv.(3)) 0) in
         * Printf.printf "%s\n" (string_I bb_result);
         * Printf.printf "number of cuts: %i\n" ncut;
         * let eval_mesh_result = eval_func_mesh Sys.argv.(1) (dump_string_of_tuple_list Sys.argv.(3)) 4 in
         * Printf.printf "exit\n";
         *)
        (*
         * if (len >3)
         * then Printf.printf "%s\n" (extract_check_func_mesh Sys.argv.(1) (dump_string_of_tuple_list Sys.argv.(3)) 2);
         * else failwith "input contains two arguments";
         *)
        (*
         * let n1 = (Ffunc "add_i", {i=Int(1., 2.)}) and (l1, l2) = (Fvar "x1", {i=Int(1., 1.)}) in
         * let func_tree = Branch (n1, [Leaf (l1, l2)]) in
         * l2.i <- Int(0., 0.);
         * (snd n1).i <- Int(1., 0.);
         * Printf.printf "%s\n" (string_func_tree func_tree);
         *)
 
