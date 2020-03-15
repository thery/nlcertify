module type T =
sig
  type num_i 
  type interval 
  exception Diverge
  val sollya_main_cmd : int -> int -> string -> string -> interval -> string
  val write_sollya : string list -> string
  val read_oc_in : Unix.file_descr -> string list
  val read_until_flush : string -> string
  val parse_sollya_output : string -> int -> num_i list
  val get_minimax :  string -> int -> interval -> num_i list
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
  = struct

    type num_i = N.t
    type interval = I.interval
    exception Diverge

    let sollya_main_cmd precision degree s definition_of_s interval = 
      Printf.sprintf "
      restart;\n
      prec = %i;\n
      d = %i;\n
      i = %s;\n
      %s
      p = remez(%s(x), d, i);\n
      b = dirtyinfnorm(%s(x) - p , i);\n
      b1 = round(b, 15, RU);\n
      " precision degree (I.string_I interval) definition_of_s s s

    let write_sollya_filename s_list filename first_write = 
      Printf.sprintf "write(%s) %s \"%s\";\n" (U.concat_string_with_string s_list " ,\" \",") (if first_write then ">" else ">>") filename
       

    let write_sollya s_list (*filename first_write*) = 
      (*
      Printf.sprintf "write(%s) %s %s;\n" (U.concat_string_with_string s_list " ,\" \",") (if first_write then ">" else ">>") filename
       *)
      Printf.sprintf "write(%s);\n" (U.concat_string_with_string s_list " ,\" \",") 

    let read_oc_in fd = 
      let rec suck_oc_in fd acc = 
        match Unix.select [fd] [] [] (-.1.0) with
          | [fd_ready], [], [] -> 
              begin 
                let buffer = Bytes.create 100 in
                let n = Unix.read fd buffer 0 100 in
                let _ = if n = 0 then U.wait 10 else () in
                let s = String.sub buffer 0 n in
                  try 
                    let _ = Str.search_forward (Str.regexp "\\$") s 0 in
                      List.rev (s :: acc)
                  with Not_found -> suck_oc_in fd (s :: acc)
              end
          | _ -> acc
      in
        suck_oc_in fd [] 

    let rec read_until_flush filename : string = 
      try
       U.wait 10;
        begin
        let s = U.string_of_file filename in
        try 
          begin
          let _ = Str.search_forward (Str.regexp "\\$") s 0 in U._pr_ s true false; s
          end
        with Not_found -> U._pr_ "Not found" true true; U.wait 10; read_until_flush filename 
        end
      with _ -> U.wait 10; U._pr_ "read again" true false; read_until_flush filename

    let parse_sollya_output filename d : num_i list =
      (*let _ = read_oc_in fd in
      let s = read_until_flush filename in*)
      let s =  U.string_of_file filename in
      let s_list = Str.split (Str.regexp "[ \t]+") s in
      let _ = List.length s_list in 
        List.map N.of_string s_list

    let parse_sollya_log filename : unit = 
      let s = U.string_of_file filename in
        try 
          begin
            let _ = Str.search_forward (Str.regexp "the algorithm does not converge") s 0 in
              U._pr_ "Error in Remez: the algorithm does not converge." true true;
              raise Diverge
          end
        with Not_found -> () 


    let rec get_minimax s d interval =
   (*
   let oc_in, oc_out, _ = O.init_sollya () in flush oc_out; 
    *)
      let d = if s = "sqrt" then Config.Config.minimax_degree_sqrt else (*else if s = "swf_43" then *) d in
      let prefix_name = "sollya_" ^ Config.Config.ineq_name ^"_" in
      let filename_input = Filename.temp_file ~temp_dir:U.tmp_dir prefix_name ".sollya" in
      let input_file = open_out_gen [Open_creat; Open_trunc; Open_wronly] 0o666 filename_input in 
      let filename_output = O.gen_output_s filename_input 7 in
      let log_file = (U.tmp_dir ^ "/sollya.log") in
        let prec =  Config.Config.minimax_precision in
        let definition_of_s = 
          if s = "ml_27" then "ml_27 = cos(x/pi) * exp(- pi * x);\n" 
          else if s = "swf_43" then "swf_43 = sin(sqrt(x));\n" 
          else if s = "pp_33" then "pp_33 = (log(x))^2;\n" 
          else "" 
        in        
        let sollya_main_cmd = sollya_main_cmd prec d s definition_of_s interval in
      (*output_string oc_out sollya_main_cmd; flush oc_out;*)
      (*let write_p_b_cmd = write_sollya_filename ["p";"b1"] filename true in
        output_string oc_out write_p_b_cmd; flush oc_out;
      let write_b_cmd = "b;\n" in        
        output_string oc_out write_b_cmd; flush oc_out;*)

        let coeffs_write_string = List.map (fun i -> Printf.sprintf "coeff(p, %i)" i) (U.int_to_list (d+ 1)) in
        let write_string = ("b1"::coeffs_write_string)(*@["\"$\""]*) in
        let write_coeff_cmd = write_sollya_filename write_string filename_output true in
          (*output_string oc_out write_coeff_cmd; flush oc_out;*)
          Printf.fprintf input_file "%s\n" (sollya_main_cmd ^ write_coeff_cmd); 
          close_out input_file;
          let _ = Sys.command (Printf.sprintf ("sollya %s > %s 2>&1") filename_input log_file) in 
           (*
           let sollya_main_cmd = "write(\"$\");\n" in
             output_string oc_out sollya_main_cmd;flush oc_out;
            
             let fd = Unix.descr_of_in_channel oc_in in*)
          try 
            let _ = parse_sollya_log log_file in
            parse_sollya_output filename_output d 
          with Diverge -> get_minimax s (d - 1) interval
  end
