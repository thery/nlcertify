module type T = 
sig
  type t
  val pwd : string
  val tmp_dir : string
  val mk_dir : string -> unit
  val log_dir : string
  val mk_tmp : unit -> unit
  val mk_log : unit -> unit
  val verbose_mode : bool
  val log_s : string
  val log_verb_s : string
  val init_log_file : unit -> unit
  val _pr_ : string -> bool -> bool -> unit
  val debug : string -> unit
  val string_blanks : int -> string
  val wait : int -> unit
  val close_log_file : unit -> unit
  val eval_time_function_6 : (t -> t -> t -> t -> t -> t -> t) ->  t -> t -> t -> t -> t -> t -> t
  val m_I : t -> t -> t
  val k_th_segment_I : t -> t -> int -> int -> t
  val fst_fst : t * t * (t list) * (t list) * 'a -> t
  val fst_fst_fst : t * t * (t list) * (t list) * 'a * 'b -> t
  exception Empty_list
  val split4 : ('a * 'b * 'c * 'd) list -> 'a list * 'b list * 'c list * 'd list
  val split5 : (t * t * t list * t list * 'a) list -> t list * t list * t list list * t list list * 'a list
  val split6 : (t * t * t list * t list * 'a * 'b) list -> t list * t list * t list list * t list list * 'a list * 'b list
  val int_to_list : int -> int list
  val ceil_int : int -> int
  val points_of_I : t -> t -> int -> t list
  val add_list_int : int list -> int
  val sum_n : int -> int
  val max_list_int : int list -> int 
  val end_itlist : (string -> string -> string) -> string list -> string
  val hd_tl : 'a list -> 'a * 'a list
  val last : 'a list -> 'a
  val combine_f : ('a -> 'b -> 'c) -> 'a list -> 'b list -> 'c list
  val sub_list : 'a list -> int -> int -> 'a list
  val elim_same_lists : ('a -> 'a -> bool) -> 'a list -> 'a list
  val combine_tuple : (t * t) list -> t list list
  val combine_tuple_1 : ('a * 'a) list -> 'a list list
  val strings_of_file : string -> string list
  val string_of_file : string -> string
  val find_in_file : string -> Str.regexp -> string
  val add_list_table : ('a, 'b) Hashtbl.t -> ('a * 'b) list -> unit
  val plural : int -> string
  val concat_string : string list -> string
  val concat_string_with_string : string list -> string -> string
  val string_of_list : string list -> string
  val init_list : int -> 'a -> 'a list
  val permute_list : 'a list -> 'a list
  val permute_list_n : int -> 'a list -> 'a list
  val get_permutations : 'a list -> 'a list list
  val index_of_elt : 'a list -> 'a -> int
  val dump_string_of_list : string -> t list
  val dump_string_of_tuple_list : string -> (t * t) list
  val string_of_tuple : t * t -> string
  val string_of_i_list_aux : t list -> string
  val string_of_i_list : t list -> string
  val string_of_mesh : t list list -> string
  val tl_string : string -> string
  val string_of_tuple_list_aux : (t * t) list -> string
  val string_of_tuple_list : (t * t) list -> string
  val string_float_box : (t * t) list -> int -> string
  val string_of_cut_box : (t * t) list list -> string
  val cut_point : (t * t) list -> (t * t) list * (t * t) list
  val binary_decomp : int -> int -> int -> bool list
  val base_decomp_aux : int -> int -> int -> int -> int list
  val bin_decomp : int -> int -> bool list
  val base_decomp : int -> int -> int -> int list
  val pow_2_n : int -> int
  val pow_base_n : int -> int -> int
  val binomial : int -> int -> int
  val map_func : ('a -> 'b) list -> 'a -> 'b list
  val sort_idx : t list -> int list
  val avoid_duplicata : ('a -> 'a -> int) -> 'a list -> 'a list
  val hashtbl_to_list : ('a, 'b) Hashtbl.t -> ('a * 'b) list
  val hashtbl_keys : ('a, 'b) Hashtbl.t -> 'a list
  val remove_from_list_aux : int -> int -> 'a list -> 'a list
  val remove_from_list : int -> 'a list -> 'a list
  val pick_rnd_in_I : t * t -> t
  val pick_rnd_in_box : int -> (t * t) list -> t list list
  val boxes_share_lower_bound : (t * t) list -> (t * t) list -> int -> bool 
  val boxes_share_upper_bound : (t * t) list -> (t * t) list -> int -> bool 
  val enumerate_ntuple_lex : int -> int -> int list array
  val lexcmp : int list -> int list -> int
  val deg_lex : int list -> int
  val lexidx_of_alpha : int list -> int
  val naive_lexidx_of_alpha : int list -> int list list -> int
  val lexsort : int list list -> int list list
  val alphacl_to_alphan : int list -> bool list -> int list 
end

module Make(N: Numeric.T) = struct

  type t = N.t  
  let pwd = (Unix.getenv "PWD") 
(*  let tmp_dir = (Unix.getenv "PWD") ^ "/tmp_" ^ Sys.argv. (2)*)
  let mk_dir dir =
    try let _ = Sys.is_directory dir in ()
    with Sys_error _ | Unix.Unix_error _-> Unix.mkdir dir 0o766;
                                           () 
  let log_dir = (Unix.getenv "PWD") ^ "/log/"
  let coq_dir = (Unix.getenv "PWD") ^ "/coq/"
  let tmp_dir = log_dir
  let mk_tmp () = mk_dir tmp_dir
  let mk_log () = mk_dir log_dir

  let verbose_mode = true
  let log_s = log_dir ^ Config.Config.ineq_name ^ ".log"
  let log_verb_s = log_dir ^ Config.Config.ineq_name ^ "_v.log"
  let sollya_err_s = tmp_dir ^ "/sollya.log"

  let init_log_file () = 
    let f = open_out(*_gen [Open_creat; Open_trunc; Open_wronly] 0o666*) log_s in
    let f_v = open_out(*_gen [Open_creat; Open_trunc; Open_wronly] 0o666*) log_verb_s in
    let sollya = open_out(*_gen [Open_creat; Open_trunc; Open_wronly] 0o666*) sollya_err_s in
      close_out f;close_out f_v; close_out sollya;
      ()

  let _pr_ s in_log in_stdout =
    let open_log_file = open_out_gen [Open_append; Open_wronly] 0o666 log_s in
    let open_log_verb_file = open_out_gen [Open_append; Open_wronly] 0o666 log_verb_s in
    let pr_log = 
      if in_log then (Printf.fprintf open_log_verb_file "%s\n" s;)
      else ()
    in
      pr_log;
      let pr_stdout = 
        if in_stdout then (prerr_endline s; Printf.fprintf open_log_file "%s\n" s;)
        else ()
      in
        pr_stdout;
        close_out open_log_verb_file;      
        close_out open_log_file;
        ()

  let debug s = _pr_ s true true

  let rec string_blanks n = if n = 0 then "" else " " ^ string_blanks (n - 1)

  let wait time = let _ = Unix.select [] [] [] (float_of_int time /. 1000.) in ()

  let close_log_file () = 
    ()

  let eval_time_function_6 f y1 y2 y3 y4 y5 y6 = 
    let prev = Unix.gettimeofday() in
    let result = f y1 y2 y3 y4 y5 y6 in
    let current = Unix.gettimeofday() in
      Printf.printf "eval_time: %.10f\n" (current-.prev);
      result

  let m_I a b = N.div_i (N.add_i a b) N.two_i
  let k_th_segment_I a b k base =  
    let base, k = N.num_of_int base, N.num_of_int k in
      N.add_i a (N.mult_i (N.div_i (N.sub_i b a) base) k)

  let fst_fst = function
    | a, _, _, _, _ -> a

  let fst_fst_fst = function
    | a, _, _, _, _, _ -> a

  exception Empty_list

  let rec split4 = function
    | (a, b, c, d)::tl -> 
        let la, lb, lc, ld = split4 tl in
          a::la, b::lb, c::lc, d::ld
    | [] -> [], [], [], []
  let rec split5 = function
    | (a, b, c, d, e)::tl -> 
        let la, lb, lc, ld, le = split5 tl in
          a::la, b::lb, c::lc, d::ld, e::le
    | [] -> [], [], [], [], []
  let rec split6 = function
    | (a, b, c, d, e, f)::tl -> 
        let la, lb, lc, ld, le, lf = split6 tl in
          a::la, b::lb, c::lc, d::ld, e::le, f::lf
    | [] -> [], [], [], [], [], []


  let rec int_to_list_aux n acc = 
    if n<0 then acc else int_to_list_aux (n-1) (n::acc)
  let int_to_list n = int_to_list_aux (n-1) []

  let points_of_I a b n = List.map (fun k -> k_th_segment_I a b k n) (int_to_list n)

  let rec add_list_int l = 
    match l with 
      | hd::tl -> hd+(add_list_int tl)
      | [] -> 0

  let sum_n n : int = n * (n + 1) / 2
  let ceil_int deg = int_of_float (ceil (float_of_int deg))

  let max_list_int l = 
    let rec max_list_aux_int m = function
      | [] -> m
      | h::tl -> max_list_aux_int (if h >= m then h else m) tl
    in
      max_list_aux_int 0 l

  let rec end_itlist f l =
    match l with
      | [] -> failwith "end_itlist"
      | [x] -> x
      | h::t -> f h (end_itlist f t)

  let hd_tl = function
    | hd::tl -> hd, tl
    | [] -> raise Empty_list
  let rec last = function
    | [hd] -> hd
    | [] -> raise Empty_list
    | hd::tl -> last tl

let rec combine_f f cb1 cb2 = 
  match cb2 with
    | h :: tl ->
        begin
          let cb = combine_f f cb1 tl in
          let h_cb = List.map (fun s -> f s h) cb1 in
            h_cb @ cb
        end
    | [] -> []

  let rec sub_list l n1 n2 =  
    let n = List.length l in
    let cnd = (n1<n && n1<=n2) in
      if cnd then
        begin
          if n1 = n2 then [List.nth l n1]          
          else if n2 >=n then sub_list l n1 (n-1)
          else (List.nth l n1)::(sub_list l (n1 + 1)  n2)
        end
      else []

  let rec elim_same_lists func = function
    | hd :: tl -> 
        begin
          let elim_tl = elim_same_lists func tl in
            if List.exists (func hd) elim_tl then elim_tl else hd::elim_tl
        end
    | [] -> []

  let rec combine_tuple  = function
    | [] -> [[]]
    | (a, b)::tl -> 
        begin
          let cb = combine_tuple tl in
          let m = m_I a b in 
            (List.map (fun l -> m::l) cb) @ (List.map (fun l -> a::l) cb) @ (List.map (fun l -> b::l) cb)
        end

  let rec combine_tuple_1  = function
    | [] -> [[]]
    | (a, b)::tl -> 
        begin
          let cb = combine_tuple_1 tl in
            (List.map (fun l -> a::l) cb) @ (List.map (fun l -> b::l) cb)
        end

  let strings_of_file filename =
    let fd = try 
      begin 
        Pervasives.open_in filename
      end
    with Sys_error _ ->
      failwith("strings_of_file: can't open"^filename) in
    let rec suck_lines acc =
      try 
        begin
        let l = Pervasives.input_line fd in
        suck_lines (l::acc)
        end
      with End_of_file -> List.rev acc in
    let data = suck_lines [] in
      (Pervasives.close_in fd; data)

  let string_of_file filename =
    end_itlist (fun s t -> s^"\n"^t) (strings_of_file filename)

  let find_in_file filename regexp : string =
    let fd = try 
      begin 
        Pervasives.open_in filename
      end
    with Sys_error _ ->
      failwith("strings_of_file: can't open " ^ filename) in
    let rec suck_lines () =
      try 
        begin
        let l = Pervasives.input_line fd in
          try 
            let _ = Str.search_forward regexp l 0 in
            let s = Str.matched_group 1 l in
              s
          with Not_found -> suck_lines ()
        end
      with End_of_file -> failwith ("No pattern found in: " ^ filename) in
    let data = suck_lines () in
      (Pervasives.close_in fd; data)

  let add_list_table table l = List.iter (fun (k, v) -> Hashtbl.replace table k v) l

  let plural n = if n > 1 then "s" else ""

  let rec concat_string l =
    match l with
      | [] -> ""
      | hd::tl -> hd ^ (concat_string tl)

  let rec concat_string_with_string l s =    
    match l with
      | [] -> ""
      | [x] -> x       
      | hd::tl -> hd ^ s ^ (concat_string_with_string tl s)


  let string_of_list l =                  
    let rec string_of_list_aux = function
      | [] -> ""
      | [s]-> s
      | h::tl -> h^" ; "^string_of_list_aux tl
    in
      "["^string_of_list_aux l^"]"

  let rec init_list n e = if n <= 0 then [] else e::(init_list (n - 1) e)

  let permute_list = function
    | hd::tl -> tl @ [hd]
    | [] -> []

  let rec permute_list_n n l = 
    let m = n mod (List.length l) in
      if m <= 0 then l
      else permute_list_n (m - 1) (permute_list l)

  let get_permutations l = 
    let n = List.length l in
    let idx_list = int_to_list n in
      List.map (fun idx -> permute_list_n idx l) idx_list

  let rec index_of_elt_aux cmp l elt i= 
    match l with 
      | hd::tl -> if cmp elt hd = 0 then i else index_of_elt_aux cmp tl elt (i+1)
      | [] -> failwith " index Not_found"

  let index_of_elt l elt = index_of_elt_aux compare l elt 0

  let dump_string_of_list s =
    let s = string_of_file s in
    let string_list = Str.split (Str.regexp "[ \t]+") s in
    let num_list = List.map N.of_string string_list in
      num_list

  let dump_string_of_tuple_list s =
    let s = string_of_file s in
    let inf_sup = Str.split (Str.regexp ", ") s in
    let string_list = List.map (Str.split (Str.regexp "[ \t]+")) inf_sup in
    let tuple_list = List.combine (List.map N.of_string (List.nth string_list 0)) (List.map N.of_string (List.nth string_list 1)) in
      tuple_list

  let string_of_tuple t = 
    "(" ^ (N.string_of_i  (fst t)) ^", " ^(N.string_of_i (snd t)) ^ ")"

  let string_float_tuple t prec = 
    "(" ^ N.string_float (fst t) prec ^", " ^N.string_float (snd t) prec ^ ")"

  let rec string_of_i_list_aux t_list = 
    match t_list with 
      | [t] -> N.string_of_i t
      | t::tl -> N.string_of_i t ^" ; " ^ string_of_i_list_aux tl
      | []-> ""
  let string_of_i_list t_list = "["^ string_of_i_list_aux t_list ^"]"        
  let string_of_mesh m = concat_string_with_string (List.map string_of_i_list m) "\n"
  let tl_string s = String.sub s 1 (String.length s - 2) 


  let rec string_of_tuple_list_aux t_list = 
    match t_list with 
      | [t] -> string_of_tuple t
      | t::tl -> string_of_tuple t ^" ; " ^string_of_tuple_list_aux tl
      | []-> ""
  let string_of_tuple_list t_list = "["^ string_of_tuple_list_aux t_list ^"]"        
  let string_float_box box prec = "[" ^ (concat_string_with_string (List.map (fun i -> string_float_tuple i prec) box) "; ") ^"]"  

  let string_of_cut_box box_list = concat_string_with_string (List.map string_of_tuple_list box_list) "\n"

  let cut_point point = 
    match point with 
      | [(a, b)] ->    
          begin
            let m = m_I a b in
            let result = ( [ (a, m) ], [ (m, b) ]  ) in
              _pr_ (N.string_of_i m) true true; result
          end
      | _ -> failwith "cannot cut interval"

  let rec binary_decomp n k i=
    if i = n then []
    else ((k mod 2)=0)::(binary_decomp n (k/2) (i+1))

  let rec base_decomp_aux n k i base = 
    if i = n then []
    else (k mod base)::(base_decomp_aux n (k/base) (i+1) base)

  let bin_decomp n k = List.rev (binary_decomp n k 0)
  let base_decomp n k base = List.rev (base_decomp_aux n k 0 base)

  let pow_2_n n = 
    let rec aux res = function
        0 -> res
      | n -> aux (2 * res) (n - 1)
    in aux 1 n

  let rec pow_base_n base n = 
    if n <= 0 then 1 else base*(pow_base_n base (n-1))

  let binomial n p = 
    let rec binomial_aux n p' r = 
      if p' > p then r else binomial_aux (n - 1) (p' + 1) (n * r / p') 
    in
      binomial_aux n 1 1

  let rec map_func func_list a = 
    match func_list with
      | f::tl -> (f a) :: (map_func tl a)
      | [] -> []

  let sort_idx l =
    let epsilon = N.pow_i N.ten_i (N.minus_i N.six_i) in
    let n = List.length l in
    let idx_list = int_to_list n in
    let l = List.map2 (fun elt i -> N.add_i elt (N.mult_i epsilon (N.num_of_int i))) l idx_list in
    let sorted_l = List.sort N.compare_i l in
      List.map (index_of_elt l) (List.rev sorted_l)

  let rec avoid_duplicata_sorted compare = function
    | [] -> []
    | [h] -> [h]
    | a::tl -> if List.mem a tl then avoid_duplicata_sorted compare tl else a::(avoid_duplicata_sorted compare tl)

  (* when l is not sorted *)
  let avoid_duplicata compare l = 
    let l = List.sort compare l in
      avoid_duplicata_sorted compare l

  (* when l is already sorted *)
  let sort_nodupl comp l = 
    let rec f acc = function
    | [] -> acc
    | [a] -> a::acc
    | a::b::tl -> f (if comp a b = 0 then acc else a::acc) (b::tl)
    in
      List.rev (f [] l)


  let hashtbl_to_list h =  Hashtbl.fold (fun k v acc -> (k, v) :: acc) h []
  let hashtbl_keys h = List.map fst (hashtbl_to_list h)

  let rec remove_from_list_aux n i = function
    | [] -> []
    | hd :: tl -> if i = n then tl else hd :: remove_from_list_aux n (i + 1) tl
  let rec remove_from_list n = remove_from_list_aux n 0

  let pick_rnd_in_I = function
    | a, b ->
        begin
          let w = N.sub_i b a in
          let rnd_i = Random.float (N.float_of_num w) in
            N.add_i a (N.num_of_float rnd_i)
        end

  let pick_rnd_in_box n bounds = 
    let rnd_pts = ref [] in
    let _ = Random.self_init () in
    for i = 0 to n - 1 do
      let pt = List.map pick_rnd_in_I bounds in
      rnd_pts := pt::!rnd_pts;
    done;
    !rnd_pts 

  let boxes_share_lower_bound bounds start_bounds k : bool = 
    let border1, border2 = fst (List.nth bounds k), fst (List.nth start_bounds k) in
      N.eq_i border1 border2
  let boxes_share_upper_bound bounds start_bounds k : bool = 
    let border1, border2 = snd (List.nth bounds k), snd (List.nth start_bounds k) in
      N.eq_i border1 border2

  let rec f1 s t = 
    let q = Array.make (t + 1) 0 in
      q. (0) <- s;
      f2 q 0 []

  and f2 q r cmb = 
    let cmb = (Array.to_list q)::cmb in
    if q. (0) = 0 then f4 q r cmb else f3 q r cmb

  and f3 q r cmb = 
    q. (0) <- q. (0) - 1;
    f5 q 1 cmb

  and f4 q r cmb = 
    if r + 1 = Array.length q then cmb
    else begin
      q. (0) <- q. (r) - 1; q. (r) <- 0;
      f5 q (r + 1) cmb
    end

  and f5 q r cmb = 
    q. (r) <- q. (r) + 1;
    f2 q r cmb 
   
  let enumerate_ntuple_lex deg n = 
    if deg = 0 then [|init_list n 0|]
    else if n = 1 then [|[deg]|]
    else Array.of_list (List.rev (f1 deg (n - 1)))

  let sub_alpha j alpha n = 
    let sub_list =  sub_list alpha (n - j) (n - 1) in
      List.fold_left (+) 0 sub_list

  let sub_sum_binomial alpha j n k = 
    let alphaj = List.nth alpha (n - j - 1) in
    let sub_alpha =  sub_alpha j alpha n in
      List.fold_left (fun sum a -> sum + (binomial (n -j - 2 + k - a - sub_alpha) (n - j - 2))) 0 (int_to_list alphaj)

  let deg_lex alpha = List.fold_left (+) 0 alpha

  let lexidx_of_alpha alpha = 
    let n = List.length alpha in
    let k = deg_lex alpha in
    let card_degree_inf = binomial (n + k - 1) n in
    let idx_degree_k = List.fold_left (fun sum j -> (sub_sum_binomial alpha j n k) + sum) 0 (int_to_list (n - 1)) in
      card_degree_inf + idx_degree_k

  let cmp_integer (a: int) (b: int) = if a > b then 1 else if a < b then -1 else 0

  let rec lexcmp_same_deg alpha1 alpha2 = match alpha1, alpha2 with
    | hd1::tl1, hd2::tl2 -> if hd1 = hd2 then lexcmp_same_deg tl1 tl2 else - (cmp_integer hd1 hd2)
    | _ -> 0

  let lexcmp alpha1 alpha2 = 
    let d1, d2 = deg_lex alpha1, deg_lex alpha2 in
      if d1 > d2 then 1 else if d1 < d2 then -1 else lexcmp_same_deg alpha1 alpha2

  let lexsort l = sort_nodupl lexcmp (List.sort lexcmp l)
  let naive_lexidx_of_alpha alpha allmons = index_of_elt_aux lexcmp allmons alpha 0

  let alphacl_to_alphan alphacl cln = 
    let rec f acc = function
      | h1::tl1, h2::tl2 -> if h2 then f (h1::acc) (tl1, tl2) else f (0::acc) (h1::tl1, tl2)
      | [], h2::tl2 -> if h2 then failwith "alphacl: missing entries" else f (0::acc) ([], tl2) 
      | [], [] -> acc
      | _ -> failwith "alphacl: too many entries"
    in
      List.rev (f [] (alphacl, cln))

end

