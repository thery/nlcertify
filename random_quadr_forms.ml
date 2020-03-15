module Make 
  (N: Numeric.T)
  (I: Interval.T with type num_i = N.t) 
  (U: Tutils.T with type t = N.t) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval) 
= struct

  let random_init1 () = 
    let _ = Random.self_init () in
    let seed = Random.int 10000 in
    U._pr_ ("Seed: " ^ string_of_int seed) true true; 
      Random.init seed

  let random_init2 seed = Random.init seed

(* with the seed 687631 d = 4 and n = 3 check_samp fails at second iteration (x0
* = [1; 1] because of the mistake Lambda_min (a - b) = Lambda_min (a) -
* Lambda_min (b) ) *)

  let random_init () = random_init2 4030

  let random_coefficients_quadr n bound is_sparse = 
    let m = Array.make_matrix (n + 1) (n + 1) N.zero_i in
      for i = 0 to n do
        for j = 0 to i do
          if (not is_sparse) || (is_sparse && (j = i - 1 || j = i + 1)) then
            begin
              let rnd_coeff = N.num_of_float (Random.float bound) in
              let rnd_sgn = (*Random.bool ()*) true in
                m. (i). (j) <- if rnd_sgn then rnd_coeff else N.minus_i rnd_coeff;
            end
          else ()
        done;
      done;
      m

  let random_coefficients_lin n bound = 
    let m = Array.make (n + 1) N.zero_i in
      for i = 0 to n do
        let rnd_coeff = N.num_of_float (Random.float bound) in
        let rnd_sgn = (*Random.bool ()*) true in
          m. (i) <- if rnd_sgn then rnd_coeff else N.minus_i rnd_coeff;
      done;
      m

(* d = number of alpha_bb quadr forms generated *)
  let random_alhpa_bb n d bounds = 
    let _ = random_init () in
    let one_P, zero_P = P.Pc N.one_i, P.Pc N.zero_i in
    let alpha_P = Array.make d zero_P in
      for i = 0 to d - 1 do
        let a = random_coefficients_lin (n - 1) bounds in
        (*let b = random_coefficients_lin (n - 1) bounds in*)
          for j = 0 to n - 1 do
            let x = P.mkX_i (j + 1) in
            let one_sub_x = P.p_sub one_P (P.pmulC x a. (j)) in
              alpha_P. (i) <- P.p_add (alpha_P. (i)) (P.pmulC (P.p_mul x one_sub_x) (N.mult_i N.four_i a. (j)));            
          done;
      done;
      let norm = N.inv_i (N.num_of_int n) in
        Array.to_list (Array.map (fun p -> P.pmulC p norm) alpha_P)



  let random_quadr_linear_forms n bound is_sparse = 
    let _ = random_init () in
    let m1 = random_coefficients_quadr n bound is_sparse in
    let m2 = random_coefficients_lin n bound in
    let quadr = ref (P.Pc N.zero_i) in
    let lin = ref (P.Pc N.zero_i) in
      for i = 0 to n do
        let lin_coeff = m2. (i) in           
        let lin_monomial = P.mkX_i i in
          lin := P.p_add !lin (P.p_mulC lin_monomial lin_coeff);
          for j = 0 to i do
            let quadr_coeff = m1. (i). (j) in           
            let quadr_monomial = (*P.p_mul lin_monomial*) (P.p_mul (P.mkX_i i) (P.mkX_i j)) in
              quadr := P.p_add !quadr (P.p_mulC quadr_monomial quadr_coeff);
          done;
      done;
      !quadr, !lin

 let random_quadr_sos n = 
    let _ = random_init () in
    let m = random_coefficients_lin n 1.0 in
    let one_P = P.Pc N.one_i in
    let quadr = ref (P.Pc N.zero_i) in
      for i = 1 to n do
        let lin_coeff = m. (i) in           
        let lin_monomial = P.mkX_i i in
        let term = P.p_sub one_P (P.p_mulC lin_monomial lin_coeff) in
          quadr := P.p_add !quadr (P.p_square term);
      done;
      !quadr

 let random_quadr_sos_sparse n = 
    let _ = random_init () in
    let m = random_coefficients_lin n 1.0 in
    let one_P = P.Pc N.one_i in
    let quadr = ref (P.Pc N.zero_i) in
      for i = 1 to n -1 do
        let lin_coeff = m. (i) in           
        let x, xn = P.mkX_i i, P.mkX_i (i + 1) in
        let term1 = P.p_sub one_P (P.p_mulC x lin_coeff) in
        let term2 =  P.p_sub one_P (P.p_mulC xn lin_coeff) in
        let term = P.p_mul term1 term2 in
          quadr := P.p_add !quadr (P.p_square term);
      done;
      !quadr

  let random_linear_forms_list n bound n_transc = 
    let _ = random_init () in
    let rnd_func () = 
    let m = random_coefficients_lin n bound in
    let lin = ref (P.Pc N.zero_i) in
      for i = 0 to n do
        let lin_coeff = m. (i) in           
        let lin_monomial = P.mkX_i i in
          lin := P.p_add !lin (P.p_mulC lin_monomial lin_coeff);
      done;
      U._pr_ (P.string_of_pol !lin) true false;
      !lin
    in
      List.map rnd_func (U.init_list n_transc ()) 

  let rosenbrock n = 
    let one_P = P.Pc N.one_i in
    let zero_P = P.Pc N.zero_i in
    let f = ref zero_P in
    let hundred = N.mult_i N.ten_i N.ten_i in
      for i = 2 to n do
        let x = P.mkX_i i in
        let x_prec = P.mkX_i (i - 1) in
        f := P.p_add !f (P.p_add (P.p_mulC (P.p_square (P.p_sub x (P.p_square x_prec))) hundred ) (P.p_square (P.p_sub one_P x)));
      done;
      (*P.p_mulC !f (N.inv_i (N.mult_i N.two_i hundred))*)
      !f

  let broyden n = 
    let one_P = P.Pc N.one_i in
    let zero_P = P.Pc N.zero_i in
    let two_P = P.Pc N.two_i in
    let three_P = P.Pc N.three_i in
    let f = ref zero_P in
    let tri_pol i = 
      let xp, x, xn = (if i = 1 then zero_P else P.mkX_i (i-1)), P.mkX_i i, (if i = n then zero_P else P.mkX_i (i+1)) in
      let a = P.p_mul x (P.p_sub three_P (P.p_mul two_P x)) in
      P.p_add (P.p_sub (P.p_sub a xp) (P.p_mul two_P xn)) one_P
    in
      for i = 1 to n do
        f := P.p_add !f (P.p_square (tri_pol i));
      done;
      !f

end
