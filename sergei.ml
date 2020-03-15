module type T = sig
  type num_i
  type pol
  type val_tbl
  type eval_tbl
  val var_hashitem_to_string : string * val_tbl -> string
  val gen_output_s : string -> string
  val gen_variables_names : string -> int -> string list
  val sergei_string_of_interval : string * val_tbl -> string
  val sergei_string_of_box : (string * val_tbl) list -> string
  val divide_hashtbl : eval_tbl -> (string * val_tbl) list
  val write_sergei_problem : pol -> eval_tbl -> bool -> out_channel -> unit
  exception Sergei_error
  val parse_sergei_output_aux : string -> num_i
  val parse_sergei_output : string -> num_i
  val get_bound_poly : pol -> eval_tbl -> bool -> num_i
end

(* bound_transc indicates wether or not the polynomial list is the upper or lower
 * bound of the transcendental function: if bound_transc then min else max*) 

module Make
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t)  
  (P: Polynomial.T with type num_i = N.t)    
  (A: Algo_types.T with type num_i = N.t and type pol = P.pol and type fw_pol = P.fw_pol) = struct 

  type num_i = N.t
  type pol = P.pol
  type val_tbl = A.val_tbl
  type eval_tbl = A.eval_tbl


  let var_hashitem_to_string = function
    | _, ((p, p'), _) -> 
        begin
          let verbose_var = P.string_of_pol (P.pol_of_fw p) in
          let var_regexp = Str.regexp "\\(x[0-9]+\\b\\)"in
            try
              let _ = Str.search_forward var_regexp verbose_var 0 in
              let var = Str.matched_group 1 verbose_var in
                var
            with Not_found -> failwith "no variables xi in this group"
        end

  let gen_output_s input_s =  (String.sub input_s 0 (String.length input_s - 4)) ^ ".out"

  let gen_variables_names vname n_eq = 
    let index_list = U.int_to_list n_eq in
    let variables_names = List.map (fun i -> vname ^ (string_of_int (i+1))) index_list in
      variables_names  


  let sergei_string_of_interval box_item =
    let var = var_hashitem_to_string box_item in
      match box_item with 
        | _, (_ ,(f1, f2)) -> 
            begin
              let s_lo = N.string_of_i f1 and s_up = N.string_of_i f2 in 
                (s_lo ^ " <= " ^ var ^ " <= " ^ s_up ^ " -> \n")
            end

  let sergei_string_of_box box = U.concat_string (List.map sergei_string_of_interval box)

  let divide_hashtbl var_hashtbl =  U.hashtbl_to_list var_hashtbl 

  let write_sergei_problem p var_hashtbl bound_transc input_file = 
    let p = if bound_transc then p else P.p_opp p in
    let term = P.string_of_pol p in
    let box = divide_hashtbl var_hashtbl in
    let constraints = term in
    let box_string = sergei_string_of_box box in
    let result = box_string ^ constraints in
      Printf.fprintf input_file "%s\n" result;
      ()

  exception Sergei_error

  let parse_sergei_output_aux s =
    let file_content = s in
    let sergei_interval = "\\[\\([-0-9\\.]+\\), *\\([-0-9\\. ]+\\)\\]" in
    let sergei_issues = "the problem evaporated" in
      try 
        let _ = Str.search_forward (Str.regexp sergei_interval) file_content 0 in
        let poly_lo_bound_string = Str.matched_group 1 file_content in
        let poly_lo_bound = (N.of_string poly_lo_bound_string) in
          N.lower_bound poly_lo_bound Config.Config.sergei_acc
      with Not_found -> 
        try
          let _ = Str.search_forward (Str.regexp sergei_issues) file_content 0 in
            raise Sergei_error
        with Not_found -> failwith "No sergei interval value in sergei result file"

  let rec parse_sergei_output output_file =
    if (Sys.file_exists output_file )
    then
      begin
        try
          let s = (U.string_of_file output_file ) in
            parse_sergei_output_aux s 
        with Failure _ ->  parse_sergei_output output_file
      end 
    else parse_sergei_output output_file 


  let get_bound_poly p var_hashtbl bound_transc = 
    let prefix_name = "sergei_" ^ Config.Config.ineq_name ^ "_" in
    let input_s = Filename.temp_file  ~temp_dir:U.tmp_dir prefix_name ".txt" in
    let output_s = gen_output_s input_s in
      U._pr_ output_s true true; 
      let input_file = open_out_gen [Open_creat; Open_trunc; Open_wronly] 0o666 input_s in
        write_sergei_problem p var_hashtbl bound_transc input_file;
        close_out input_file;
        let cmd = "sergei " ^ input_s ^ " > " ^ output_s ^ " 2>&1" in 
        let _ = Sys.command cmd in
        let poly_bound = parse_sergei_output output_s in
          (*
           let _ = Sys.command ("rm -f " ^ input_s ^ " " ^ output_s) in
           *)
          if bound_transc then poly_bound else N.minus_i poly_bound
(*
 * No disjunctions case  
 *
let get_bound_poly p_list var_hashtbl varloc_hashtbl bound_transc oc_out =
  let m_list = map (fun pol -> get_bound_poly pol var_hashtbl varloc_hashtbl bound_transc oc_out ) p_list in
    (if bound_transc then max_list else min_list) m_list
 *)

(* Disjunctions case *) 
(*
let get_bound_poly p_list var_hashtbl varloc_hashtbl bound_transc oc_out =
  let m_list = map (fun pol -> get_bound_poly pol var_hashtbl varloc_hashtbl bound_transc oc_out ) p_list in
    m_list
 *)
end
