let start_algo xconvert norm =
  let module N =  (val (Numeric.of_string ("float")): Numeric.T) in
  let module Nq =  (val (Numeric.of_string (Config.Config.coeff_type)): Numeric.T) in
  let module U = Tutils.Make (N) in
  let module Uq = Tutils.Make (Nq) in
  let module Fun = Functions.Make (N) in
  let module Funq = Functions.Make (Nq) in
  let module I = Interval.Make (N)(Fun)(U) in
  let module Iq = Interval.Make (Nq)(Funq)(Uq) in
  let module P = Polynomial.Make (N)(U)(I) in 
  let module Pq = Polynomial.Make (Nq)(Uq)(Iq) in 
  let module M = Mesh_interval.Make (N)(U)(I) in
  let module Mq = Mesh_interval.Make (Nq)(Uq)(Iq) in

  let module Fu = Fw_utils.Make (Nq)(Uq)(Iq)(Pq) in
  let module F = Flyspeck_types.Make (Nq)(Uq)(Iq) in
  let module A = Algo_types.Make (Nq)(Uq)(Iq)(F)(Pq)(Fu) in
  let module Tb = Algo_tables.Make (Nq)(Uq)(Iq)(Pq)(Fu)(A) in 
  let module E = Unfold_eval_tree.Make (Nq)(Uq)(Iq)(F)(Mq) in
  let module Mk = Mk_flyspeck.Make (Nq)(Uq)(Iq)(F)(E) in
  let module O = Oracle.Make (Nq)(Uq)(Iq)(Pq)(A) in
  let module Op = Operations.Make (Nq)(Uq)(Iq)(Pq)(Fu)(F)(E)(A)(Tb) in
  let module L = Fw2oracle_lasserre.Make (Nq)(Uq)(Iq)(Pq)(Fu)(O) in 
  let module S = Sparsepop.Make (Nq)(Uq)(Iq)(Pq)(Fu)(A)(O)(L) in
  let module R = Rewrite.Make (Nq)(Uq)(Iq)(Pq)(Fu)(F)(E)(A)(Op) in
  let module Sollya = Sollya.Make (Nq)(Funq)(Uq)(Iq)(Mq)(Pq)(Fu)(A)(O) in
  let module Approx = Approx_func.Make (Nq)(Funq)(Uq)(Iq)(Mq)(Pq)(Fu)(A)(O)(Sollya)(Tb) in 
  let module D = Derivatives.Make (Nq)(Uq)(Iq)(Pq)(F)(Mq)(A)(Op) in
  let module Sergei = Sergei.Make (Nq)(Uq)(Pq)(A) in
  let module Ia = Interval_arith.Make (Nq)(Uq)(Iq)(Pq)(F)(Fu)(E)(A)(Tb) in
  let module C = Cut_box.Make (Nq)(Uq)(Iq)(Mq) in
  let module Sdp = Sdp_aux.Make (N)(U)(M) in
  let module Sos = Sos.Make (N)(U)(M)(I)(P) (Nq)(Uq)(Mq)(Iq)(Pq) (Sdp) in
  let module Tm = Taylor_cut.Make (Nq)(Uq)(Iq)(Mq)(Pq)(Fu)(F)(A)(D)(Tb)(Ia)(C)(Op) in
  let module Template = Template.Make (Nq)(Funq)(Uq)(Iq)(Pq)(Fu)(F)(A)(Tb)(Op)(Approx)(Ia)(Tm) in
  let module Algo_disj = Algo_disj.Make (Nq)(Funq)(Uq)(Iq)(Pq)(Fu)(F)(A)(Tb)(Op)(Approx)(Ia)(Tm)(Template)(S) in 
  let module Algo_cut = Algo_cut.Make (Nq)(Funq)(Uq)(Iq)(Mq)(Pq)(Fu)(F)(A)(R)(Tb)(Op)(Approx)(Tm)(Sergei)(S)(O)(Algo_disj) in
    (*
  let module Algo_moore = Algo_moore.Make (Nq)(Funq)(Uq)(Iq)(Mq)(Pq)(Fu)(F)(A)(R)(Tb)(Op)(Approx)(Tm)(Sergei)(S)(Algo_disj)(Ia) in
     *)
(*  let module Rnd = Random_quadr_forms.Make (N)(I)(U)(P) in*)
  let module Moore = Moore.Make (Nq)(Funq)(Uq)(Iq)(Mq)(Pq)(Fu)(F)(A)(R)(Tb)(Op)(Approx)(Ia)(Tm)(Sergei)(S)(O)(Algo_disj)(C) in
  let time_start = Unix.gettimeofday() in
    (*let _ = R.random_quadr_forms 20 100 in*)
  (* Tables Creation *)
  let _ = if Sys.command "sdpa --version > /dev/null" = 127 then (print_endline "You can download it at http://sdpa.sourceforge.net/download.html"; exit 0) else () in
  let _ = if (Config.Config.approx_minimax || Config.Config.minimax_sqrt) && Sys.command "sollya --help > /dev/null" = 127 then (print_endline "You can download it at http://sollya.gforge.inria.fr\nYou can also set approx_minimax = false and minimax_sqrt = false in param.transc"; exit 0) else () in
  let _ = if Config.Config.check_certif_coq then
    begin
    let coqc_signal =   Sys.command "coqc -v > /dev/null" in
      if coqc_signal = 127 then (print_endline "You can download coq at http://coq.inria.fr/download and ssreflect at https://gforge.inria.fr/frs/download.php/31453/ssreflect-1.4-coq8.4.tar.gz\nYou can also set check_certif_coq = false in param.transc"; exit 0) 
      else begin
        if Sys.file_exists "coq/remainder.vo" then () else (print_endline "To check semialgebraic bounds with Coq, you need to compile some specific vernacular files. The compilation can be done with the following commands:\n% cd coq; make; cd ..\nNote that this requires the ssreflect libraries. You can download ssreflect at https://gforge.inria.fr/frs/download.php/31453/ssreflect-1.4-coq8.4.tar.gz\nYou can also set check_certif_coq = false in param.transc"; exit 0) 
      end
    end else () in


  let prev = Unix.gettimeofday () in
    U.mk_tmp (); U.mk_log (); U.init_log_file ();
    I.create_basic_tables; Op.create_T_table;
    Mk.make_ast_hashtable F.sphere_table Mk.sphere_final_ml;
    Mk.make_bounds_ineq_hashtables F.sphere_table F.bounds_table F.ineq_table [Mk.ineq_final_ml; Config.Config.input_ineqs_filename];

    let current = Unix.gettimeofday () in
    let hash_mess = Printf.sprintf "Table creation time: %f" (current -. prev) in 
      U._pr_ hash_mess true false;
    S.mk_param_sdpa Config.Config.sdp_solver_print;
    (*U._pr_ (Mk.string_flyspeck_ineq false) true false;*)
    let use_matlab, use_sollya = Config.Config.use_matlab, Config.Config.use_sollya in
    let oc_in, oc_out, oc_err = if use_matlab then O.init_matlab () else stdin, stdout, stdin in 
    let relax_order = Config.Config.relax_order in
    let n_cuts = Config.Config.samp_iters + 1 in
    let stat_errors = ref (Array.make n_cuts Nq.zero_i) in
    let ineq_name = Config.Config.ineq_name in
    let n_begin = 5 in
    let n_end = n_begin in
    let degree = 2 in
    let nvars = n_end in
    let bench_errors = Array.make_matrix (n_end - n_begin + 1) n_cuts Nq.zero_i in
    let (l_I, r_I), errors = 
      if ineq_name = "custom" then Algo_cut.custom_algo_cut xconvert norm oc_in oc_out relax_order, []
      else if ineq_name = "control" then Moore.control_pol oc_in oc_out relax_order
      else if ineq_name = "rnd_pol" then Moore.rnd_pol norm oc_in oc_out relax_order nvars degree
      else if ineq_name = "rnd_pol_stat" then 
        begin
          for i = 0 to Config.Config.n_stat - 1 do
            let _, errors = Moore.rnd_pol norm oc_in oc_out relax_order nvars degree in
            let errors = Array.of_list errors in
              stat_errors := Array.mapi (fun j e -> Nq.add_i e !stat_errors. (j)) errors;
              ()
          done;
          (Iq.zero_I, Iq.zero_I), Array.to_list !stat_errors
        end
      else if ineq_name = "rnd_pol_bench" then 
        begin
          for i = 0 to n_end - n_begin do
            for j = 0 to Config.Config.n_stat - 1 do

            let _, errors = Moore.rnd_pol norm oc_in oc_out relax_order (i + n_begin) degree in
            let errors = Array.of_list errors in
              let _ = 
                if Array.length (bench_errors. (i)) = Array.length errors then
                  bench_errors. (i) <- Array.mapi (fun j e -> Nq.add_i e bench_errors. (i). (j))  errors
                  else () in
              (*
              stat_errors := Array.mapi (fun j e -> N.add_i e !stat_errors. (j)) errors;
               *)
              ()
            done;
          done;
          (Iq.zero_I, Iq.zero_I), Array.to_list !stat_errors
        end
      else if ineq_name = "sos" then 
        begin
          let _  = Sos.test_mon_support () in
            (Iq.zero_I, Iq.zero_I), []
        end
      else
        begin
          let var_list, (full_ineqs, bounds) = Mk.select_flyspeck_bounds_ineq true in
            Uq.debug (Uq.string_of_tuple_list bounds);
          let t1, t2 = List.hd full_ineqs in

          let size_mess = Printf.sprintf "Size of tree: %i" (F.leaves_nodes_number t1 + F.leaves_nodes_number t2)in 
            Uq._pr_ size_mess true false;
            (*
            Algo_cut.init_algo_cut (*Algo_moore.init_trees *)t1 t2 var_list bounds xconvert norm oc_in oc_out relax_order, [] *)
             Moore.solve_ineq norm t1 t2 var_list bounds oc_in oc_out relax_order
        end
    in
      stat_errors := Array.map (fun e -> Nq.div_i e (Nq.num_of_int Config.Config.n_stat)) !stat_errors;  
      for i = 0 to n_end - n_begin do
        bench_errors. (i) <- Array.map (fun e -> Nq.div_i e (Nq.num_of_int Config.Config.n_stat)) bench_errors. (i);  
      done;
      let min_lhs, max_rhs = Iq.inf_I l_I, Iq.sup_I r_I in
      let cmp_symbol = if Nq.ge_i min_lhs max_rhs then " >= " else " <= " in
      Uq._pr_ (Nq.string_of_i_coq (Iq.inf_I l_I) ^ cmp_symbol ^ Nq.string_of_i_coq (Iq.sup_I r_I) (*Config.Config.print_precision*)) true true;
      (*
      let print_bool = ineq_name = "rnd_pol_stat" in        
      Uq._pr_ (Mq.string_of_array_ln !stat_errors) print_bool print_bool;
      let print_bool = ineq_name = "rnd_pol_bench" in
        for i = 0 to n_end - n_begin do
          Uq._pr_ (Mq.string_of_array_ln bench_errors. (i)) print_bool print_bool;
        done;
       *)
        let stop_cmd = if use_matlab then O.stop_matlab oc_in oc_out oc_err else () in 
          stop_cmd;
          let stop_sollya_cmd = if use_sollya then let a, b, c = O.init_sollya () in O.stop_sollya a b c else () in 
            stop_sollya_cmd;
          let check_mess = if Iq.ge_I l_I r_I then "Inequality " ^ Config.Config.ineq_name ^ " verified" else "Failed to verify the inequality " ^ Config.Config.ineq_name in
            Uq._pr_ check_mess true true;
            let time_end = Unix.gettimeofday () in 
            let final_mess = Printf.sprintf "Total time: %g seconds" (time_end -. time_start) in
            let _ = if Config.Config.erase_sollya_files then Sys.command "rm -f log/sollya.log" else 0 in 
             Uq.debug final_mess; 
              Uq.close_log_file (); 
            ()

let main () = 
      begin
      let xconvert, norm = Config.Config.xconvert_variables, Config.Config.normalize_ineqs in
      let _ = start_algo xconvert norm in 
        exit 0
      end
;;
let _ = main () in ()
