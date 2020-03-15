module type T = 
sig
  type num_i 
  type positive
  type pol 
  type fw_pol
  type eval_tbl
  type eval_interv_type 
  type poly_interval 
  type fold_poly_tree 
  type interval
  type algo_semi_alg
  val interval_T : algo_semi_alg -> eval_tbl -> (pol * int, eval_interv_type) Hashtbl.t -> (string, poly_interval) Hashtbl.t -> positive list -> fold_poly_tree -> bool -> interval
end

module Make 
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t)  
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval)  
  (F:Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) 
  (Fu: Fw_utils.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol and type interval = I.interval)
  (E:Unfold_eval_tree.T with type num_i = N.t and type func_tree = F.func_tree and type interval = I.interval)  
  (A: Algo_types.T with type num_i = N.t and type node = F.node and type inter_mut = I.inter_mut and type interval = I.interval and type pol = P.pol and type fw_pol = P.fw_pol) 
  (T: Algo_tables.T with type num_i = N.t and type p = P.positive and type eval_tbl = A.eval_tbl) = struct

    type num_i = N.t
    type positive = P.positive
    type pol = P.pol
    type fw_pol = P.fw_pol
    type eval_tbl = A.eval_tbl
    type eval_interv_type = E.eval_interv_type
    type poly_interval = A.poly_interval
    type fold_poly_tree = A.fold_poly_tree
    type interval = I.interval
    type algo_semi_alg = A.algo_semi_alg

    let interval_T (get_semialg_min : algo_semi_alg) tbl tbl_I varloc_hashtbl vars t nosos = 
      let interval_sub_box tbl tbl_id t = 
        let get_bound p is_min : num_i = if P.is_degree_one p then N.zero_i else U.fst_fst_fst (get_semialg_min ~force:false ~incr_cliques:false tbl (Fu.mk_Pw p) [] [] [] is_min true false) in
        let rec ia  = function
          | A.Varloc (s, (*i_var*)_) ->
              begin
                try
                  let result = Hashtbl.find varloc_hashtbl s in
                  let ir = A.ipi result in
                   (* i_var.I.i <- ir;*)
                    E.Num_interval ir
                with Not_found ->
                  begin
                    try
                      let _, (i1, i2) = Hashtbl.find tbl s in
                      let ir = I.Int (i1, i2) in
                        (*i_var.I.i <- ir;*)
                        E.Num_interval ir
                    with Not_found -> failwith "Varloc not found in interval arith"
                  end
              end
          | A.Pol (p, (*i_pol*)_) ->
              begin
                try Hashtbl.find tbl_I (p, tbl_id)
                with Not_found -> 
                  begin
                    match p with
                      | P.Pc c ->
                          let ic = I.mk_i_I c in
                            (*i_pol.I.i <- ic;*) Hashtbl.add tbl_I (p, tbl_id) (E.Num_interval ic);
                            E.Num_interval ic
                      | _ when P.is_degree_one p || nosos -> E.Num_interval (P.basic_pol_I tbl p)
                      | _ ->
                          begin
                            let min_bound = get_bound p true in
                            let max_bound = get_bound p false in
                              U._pr_ "cmp" false false;
                            let ip = I.Int (min_bound, max_bound) in
                              (*i_pol.I.i <- ip;*) Hashtbl.add tbl_I (p, tbl_id) (E.Num_interval ip);
                              E.Num_interval ip
                          end
                  end
              end
          | A.Br_poly ((F.Ffunc "and", _), [t1; t2]) -> 
              begin 
                match ia t1, ia t2 with 
                  | E.Bool_interval b1, E.Bool_interval b2 -> E.Bool_interval (b1 && b2)
                  | _ -> failwith "Has to be Bool_Int"
              end
          | A.Br_poly ((F.Ffunc "cnd", (*cnd_interv*)_), [A.Br_poly ((F.Ffunc "if", _),  [t1]); A.Br_poly((F.Ffunc "then", (*then_interv*)_), [t2]); A.Br_poly((F.Ffunc "else", (*else_interv*)_), [t3])]) -> 
              begin
                match ia t1 with
                  | E.Bool_interval b1 -> 
                      begin
                        let ir = ia (if b1 then t2 else t3) in
                        (*let i = E.to_interval ir in
                        let cnd = if b1 then then_interv else else_interv in
                          cnd.I.i <- i;*)
                          ir
                      end
                  | _ -> failwith "No such case for if then else"
              end
          | A.Br_poly ((F.Ffunc s, (*i_func*)_), [h]) -> 
              begin
                try 
                  let g = Hashtbl.find I.func_interval_basic s in
                  let ih = ia h in
                  let i = g (E.to_interval ih) in                    
                    (*i_func.I.i <- i;*)
                    E.Num_interval i
                with Not_found -> U._pr_ (Printf.sprintf "At %s:" s) true true; failwith "arity 1 func_interval_basic not found" 
              end
          | A.Br_poly ((F.Ffunc s, (*i_func*)_), [h1; h2]) -> (* incomplete *)
              begin 
                try
                  let g = Hashtbl.find I.func_interval_basic2 s in
                  let ih1 = ia h1 and ih2 = ia h2 in
                  let i = g (E.to_interval ih1) (E.to_interval ih2) in
                    (*i_func.I.i <- i;*)
                    E.Num_interval i
                with Not_found -> 
                  try 
                    let g = Hashtbl.find I.func_interval_bool s in
                    let ih1 = ia h1 and ih2 = ia h2 in
                    let i = g (E.to_interval ih1) (E.to_interval ih2) in
                      E.Bool_interval i
                  with Not_found -> U._pr_ (Printf.sprintf "At %s:" s) true false; failwith "arity 2 func_interval_basic not found"
              end
          | _ -> failwith "unsupported case for interval arithmetic"
        in
          (* 
           _pr_ (string_T t ^ "\n") false false;
           _pr_ (string_T (Operations.simpl_T t)) false false;
           *)
          E.to_interval (ia t) 
      in
        (*
      let tbl_list = List.map (fun b -> T.get_tbl var_list b vars) box_list in
      let n = List.length box_list in
      let id_list = U.int_to_list n in
      let interval_list = List.map2 (fun sub_tbl id -> interval_sub_box sub_tbl id t) tbl_list id_list in
      let mess = Printf.sprintf "interval list: %s" (I.string_of_list_I interval_list) in
        U._pr_ mess true false;
        I.union_list_I interval_list 
         *)
        interval_sub_box tbl 0 t
  end
