module type T = sig
  type func_tree
  type fold_poly_tree 
  type poly_interval
  type pol
  val atan2_to_atn : (fold_poly_tree -> poly_interval list) -> fold_poly_tree -> fold_poly_tree -> fold_poly_tree
  val fold_poly : (fold_poly_tree -> poly_interval list) -> (string, pol) Hashtbl.t -> bool -> func_tree -> fold_poly_tree
  val extract_tame_hypermap : func_tree -> func_tree * func_tree
end

module Make
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (P: Polynomial.T with type num_i = N.t) 
  (Fu: Fw_utils.T with type num_i = N.t and type fw_pol = P.fw_pol) 
  (F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) 
  (E:Unfold_eval_tree.T with type num_i = N.t and type func_tree = F.func_tree) 
  (A: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type node = F.node and type inter_mut = I.inter_mut and type interval = I.interval) 
  (O: Operations.T with type num_i = N.t with type fold_poly_tree = A.fold_poly_tree) = struct

  type func_tree = F.func_tree
  type fold_poly_tree = A.fold_poly_tree
  type poly_interval = A.poly_interval
  type pol = P.pol

  let atan2_to_atn f x y = 
    let sub_square = O.sub_T (O.square_T x) (O.square_T y) in
    let rx = f x and ry = f y and rss = f sub_square in
      begin
        let interval_x, interval_y, interval_ss = A.ipi_of_list rx, A.ipi_of_list ry, A.ipi_of_list rss in
        let cnd_ss = I.gt_I interval_ss I.zero_I 
        and cnd_x = I.gt_I interval_x I.zero_I 
        and cnd_y_plus = I.gt_I interval_y I.zero_I 
        and cnd_y_minus = I.lt_I interval_y I.zero_I in
        let x, y =  
          if (cnd_ss && cnd_x) then x, y
          else if cnd_y_plus then y, x 
          else if cnd_y_minus then O.minus_T y, x 
          else
            begin 
              U._pr_ (I.string_I interval_ss) true false;
              U._pr_ (I.string_I interval_x) true false;
              U._pr_ (I.string_I interval_y) true false;
              failwith "Fourth case of atn2 or disjunction needed";
            end
        in
        let atn_tree = O.fun_T (O.div_T y x) "atan" in
        let atn_tree = 
          if (cnd_ss && cnd_x) then atn_tree
          else if cnd_y_plus then O.sub_T O.half_pi_T atn_tree
          else if cnd_y_minus then O.sub_T atn_tree O.half_pi_T
          else O.pi_T
        in
          atn_tree
      end
(*
let refold_poly tbl t : fold_poly_tree -> fold_poly_tree = function
  | 
 *)
  let fold_poly f tbl xconvert tree : fold_poly_tree =
  let tbl_let = Hashtbl.create 2 in
  let rec fold_pol : (func_tree -> fold_poly_tree) = function
    | F.Branch ((F.Ffunc "mult_i", i), [F.Leaf (F.Fvar v1, i1); F.Leaf (F.Fvar v2, i2)]) ->
        begin
          let p1 = Hashtbl.find tbl v1 and p2 = Hashtbl.find tbl v2 in
            if (xconvert && v1 = v2) then A.Pol (p1, i) else A.Pol (P.p_mul p1 p2, i)
        end
    | F.Leaf (lf, i) ->
        begin
          match lf with 
            | F.Fvar v -> 
                begin
                  try
                    let p = Hashtbl.find tbl v in
                    let poly = A.Pol (p, i) in
                      if (Hashtbl.mem tbl_let v || not xconvert) then poly
                      else 
                        begin
                          (* (Printf.sprintf "In F.Leaf, varloc found
                           * %s" v); *)
                          (*
                           A.Br_poly ((F.Ffunc "sqrt", void_im()), [A.Varloc (v, i)])
                           *)
                          A.Br_poly ((F.Ffunc "sqrt", F.void_im()), [poly])
                        end
                  with Not_found -> 
                    U._pr_ (Printf.sprintf "In F.Leaf, varloc not found %s" v) true false ;
                    A.Varloc (v, i)
                end
            | F.Fint f -> let p = P.Pc (N.num_of_int f) in
                A.Pol (p, i)
            | F.Fflo f -> let p = P.Pc f in
                A.Pol (p, i)
            | F.Fvarloc s -> (*A.Varloc (s, i)*) U._pr_ s true false ;failwith "F.Fvarloc found in fold_poly"
        end
    | F.Branch ((F.Ffunc "let", let_interv ), [ F.Leaf (F.Fvarloc s, i); t1; t2]) -> 
        begin
          let pol1 = fold_pol t1 in
            match pol1 with
              | A.Pol (p1, i1) -> 
                  begin
                    Hashtbl.add tbl s p1; Hashtbl.add tbl_let s p1;
                    let pol2 = fold_pol t2 in 
                      Hashtbl.remove tbl s; Hashtbl.remove tbl_let s;
                      pol2
                  end
              | _ -> A.Br_poly ((F.Ffunc "let", let_interv ), [A.Varloc (s, i); pol1; fold_pol t2])
        end
    | F.Branch ((F.Ffunc s, i), t) ->
        let fold_t = List.map fold_pol t in
          begin
            try
              let p_func = Hashtbl.find P.poly_func s in
                match fold_t with 
                  | [A.Pol (p1, i1); A.Pol (p2, i2)] -> A.Pol (p_func p1 p2, F.void_im())
                  | _ -> A.Br_poly ((F.Ffunc s, i), fold_t) 
            with Not_found ->
              if s = "minus_i" then 
                begin
                  match fold_t with
                    | [A.Pol (p1, i1)] -> A.Pol (P.p_opp p1, F.void_im ())
                    | _ -> A.Br_poly ((F.Ffunc s, i), fold_t)
                end
              else if s = "atan2" then
                begin
                  match fold_t with
                    | [A.Pol (P.Pc f1, i1); A.Pol (P.Pc f2, i2)] -> A.Pol (P.Pc (N.atan2_i f2 f1), F.void_im ())
                    | [x; y] -> atan2_to_atn f x y 
                    | _ -> failwith "Bad fold_poly_tree Arguments for atan2"
                end
                  (*
              else if s = "pow_i" then 
                begin
                  match fold_t with
                    | [A.Pol (p1, i1); A.Pol (Pc f0, i2)] -> A.Pol (p_pow p1 (int_of_float f0), void_im ())
                    | _ -> A.Br_poly ((F.Ffunc s, i), fold_t)
                end
                   *)
              else 
                try
                  let f = Hashtbl.find I.func_basic s in
                    match fold_t with
                      | [A.Pol (P.Pc f0, i1)] -> A.Pol (P.Pc (f f0), i1)
                      | _ -> A.Br_poly ((F.Ffunc s, i), fold_t)
                with Not_found -> A.Br_poly ((F.Ffunc s, i), fold_t) 
          end
    | F.Branch ((n, i), t) -> A.Br_poly ((n, i), List.map fold_pol t)
  in
    fold_pol tree

let extract_tame_hypermap tree =
  let tree_list = E.unfold_add_tree tree in
  let hmap_list, nl_list = List.partition (fun t -> F.degree_map_tree t = 1 || F.degree_map_tree t = 0 ) tree_list in
  let hmap, nl = E.fold_add_tree hmap_list, E.fold_add_tree nl_list in
    nl, hmap

end
