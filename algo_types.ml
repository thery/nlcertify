module type T = 
sig
  type num_i
  type interval 
  type inter_mut 
  type pol 
  type node 
  type fw_pol 
  type cert_pop
  type fold_poly_tree =
      Varloc of string * inter_mut
    | Pol of pol * inter_mut
    | Br_poly of node * fold_poly_tree list
  type poly_interval =
      Poly_Int of (fw_pol * fw_pol)
    | Bool_Int of bool
  type val_tbl = (fw_pol * fw_pol) * (num_i * num_i)
  type eval_tbl = (string, val_tbl) Hashtbl.t
  type rewrite_tbl = (string, poly_interval) Hashtbl.t
  type fw_tbl = (fold_poly_tree * int, poly_interval) Hashtbl.t
  type algo_semi_alg =
    ?incr_cliques:bool ->
    ?incr_relax_order:bool ->
    ?relax_order:int ->
    ?force:bool ->
    eval_tbl ->
    fw_pol ->
    pol list -> pol list -> fw_pol list ->
    bool -> bool -> bool -> num_i * num_i * num_i list * num_i list * pol * cert_pop
  val get_result : fw_pol * fw_pol -> poly_interval
  val list_result :(fw_pol * fw_pol) list -> poly_interval list
  val get_pmin : poly_interval -> fw_pol
  val get_pmax : poly_interval -> fw_pol
  val string_of_poly : pol -> string
  val string_fold_tree : fold_poly_tree -> string
  val string_T : fold_poly_tree -> string
  val string_float_T : int -> fold_poly_tree -> string
  val string_of_poly_interval : poly_interval -> string
  val interval_of_poly_interval : poly_interval -> interval
  val ipi : poly_interval -> interval
  val ipi_of_list : poly_interval list -> interval
  val fpt_nodes : fold_poly_tree -> int
  val fpt_nodes_list : fold_poly_tree list -> int
  val fpt_leaves_nodes : fold_poly_tree -> int
  val fpt_leaves_nodes_list : fold_poly_tree list -> int
  val depth_aux : 'a -> ('a -> 'b -> 'a) -> 'b list -> 'a
  val depth : fold_poly_tree -> int
  val branches_T : fold_poly_tree -> fold_poly_tree list
  val interv_at_node : fold_poly_tree -> interval
  val assign_interv_tree : interval -> fold_poly_tree -> unit
  val ait : interval -> fold_poly_tree -> unit
  val aipi : interval -> poly_interval -> poly_interval
end

module Make
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (Ft: Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) 
  (P: Polynomial.T with type num_i = N.t) 
  (Fu:Fw_utils.T with type num_i = N.t and type interval = I.interval and type fw_pol = P.fw_pol)  = struct

    type num_i = N.t
    type interval = I.interval
    type inter_mut = I.inter_mut
    type pol = P.pol
    type node = Ft.node
    type fw_pol = P.fw_pol
    type cert_pop = P.cert_pop

    type fold_poly_tree = 
      | Varloc of string * inter_mut
      | Pol of pol * inter_mut
      | Br_poly of node * fold_poly_tree list

    type poly_interval =
      | Poly_Int of (fw_pol * fw_pol)
      | Bool_Int of bool

    type val_tbl =  (fw_pol * fw_pol) * (num_i * num_i)                 
    type eval_tbl =  (string, val_tbl) Hashtbl.t 
    type rewrite_tbl = (string, poly_interval) Hashtbl.t 
    type fw_tbl = ((fold_poly_tree * int), poly_interval) Hashtbl.t

    type algo_semi_alg = ?incr_cliques:bool -> ?incr_relax_order:bool -> ?relax_order:int -> ?force:bool -> eval_tbl -> fw_pol -> pol list -> pol list -> fw_pol list -> bool -> bool -> bool -> num_i * num_i * num_i list * num_i list * pol * cert_pop

    let get_result t = 
      match t with 
        | p1, p2 -> Poly_Int (p1, p2)

    let list_result tuple_list = List.map get_result tuple_list 

    let get_pmin = function 
      | Poly_Int (p1, _) -> p1
      | _ -> failwith "Must be Poly_Int to get pmin"

    let get_pmax = function 
      | Poly_Int (_, p2) -> p2
      | _ -> failwith "Must be Poly_Int to get pmin"


  (*| Disj_Triple of poly_interval * poly_interval * poly_interval*)


    let string_of_poly = P.string_of_pol
    (*let string_of_poly p = ""*)

    let string_fold_tree t = 
      let rec print_aux = function
        | Varloc (v, i)-> "Varloc("^v^ " , " ^ (I.string_of_I i) ^ ")"
        | Pol (p, i) -> "Pol(" ^ (string_of_poly p) ^ " , " ^ (I.string_of_I i) ^ ")"
        | Br_poly ((f, i),t) ->"Br_poly (("^ (match f with 
                                                | Ft.Ffunc s -> "func("^s^")"
                                                | Ft.Ffuncloc s -> "funcloc("^s^")"
                                                | Ft.Void -> ""
          )
          ^" , " ^I.string_of_I i^ ") , "^U.string_of_list (List.map print_aux t) ^")"
      in
        print_aux t


    let rec string_I i = if Config.Config.string_I_verb then I.string_of_I i else "" 

let rec string_T = function
  | Varloc (v, i) -> "loc" ^ v ^ string_I i 
  | Pol (p, i) -> string_of_poly p ^ string_I i
  | Br_poly ((Ft.Ffunc "minus_i", i), [a]) ->  "<->( " ^ string_T a ^ " )"  ^ string_I i 
  | Br_poly ((Ft.Ffunc "inv_i", i), [a]) ->  "</>( " ^ string_T a ^ " )" ^ string_I i 
  | Br_poly ((Ft.Ffunc s, i), [a]) ->  s ^ "( " ^ string_T a ^ " )" ^ string_I i 
  | Br_poly ((Ft.Ffunc "add_i", i), [a; b]) ->  "( " ^  (string_T a) ^ ") <+> (" ^ (string_T b) ^ " )" ^ string_I i 
  | Br_poly ((Ft.Ffunc "sub_i", i), [a; b]) ->  "( " ^  (string_T a) ^ ") <-> (" ^ (string_T b) ^ " )" ^ string_I i 
  | Br_poly ((Ft.Ffunc "mult_i", i), [a; b]) -> "( " ^  (string_T a) ^ ") <*> (" ^ (string_T b) ^ " )" ^ string_I i 
  | Br_poly ((Ft.Ffunc "pow_i", i), [a; b]) ->  "( " ^  (string_T a) ^ ") <^> (" ^ (string_T b) ^ " )" ^ string_I i 
  | Br_poly ((Ft.Ffunc "div_i", i), [a; b]) ->  "( " ^  (string_T a) ^ ") </> (" ^ (string_T b) ^ " )" ^ string_I i 
  | Br_poly ((Ft.Ffunc s, i), [a; b]) ->  
      begin
        try
          let str = Hashtbl.find I.str_func_bool s in 
            "( " ^  (string_T a) ^ " ) " ^ str ^  " ( " ^ (string_T b) ^ " ) " ^ string_I i 
        with Not_found -> U._pr_ s true true; failwith "not found in string_T"
      end
  | Br_poly ((Ft.Ffuncloc s, i), t) -> s ^ "( " ^ (U.concat_string (List.map string_T t)) ^ " )" ^ string_I i 
  | Br_poly ((Ft.Void, _), t) -> "Void" ^ "( " ^ (U.concat_string (List.map string_T t)) ^ " )" 
  | Br_poly ((Ft.Ffunc s, i), t) -> s ^ "( " ^ (U.concat_string (List.map string_T t)) ^ " )" ^ string_I i 

let rec string_float_T prec = function
  | Varloc (v, i) -> "loc" ^ v
  | Pol (p, i) -> P.string_of_pol_float p prec
  | Br_poly ((Ft.Ffunc "minus_i", i), [a]) ->  "(-(" ^ string_float_T prec a ^ "))"
  | Br_poly ((Ft.Ffunc "inv_i", i), [a]) ->  "1 / (" ^ string_float_T prec a ^ ")"
  | Br_poly ((Ft.Ffunc s, i), [a]) ->  s ^ "(" ^ string_float_T prec a ^ ")"
  | Br_poly ((Ft.Ffunc "add_i", i), [a; b]) -> (match b with Br_poly ((Ft.Ffunc "minus_i", _), [c]) 
      -> string_float_T prec a ^ " - (" ^ string_float_T prec c ^ ")" | _ ->  string_float_T prec a ^ " + (" ^ string_float_T prec b ^ ")" )
  | Br_poly ((Ft.Ffunc "sub_i", i), [a; b]) ->  string_float_T prec a ^ " - (" ^ string_float_T prec b ^ ")"
  | Br_poly ((Ft.Ffunc "mult_i", i), [a; b]) ->  "(" ^ string_float_T prec a ^ ") * (" ^ string_float_T prec b ^ ")"
  | Br_poly ((Ft.Ffunc "pow_i", i), [a; b]) ->  "(" ^  (string_float_T prec a) ^ ") ** (" ^ (string_float_T prec b) ^ ")" 
  | Br_poly ((Ft.Ffunc "div_i", i), [a; b]) -> "(" ^ string_float_T prec a ^ ") / (" ^ string_float_T prec b ^ ")"
  | Br_poly ((Ft.Ffunc s, i), [a; b]) ->  
      begin
        try
          let str = Hashtbl.find I.str_func_bool s in 
            "( " ^  (string_float_T prec a) ^ " ) " ^ str ^  " ( " ^ (string_float_T prec b) ^ " ) " ^ string_I i 
        with Not_found -> U._pr_ s true true; failwith "not found in string_T"
      end
  | Br_poly ((Ft.Ffuncloc s, i), tree) -> s ^ "( " ^ (U.concat_string (List.map (fun t -> string_float_T prec t) tree)) ^ " )" ^ string_I i 
  | Br_poly ((Ft.Void, _), tree) -> "Void" ^ "( " ^ (U.concat_string (List.map (fun t -> string_float_T prec t) tree)) ^ " )" 
  | Br_poly ((Ft.Ffunc s, i), tree) -> s ^ "( " ^ (U.concat_string (List.map (fun t -> string_float_T prec t) tree)) ^ " )" ^ string_I i 

let string_of_poly_interval = function
  | Poly_Int (p1, p2) ->
      "Poly Min:\n" ^ Fu.string_of_fw p1  ^ "\n" ^
      "Poly Max:\n" ^ Fu.string_of_fw p2  ^ "\n" 
  | Bool_Int b -> string_of_bool b
(*  | Disj_Triple a b c -> "Interv1: " ^ (string_of_I a) ^ " " ^ "Interv2: " ^
 *  (string_of_I b) ^ " " ^ "Interv3: " ^ (string_of_I c) ^ "\n"*)

let interval_of_poly_interval = function
  | Poly_Int (p1, p2) -> I.union_I (Fu.interval_of_fw p1) (Fu.interval_of_fw p2)
  | Bool_Int _ -> I.Void_i
let ipi = interval_of_poly_interval
let ipi_of_list l = I.union_list_I (List.map ipi l) 

let rec fpt_nodes = function
  | Br_poly (_, l) -> 1 + fpt_nodes_list l
  | _ -> 0
and fpt_nodes_list tree = 
  match tree with
    | [] -> 0
    | t::q -> fpt_nodes t + fpt_nodes_list q

    let rec fpt_leaves_nodes = function
      | Br_poly (_, l) -> 1 + fpt_leaves_nodes_list l
      | _ -> 1
    and fpt_leaves_nodes_list tree = 
      match tree with
        | [] -> 0
        | t::q -> fpt_leaves_nodes t + fpt_leaves_nodes_list q


    let rec depth_aux a f = function
      | [] -> a
      | t :: q -> depth_aux (f a t) f q
    let rec depth = function
      | Br_poly (_,t_list) -> let f a b = max a (depth b) in 1 + depth_aux 0 f t_list
      | _ -> 1

    let rec branches_T = function | Br_poly (_, t) -> t | _ -> []

    let interv_at_node = function
      | Br_poly ((_, i), _) -> i.I.i
      | Pol (_, i)-> i.I.i    
      | Varloc (_, i) -> i.I.i

    let assign_interv_tree ni = function
      | Br_poly ((_, i), _) -> i.I.i <- ni; ()
      | Pol (_, i)-> i.I.i <- ni; ()
      | Varloc (_, i) -> i.I.i <- ni; ()
    let ait = assign_interv_tree 

    let aipi i = function
      | Poly_Int (p1, p2) -> 
          begin
            let p1_I = I.intersection_I  (Fu.ifw p1) i in
            let p2_I = I.intersection_I  (Fu.ifw p2) i in
            let p1, p2 = Fu.ai p1_I p1, Fu.ai p2_I p2 in
             get_result (p1, p2)
          end
      | _ as pi -> pi
end 
