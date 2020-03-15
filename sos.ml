
module Make
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (M: Mesh_interval.T with type num_i = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval)  
  (Nq: Numeric.T) 
  (Uq: Tutils.T with type t = Nq.t) 
  (Mq: Mesh_interval.T with type num_i = Nq.t) 
  (Iq: Interval.T with type num_i = Nq.t) 
  (Pq: Polynomial.T with type num_i = Nq.t and type interval = Iq.interval)  
  (Sdpa: Sdp_aux.T with type num_i = N.t)
  = struct
    type num_i = N.t   
    type alpha = int list
    let sos_verb = Config.Config.sos_verb
    let debug s = if sos_verb then U.debug s else ()
    let debug_time s = if Config.Config.sdp_verb then U.debug s else ()
    let str_of_alpha alpha = U.string_of_list (List.map string_of_int alpha)
    let str_of_allmons allmons = U.concat_string_with_string (List.map str_of_alpha allmons) "\n"
    let str_of_monomials m = 
      let str = ref "" in
      let k = Array.length m in
      for d = 0 to k - 1 do
          let md = m. (d) in     
          for i = 0 to Array.length md - 1 do
            str := !str ^ (str_of_alpha (md. (i))) ^ "\n";
          done;
      done;
      !str

    let print_block_monomials block = 
      let str = ref "" in
      for b = 0 to Array.length block - 1 do
        let block_mess = "BLOCK " ^ (string_of_int (b + 1)) ^ "\n"  in
        str := !str ^ block_mess  ^ str_of_monomials block. (b);
      done;
      debug !str; ()

    let true_nb cl = List.fold_left (fun acc b -> acc + (if b then 1 else 0)) 0 cl
    let zero_nb mon = List.fold_left (fun acc b -> acc + (if b = 0 then 1 else 0)) 0 mon
    let str_of_support = function
        alpha, p_alpha -> Printf.sprintf "%s %s" (M.string_of_array_int alpha) (N.string_of_i p_alpha)

    let k_q q =  int_of_float (ceil ((float_of_int (P.degree_pol q)) /. 2.))  

    let str_of_obj_idx = function
        column, p_alpha -> Printf.sprintf "%i %s" column (N.string_of_i p_alpha)

    let pick_in_list l idxs = 
      let rec f acc = function
        | n::tl -> f ((List.nth l (n - 1))::acc) tl
        | [] -> acc
      in
        List.rev (f [] idxs)

    let postoint = Numbers.T.Translation.positive

    let vars_of_pol p n : bool list = 
      let vars = List.map (fun pos -> postoint pos - 1) (P.vars_of_pol p) in
      List.map (fun i -> List.mem i vars ) (U.int_to_list n)


    let mons_add m1 m2 = List.map2 (+) m1 m2
    let mons_sub m1 m2 = List.map2 (-) m1 m2
    let double_alpha alpha = List.map (fun i -> 2 * i) alpha
    let mons_eq m1 m2 = List.for_all2 (=) m1 m2
    let mon_eq_zero m = List.for_all (fun i -> i = 0) m
    let mon_zero n = U.init_list n 0


    let mons_support pol n : (int array * num_i) array = 
      let mons = P.monomials pol in
       debug (Printf.sprintf "Support of polynomial %s:" (P.string_of_pol pol));
       List.iter (fun p -> debug (P.string_of_pol p)) mons;
        Array.map (P.monomial_support n) (Array.of_list mons)


    let mons_support_list pol n : int list list = 
      let mons = mons_support pol n in
        Array.to_list (Array.map (fun (mon, _) -> Array.to_list mon) mons)

    let mons_support_debug n =  (U.init_list n 0)::(Array.to_list (U.enumerate_ntuple_lex 1 n))


(* DEBUG *)         (* allmons is A^{Fq}_{2 * (k - kq)} , k = 2 * (k - kq) *) 
    let minkovski_sum deg_max q cl n (allmons: int list array array) = 
      let support_q = mons_support_list q n in
      let k = Array.length allmons -1 in
      let minkovski mon = 
        let sum = ref [] in
        for d = 0 to k do
          let mons = allmons. (d) in
          for i = 0 to Array.length mons - 1 do
            let alpha_sos_pol = U.alphacl_to_alphan (mons_add mon (mons. (i))) cl in
            if U.deg_lex alpha_sos_pol <= deg_max then sum := alpha_sos_pol::!sum; 
          done; 
        done;
        !sum in
      let minkovski_sum = List.concat (List.map minkovski support_q) in
        U.lexsort minkovski_sum

    let union_supports supports = U.lexsort (List.concat supports)

    let mk_support_fe support_f = 
      let is_even alpha = List.for_all (fun alphai -> alphai mod 2 = 0) alpha in
        List.filter is_even support_f

    (* When we suppose that all the monomials of degree di and dj have been
     * considered i.e. no use of Newton polytope *)
    let idx_of_support_tbl n = function
      | (di, dj, i, j) -> (U.binomial (n + di - 1) n) + i, (U.binomial (n + dj - 1) n) + j
                                                                                         
    let sdpa_line_of_alpha alpha v =
      let i, j = idx_of_support_tbl (List.length alpha) v in
        U.lexidx_of_alpha alpha, 1, i + 1, j + 1, N.one_i

    let loc_sdpa_line_of_alpha mon q_alpha coord idx_q = 
      let i, j = idx_of_support_tbl (Array.length mon) coord in
        U.lexidx_of_alpha (Array.to_list mon), 1 + idx_q, i + 1, j + 1, q_alpha

    (* sdpa_line three functions for kojima sparse sdp relaxation: *)

    (* add one to the lexidx because alpha = 0 is not in sparse_allmons *)
    let sparse_sdpa_line_of_alpha alpha v cl sparse_allmons cl_idx = 
      let i, j = idx_of_support_tbl (true_nb cl) v in
        1 + U.naive_lexidx_of_alpha alpha sparse_allmons, 1 + cl_idx, i + 1, j + 1, N.one_i
    
    let sparse_loc_sdpa_line_of_alpha mon q_alpha coord nvars sparse_allmons idx_q =
      (*debug (str_of_alpha (Array.to_list mon));*)
      let i, j = idx_of_support_tbl nvars coord in
        1 + U.naive_lexidx_of_alpha (Array.to_list mon) sparse_allmons, 1 + idx_q, i + 1, j + 1, q_alpha

    let sparse_diag_sdpa_line_of_alpha mon q_alpha coord nvars sparse_allmons size_prev_block nBlOCK =
      let i, j = idx_of_support_tbl nvars coord in
        1 + U.naive_lexidx_of_alpha (Array.to_list mon) sparse_allmons, nBlOCK, i + size_prev_block + 1, i + size_prev_block + 1, q_alpha

    let gamma_alpha (alpha : alpha) = N.num_of_float (List.fold_left (fun a b -> a *. (1. /. ( b +. 1.)) ) 1. (List.map float_of_int alpha))

    (* sdpa lines for diagonal block matrix to handle equality constraints:
    * y_alpha = gamma_alpha + ... *)
    let sparse_L1_sdpa_line_of_alpha mon_lexidx q_alpha i size_prev_block nBlOCK =
        1 + mon_lexidx, nBlOCK, i + size_prev_block + 1, i + size_prev_block + 1, q_alpha

    let allmons k n = Array.map (fun d -> U.enumerate_ntuple_lex d n) (Array.of_list (U.int_to_list (k + 1))) 

    (* check if alpha in N_deg^n *)
    let is_mon_deg_n npop n deg alpha = 
      let sub_list = U.sub_list alpha n (npop - 1) in
       mon_eq_zero sub_list && U.deg_lex alpha = deg

    (* input: alpha list 
     * the alpha lie in N_k^npop, with k >= kmax
     * n, kmin, kmax : select only the alpha in N_deg^n for kmin <= deg <= kmax
       output: alpha matrix, each matrix row matches a certain degree *)
    let sparse_allmons_sort_degree allmons npop n kmin kmax : alpha array array =       
      let allmons_array = Array.make (kmax - kmin + 1) ([||]) in
      for deg = kmin to kmax do
        allmons_array. (deg - kmin) <- Array.of_list (List.filter (is_mon_deg_n npop n deg) allmons);
      done;
      allmons_array 

    let sparse_L1_sdpa_lines sparse_allmons npop n d nBlOCK bLOCKsTRUCT = 
      let sparse_allmons_d = sparse_allmons_sort_degree sparse_allmons npop n 0 d in 
      let size_block = Array.fold_left ( + ) 0 (Array.map Array.length sparse_allmons_d) in
      let f0_array = Array.make (2 * size_block) (0, 0, 0, 0, N.zero_i) in
      let f_array = Array.make (2 * size_block) (0, 0, 0, 0, N.zero_i) in
      let array_idx = ref 0 in
        bLOCKsTRUCT. (nBlOCK - 1) <- - 2 * size_block; 
        for idx = 0 to d do
          let mons = sparse_allmons_d. (idx) in
          for mon_idx = 0 to Array.length mons - 1 do
            let i = !array_idx in
            let mon = mons. (mon_idx) in
            f0_array. (i) <- 0, nBlOCK, i + 1, i + 1, gamma_alpha mon;
            f0_array. (i + size_block) <- 0, nBlOCK, i + size_block + 1, i + size_block + 1, N.minus_i (gamma_alpha mon);
            f_array. (i) <- 1 + U.naive_lexidx_of_alpha mon sparse_allmons, nBlOCK, i + 1, i + 1, N.one_i;
            f_array. (i + size_block) <- 1 + U.naive_lexidx_of_alpha  mon sparse_allmons, nBlOCK, i + size_block + 1, i + size_block + 1, N.minus_i N.one_i;
            incr array_idx;
          done;
        done;
        Array.append f0_array f_array, sparse_allmons_d

  (* cl: bool list indexing the subset of variables to define the clique
   * returns a hashtbl where:
   * keys are n-tuple corresponding to n-variables monomials of degree atmost k 
   * values are list of indexes of this monomial in the k-truncated moment
   * matrix in Lasserre hierarchy defined by the coordinates of the block and
   * the coordinates inside the block, thus values are 4-tuple of integers *)
    let moment_matrix_tbl k snk allmons cl = 
      let moment_tbl = Hashtbl.create snk in
        for di = 0 to k do
          let mdi = allmons. (di) in            
          let li = Array.length mdi in
            for dj = di to k do
              if dj = 0 && dj = 0 then () 
              else 
                begin
                  let mdj = allmons. (dj) in
                  let cj = Array.length mdj in
                    (* loop inside block (di, dj) for monomials of degree di + dj *)
                    for i = 0 to li - 1 do
                      let start_j = if dj = di then i else 0 in
                      for j = start_j to cj - 1 do
                        let mi, mj = mdi. (i), mdj. (j) in
                        let mij = (*U.alphacl_to_alphan*) (mons_add mi mj) (*cl*) in
                          Hashtbl.add moment_tbl mij (di, dj, i, j)
                      done;
                    done;
                end
            done;
        done;
        moment_tbl

    let sparse_moment_matrix_tbl k cl allmons card_support = 
      (* let n = true_nb cl in
      let allmons = allmons k n in
      let sparse_moment_size = U.binomial (n + k) n in*)
      let sparse_moment_size = card_support in
      let m = sparse_moment_size * sparse_moment_size / 2  in
      let sparse_moment_tbl = moment_matrix_tbl k m allmons cl in
       (* IMPORTANT: the set of keys of this table is not the full set of moment
       * variables but corresponds only to the subset of moment variables that occur in
       * the moment matrix *) 
        sparse_moment_size, sparse_moment_tbl


  (* returns a hashtbl where:
   * keys are n-tuple corresponding to n-variables monomials of degree atmost k 
   * values are list of (q_alpha, beta) with beta = index of the moment variable
   * y_beta in the k-truncated localizing matrix and q_alpha the coeff of y_beta *)
    let localizing_matrix_tbl k n allmons q vars =
      let q0 = ref N.zero_i in
      let nvars = true_nb vars in 
      let kq = k - (k_q q)  in
      (*let loc_size = *)
      let prev_loc_size = (U.binomial (nvars + kq) nvars) in 
      (* if no poly newton then loc_size = (U.binomial (nvars + k) nvars) in *)
      let m = prev_loc_size * prev_loc_size / 2 in
      let mons_support = mons_support q n in
      let loc_tbl = Hashtbl.create m in
        for di = 0 to kq do
          let mdi = allmons. (di) in            
          let li = Array.length mdi in
            for dj = di to kq do
              let mdj = allmons. (dj) in
              let cj = Array.length mdj in
                (* loop inside block (di, dj) over monomials of degree di + dj *)
                for i = 0 to li - 1 do
                  let start_j = if dj = di then i else 0 in
                    for j = start_j to cj - 1 do
                      (* loop over the coeffs q_alpha of q *)
                      for a = 0 to Array.length mons_support - 1 do
                        let alpha, q_alpha = mons_support. (a) in
                          if di = 0 && dj = 0 && (List.for_all (fun i -> i = 0) (Array.to_list alpha)) then begin q0 := q_alpha;() end
                          else
                            begin
                              let mi, mj = mdi. (i), mdj. (j) in
                              let mon =  mons_add  (Array.to_list alpha) (U.alphacl_to_alphan (mons_add mi mj) vars) in
                              let mij = Array.of_list mon in
                               Hashtbl.add loc_tbl mij (q_alpha, (di, dj, i, j))
                            end
                      done;
                    done;
                done;
            done;
        done;
        !q0, prev_loc_size, loc_tbl

    let mk_loc_sos_support is_eq allmons k q vars : alpha array array =   
      (*debug (P.string_of_pol q);*)
      let kq = if is_eq then 2 * k - P.degree_pol q else k - (k_q q) in
      let loc_allmons = Array.make (kq + 1) [||] in
      for d = 0 to kq do
        let md_vars = allmons. (d) in
        let md = Array.map (fun mon ->  U.alphacl_to_alphan mon vars) md_vars in
        loc_allmons. (d) <- md;
      done;
      loc_allmons

    let find_clique_loc vars cliques : bool list = 
      let vars_subet_clique vars cl = List.for_all2 (fun v c -> v = c || c && (not v)) vars cl in
        List.find (vars_subet_clique vars) cliques

    let sparse_loc_matrix_tbl k q cliques n = 
      let vars = vars_of_pol q n in
      let vars = if Config.Config.loc_support_clique then find_clique_loc vars cliques else vars in
      let nvars = true_nb vars in
      let allmons = allmons k nvars in
      let loc_sos_support = mk_loc_sos_support false allmons k q vars in (* false since ineq *)
      let q0, loc_size, loc_tbl = localizing_matrix_tbl k n allmons q vars in
      
        q0, loc_size, loc_tbl, nvars, loc_sos_support

  (* returns a hashtbl where:
   * keys are n-tuple corresponding to n-variables monomials of degree atmost k 
   * values are list of (q_alpha, beta) with beta = index of the moment variable
   * y_beta in the k-truncated diagonal equality block matrix and q_alpha the coeff of y_beta *)
    let loc_diag_matrix_tbl k n allmons q vars =
      let q0 = ref N.zero_i in
      let nvars = true_nb vars in 
      let k = 2 * k - P.degree_pol q in
      let diag_size = (U.binomial (nvars + k) nvars) in
      let mons_support = mons_support q n in
      let m = (Array.length mons_support) * diag_size in
      let diag_tbl = Hashtbl.create m in
        for d = 0 to k do
          let md = allmons. (d) in    
          let l = Array.length md in
            (* loop inside symmetric block d over monomials of degree d*)
                for i = 0 to l - 1 do
                  (* loop over the coeffs q_alpha of q *)
                  for a = 0 to Array.length mons_support - 1 do
                    let alpha, q_alpha = mons_support. (a) in
                      if d = 0 && (List.for_all (fun i -> i = 0) (Array.to_list alpha)) then begin q0 := q_alpha;() end
                      else
                        begin
                          let m = md. (i) in                            
                          let mon =  mons_add  (Array.to_list alpha) (U.alphacl_to_alphan m vars) in
                          let m = Array.of_list mon in
                            (*if List.mem mon sparse_allmons then*) Hashtbl.add diag_tbl m (q_alpha, (d, d, i, i))
                        end
                  done;
            done;
        done;
        !q0, diag_size, diag_tbl

    let get_loc_moment_variables loc_tbl = 
      let moment_variables = U.hashtbl_keys loc_tbl in
        List.map (Array.to_list) moment_variables

    let sparse_diag_matrix_tbl k q cliques n = 
      let vars = vars_of_pol q n in
      let vars = if Config.Config.loc_support_clique then find_clique_loc vars cliques else vars in
      let nvars = true_nb vars in
      let allmons = allmons (2 * k) nvars in
      let diag_sos_support : alpha array array = mk_loc_sos_support true allmons k q vars in (* true since eq *)
      let q0, loc_size, loc_tbl = loc_diag_matrix_tbl k n allmons q vars in
        q0, loc_size, loc_tbl, nvars, diag_sos_support

    (* Given alpha a ntuple, returns the list of (i, j) indexes in the moment matrix where y_alpha is*)
    let idxs_of_alpha_support_tbl (alpha : int array) tbl = 
      let idxs = Hashtbl.find_all tbl alpha in
      let n = Array.length alpha in      
        List.rev_map (idx_of_support_tbl n) idxs

    let obj_idx_p_alpha = function
      | alpha, p_alpha -> U.lexidx_of_alpha (Array.to_list alpha), p_alpha

    let sparse_obj_idx_p_alpha sparse_allmons = function
      | alpha, p_alpha -> (*debug (str_of_alpha (Array.to_list alpha));*) 1 + U.naive_lexidx_of_alpha (Array.to_list alpha) sparse_allmons, p_alpha

    let str_of_sdpa_int_array m = 
      if (List.for_all (fun i -> i = 0) (Array.to_list m)) then U.string_blanks (Array.length m + 2) else M.string_of_array_int m

    let string_of_sdpa_matrix m =
      let n = Array.length m in
      let res = ref "" in
       for i = 0 to n - 1 do
         for j = 0 to n - 1 do
           res := !res ^ "(" ^ str_of_sdpa_int_array (m. (i). (j)) ^ ")";
         done;
         res := !res ^ "\n";
       done;
       !res

    let check_sdpa_matrix size (tbl:(int list, int * int * int * int) Hashtbl.t) n = 
      let sdpa_matrix = Array.make_matrix size size (Array.make n 0) in
      let assign_matrix alpha v = 
      let i, j = idx_of_support_tbl (List.length alpha) v in
        sdpa_matrix. (i). (j) <- Array.of_list alpha;() 
      in
      let _ = Hashtbl.iter assign_matrix tbl in
        (*
      debug (string_of_sdpa_matrix sdpa_matrix);
         *)
        ()


    let cmp_matrix_lines l1 l2 = match l1, l2 with
      | (var1, _, i1, _, _), (var2, _, i2, _, _) -> if compare i1 i2 = 0 then compare var1 var2 else compare i1 i2

    let cmp_diag_lines l1 l2 = match l1, l2 with
      | (var1, _, i1, j1, _), (var2, _, i2, j2, _) when i1 = j1 && i2 = j2 -> if compare i1 i2 = 0 then compare var1 var2 else compare i1 i2
      | _ -> failwith "error in diag block for equality constraints"

    let sort_matrix_lines mat_lines = List.sort cmp_matrix_lines mat_lines
    let sort_diag_lines diag_lines = List.sort cmp_diag_lines diag_lines
    (*type loc = Fe | Gp*)
    (*let str_of_loc = function Fe -> "Fe" | Gp -> "Gp"*)
    type vertex = Gp of alpha | Fe of alpha
    let str_of_vertex = function Gp alpha -> "Gp" ^ str_of_alpha alpha | Fe alpha -> "Fe" ^ str_of_alpha alpha
                                                                                              (*
    let eq_loc n1 n2 = match n1, n2 with | Gp, Gp | Fe, Fe -> true | _ -> false
    let compare_loc n1 n2 = match n1, n2 with | Gp, Fe -> -1 | Gp, Gp | Fe, Fe -> 0 | Fe, Gp -> 1
                                                                                               *)
    let eq_vertex (v1: vertex) (v2: vertex) = match v1, v2 with 
      | Gp alpha1, Gp alpha2 | Fe alpha1, Fe alpha2 -> mons_eq alpha1 alpha2 | _ -> false
    let compare_vertex (v1: vertex) (v2: vertex) = match v1, v2 with 
      | Gp alpha1, Gp alpha2 | Fe alpha1, Fe alpha2 -> U.lexcmp alpha1 alpha2
      | Gp _, Fe _ -> -1 | _ -> 1
    let is_gp_vertex = function 
      | Gp _ -> true | Fe _ -> false
    let grep_alpha = function | Gp alpha | Fe alpha -> alpha
    module G = Graph.Persistent.Digraph.ConcreteBidirectional(struct type t = vertex let compare = compare_vertex let hash = Hashtbl.hash let equal = eq_vertex end)

    let print_vertices g : unit = G.iter_vertex (fun v -> debug (str_of_vertex v)) g; ()
    let g = ref G.empty

    let mk_support_lagrangian k n cliques q = 
      (* Need to look for a clique cl such that vars \subset cl *)
      let vars = vars_of_pol q n in
      let cl_q = if Config.Config.loc_support_clique then find_clique_loc vars cliques else vars in
      let nvars = true_nb cl_q in
      let allmons_degree = 2 * (k - k_q q) in
      let allmons = allmons allmons_degree nvars in
      let deg_max = 2 * k in
        minkovski_sum deg_max q cl_q nvars allmons 

    let mk_vertices deg k cl cliques g pol ineqs eqs n = 
      let g = ref !g in 
      let supports_eqs = List.map (mk_support_lagrangian k n cliques) (eqs) in
      let supports_ineqs = List.map (mk_support_lagrangian k n cliques) (ineqs) in
      let support_pol = mons_support_list pol n in
      let support_zero = [U.init_list n 0] in
      let supports = support_zero::support_pol::(supports_eqs @ supports_ineqs) in
      let support = mk_support_fe (union_supports supports) in
      List.iter (fun mon -> g := G.add_vertex !g (Fe mon)) support;
      let support_cl = allmons k (true_nb cl) in
        for d = 0 to k do
          let mons = support_cl. (d) in
          for i = 0 to Array.length mons - 1 do
            let mon = U.alphacl_to_alphan (mons. (i)) cl in
            let v = Gp mon in
              g := G.add_vertex !g v;
          done; 
        done;
        (*print_vertices !g;*)
        !g

    let check_for_edge g alpha1 alpha2 = 
      let beta = mons_sub (double_alpha alpha1) alpha2 in 
        G.mem_vertex !g (Gp beta)

    let check_add_edge v1 v2 g : unit = match v1, v2 with
      | (Gp alpha1), (Fe alpha2) when mons_eq (double_alpha alpha1) alpha2 -> g := G.add_edge !g v1 v2; ()
      | (Gp alpha1), (Gp alpha2) when ((not (mons_eq alpha1 alpha2)) && check_for_edge g alpha1 alpha2) -> g := G.add_edge !g v1 v2; ()
      | _ -> ()

    let mk_edges g = 
      let g = ref g in
        G.iter_vertex (fun v1 -> G.iter_vertex (fun v2 -> check_add_edge v1 v2 g) !g) !g;
        !g 

    exception No_outgoing_edges of vertex;;

    let raise_no_outgoing_edges g vertex = match vertex with 
        Gp alpha when G.out_degree g vertex = 0 -> raise (No_outgoing_edges vertex)
      | _ -> ()

    let rec elim_sos_phase2 g =     
      try G.iter_vertex (raise_no_outgoing_edges g) g; g
      with No_outgoing_edges vertex -> 
        begin
          let g = G.remove_vertex g vertex in
            elim_sos_phase2 g
        end


    let elim_sos cl cliques pol ineqs eqs n relax_order = 
      let deg_pols = List.map P.degree_pol (pol::ineqs@eqs) in
      let deg = U.max_list_int deg_pols in
      let k = int_of_float (ceil (float_of_int deg /. 2.)) in
      let k = max k relax_order in
      let g = ref G.empty in
      let g = mk_vertices deg k (*U.init_list n true*) cl cliques g pol ineqs eqs n in
      let g = mk_edges g in    
      let g = if Config.Config.reduce_sos then elim_sos_phase2 g else g in
      let allmons = G.fold_vertex (fun v acc -> if is_gp_vertex v then (grep_alpha v)::acc else acc) g [] in
      let sparse_allmons = U.lexsort allmons in
        (*
        debug "sos supports for clique";
        debug (str_of_allmons sparse_allmons);
        debug "\n";
         *)
        sparse_allmons

    let norm_box n = Uq.init_list n (Nq.zero_i, Nq.one_i)

    let ineqs_box vars box : Pq.pol list = 
      let ineqs_tuple var bound = 
        let lo, up = bound in
        let lo, up = Pq.Pc lo, Pq.Pc up in
        let x = Pq.mk_X var in
        let l = [Pq.p_sub x lo; Pq.p_sub up x] in
        let p_square_bounds = Pq.p_sub  (Pq.p_square (Pq.p_sub up lo)) (Pq.p_square (Pq.p_sub x lo)) in
        if Config.Config.bound_squares_variables then l, [p_square_bounds] else l, []
      in
      let global_lists = List.map2 ineqs_tuple vars box in
      let var_list, varsqr_list = List.split global_lists in
        List.concat var_list @ List.concat varsqr_list

    let archimedean l bound = Pq.p_sub (Pq.Pc bound)  (List.fold_left (fun y x -> Pq.p_add y (Pq.p_square x)) (Pq.Pc Nq.zero_i) l)

    let archimedean_box vars box ineqs = 
      let box_bnd = List.fold_left (fun bnd (_, up) -> Nq.add_i bnd (Nq.sqr_i up)) Nq.zero_i box in
        if Config.Config.mk_archimedean then (archimedean (List.map Pq.mk_X vars) box_bnd)::ineqs else ineqs 

    let relax_eqs ineqs eqs = 
      let tol = Nq.num_of_float Config.Config.eq_tol in
(*      let relax eq = [P.p_sub eq (P.Pc tol); eq] in*)
      let relax eq = [Pq.p_opp eq; eq] in        
        if Nq.eq_i tol Nq.zero_i then ineqs @ (List.concat (List.map relax eqs)), [] else ineqs, eqs

    let scale_pop pol ineqs vars box eqs = 
      let scale_bool = Config.Config.scale_pol in
      let fixed = [] in
      let n = List.length vars in
      let tbl_scaling_list = List.combine vars box in
      let tbl_scaling = Hashtbl.create n in
      Uq.add_list_table tbl_scaling tbl_scaling_list;
         let pol, obj_norm =  if scale_bool then Pq.scale_pol tbl_scaling fixed pol false else pol, Nq.one_i in
      let ineqs_magns, eqs_magns = List.map (fun p -> Pq.scale_pol tbl_scaling fixed p false) ineqs, List.map (fun p -> Pq.scale_pol tbl_scaling fixed p false) eqs in
      let ineqs_scale, eqs = List.map fst ineqs_magns, List.map fst eqs_magns in
      let magns_ineqs, magns_eqs = List.map snd ineqs_magns, List.map snd eqs_magns in
(*
      let ineqs, eqs = if scale_bool then List.map (fun i -> fst (P.scale_pol tbl_scaling fixed  i))  ineqs,  List.map (fun e -> fst (P.scale_pol tbl_scaling fixed e)) eqs else ineqs, eqs in*)
      let box = if scale_bool then (norm_box n) else box in
      let ineqs_box = ineqs_box vars box in
      let ineqs_box = archimedean_box vars box ineqs_box in
      let pol0 = Pq.eval_p (fun _ -> Nq.zero_i) pol in       
        debug "Objective polynomial: "; 
        debug (Pq.string_of_pol (Pq.p_sub pol (Pq.Pc pol0)));
        debug "pol0 after scaling";
        debug (Nq.string_of_i pol0);
        debug "scaling factor:";
        debug (Nq.string_of_i obj_norm);

      let ineqs, eqs = relax_eqs ineqs eqs in
        debug "Polynomial inequality constraints:";
        List.iter(fun pol -> debug (Pq.string_of_pol pol)) ineqs;
        debug "Polynomial box constraints:";
        List.iter(fun pol -> debug (Pq.string_of_pol pol)) ineqs_box;
        obj_norm, pol0, Pq.p_sub pol (Pq.Pc pol0), ineqs_scale, ineqs_box, eqs, magns_ineqs, magns_eqs, box

    let descale_bounds bound = 
      let a, b = fst bound, snd bound in
      let a2 = Nq.minus_i (Nq.div_i a (Nq.sub_i b a)) in
      let b2 =  Nq.div_i (Nq.sub_i Nq.one_i a) (Nq.sub_i b a) in
        a2, b2

    let rescale_optimum opt box = 
      let scale_bool = Config.Config.scale_pol in
      let opt_rescaled = List.map2 (fun o (a, b) -> Nq.add_i (Nq.mult_i o (Nq.sub_i b a)) a) opt box in
       if scale_bool then opt_rescaled else opt

    let rescale_L1 pol vars box pol0 obj_norm = 
      let scale_bool = Config.Config.scale_pol in
      let fixed = [] in
      let n = List.length vars in
      let descale_box = List.map descale_bounds box in
      let tbl_scaling_list = List.combine vars descale_box in
      let tbl_scaling = Hashtbl.create n in
        Uq.add_list_table tbl_scaling tbl_scaling_list;
        let pol, pol_norm =  if scale_bool then Pq.scale_pol tbl_scaling fixed pol true else pol, Nq.one_i in
        let pol = Pq.p_mulC pol pol_norm in
        Pq.p_mulC (Pq.p_addC pol pol0) obj_norm 

    let mk_cliques_real2float n_exact n =   
      let mat = Array.make_matrix (n - n_exact) n false in
        for i = 0 to (n - n_exact - 1) do
          for j = 0 to (n_exact - 1) do
            mat. (i). (j) <- true;
          done;
           mat. (i). (i + n_exact) <- true;
        done;
      Array.to_list ((Array.map Array.to_list) mat)

   let relax_sdp_lasserre pol ineqs n relax_order = 
      let deg_pols = List.map (fun q -> int_of_float (ceil ((float_of_int (P.degree_pol q)) /. 2.))) (pol::ineqs) in
      let k = U.max_list_int deg_pols in
      let k = max k relax_order in
      let mons_support = mons_support pol n in
      let moment_matrix_size = U.binomial (n + k) n in
      let allmons = allmons k n in
      let m = U.binomial (n + 2 * k) n - 1 in
      let nBlOCK = 1 + List.length ineqs in
      let bLOCKsTRUCT = Array.make nBlOCK 0 in
        bLOCKsTRUCT. (0) <- moment_matrix_size;
      let c = Array.make m N.zero_i in
      let obj_idx = Array.map (fun ms -> obj_idx_p_alpha ms) mons_support in
      let card_obj = Array.length obj_idx in
      (* Fill the elements of the objective function c with the p_alpha *)
        for i = 0 to card_obj - 1 do
          let idx, p_alpha = obj_idx. (i) in
            debug (Printf.sprintf "%i %s"  idx (N.string_of_i p_alpha));
            c. (idx - 1) <- p_alpha;
            ()
        done;
        (* Fill the k-truncated Lasserre moment matrix *)
        let tbl = moment_matrix_tbl k m allmons (U.init_list n true) in
          check_sdpa_matrix moment_matrix_size tbl n;
          (*let sparse_allmons : int list list = U.lexsort (U.hashtbl_keys tbl)
           * in*)
        let first_sdpa_line = 0, 1, 1, 1, N.minus_i N.one_i in
        let moment_sdpa_lines = Hashtbl.fold (fun alpha v acc -> (sdpa_line_of_alpha alpha v 
        ) :: acc) tbl [first_sdpa_line] in
        (* Fill the k-truncated Lasserre localizing matrix *)
        let loc_sdpa_lines q idx_q = 
          let idx_q = 1 + idx_q in
          let q0, loc_size, loc_tbl = localizing_matrix_tbl k n allmons q (U.init_list n true) in
          let loc_first_sdpa_line = 0, 1 + idx_q, 1, 1, N.minus_i q0 in
            bLOCKsTRUCT. (idx_q) <- loc_size;
            Hashtbl.fold (fun mon (q_alpha, coord) acc -> (loc_sdpa_line_of_alpha mon q_alpha coord idx_q) :: acc) loc_tbl [loc_first_sdpa_line]
        in
        let loc_sdpa_lines = List.concat (List.map2 loc_sdpa_lines ineqs (U.int_to_list (List.length ineqs))) in
          m, nBlOCK, bLOCKsTRUCT, c, Sdpa.Sparse ([Array.of_list (moment_sdpa_lines @ loc_sdpa_lines)]) 
                                      

    let relax_sdp_kojima pol ineqs eqs n is_L1 relax_order = 

      let deg_pols = List.map (fun q -> int_of_float (ceil ((float_of_int (P.degree_pol q)) /. 2.))) (pol::(ineqs @ eqs)) in
      let k = U.max_list_int deg_pols in        
      let k = max k relax_order in
        (*
      let cliques = [[true; false; false; true; false; false]; [true; true; true; false; false; true]; [false; true; true; false; true; true]] in
         *)
        (*
      let cliques = [[true; false; false; true; false; false; false; false]; [true; true; true; false; false; true; false; false]; [true; true; false; false; true; true; true; true]] in
         *)
        (*
      let cliques = if Config.Config.use_cliques then [[true; false; false; true; false; false]; [true; true; true; false; true; false]; [true; false; true; false; true; true]] else [U.init_list n true] in
         *)        
      let default_cliques = [U.init_list n true] in
      let cliques = 
        if Array.length Sys.argv > 3 && Sys.argv. (2) = "fp" then 
          let n_exact = int_of_string (Sys.argv. (3)) in
            if n_exact >= n then default_cliques else mk_cliques_real2float n_exact n
        else if Config.Config.use_cliques && n = 6 then 
          Array.to_list ((Array.map Array.to_list) (Mq.matrix_id false true n)) 
        else default_cliques
      in         
        (*
      let cliques = if Config.Config.use_cliques then [[true; false; true; false; false; true; true; false]; [false; true; false; true; true; false; false; true]] else [U.init_list n true] in
         *)
      (*let _ =  elim_sos pol ineqs eqs n in 
      let allmons = allmons k n in
      let card_support = U.binomial (n + k) n in*)
      let sparse_sos_supports = List.map (fun cl -> elim_sos cl cliques pol ineqs eqs n relax_order) cliques in (* SOS research space: monomials generating the sos moment variables *)

      let card_supports = List.map List.length sparse_sos_supports in (* nb of monomials considered in SOS supports for each clique cl *)
      let sparse_sos_supports : (alpha array array) list = List.map (fun supp -> sparse_allmons_sort_degree supp n n 0 k) sparse_sos_supports in
      let cliques_sos_supports = List.combine cliques sparse_sos_supports in
      let cl_idxs_cards_sos = List.combine (U.int_to_list (List.length cliques)) card_supports in
        (*
        debug (str_of_allmons (pick_in_list sparse_allmons [1;4;7;10;19;23;26;35;51;56;59;68;84;109]));
         *)
        (* Two additional diagonal blocks if searching for L1 underestimator *)
      let nBlOCK_eqs, nBlOCK_L1 =  (if List.length eqs = 0 then 0 else 1), if is_L1 then 1 else 0 in

      let nBlOCK_POP = List.length cliques + List.length ineqs + nBlOCK_eqs in
      let nBlOCK = nBlOCK_POP + nBlOCK_L1 in

      let bLOCKsTRUCT = Array.make nBlOCK 0 in
      let block_monomials = Array.make (List.length cliques + List.length ineqs) [||] in
      let block_monomials_eqs = Array.make (List.length eqs + nBlOCK_L1) [||] in
      (* Fill the k-truncated block moment matrix *)
      let mk_sparse_moment_tables cl cl_idx sparse_sos_support card_support = 
        let sparse_moment_size, sparse_moment_tbl = sparse_moment_matrix_tbl k cl sparse_sos_support card_support in
          block_monomials. (cl_idx) <- sparse_sos_support;
          bLOCKsTRUCT. (cl_idx) <- sparse_moment_size;
          sparse_moment_tbl
      in      
      let sparse_moment_tables = List.map2 (fun (cl, supp) (cl_idx, card) -> mk_sparse_moment_tables cl cl_idx supp card) cliques_sos_supports cl_idxs_cards_sos in 
      let sparse_allmons_unsorted = List.concat (List.map U.hashtbl_keys sparse_moment_tables) in
      let sparse_allmons_mom_matrix : int list list = U.lexsort sparse_allmons_unsorted in (* set of moment variables in the moment matrix *)

      (* Need to get all the moment variables before generating the sdpa_lines *)
      let sparse_moment_sdpa_lines sparse_allmons cl_idx = 
        let tbl, cl = List.nth sparse_moment_tables cl_idx, List.nth cliques cl_idx in
        let sparse_first_sdpa_line = (if is_L1 then 1 else 0), 1 + cl_idx, 1, 1, if is_L1 then N.one_i else N.minus_i N.one_i in
          Hashtbl.fold (fun alpha v acc -> (sparse_sdpa_line_of_alpha alpha v cl sparse_allmons cl_idx ) :: acc) tbl [sparse_first_sdpa_line] 
      in 
        (* Prepare the k-truncated Lasserre localizing matrix for ineqs *)
        let mk_loc_tbl q idx_q = 
          let idx_q = (List.length cliques) + idx_q in
          let q0, loc_size, loc_tbl, nvars, loc_sos_support = sparse_loc_matrix_tbl k q cliques n in
          let loc_first_sdpa_line = (if is_L1 then 1 else 0), 1 + idx_q, 1, 1, if is_L1 then q0 else N.minus_i q0 in
            bLOCKsTRUCT. (idx_q) <- loc_size;
            block_monomials. (idx_q) <- loc_sos_support;
            loc_tbl, (nvars, loc_first_sdpa_line)
        in
        let loc_sdpa_lines idx_q loc_tbl nvars fst_line sparse_allmons = 
          let idx_q = (List.length cliques) + idx_q in
          Hashtbl.fold (fun mon (q_alpha, coord) acc -> (sparse_loc_sdpa_line_of_alpha mon q_alpha coord nvars sparse_allmons idx_q) :: acc) loc_tbl [fst_line] 
        in
        let triple_list = List.map2 mk_loc_tbl ineqs (U.int_to_list (List.length ineqs)) in
        let loc_tbls, _ = List.split triple_list in

        (* Prepare the k-truncated Lasserre diagonal block matrix for eqs *)
        let mk_diag_tbl q idx_q =
         (* 
          let idx_q = (List.length cliques) + (List.length ineqs) + idx_q in
          *)
          let q0, diag_size, diag_tbl, nvars, diag_sos_support = sparse_diag_matrix_tbl k q cliques n in
            debug (string_of_int diag_size);
          let size_fst_block = bLOCKsTRUCT. (nBlOCK_POP - 1) in
          let diag_first_sdpa_line = (if is_L1 then 1 else 0), nBlOCK_POP, 1 + size_fst_block, 1 + size_fst_block, if is_L1 then q0 else N.minus_i q0 in
          let size_snd_block = size_fst_block + diag_size in
          let diag_second_sdpa_line = (if is_L1 then 1 else 0), nBlOCK_POP, 1 + size_snd_block, 1 + size_snd_block, if is_L1 then N.minus_i q0 else q0 in
            bLOCKsTRUCT. (nBlOCK_POP - 1) <- size_snd_block + diag_size;
            block_monomials_eqs. (idx_q) <- diag_sos_support;
            diag_tbl, (nvars, size_fst_block, diag_first_sdpa_line, size_snd_block, diag_second_sdpa_line)
        in
        let diag_sdpa_lines diag_tbl nvars size_fst_block fst_line size_snd_block snd_line sparse_allmons =           
          let first_ineq_lines = Hashtbl.fold (fun mon (q_alpha, coord) acc -> (sparse_diag_sdpa_line_of_alpha mon q_alpha coord nvars sparse_allmons size_fst_block nBlOCK_POP) :: acc) diag_tbl [fst_line] in
          let second_ineq_lines = Hashtbl.fold (fun mon (q_alpha, coord) acc -> (sparse_diag_sdpa_line_of_alpha mon (N.minus_i q_alpha) coord nvars sparse_allmons size_snd_block nBlOCK_POP) :: acc) diag_tbl (snd_line :: first_ineq_lines) in
            second_ineq_lines
        in
        let cmplex_list = List.map2 mk_diag_tbl eqs (U.int_to_list (List.length eqs)) in
        let diag_tbls, _ = List.split cmplex_list in

          (* Generates the full set of moment variables *)
        let sparse_allmons_loc, sparse_allmons_diag = List.concat (List.map get_loc_moment_variables loc_tbls), List.concat (List.map get_loc_moment_variables diag_tbls) in
        let allmons_pol_support = mons_support_list pol n in 
        let sparse_allmons : alpha list = U.lexsort (sparse_allmons_mom_matrix @ sparse_allmons_loc @ sparse_allmons_diag @ allmons_pol_support) in
        let sparse_allmons = if is_L1 then (mon_zero n)::sparse_allmons else sparse_allmons in

        (* Fill the elements of the objective function c with the p_alpha *)
        let mons_support = mons_support pol n in         
        let m = List.length sparse_allmons in
        let c = Array.make m N.zero_i in
          (*
        debug "printing all monomials";
        debug (str_of_allmons sparse_allmons);
           *)
        let sparse_obj_idx = Array.map (fun ms -> sparse_obj_idx_p_alpha sparse_allmons ms) mons_support in
        debug "\n";

        let card_obj = Array.length sparse_obj_idx in
          debug "support and coeffs of objective function:";
          for i = 0 to card_obj - 1 do
            let idx, p_alpha = sparse_obj_idx. (i) in
              debug (Printf.sprintf "%i %s"  idx (N.string_of_i p_alpha));
              c. (idx - 1) <- p_alpha;
              ()
          done;

          (* Fill the sdpa_lines *)
          let sparse_moment_sdpa_lines = List.concat (List.map (sparse_moment_sdpa_lines sparse_allmons) (U.int_to_list (List.length cliques))) in

          let sparse_moment_sdpa_lines = sort_matrix_lines sparse_moment_sdpa_lines in

          let loc_sdpa_lines =  List.concat (List.map2 (fun idx_q (loc_tbl, (nvars, fst_line)) -> sort_matrix_lines (loc_sdpa_lines idx_q loc_tbl nvars fst_line sparse_allmons)) (U.int_to_list (List.length ineqs)) triple_list) in

          let diag_sdpa_lines = List.concat (List.map (fun (diag_tbl, (nvars, size_fst_block, fst_line, size_snd_block, snd_line)) -> diag_sdpa_lines diag_tbl nvars size_fst_block fst_line size_snd_block snd_line sparse_allmons) cmplex_list) in
          let diag_sdpa_lines = sort_diag_lines diag_sdpa_lines in
            (* in case of equality constraints: needs a "-" for the block-diag loc matrix *)
            if (not (List.length eqs = 0)) then bLOCKsTRUCT. (nBlOCK_POP - 1) <- - bLOCKsTRUCT. (nBlOCK_POP - 1);
            if is_L1 then bLOCKsTRUCT. (nBlOCK - 1) <- - bLOCKsTRUCT. (nBlOCK - 1);

            let array_L1, sparse_allmons_L1 = if is_L1 then sparse_L1_sdpa_lines sparse_allmons n Config.Config.vars_L1 Config.Config.degree_L1 nBlOCK bLOCKsTRUCT else [||], [||] in

            let nblocks_eqs = Array.length block_monomials_eqs in
              if is_L1 then block_monomials_eqs. (nblocks_eqs - 1) <- sparse_allmons_L1;
              print_block_monomials block_monomials;
              print_block_monomials block_monomials_eqs;

            let mat =  Array.append (Array.of_list (sparse_moment_sdpa_lines @ loc_sdpa_lines @ diag_sdpa_lines)) array_L1 in
            m, nBlOCK, bLOCKsTRUCT, c, Sdpa.Sparse [mat], block_monomials, block_monomials_eqs 


 (*
    let fold_left_psatz f acc m = 
     if Mq.size m = 0 then acc else
       begin
         let res = ref acc in
         for i = 0 to Mq.size m - 2 do
           res := !res ^ (f m. (i)) ^ " + (";
         done;
         !res ^ f (m. (Mq.size m - 1)) ^ Uq.concat_string (Uq.init_list (Mq.size m - 1 ) ")")
       end
 *)
(*               
    let str_of_coq_ineq_pos ineqs eqs = 
      let s = ref "Definition ineq_pos (n:positive) : PolC := match n with\n| 1%%positive => P1\n" in

        for i = 0 to Array.length ineqs - 1 do
          let ineq = ineqs. (i) in
          s := !s ^ (Printf.sprintf "| %i%%positive => %s\n" (i + 1) (string_of_pol_ast ineq) );
        done; 
        !s ^ "| _ => P1\n end.\n"                                                
 *)
    let string_of_vars vars = 
      let vars_to_strings = List.map (fun v -> P.string_of_pol (P.mk_X v)) vars in
        U.concat_string_with_string vars_to_strings " "


    let mk_block_eigs_eqs eigs_eqs block_monomials_eqs magns_ineqs magns_eqs =
     (* 
      let ndiag_blocks = Array.length eigs_eqs in
      (* nblocks = if no equalities then ndiag_blocks else neqs + ndiag_blocks - 1 *)
      *)
      let eigs = Array.concat (Array.to_list eigs_eqs) in
      let nblocks = Array.length block_monomials_eqs in
      let block_eigs_eqs = Array.make nblocks [||] in
      let idx = ref 0 in
        for eq_idx = 0 to nblocks - 1 do 
          let mons = block_monomials_eqs. (eq_idx) in            
          let mons_size = Array.fold_left (fun a b -> a + Array.length b) 0 mons in
          block_eigs_eqs. (eq_idx) <- Array.make mons_size N.zero_i;
            for i = 0 to mons_size - 1 do
              let coeff = N.sub_i eigs. (!idx)  eigs. (!idx + mons_size) in
                block_eigs_eqs. (eq_idx). (i) <- coeff;
                incr idx;
            done;
            idx := !idx + mons_size;
        done;
        block_eigs_eqs

  
    let replace_xi_by_yi s = Str.global_replace (Str.regexp ("x\\([0-9]+\\)")) "y\\1" s


(* obj_min_norm: output FP of SDPA
 * obj_min_norm_rat: obj_min_norm + eps (remainder bound)
 * obj_min_rat: pol0 + obj_min_norm_rat
 * obj_min_float: brutal FP conversion of obj_min_norm_rat
 * 
 * TODO POP : multiply obj_min_rat by obj_magnitude and adapt mk_coq_cert
 * *)
    let ntopos = Numbers.T.Translation.positive_n

    let solve_pop n obj ineqs eqs box is_L1 relax_order is_top_level_bound =
      let prefix_name = Config.Config.ineq_name in
      let vars =  List.map (fun n -> ntopos (succ n)) (U.int_to_list n) in

      (*let pol_to_float = Convert.pol_to_float in*)


        (*
      let float_to_zarith_box = Convert.float_to_zarith_box in
         *)
        (*
      let bounds_for_check = box in
         *)
(*        
      let objf = pol_to_float obj in
      let ineqs = List.map pol_to_float ineqs in
      let eqs = List.map pol_to_float eqs in 
      let box = box_to_float box in
 *)
      let obj_magnitude, pol0, pol, ineqs_scale, ineqs_box, eqs, magns_ineqs, magns_eqs, box = scale_pop obj ineqs vars box eqs in

(*      let pol_to_float = Convert.pol_num_to_float (fun i -> N.num_of_string (Nq.string_float i 20)) in *)
      let module Floatrat = Floatrat.Make (N)(I)(P)(Nq)(Iq)(Pq) in 
      let pol_to_float = Floatrat.pol_to_float in 

          let m, nBlOCK, bLOCKsTRUCT, c, mat_list, block_monomials, block_monomials_eqs = relax_sdp_kojima (pol_to_float pol) (List.map  pol_to_float (ineqs_box @ ineqs_scale)) (List.map pol_to_float eqs) n is_L1 relax_order in
      let obj_min_norm, opt, _, block_eigs, eigs_eqs = Sdpa.solve_sdp m nBlOCK bLOCKsTRUCT c mat_list prefix_name in

      let block_eigs_eqs = mk_block_eigs_eqs eigs_eqs block_monomials_eqs magns_ineqs magns_eqs in
      let module Coq_interface = Coq_interface.Make (N)(U)(M)(I)(P)(Nq)(Uq)(Mq)(Iq)(Pq) in
        (* IMPORTANT: ineqs is the list of inequalities with scaled vars but no magnitude scaling *)
      let ti = Unix.gettimeofday () in 
      let ineqs, obj_scaled, underestimator_L1, obj_min_rat, c = Coq_interface.mk_coq_cert pol ineqs_scale (ineqs_box: Pq.pol list) (eqs : Pq.pol list) magns_ineqs magns_eqs block_eigs block_monomials block_eigs_eqs block_monomials_eqs obj_min_norm pol0 bLOCKsTRUCT is_L1 prefix_name in
      let tf = Unix.gettimeofday () in
        debug_time (Printf.sprintf "Informal checking time: %f secs" (tf -. ti));

        (*TODO bug rel0 is not zero *)
      let rel0 = N.zero_i in
      if is_L1 then begin
        let rescale_L1 = rescale_L1 underestimator_L1 vars box pol0 obj_magnitude in 
          Uq.debug "L1 underestimator after rescaling:"; Uq.debug (Pq.string_of_pol rescale_L1);
          N.zero_i, N.zero_i, opt, opt, rel0, rescale_L1, obj_min_rat, c
      end
      else begin                
        let obj_magnitude_float = Floatrat.num_of_numq obj_magnitude in
        let obj_min_float = Floatrat.num_of_numq obj_min_rat in
          (*
        let obj_add_pol0 = Pq.PEadd (obj_scaled, (Pq.PEc pol0)) in
        let obj_coq = Pq.psubC obj obj_min_rat in          
        debug (Printf.sprintf "Definition objq := %s." (Coq_interface.string_of_pexpr obj_add_pol0));
        debug (Printf.sprintf "Definition objp := %s." (replace_xi_by_yi (Coq_interface.string_of_pexpr (Pq.denorm obj_coq))));
           *)
        debug (Printf.sprintf "Bound used for verification: %s\nApproximate bound value: %s"  (Nq.string_of_i_coq (Nq.mult_i obj_min_rat obj_magnitude)) (N.string_of_i_coq (N.mult_i obj_min_float obj_magnitude_float)));      

         let module Fu = Fw_utils.Make (Nq)(Uq)(Iq)(Pq) in
         let module Coq_fsa = Coq_fsa.Make (Nq)(Uq)(Mq)(Iq)(Pq)(Fu) in           
           if is_top_level_bound (* && Nq.ge_i obj_min_rat Nq.zero_i *) && Config.Config.check_certif_coq_pop then Coq_fsa.check_pop vars box (Array.of_list ineqs) (Pq.paddC pol pol0) obj_min_rat c;            
           obj_min_float, obj_min_float, U.sub_list opt 0 (n - 1), U.sub_list opt 0 (n - 1), rel0, Pq.Pc Nq.zero_i, Nq.mult_i obj_magnitude obj_min_rat, c
      end 

    let test_mon_support () = 
      let module Sos_benchs =  Sos_benchs.Make (Nq)(Uq)(Mq)(Iq)(Pq) in
      let n, pol, ineqs, eqs, box = (*hard_3318_pop*) (*half_disk_debug*) Sos_benchs.(*partial_delta_pop*)rat_3318_pop(*rat_sqrt_test*)  (*delta_pop_L1_deg2_k3*) (*rat_lasserre*) (*sofa*) () in
      let _ = solve_pop n (pol) ineqs eqs box Config.Config.is_L1 Config.Config.relax_order true in ()
end
