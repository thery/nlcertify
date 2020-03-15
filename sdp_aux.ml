module type T = 
sig
  type num_i
  type sdpa_matrix_list = Dense of num_i array array list | Sparse of (int * int * int * int * num_i) array list
  val gen_output_s : string -> string
  val write_sdpa_pb : num_i array -> sdpa_matrix_list -> out_channel -> unit
  val write_sdpa_sparse : int -> int -> int array -> num_i array -> sdpa_matrix_list -> out_channel -> unit
  val parse_sdpa_output : string -> num_i * string * string * string
  val sparse_input_robust_sdp_1998 : num_i -> num_i array array -> int * int * int array * num_i array *
sdpa_matrix_list
  val sparse_input_robust_sdp_2008 : num_i array array -> num_i array array -> int * int * int array * num_i array * sdpa_matrix_list
  val solve_sdp : int -> int -> int array -> num_i array -> sdpa_matrix_list -> string -> num_i * num_i list * string * (num_i array * num_i array array) array * num_i array array
  val lambda_min : num_i array -> num_i array array list -> num_i
  val lambda_min_robust : num_i array array -> num_i array array -> num_i
end

module Make (N: Numeric.T) (U: Tutils.T with type t = N.t) (M: Mesh_interval.T with type num_i = N.t) = struct   

  type num_i = N.t
  let gen_output_s input_s =  (String.sub input_s 0 (String.length input_s - 4)) ^ ".out"
  let verb = Config.Config.sdp_verb 
  let debug s = if verb then U.debug s else ()

  type sdpa_matrix_list = Dense of num_i array array list | Sparse of (int * int * int * int * num_i) array list
  let matrix_is_dense = function Dense _ -> true | Sparse _ -> false
  let matrix_is_sparse = function Dense _ -> false | Sparse _ -> true  
  let extract_dense = function
    | Dense m -> m
    | Sparse _ -> failwith "sdpa dense matrix required"
  let extract_sparse = function
    | Sparse m -> m
    | Dense _ -> failwith "sdpa sparse matrix required"

  let write_sdpa_pb c mat_list input_file = 
    let mat_list = extract_dense mat_list in
    let m = Array.length c in
    let nBlOCK = 1 in
    let f0, f =  
      match mat_list with
        | hd::tl -> hd, tl
        | [] -> failwith "empty mat_list"
    in
    let bLOCKsTRUCT = Array.length f0 in
    let info = Printf.sprintf "%i\n%i\n%i\n" m nBlOCK bLOCKsTRUCT in
    let mat_string = (M.string_of_array c) ^ "\n" ^ (M.string_of_matrix f0) ^ "\n" ^ (U.concat_string_with_string (List.map M.string_of_matrix f) "\n") in
      Printf.fprintf input_file "%s\n" (info ^ mat_string);
      ()

  let write_sdpa_sparse m nBlOCK bLOCKsTRUCT c mat_list input_file = 
    let mat_list = extract_sparse mat_list in
    let info = Printf.sprintf "%i\n%i\n%s\n" m nBlOCK (M.string_of_array_f bLOCKsTRUCT (fun i -> string_of_int i ^ " ")) in
    let obj = M.string_of_array_f c (fun i -> N.string_of_i i ^ " ") in
    let mat_array = Array.of_list mat_list in
      (*
    let mat_string = M.string_of_array_f mat_array (fun a -> M.string_of_sdpa_array a ^ "\n") in
       *)
      let first_s = Printf.sprintf "%s%s\n" info obj in
        Printf.fprintf input_file "%s" first_s;
        let n_arrays = Array.length mat_array in
        for mat_idx = 0 to n_arrays - 1 do
          let mat = mat_array. (mat_idx) in
          let n = Array.length mat in
            for line = 0 to n - 1 do
              Printf.fprintf input_file "%s" (M.string_of_sdpa_line mat. (line));
            done;
        done;
        ()

  let list_of_line l = List.map N.of_string (Str.split (Str.regexp  "[ {},\n]+" ) l) 
  let array_of_line l = Array.of_list (list_of_line l)

        
  let custom_float_of_string = fun _ -> 10000.
  let custom_num_of_float = fun _ -> N.num_of_float 10000.
         
  let extract_sos_matrices yMat : float array array list = 
    let split = Str.split in
      (*
    let lvl2 = Str.regexp (if Config.Config.relax_order = 1 then "},\n" else "},\n") in
       *)
     (* 
    let lvl1, lvl2, lvl3 = Str.regexp "}[ \t]*}\n{[ \t]*{", Str.regexp "},?\n", Str.regexp "[ {},\n\t]+" in
      *)
    let lvl1, lvl2, lvl3 = Str.regexp "}\n", Str.regexp "},\n", Str.regexp "[ {},\n\t]+" in
    let matrices_list = split lvl1 yMat in
    let num_mat_of_string mat = 
      let lines_array = Array.of_list (split lvl2 mat) in
        Array.map (fun line -> Array.of_list (List.map float_of_string (split lvl3 line) )) lines_array
    in
    let l = List.map num_mat_of_string matrices_list in
      List.filter (fun mat -> not (M.size mat = 0)) l

  let eigs_of_yMat mat : num_i array * num_i array array = 
   (* 
    U.debug ("pr:" ^( M.string_of_matrix_f mat (fun i -> string_of_float i ^ " ")));
    *)
        let mat = Lacaml.D.Mat.of_array mat in
        let eigenvalues = Lacaml.D.Vec.to_array (Lacaml.D.syev ~vectors:true mat) in
        let eigenvectors = Lacaml.D.Mat.to_array (Lacaml.D.Mat.transpose mat) in
        let eigenvalues = Array.map N.num_of_float eigenvalues in
        let eigenvalues = Array.map (fun ev -> if N.ge_i (N.num_of_float Config.Config.eig_tol) ev then N.zero_i else ev)  eigenvalues in
          eigenvalues, Array.map (fun a -> Array.map N.num_of_float a) eigenvectors

  let eigs_of_diagMat mat = Array.map N.num_of_float (Array.concat (Array.to_list mat))


  let find_sdpa_xvecxymat filename =
    let fd = 
      try Pervasives.open_in filename
      with Sys_error _ ->
        failwith("strings_of_file: can't open " ^ filename) in
    let rec suck_lines is_foundxvec is_foundx is_foundy accxvec accx accy =
      try 
        begin
        let l = Pervasives.input_line fd ^ "\n" in
          if is_foundy then 
            begin
              try
                let _ = Str.search_forward (Str.regexp "main loop time") l 0 in
                  accxvec, accx, accy
              with Not_found -> suck_lines true true true accxvec accx (l::accy) 
            end
          else if is_foundx then
            begin
              try
                let _ = Str.search_forward (Str.regexp "yMat") l 0 in
                  suck_lines true true true accxvec accx []
              with Not_found -> suck_lines true true false accxvec (l::accx) accy
            end
          else if is_foundxvec then 
            begin
              try 
                let _ = Str.search_forward (Str.regexp "xMat =") l 0 in
                  suck_lines true true false accxvec [] []
              with Not_found -> suck_lines true false false (l::accxvec) [] []
            end
          else 
            begin
              try 
                let _ = Str.search_forward (Str.regexp "xVec =") l 0 in
                  suck_lines true false false [] [] []
              with Not_found -> suck_lines false false false [] [] [] 
            end

        end
      with End_of_file -> failwith ("No pattern found in: " ^ filename) in
    let data = suck_lines false false false [] [] [] in
      (Pervasives.close_in fd; data)


  let parse_sdpa_output output_file =
    let time_regexp = Str.regexp "ALL TIME = \\([0-9\\.]+\\)" in
    let sdp_status =  Str.regexp ("phase\\.value [ ]+= \\([a-zA-Z]+\\)") in
    let status = 
      try U.find_in_file output_file sdp_status
      with Not_found -> failwith "No SDP status in SDPA result file"
    in
    let _ = if List.mem status [(*"pFEAS"; "dFEAS"; "dUBND"*)] then (debug status; failwith "I won't try to certify this" ) in
    let scientific_notation =  "[-+][0-9\\.]+e[-+][0-9][0-9]" in
    let obj_value_regexp = Str.regexp ("objValDual[ \t]*=[ \t]*\\(" ^ scientific_notation ^ "\\)") in
    let obj_dual = 
      try
        let s1 = U.find_in_file output_file obj_value_regexp in
        let objval_dual = N.of_string s1 in
        let s = U.find_in_file output_file time_regexp in
          debug (" SOS numerical computation in " ^ s ^ " secs with status " ^ status);
          objval_dual
      with Not_found -> failwith "No objective dual value in SDPA result file" 
    in
    let xVec, xMat, yMat = find_sdpa_xvecxymat output_file in
      (*
    let xMat, yMat = List.tl xMat,  List.tl yMat in
       
    let xMat, yMat = List.tl (List.rev xMat), List.tl (List.rev yMat) in
       *)
    let xVec, xMat, yMat =  List.fold_left (^) "" (List.rev xVec), List.fold_left (^) "" (List.rev xMat), List.fold_left (^) "" (List.rev yMat) in
      obj_dual, xVec, xMat, yMat



  let sparse_input_robust_sdp_1998 rho hx0 = 
    let n = Array.length hx0 in
    let big_n = U.sum_n n in
    let nBlOCK = big_n + 1 in
    let m = 2 * big_n * big_n + 1 in
    let upper_tbl = M.upper_mat_idx n in
    let e = 0, 0, 0, 0, N.zero_i in
    let bLOCKsTRUCT = Array.make nBlOCK (2 * n) in
      bLOCKsTRUCT. (big_n) <- n;
      let c = Array.make m N.zero_i in
        c. (m - 1) <- N.minus_i N.one_i;
        let fs = Array.make (2 * big_n * big_n) e in
        let fq = Array.make (2 * big_n * big_n) e in
        let ft = Array.make n e in
        let f0 = Array.make (3 * big_n) e in
          for t = 0 to (n - 1) do
            ft. (t) <- m, nBlOCK, t + 1, t + 1, N.minus_i N.two_i;
          done;
          for k = 0 to (big_n -1) do
            let _ = 
              match M.rho_i k upper_tbl rho with
                | M.Rhoi (r, k') -> 
                    begin
                      f0. (2 * k) <- 0, k + 1, k' + n, k', r; 
                      f0. (2 * k + 1) <- 0, k + 1, k', k' + n, r;
                    end
                | M.Rhoij (r, k', k'') -> 
                    begin
                      f0. (2 * k) <- 0, k + 1, k' + n, k'', r; 
                      f0. (2 * k + 1) <- 0, k + 1, k', k'' + n, r;
                    end
            in
            let row, col = upper_tbl. (k) in
              f0. (k + 2 * big_n) <- 0, nBlOCK, row + 1, col + 1, N.minus_i (N.mult_i N.two_i (hx0. (row). (col)));
              for i = 0 to (big_n -1) do
                let fidx = k * big_n + i in
                let idx = 2 * fidx in
                let qidx = fidx + big_n * big_n in
                let _ = 
                  match M.ei i upper_tbl with 
                    | M.Ei (k') -> 
                        begin
                          fs. (idx) <- fidx + 1, k + 1, k', k', N.one_i;
                          fs. (idx + 1) <- fidx + 1, nBlOCK, k', k', N.minus_i N.one_i;
                          fq. (idx) <- qidx + 1, k + 1, k' + n, k' + n, N.one_i;
                          fq. (idx + 1) <- qidx + 1, nBlOCK, k', k', N.minus_i N.one_i;
                        end
                    | M.Eij (k', k'') -> 
                        begin
                          fs. (idx) <- fidx + 1, k + 1, k', k'', N.two_i;
                          fs. (idx + 1) <- fidx + 1, nBlOCK, k', k'', N.minus_i N.two_i;
                          fq. (idx) <- qidx + 1, k + 1, k' + n, k'' + n, N.two_i;
                          fq. (idx + 1) <- qidx + 1, nBlOCK, k', k'', N.minus_i N.two_i;
                        end
                in
                  ()
              done;
          done;
          m, nBlOCK, bLOCKsTRUCT, c, Sparse ([f0; fs; fq; ft])

  let sparse_input_robust_sdp_2008 b0 hx0 = 
    let n = Array.length hx0 in
    let nBlOCK = U.pow_2_n (n - 1) in
    let big_n = U.sum_n n in
    let e = 0, 0, 0, 0, N.zero_i in
    let bLOCKsTRUCT = Array.make nBlOCK n in
    let c = Array.make 1 (N.minus_i N.one_i) in
    let ft = Array.make (nBlOCK * n) e in
    let f0 = Array.make (nBlOCK * big_n) e in
      for k = 0 to (nBlOCK - 1) do
        for i = 0 to (n - 1) do
          ft. (i * nBlOCK + k) <- 1, k + 1, i + 1, i + 1, N.minus_i N.one_i;
        done;
      done;
      let idx = ref 0 in
      let sign_matrix = M.sign_mat n in
        for k = 0 to (nBlOCK - 1) do
          let sign_array = sign_matrix. (k) in
            for i = 0 to (n - 1) do
              for j = i to (n - 1) do
                let s = N.mult_i (sign_array. (i)) (N.mult_i (sign_array. (j)) (b0. (i). (j))) in
                  f0. (!idx) <- 0, k + 1, i + 1, j + 1, N.add_i (hx0. (i). (j)) s;
                  idx := !idx + 1;
              done;
            done;
        done;
        1, nBlOCK, bLOCKsTRUCT, c, Sparse ([f0; ft])

  let count_nondiag_blocks bLOCKsTRUCT = 
    let count = ref 0 in
      for i = 0 to Array.length bLOCKsTRUCT - 1 do
        if bLOCKsTRUCT. (i) > 0 then incr count;
      done;
      !count

  let solve_sdp m nBlOCK bLOCKsTRUCT c mat_list prefix_name = 
    let input_s = Filename.temp_file ~temp_dir:U.tmp_dir prefix_name ".dat" in
      debug input_s;
    let input_file = open_out_gen [Open_creat; Open_trunc; Open_wronly] 0o666 input_s in
    let output_s = gen_output_s input_s in
    let is_sparse = matrix_is_sparse mat_list in
    let _ = if is_sparse then write_sdpa_sparse m nBlOCK bLOCKsTRUCT c mat_list input_file else write_sdpa_pb c mat_list input_file in
      close_out input_file;
      let cmd = (if is_sparse then "sdpa -ds " else "sdpa ") ^ input_s ^ (if is_sparse then " -o " else "  ") ^ output_s ^ " -p param.sdpa " ^ "> /dev/null" in
      let _ = Sys.command cmd in
      let obj_min, xVec, xMat, yMat = parse_sdpa_output output_s in
      let xVec = list_of_line xVec in
        (*
        U.debug (U.string_of_list (List.map M.string_of_array xMat));
        U.debug (U.string_of_list (List.map M.string_of_array yMat));
         *)
      let _ = if Config.Config.erase_sdpa_files then Sys.command ("rm -f " ^ input_s ^ " " ^ output_s) else 0 in
      let sos_matrices = Array.of_list (extract_sos_matrices yMat) in
      let nondiag_count = count_nondiag_blocks bLOCKsTRUCT in
      let block_eigs , block_eigs_eqs = Array.make nondiag_count ([||],[||]), Array.make (nBlOCK - nondiag_count) [||] in
        for block_idx = 0 to nondiag_count - 1 do
          block_eigs. (block_idx) <- eigs_of_yMat (sos_matrices. (block_idx));
        done;
        for block_idx = nondiag_count to nBlOCK - 1 do
          block_eigs_eqs. (block_idx - nondiag_count) <- eigs_of_diagMat (sos_matrices. (block_idx));
        done;
        obj_min, xVec, xMat, block_eigs, block_eigs_eqs
 
  let lambda_min c mat_list = 
    let prefix_name = "lambda_min_" ^ Config.Config.ineq_name ^ "_" in
    let lambda_min, _, _, _, _ =  solve_sdp 0 0 [||] c (Dense mat_list) prefix_name in
      N.minus_i lambda_min

  let lambda_min_robust b0 hx0 =  
    let prefix_name = "lambda_min_rob" ^ Config.Config.ineq_name ^ "_" in
    let m, nBlOCK, bLOCKsTRUCT, c, mat_list = sparse_input_robust_sdp_2008 b0 hx0 in      
    let lambda_min, _, _, _, _ = solve_sdp m nBlOCK bLOCKsTRUCT c mat_list prefix_name in
    let lambda_min = N.minus_i lambda_min in
      N.under_i lambda_min

end
