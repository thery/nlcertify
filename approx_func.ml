module type T = 
sig

  type num_i
  type positive
  type transc_approx
  type f
  type fw_pol
  type interval

  val rel_tol_arg : num_i
  val abs_tol_arg : num_i
  val rope_of_chord : num_i -> num_i -> (num_i -> num_i) -> num_i
  val coeff_origine : num_i -> num_i -> (num_i -> num_i) -> num_i
  val get_chord_equation : num_i -> num_i -> (num_i -> num_i) -> transc_approx
  val get_tangent_equation : num_i -> (num_i -> num_i) -> (num_i -> f) -> transc_approx
  val get_osc_par_eq : num_i -> (num_i -> num_i) -> (num_i -> f) -> num_i -> transc_approx
  val get_cubic_eq : num_i -> (num_i -> num_i) -> (num_i -> f) -> (num_i -> f) -> num_i -> transc_approx
  val delta_func_tan : (num_i -> num_i) -> num_i -> num_i -> num_i -> bool
  val compose_fw_approx : fw_pol -> transc_approx -> fw_pol
  val combine_fw_tan_chords : bool -> transc_approx list -> fw_pol -> fw_pol
  val get_tangent : (num_i -> num_i) -> (num_i -> f) -> num_i -> num_i -> int -> int -> transc_approx
  val get_tangents_aux : (num_i -> num_i) -> (num_i -> f) -> num_i -> num_i -> int -> int -> bool -> transc_approx list
  val get_tangents : (num_i -> num_i) -> (num_i -> f) -> interval -> int -> bool -> transc_approx list
(*  val get_tan_osc_aux : (num_i -> num_i) -> (num_i -> f) -> (interval ->
 *  num_i) -> (interval -> num_i) -> interval -> bool -> bool -> num_i ->
 *  transc_approx * transc_approx*)
  val get_tan_osc :  (num_i -> num_i) -> (num_i -> f) -> bool -> bool -> (interval -> num_i) -> (interval -> num_i) -> interval -> num_i list -> transc_approx list * transc_approx list
  val get_chord : (num_i -> num_i) -> num_i -> num_i -> int -> int -> transc_approx
  val get_chords_aux : (num_i -> num_i) -> num_i -> num_i -> int -> int -> transc_approx list
  val get_chords : (num_i -> num_i) -> interval -> int -> transc_approx list
  val check_approx_s : string -> interval -> transc_approx list -> transc_approx list -> interval * interval
  val add_argmins_with_eval : string -> interval -> transc_approx list -> transc_approx list -> num_i list ref -> unit
  val mk_approx : (num_i -> num_i) -> (num_i -> f) -> bool -> bool -> fw_pol -> interval -> (interval -> num_i) -> (interval -> num_i) -> positive list -> num_i list list -> num_i list ref -> bool -> transc_approx list * transc_approx list
  val mk_approx_rec : string -> (num_i -> num_i) -> (num_i -> f) -> bool -> bool -> fw_pol -> interval -> (interval -> num_i) -> (interval -> num_i) -> positive list -> num_i list list -> num_i list ref -> int -> transc_approx list * transc_approx list
  val approx_transc_with_poly : string -> fw_pol -> fw_pol -> (num_i -> num_i) -> (num_i -> f) -> (interval -> num_i) -> (interval -> num_i) -> (interval -> bool) list -> interval  -> positive list -> num_i list list -> (fw_pol * fw_pol) * (interval * interval)
end


module Make 
  (N: Numeric.T) 
  (Fun: Functions.T with type num_i = N.t) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (M: Mesh_interval.T with type num_i = N.t and type interval = I.interval) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval) 
  (Fu: Fw_utils.T with type num_i = N.t and type positive = P.positive and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval and type transc_approx = P.transc_approx) 
  (A: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol) 
  (O: Oracle.T with type num_i = N.t and type positive = P.positive and type pol = P.pol with type term = P.term and type val_tbl = A.val_tbl) 
  (S: Sollya.T with type num_i = N.t and type interval = I.interval) 
  (Tb: Algo_tables.T with type num_i = N.t and type p = P.positive and type eval_tbl = A.eval_tbl and type fw_tbl = A.fw_tbl)  = struct


    type num_i = N.t
    type positive = P.positive
    type transc_approx = Fu.transc_approx
    type f = Fun.f
    type fw_pol = P.fw_pol
    type interval = I.interval
    let prec = Config.Config.print_precision

    let verb = Config.Config.parab_verb 
    let debug s = if verb then U.debug s else ()

    let rel_tol_arg = N.pow_i N.ten_i (N.minus_i N.two_i)
    let abs_tol_arg =  N.pow_i N.ten_i (N.minus_i N.three_i)

    let rope_of_chord a b transc = 
      if a = b then N.zero_i 
      else N.div_i (N.sub_i (transc b) (transc a)) (N.sub_i b a)

    let coeff_origine a b transc = 
      if a = b then transc a
      else N.div_i (N.sub_i (N.mult_i (transc a) b) (N.mult_i (transc b) a)) (N.sub_i b a)

    let get_chord_equation a b transc = P.Tan (rope_of_chord a b transc, coeff_origine a b transc)

    let get_tangent_equation x0 transc transc' = 
      let x0_value = Fun.transc'_num transc' x0 in
        P.Tan (x0_value, N.sub_i (transc x0) (N.mult_i x0 x0_value ))

    let get_osc_par_eq x0 transc transc' curv =
      if N.eq_i curv N.zero_i then get_tangent_equation x0 transc transc' 
      else
      let f_x0 = transc x0 and f'_x0 = Fun.transc'_num transc' x0 in
      let ferror i = if Config.Config.round_maxplus_error then (if N.ge_i curv N.zero_i then N.upper_bound i (int_of_float Config.Config.interval_acc) else N.lower_bound i (int_of_float Config.Config.interval_acc)) else i in
        P.Par (N.div_i curv N.two_i, f'_x0, ferror f_x0, x0)

    let get_cubic_eq x0 transc transc' transc'' curv =
      let f_x0 = transc x0 and f'_x0 = Fun.transc'_num transc' x0 and f''_x0 = Fun.transc'_num transc'' x0  in
        P.Cub (N.div_i curv N.six_i, N.div_i f''_x0 N.two_i, f'_x0, f_x0, x0)


    (* Checks wether or not transc b - (r*b + p) >=0 *)
    let delta_func_tan transc r p b = N.ge_i (transc b) (N.add_i (N.mult_i r b) p)
    let c0 = P.cert_null
    let compose_fw_approx fw a = 
      let i = Fu.ifw (Fu.compose_fw_approx_for_eval fw a) in 
        U._pr_ ("Compose interval: " ^ (Fu.string_approx a) ^ (Fu.string_of_fw fw) ^ (I.string_I i)) false false;
        P.Comp ((a, fw), i, c0)

    let rec combine_fw_tan_chords is_lhs d fw = 
      let fw_l =  List.map (compose_fw_approx fw) d in
      let f fw_l = if is_lhs then Fu.assign_max fw_l else Fu.assign_min fw_l in
        (f fw_l) 

    let get_tangent transc transc' a b k base = 
      let x0 = U.k_th_segment_I a b k base in
        get_tangent_equation x0 transc transc'

    let rec get_tangents_aux transc transc' a b k base direction = 
      if (k >= base) then [] 
      else
        let k' = if direction then k else base - k in
          (get_tangent transc transc' a b k' base)::(get_tangents_aux transc transc' a b (k+1) base direction)  

(* get_tangents returns the list of tuples (r, v) with r being the rope of the
* tangent and v the origin value at transc, transc' being the derivative, w.r.t
* interval = Int (a, b). 
* If direction = true then we start generating tangents from a
* otherwise from b: helpful if transc is neither concave nor convexe *)

    let get_tangents transc transc' interval ntangents direction = 
      let (a, b) = I.tuple_of_I interval in
        get_tangents_aux transc transc' a b 0 ntangents direction 

    let get_chord transc a b k base = 
      let left_bound = U.k_th_segment_I a b k base in
      let right_bound = U.k_th_segment_I a b (k+1) base in
        get_chord_equation left_bound right_bound transc

    let rec get_chords_aux transc a b k base = 
      if (k >= base) then [] 
      else
        (get_chord transc a b k base)::(get_chords_aux transc a b (k+1) base)  

    let get_chords transc interval nchords = 
      let (a, b) = I.tuple_of_I interval in 
        get_chords_aux transc a b 0 nchords 

(* Dummy function: not used yet         
    let get_tan_osc_aux transc transc' min_c max_c interval is_incr is_conv_conc x0 =
      let curv_below = min_c interval and curv_above = max_c interval in
      let curv_H_below = N.mult_i N.two_i (I.min_c_conv_atan interval x0) in
      let curv_H_above = N.mult_i N.two_i (N.minus_i (I.max_c_conv_atan interval x0)) in
      let tan_eq = get_tangent_equation x0 transc transc' in
      let (r, p) = Fu.tan_approx tan_eq in
      let (a, b) = I.tuple_of_I interval in
      let b1, b2, b3, b4, b5 = is_incr, is_conv_conc, N.le_i x0 N.zero_i, delta_func_tan transc r p a, delta_func_tan transc r p b in
      let nb1, nb2, nb3, nb4, nb5 = not b1, not b2, not b3, not b4, not b5 in
      (*  let osc = get_below_osc_equation x0 transc transc' min_c is_conv_conc
       *  is_incr in*)
      (*_pr_ (string_approx osc) true false ;*)
      let lower = 
        if ((b1 && b2 && b3 && b5) || (b1 && nb2 && nb3 && b4) || (nb1 && nb2 && nb3 && b4) || (nb1 && b2 && b3 && b5)) 
        (*then tan_eq*)
        then get_osc_par_eq x0 transc transc' curv_H_below
        else get_osc_par_eq x0 transc transc' curv_below
      in
      let upper = 
        if (b1 && b2 && nb3 && nb4) || (b1 && nb2 && b3 && nb5) || (nb1 && b2 && nb3 && nb4) || (nb1 && nb2 && b3 && nb5) 
        (*then tan_eq*)
        then get_osc_par_eq x0 transc transc' curv_H_above 
        else get_osc_par_eq x0 transc transc' curv_above
      in
        lower, upper
 *)
    let get_tan_osc transc transc' is_conv is_conc min_c max_c interval x0 =
      (* min_c : min_{x \in interval} transc''(x) *)
      (* max_c : max_{x \in interval} transc''(x) *)

(*      let mess = Printf.sprintf "List of control points: %s "
 *      (I.string_float_list x0) in debug mess;*)
      if is_conv then
        List.map (fun x -> get_tangent_equation x transc transc') x0,
        (*   List.map (fun x -> get_osc_par_eq x transc transc' (min_c interval)) x0, *)
        (*get_chords transc interval 1
        @*) List.map (fun x -> get_osc_par_eq x transc transc' (max_c interval)) x0
      (* for instance, min_c can be positive for arctan on a negative interval*)
      else if is_conc then
        (*get_chords transc interval 1 @*) List.map (fun x -> get_osc_par_eq x transc transc' (min_c interval)) x0, 
        List.map (fun x -> get_tangent_equation x transc transc') x0
      (* for instance, max_c can be negative for arctan on a positive interval*)
      else
        begin
          U._pr_ "Warning: Not on convex interval" true false; 
          List.map (fun x -> get_osc_par_eq x transc transc' (min_c interval)) x0 (*@
                                                                                   get_chords transc interval 1*),
          List.map (fun x -> get_osc_par_eq x transc transc' (max_c interval)) x0
        end

    let check_approx_s s interval dmin dmax = 
      let f = Hashtbl.find I.func_basic s in
      let a, b = I.tuple_of_I interval in
      let points = U.points_of_I a b Config.Config.check_points in
      let approx_min = combine_fw_tan_chords true dmin (Fu.mk_Pw P.mkX) in
        U._pr_ (Fu.string_of_fw approx_min) true false;
      let approx_max = combine_fw_tan_chords false dmax (Fu.mk_Pw P.mkX) in
      let evals_fw_min = List.map (fun p -> Fu.eval_fw (Tb.get_tbl_pol [Numbers.T.XH] [p]) approx_min) points in
      let evals_fw_max = List.map (fun p -> Fu.eval_fw (Tb.get_tbl_pol [Numbers.T.XH] [p]) approx_max) points in
      let evals_f = List.map f points in
      let evals_min = List.map2 (fun e1 e2 -> (N.sub_i e1 e2)) evals_f evals_fw_min in
      let evals_max = List.map2 (fun e1 e2 -> (N.sub_i e1 e2)) evals_fw_max evals_f in
      let check_dmin, check_dmax = I.mk_I (I.min_list evals_min, I.max_list evals_min), I.mk_I (I.min_list evals_max, I.max_list evals_max) in
        U._pr_ (Printf.sprintf "CheckDmin: %s CheckDmax: %s" (I.string_I check_dmin) (I.string_I check_dmax)) true true;
        check_dmin, check_dmax

    let add_argmins_with_eval s interval dmin dmax (argmins: num_i list ref) : unit = 
      try
        let f = Hashtbl.find I.func_basic s in
        let a, b = I.tuple_of_I interval in
        let points = U.points_of_I a b 100 in
        let approx_min = combine_fw_tan_chords false dmax (Fu.mk_Pw P.mkX) in
        let evals_fw = List.map (fun p -> Fu.eval_fw (Tb.get_tbl_pol [Numbers.T.XH] [p]) approx_min) points in
        let evals_f = List.map f points in
        let evals = List.map2 (fun e1 e2 -> (N.sub_i e1 e2)) evals_fw evals_f in
        let eval_max = I.max_list evals in
        let idx = U.index_of_elt evals eval_max in
        let mess = Printf.sprintf "evals_f = %s " (I.string_of_list_i evals_f) in
          U._pr_ mess true false;
          let mess = Printf.sprintf "evals_fw = %s " (I.string_of_list_i evals_fw) in
            U._pr_ mess true false;
            let mess = Printf.sprintf "idx = %i: max = %s" idx (N.string_of_i eval_max) in
              U._pr_ mess true false;
              let argmin = List.nth points idx in
                argmins := argmin :: !argmins;
      with Not_found -> failwith (Printf.sprintf "%s: function not found" s)

    let mk_approx transc transc' is_conv is_conc pmin interval min_c max_c vars (optim_guesses: num_i list list) argmins use_optim = 
      (*
       let curv_below = min_c interval and curv_above = max_c interval in
       *)
      let w = I.width_I interval in
      let rel_tol_arg = N.mult_i w (N.mult_i N.ten_i rel_tol_arg) in
      let abs_tol_arg = N.mult_i w rel_tol_arg in
      (*
       let arg_mins, arg_maxs = List.map (fun o -> eval_fw o pmin) optim_guesses, List.map (fun o -> eval_fw o pmax) optim_guesses in
       *)
      let arg_mins = if use_optim then 
        begin
          let arg_mins = List.map (fun o -> Fu.eval_fw (Tb.get_tbl_pol vars o) pmin) optim_guesses in
          let sorted_arg_mins = I.sort_tol rel_tol_arg abs_tol_arg (List.sort N.compare_i arg_mins) in
          (*
           let sorted_arg_mins = sort compare arg_mins in
           *)
          let n = List.length optim_guesses - List.length sorted_arg_mins in
          let argc = Array.length Sys.argv in
          let arg_mins = 
            if argc = 4 && N.is_integer (N.of_string Sys.argv. (3)) then
              begin
                let cuts =  int_of_string Sys.argv. (3) in
              (*
               let half = N.num_of_float 0.5 in
               let third = N.num_of_float 0.3 in
               let a, b = third, half in
               *)
                let a, b = I.tuple_of_I interval in
                  U.points_of_I a b cuts
              end
                else if argc > 3 then
                  begin
                    let arg_mins = Array.sub Sys.argv 3 (argc - 3) in
                    let arg_mins = List.map N.of_string (Array.to_list arg_mins) in
                      I.sort_tol rel_tol_arg abs_tol_arg (List.sort N.compare_i arg_mins) 
                  end
                else
                  (* 
                   let sorted_arg_min = sort_tol rel_tol_arg abs_tol_arg (sort compare atan_arg_min) in
                   *)
                  let mess = Printf.sprintf "sorted_argmin: %s " (I.string_of_list_i arg_mins) in
                    U._pr_ mess true false;
                    let sort_arg_mins = M.add_points_I interval n sorted_arg_mins in
                    let mess = Printf.sprintf "new_argmin: %s " (I.string_of_list_i sort_arg_mins) in
                      U._pr_ mess true false;
                      List.sort N.compare_i arg_mins
          in
            (*
             List.map N.num_of_float [-1.0000 ; -0.7145 ; -0.7105 ; -0.7086 ; -0.7085 ; -0.6971 ; -0.6802 ; -0.6456 ; -0.5771 ; -0.4394 ;-0.7145 ; -0.7105 ; 0.7086 ; 0.7085 ; 0.6971 ; 0.6802 ; 0.6456 ; 0.5771 ; 0.4394; 1.0000]*)

            arg_mins
        end
      else [] in
        argmins:=arg_mins @ !argmins;
        let arg_mins = !argmins in
        let _ = arg_mins in
        let arg_mins = if Config.Config.approx_func_centered then [I.mid_I interval] else arg_mins in
          get_tan_osc transc transc' is_conv is_conc min_c max_c interval arg_mins 

    let rec mk_approx_rec s transc transc' is_conv is_conc pmin interval min_c max_c vars (optim_guesses: num_i list list) argmins number_approx =
      (* modify the first true to false to build approximations with evaluated
       * argmins *)
      if number_approx = 0 * List.length optim_guesses then mk_approx transc transc' is_conv is_conc pmin interval min_c max_c vars optim_guesses argmins true 
      else  
        let use_optim = number_approx = 0 in
        let dmin, dmax = mk_approx transc transc' is_conv is_conc pmin interval min_c max_c vars optim_guesses argmins use_optim in
          add_argmins_with_eval s interval dmin dmax argmins;
          let mess = Printf.sprintf "n = %i: argmins = %s " number_approx (I.string_of_list_i !argmins) in
            U._pr_ mess true false;
            mk_approx_rec s transc transc' is_conv is_conc pmin interval min_c max_c vars optim_guesses argmins (number_approx + 1)



    (* If optim_guess is argument of the function transc then we do not need to
     * evaluate poly1 and poly2 for it (disjunction case)
     * Otherwise, we compute the list of transc arguments using eval_fw optim_guess *)
    let approx_transc_with_poly s poly1 poly2 transc transc' min_c max_c prop_list interval vars (optim_guesses : num_i list list) = 
      let nums = U.int_to_list 65 in  
      let pi_multiple = List.map (fun i -> N.mult_i (N.num_of_int i) (N.num_of_float (3.1415/.2.)) )  nums in      
      let (*argmins_user*)_ = pi_multiple in
      let argmins = ref [](*argmins_user*) in    
        try
          (*let tangents = get_tangents transc transc' interval accuracy true in
           let chords = get_chords transc interval accuracy in*)
          let bool_list = U.map_func prop_list interval in
            match bool_list with
              | [is_conv; is_conc; is_incr; is_deacr] ->
                  begin
                    U._pr_ (s ^ " on " ^ (I.string_I interval) (*^ "; conv, conc, incr, deacr : " ^ (string_of_bool is_conv) ^ " " ^ (string_of_bool is_conc) ^ " " ^ (string_of_bool is_incr) ^ " " ^(string_of_bool is_deacr)*)) true false;
                    let pmax = if is_incr  then poly2  else poly1 in
                    let pmin = if is_deacr then poly2  else poly1 in                  
                    let dmin, dmax, eval_min, eval_max = 
                      if (s = "sqrt" && Config.Config.minimax_sqrt || Config.Config.approx_minimax) && N.ge_i (I.width_I interval) (N.num_of_float 0.02) then
                       begin
                         let e, l = U.hd_tl (S.get_minimax s Config.Config.minimax_degree interval) in
                           U._pr_ ("Sollya error: " ^ (N.string_of_i e)) true true;
                           [P.Minimax l], [P.Minimax l], I.mk_i_I e, I.mk_i_I e
                       end 
                      else
                        begin                        
                          let dmin, dmax = mk_approx_rec s transc transc' is_conv is_conc pmin interval min_c max_c vars optim_guesses argmins 0 in
                          let eval_min, eval_max = if Config.Config.check_points = 0 then I.zero_I, I.zero_I else check_approx_s s interval dmin dmax in
                          let _ = Printf.sprintf "argmins: %s -> %s" (I.string_of_list_i !argmins) (U.concat_string_with_string (List.map Fu.string_approx dmax) "; ") in
                          let mess = Printf.sprintf " Control points set: %s Underestimators:%s Overestimators: %s" (I.string_float_list !argmins prec) (U.concat_string_with_string (List.map (fun t -> Fu.string_float_approx t prec) dmin) ";") (U.concat_string_with_string (List.map (fun t -> Fu.string_float_approx t prec) dmax) "; ")  in
                            U._pr_ mess true verb;
                            dmin, dmax, eval_min, eval_max
                        end in
                      (*
                      U._pr_ ("Lower Approx: " ^ U.concat_string (List.map Fu.string_approx dmin)) true verb;
                      U._pr_ ("Upper Approx: " ^ U.concat_string (List.map Fu.string_approx dmax)) true verb;
                       *)
                      let new_poly1 = combine_fw_tan_chords true dmin pmin in
                      let new_poly2 = combine_fw_tan_chords false dmax pmax in
                        (new_poly1, new_poly2), (eval_min, eval_max)                        
                  end
              | _ -> failwith "Not a valid boolean list"
        with Not_found -> failwith "Not a transcendental or derivable function"
  end
