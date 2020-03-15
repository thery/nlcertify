module type T = sig
  type num_i
  type positive
  type pol
  type fold_poly_tree

  val deriv_T_aux : positive -> (pol * positive, fold_poly_tree) Hashtbl.t -> fold_poly_tree -> fold_poly_tree
  val simpl : fold_poly_tree -> fold_poly_tree
  val deriv_T : positive -> (pol * positive, fold_poly_tree) Hashtbl.t -> bool -> fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  val deriv2_T : positive -> positive -> (pol * positive, fold_poly_tree) Hashtbl.t -> bool -> fold_poly_tree -> fold_poly_tree
  type grad = Grad of fold_poly_tree array
  type hess = Hess of fold_poly_tree array array
  val grad_zero_T : int -> grad
  val hessian_zero_T : int -> hess
  val grad_T : positive array -> (pol * positive, fold_poly_tree) Hashtbl.t -> fold_poly_tree -> fold_poly_tree -> bool -> grad
  val hessian_T : positive array -> (pol * positive, fold_poly_tree) Hashtbl.t -> fold_poly_tree -> bool -> hess
  val proj_grad_T : int -> positive -> num_i -> grad -> grad
  val proj_hess_T : int -> positive -> num_i -> hess -> hess
end

module Make
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (P: Polynomial.T with type num_i = N.t) 
  (F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut)  
  (M: Mesh_interval.T with type num_i = N.t and type interval = I.interval) 
  (A: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node = F.node and type inter_mut = I.inter_mut) 
  (O: Operations.T with type num_i = N.t and type pol = P.pol and type fold_poly_tree = A.fold_poly_tree and type positive = P.positive) = struct

    open O
    open O.Infixes

  type num_i = N.t
  type positive = P.positive 
  type pol = P.pol
  type fold_poly_tree = A.fold_poly_tree

  let rec deriv_T_aux var tbl t =  
    match t with
      | A.Varloc (v, _) -> failwith ("varloc found: " ^ v);
      | A.Pol (p, _) -> 
          begin
            try Hashtbl.find tbl (p, var)
            with Not_found ->
              begin
                let dp = A.Pol (P.deriv_pol var p, F.void_im ()) in
                  Hashtbl.add tbl (p, var) dp; dp
              end
          end
      | A.Br_poly ((F.Ffunc "cnd", _), [A.Br_poly ((F.Ffunc "if", _),  [t1]); A.Br_poly((F.Ffunc "then", _), [t2]); A.Br_poly((F.Ffunc "else", _), [t3])]) ->
          A.Br_poly ((F.Ffunc "cnd", F.void_im ()), [A.Br_poly ((F.Ffunc "if", F.void_im ()),  [t1]); A.Br_poly((F.Ffunc "then", F.void_im ()), [deriv_T_aux var tbl  t2]); A.Br_poly((F.Ffunc "else", F.void_im ()), [deriv_T_aux var tbl  t3])])
      | A.Br_poly ((F.Ffunc "minus_i", _), [a]) ->  minus_T (deriv_T_aux var tbl  a)
      | A.Br_poly ((F.Ffunc "sqrt", _), [a]) -> ((deriv_T_aux var tbl  a) </> ( two_T <*> t ))
      | A.Br_poly ((F.Ffunc "add_i", _), [a; b]) -> ((deriv_T_aux var tbl  a) <+> (deriv_T_aux var tbl  b))
      | A.Br_poly ((F.Ffunc "sub_i", _), [a; b]) -> ((deriv_T_aux var tbl  a) <-> (deriv_T_aux var tbl  b))
      | A.Br_poly ((F.Ffunc "pow_i", _), [a; b]) -> (b <*> (deriv_T_aux var tbl a)  <*> (pow_T a (sub_T b one_T)))
      | A.Br_poly ((F.Ffunc "mult_i", _), [   a;  A.Br_poly ((F.Ffunc "inv_i", _), [b])   ]) -> ((((deriv_T_aux var tbl  a) <*> b)  <-> ((deriv_T_aux var tbl  b) <*> a)) </> (square_T b))
      | A.Br_poly ((F.Ffunc "mult_i", _), [a; b]) -> (((deriv_T_aux var tbl  a) <*> b)  <+> ((deriv_T_aux var tbl  b) <*> a))  
      | A.Br_poly ((F.Ffunc "div_i", _), [a; b]) -> ((((deriv_T_aux var tbl  a) <*> b)  <-> ((deriv_T_aux var tbl  b) <*> a)) </> (square_T b))
      | A.Br_poly ((F.Ffunc "sin", _), [a]) -> ((deriv_T_aux var tbl  a)   <*> (cos_T a) )
      | A.Br_poly ((F.Ffunc "cos", _), [a]) -> ((deriv_T_aux var tbl  a)   <*> (minus_T (sin_T a) ))
      | A.Br_poly ((F.Ffunc "tan", _), [a]) -> ((deriv_T_aux var tbl  a)   <*> (one_T <+> (square_T (tan_T a)  )))
      | A.Br_poly ((F.Ffunc "asin", _), [a]) -> ((deriv_T_aux var tbl  a)   <*> (inv_T (sqrt_T (one_T <-> (square_T a)))))
      | A.Br_poly ((F.Ffunc "acos", _), [a]) -> ((deriv_T_aux var tbl  a)   <*> (minus_T (inv_T (sqrt_T (one_T <-> (square_T a))))))
      | A.Br_poly ((F.Ffunc "atan", _), [a]) -> ((deriv_T_aux var tbl  a)   <*> (inv_T (one_T <+> (square_T a))))                                                  
    (*
    | A.Br_poly ((F.Ffunc "atan", _), [ A.Br_poly ((F.Ffunc "mult_i", _), [  Pol(p1, _);  A.Br_poly ((F.Ffunc "inv_i", _), [ A.Br_poly ((F.Ffunc "sqrt", _), [Pol (p2, _)])    ])   ])   ]) ->
        begin
          _pr_ "atan detected" true false;
          let dp1, dp2 = deriv_pol var p1, deriv_pol var p2 in
          let p' = p_sub (p_mulC (p_mul dp1 p2) two_i) (p_mul p1 dp2) in
            _pr_ (string_of_pol p1) true false;
            _pr_ (string_of_pol p2) true false;
            _pr_ (string_of_pol dp1) true false;
            _pr_ (string_of_pol dp2) true false;
            _pr_ (string_of_pol p') true false;
            deriv_T_aux var tbl t 
        end
     *)
      | A.Br_poly ((F.Ffunc "log", _), [a]) -> ((deriv_T_aux var tbl  a)   <*> (inv_T a) )
      | A.Br_poly ((F.Ffunc "inv_i", _), [a]) -> ((deriv_T_aux var tbl  a)   <*> (minus_T (square_T t )))
      | A.Br_poly ((F.Ffunc "exp", _), [a]) -> ((deriv_T_aux var tbl  a)   <*> t )
      | A.Br_poly ((F.Ffunc "pp_33", _), [a]) -> const_T N.two_i <*> deriv_T_aux var tbl a <*>  log_T a </> a
      | _ -> failwith "unsupported case for derivation"

    let simpl = id_T
    let simplify_T = if Config.Config.common_denum then simpl_T else id_T

  let deriv_T var tbl xconvert nl hmap =
    let ti = Unix.gettimeofday() in
    let deriv_nl =
      if (* BUG xconvert *) false then (simpl (deriv_T_aux var tbl nl) <*> (two_T <*> (sqrt_T (x_T var)))) else simplify_T (deriv_T_aux var tbl nl)
    in
    let deriv_hmap = simpl (deriv_T_aux var tbl hmap) in
    let tf = Unix.gettimeofday() in
      U._pr_ (Printf.sprintf "Derivation Time: %f" (tf -. ti )) true false ;
      deriv_nl <+> deriv_hmap


  let deriv2_T v1 v2 tbl xconvert t =
    let ti = Unix.gettimeofday() in
    let result = 
      if (* BUG xconvert *) false then 
        begin
          let x_1 = sqrt_T (x_T v1) and x_2 = sqrt_T (x_T v2) in
          let t1 = two_T <*> (kronecker_T v1 v2) <*> simpl (deriv_T_aux v1 tbl t) in
          let t2 = four_T <*> x_1 <*> x_2 <*> (deriv_T_aux v1 tbl (simpl (deriv_T_aux v2 tbl t))) in
            t1 <+> t2
        end
      else deriv_T_aux v1 tbl (deriv_T_aux v2 tbl t)
    in
    let tf = Unix.gettimeofday() in
      U._pr_ (Printf.sprintf "D2f Time: %f" (tf -. ti )) true false ;
      result



  type grad = Grad of fold_poly_tree array
  type hess = Hess of fold_poly_tree array array

  let grad_zero_T n = Grad (Array.make n zero_T)
  let hessian_zero_T n = Hess (Array.make_matrix n n zero_T)

  let grad_T vars tbl nl hmap xconvert : grad = 
    let nvars = M.size vars in
    let g = Array.make nvars zero_T in
      for i = 0 to (nvars - 1) do
        g. (i) <- deriv_T (vars. (i)) tbl xconvert nl hmap;
      done;
      U._pr_ (M.string_of_array_f g A.string_T) true false;
      Grad g

  let hessian_T vars tbl t xconvert : hess = 
    let nvars = M.size vars in
    let h = Array.make_matrix nvars nvars zero_T in
      for i = 0 to (nvars - 1) do
        for j = i to (nvars - 1) do
          h. (i). (j) <- deriv2_T (vars. (i)) (vars. (j)) tbl xconvert t;
          h. (j). (i) <-  h. (i). (j);
        done;
      done;
      U._pr_ (M.string_of_matrix_f h A.string_T) true false;
      Hess h

    let remove_from_array idx a = Array.of_list (U.remove_from_list idx (Array.to_list a))
    let remove_from_matrix idx m = 
      let m = remove_from_array idx m in
        Array.map (remove_from_array idx) m 

    let proj_grad_T dir_idx pos_k value = function
      | Grad g -> Grad (Array.map (O.eval_T_num pos_k value) (remove_from_array dir_idx g))
    let proj_hess_T dir_idx pos_k value = function
      | Hess h -> Hess (M.map_matrix O.zero_T (O.eval_T_num pos_k value) (remove_from_matrix dir_idx h))

end
