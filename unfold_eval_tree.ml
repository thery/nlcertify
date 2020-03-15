module type T = 
sig
  type num_i
  type interval
  type func_tree
  type eval_type =
      Bool_eval of bool
    | Num_eval of num_i
    | Fail_eval of string
  type eval_left_right_type =
      EL of eval_type
    | ER of eval_type
    | EM
  val func_at_node : func_tree -> string
  val interv_at_node : func_tree -> interval
  val medium_value_at_node : func_tree -> num_i
  val contains_s : string -> func_tree list -> bool
  val contains_func_aux : func_tree -> bool
  val contains_func : func_tree -> bool
  val contains_fun : func_tree -> bool
  val is_func_arg : func_tree -> bool
  val contains_func_as_arg : func_tree list -> bool
  val extract_func_from_tree :func_tree list -> string * func_tree list
  val find_non_void_string : string list -> string
  val find_funcloc : func_tree -> string
  val unfold_func_tree :string -> func_tree -> func_tree list
  val unfold_add_tree : func_tree -> func_tree list
  val unfold_mul_tree : func_tree -> func_tree list
  val fold_add_tree : func_tree list -> func_tree
  val compose_unfold_tree_with_func :string -> func_tree -> func_tree
  val compose_tree_with_func :string -> func_tree -> func_tree * string
  val find_fun_tree : func_tree -> func_tree
  val find_fun_list : func_tree list -> func_tree
  val build_fun_tree : func_tree -> func_tree
  val is_tuple : func_tree list -> bool
  val mk_tuple_tree : func_tree -> func_tree -> func_tree
  val mk_tuple_aux : func_tree -> func_tree list
  val cut_tuples : func_tree -> func_tree list
  val remove_tuple : func_tree -> func_tree
  val eval_func_aux :(string, num_i) Hashtbl.t -> func_tree -> eval_type
  val eval_tuple : (string, num_i) Hashtbl.t -> func_tree -> eval_type list
  val tuple_to_list : func_tree -> func_tree list
  val replace_leaf_funcloc_by_tree :(string * func_tree) list -> func_tree -> func_tree
  val unfold_tree_with_fun_tree : func_tree -> func_tree -> func_tree
  val unfold_ineq_tree : func_tree -> func_tree
  val print_unfold_tree :bool -> ((string * string list) * func_tree, string list * func_tree)Hashtbl.t ->(string * string list) * func_tree -> string * string list * func_tree
  val eval_func_unfold : string -> num_i list -> eval_type
  val eval_func_num : string -> num_i list -> num_i
  val eval_tree :func_tree -> string list -> num_i list -> num_i
  val get_low_values : num_i list -> num_i list
  type eval_interv_type =
      Bool_interval of bool
    | Num_interval of interval
  val to_interval : eval_interv_type -> interval
  val to_boolean : eval_interv_type -> bool
  val eval_interval :(string, num_i * num_i) Hashtbl.t ->func_tree -> eval_interv_type
  val eval_interval_unfold :string -> (num_i * num_i) list -> num_i * num_i
  val eval_func_mesh :string -> (num_i * num_i) list -> int -> num_i list
end


module Make
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (F: Flyspeck_types.T with type num_i = N.t and type inter_mut = I.inter_mut) 
  (M:Mesh_interval.T with type num_i = N.t) = struct

  type num_i = N.t
  type interval = I.interval
  type func_tree = F.func_tree
  open N
  open I
  open F
  open U
  type eval_type =
    | Bool_eval of bool
    | Num_eval of num_i 
    | Fail_eval of string

  type eval_left_right_type = 
    | EL of eval_type  (* the result matches negative argument for *)
    | ER of eval_type
    | EM (* *)

  let func_at_node = function
    | Branch ((Ffunc s, _), t) -> s
    | _ -> ""
  let interv_at_node = function 
    | Branch ((_, i), _) -> i.i
    | Leaf (s, i)-> i.i

  let medium_value_at_node n = 
    let interv = interv_at_node n in 
      match interv with 
        | Int (a, b) -> m_I a b
        | Void_i -> failwith "cannot extract medium value from void interval"

  let rec contains_s str t = 
    match t with
      | Branch ((Ffunc s, _), sub_t)::tl-> if s = str then true else (contains_s str tl (*|| contains_s str sub_t*)) 
      | _ -> false

  (* check funcloc only at first node*)
  let contains_func_aux tree = 
    match tree with 
      | Branch ((Ffuncloc s, _), _)-> true 
      | _ -> false 


  (* check funcloc inside the whole tree*)
  let rec contains_func tree = 
    match tree with 
      | Branch ((Ffuncloc _, _), _)-> true
      | Branch ((_, _), t) -> List.fold_left (fun b tree -> (b || contains_func tree)) false t
      |_ -> false


  let rec contains_fun tree =
    match tree with
      | Branch ((Ffunc "fun", _), _)-> true
      | Branch ((_, _), t) -> List.fold_left (fun b tree -> (b || contains_fun tree)) false t
      | _ -> false

  let is_func_arg tree =
    match tree with
      | Branch ((Ffunc s, i), []) -> true
      | _ -> false

  let rec contains_func_as_arg t = 
    match t with 
      | hd::tl -> if is_func_arg hd then true else contains_func_as_arg tl 
      | [] -> false

  let rec extract_func_from_tree t = 
    let (func_tree, t_without_func) = List.partition (fun tree -> (is_func_arg tree)) t in
    let func = func_at_node (List.hd func_tree) in
      (func, t_without_func)
  (*
   let rec contains_s str t = 
   match t with 
   | (Branch((Ffunc s, _), sub_t))::tl-> if s=str then true else false
   | _ -> false
   *)

  let rec find_non_void_string l = 
    match l with 
      | s::tl -> if (s="") then (find_non_void_string tl) else s
      | [] -> ""


  let rec find_funcloc tree = 
    match tree with 
      | Branch ((Ffuncloc s, i), t) -> s
      | Branch (n, t) -> let s_list = List.map find_funcloc t in 
          (find_non_void_string s_list )
      | _ -> ""

  let rec unfold_func_tree s = function
    | Branch (( Ffunc str, _), [a; b]) when s = str -> unfold_func_tree s a @ unfold_func_tree s b
    | _ as t -> [t]

  let rec unfold_add_tree = function
    | Branch (( Ffunc "add_i", _), [a; b]) -> unfold_add_tree a @ unfold_add_tree b
    | Branch (( Ffunc "sub_i", _), [a; b]) -> unfold_add_tree a @ List.map minus_tree (unfold_add_tree b)
    | _ as t -> [t]

  let unfold_mul_tree = unfold_func_tree "mult_i"
  let fold_add_tree t = List.fold_left add_tree zero_t t

  (* compose_unfold works only with a single local function funcloc *)

  let rec compose_unfold_tree_with_func f tree = 
    match tree with 
      | Branch ((Ffuncloc s, i), t) -> 
          let new_t = List.map  (compose_unfold_tree_with_func f) t in
            Branch ((Ffunc f, i), new_t)
      | Branch (n, t) -> 
          let new_t = List.map  (compose_unfold_tree_with_func f) t in
            Branch(n, new_t)
      |  _ -> tree


  let rec compose_tree_with_func func tree =
    match tree with 
      | Branch ((Ffuncloc s, i), t) -> (Branch ((Ffunc func, void_im()), t), s)
      | Branch((f, i), t) -> (Branch((f, void_im()), t), "")
      | Leaf(l, i) -> (Leaf(l, void_im()), "")

  let rec find_fun_tree tree = 
    match tree with 
      | Branch ((Ffunc "fun",  i1), t) -> Branch ((Ffunc "fun",  void_im()), t)
      | Branch ((_, _), t) -> find_fun_list t
      | _ -> failwith "fun tree not found"
  and find_fun_list t = 
    match t with 
      | hd::tl -> 
          if (contains_fun hd ) then (find_fun_tree hd) 
          else (find_fun_list tl) 
      | [] -> failwith "fun tree not found"

  let build_fun_tree tree = 
    match tree with 
      | Branch (n, t) -> 
          let new_branches = t @ [Leaf( Fvar "new_x" , void_im())] in
          let new_var = Leaf (Fvarloc "new_x", void_im()) in
            Branch ((Ffunc "fun",  void_im()), [new_var; Branch (n, new_branches)])
      | _ -> failwith "Impossible to build fun tree"
  (*
   let is_tuple s = 
   if s = "abc_of_quadratic" then (Printf.printf "tuple \n";true) else false
   *)
  let is_tuple t =
    match t with 
      | [h] ->
          begin 
            if func_at_node h = "abc_of_quadratic" then 
              ((*Printf.printf "tuple \n";*)true) 
            else false
          end
      | _ -> false


  let rec mk_tuple_tree tuple_tree tree : func_tree =
    match tree with
      | Branch ((f, i), t) -> 
          (match f with
             | Void -> tuple_tree
             | _ -> (match (List.rev t) with
                       | hd::tl -> Branch ((f, void_im()), (List.rev tl) @ [mk_tuple_tree tuple_tree hd ])
                       | [] -> failwith "unsupported case")
          )
      | _ -> failwith "unsupported case"


  let rec mk_tuple_aux tree : func_tree list =
    match tree with
      | Branch((Ffunc "tuple", _), [t1;t2]) -> mk_tuple_aux( t1) @ [t2]
      | Branch((f, i), t) -> [Branch((f, void_im()), t)]
      | Leaf(l, i) -> [Leaf(l, void_im())]

  let rec cut_tuples tree : func_tree list = 
    match tree with
      | Branch ((f, i), t) -> (match f with 
                                 | Ffunc "tuple" -> mk_tuple_aux tree
                                 | _ -> cut_tuples (List.nth t ((List.length t) -1)) 
        )
      | _ -> failwith "unsupported case"

  let rec remove_tuple tree : func_tree =
    match tree with
      | Branch ((f, i), t) -> 
          (match f with         
             | Ffunc "tuple" -> ((*Printf.printf "remove now \n";*) 
                 Branch ((Void, void_im()), []))
             | _ -> (match (List.rev t) with
                       |hd::tl -> Branch ((f, void_im()),  (List.rev tl) @ [remove_tuple hd])
                       |[] -> failwith "unsupported case"
               )
          ) 
      | _ -> failwith "unsupported case"

  let rec eval_func_aux var_hashtbl tree : eval_type =
    match tree with 
      | Leaf (Fvar v, _)-> ((* Printf.printf "var: %s %s\n" v (fst (nth var_point 0));*)
          try 
            let value = Hashtbl.find var_hashtbl v in
              Num_eval value
          with Not_found -> (_pr_ "eval_func_aux used!" true true; Fail_eval v)
        )
      | Leaf (Fint i, _) -> Num_eval (num_of_int i)
      | Leaf (Fflo f, _) -> Num_eval f
      | Branch ((Ffunc "and", _), [t1; t2]) -> ( 
          let b1 = eval_func_aux var_hashtbl t1 and b2 = eval_func_aux var_hashtbl t2 in 
            match (b1,b2) with 
              | (Bool_eval bool1, Bool_eval bool2) -> Bool_eval (bool1 && bool2)
              | _ -> Fail_eval "and"
        )
      | Branch ((Ffunc "cnd", _), [Branch ((Ffunc "if", _),  [t1]); Branch((Ffunc "then", _), [t2])]) -> (
          let bool_cnd = eval_func_aux var_hashtbl t1 in
            match bool_cnd with
              | Bool_eval bool1 -> (
                  if bool1 
                  then eval_func_aux var_hashtbl t2 
                  else Fail_eval "cnd"
                )
              | _ -> Fail_eval "cnd"
        )
      | Branch ((Ffunc "cnd", _), [Branch ((Ffunc "if", _),  [t1]); Branch((Ffunc "then", _), [t2]); Branch((Ffunc "else", _), [t3])]) -> (
          let bool_cnd = eval_func_aux var_hashtbl t1 in
            match bool_cnd with
              | Bool_eval bool1 -> 
                  eval_func_aux var_hashtbl (if bool1 then t2 else t3)
              | _ -> Fail_eval "Has to be Bool_eval"
        )
      | Branch ((Ffunc "let", _), [Leaf (Fvarloc s, _); t1; t2]) -> ( 
          let s_value = eval_func_aux var_hashtbl t1 in
            match s_value with 
              | Num_eval f -> (
                  Hashtbl.add var_hashtbl s f;
                  let let_value = eval_func_aux var_hashtbl t2 in
                    Hashtbl.remove var_hashtbl s;
                    let_value
                )
              | _ -> Fail_eval "Has to be Num_eval"
        )
      | Branch ((Ffunc s, _), t) -> (*Printf.printf "eval at %s\n" (s);*)(
          try 
            let g = Hashtbl.find func_basic s in
              match t with 
                | [h] -> ( 
                    let value = eval_func_aux var_hashtbl h in
                      match value with 
                        | Num_eval f -> Num_eval (g f)
                        | _ -> Fail_eval "Has to be Num_eval"
                  )
                | _ -> Fail_eval "More than one element in the list"
          with Not_found -> 
            try 
              let g = Hashtbl.find func_basic2 s in
                match t with 
                  | [a; b] -> ( 
                      let value1 = eval_func_aux var_hashtbl a in
                      let value2 = eval_func_aux var_hashtbl b in
                        match value1, value2 with 
                          | Num_eval f1, Num_eval f2 -> Num_eval (g f1 f2)
                          | _ -> Fail_eval "Has to be Num_eval"
                    )
                  | _ -> Fail_eval "More than two elements in the list"
            with Not_found -> 
              try 
                let g = Hashtbl.find func_bool s in
                  match t with 
                    | [a; b] -> ( 
                        let value1 = eval_func_aux var_hashtbl a in
                        let value2 = eval_func_aux var_hashtbl b in
                          match value1, value2 with 
                            | Num_eval f1, Num_eval f2 -> Bool_eval (g f1 f2)
                            | _ -> Fail_eval "Has to be Num_eval"
                      )
                    | _ -> Fail_eval "More than two elements in the list"
              with Not_found -> Printf.printf "At %s:" s; Fail_eval "tree not correctly unfolded"
        )
      | _ -> Fail_eval "unsupported case"

  and eval_tuple var_hashtbl tree : eval_type list = 
    match tree with
      | Branch((Ffunc "tuple", _), [t1; t2]) -> (*Printf.printf "tuple found \n" ;*) (eval_tuple var_hashtbl t1) @ (eval_tuple var_hashtbl t2)
      (*Printf.printf "tuple not found \n" ;*) (* Printf.printf "%s\n" (string_func_tree tree);*)  
      | _ -> [(eval_func_aux var_hashtbl (unfold_ineq_tree tree))]			

  and  tuple_to_list tree = 
    match tree with 
      | Branch((Ffunc "tuple", _), [t1; t2]) -> (tuple_to_list t1) @ (tuple_to_list t2)
      | Branch((n, i), t) -> [Branch((n, void_im()), t)]
      | Leaf(v, i) -> [Leaf(v, void_im())]

  and replace_leaf_funcloc_by_tree tree_map sub_tree = 
    match sub_tree with 
      | Leaf (Fvar s , i) -> (try List.assoc s tree_map with Not_found ->  Leaf (Fvar s , void_im()))
      | Leaf (v, i) -> Leaf(v, void_im())
      | Branch (n, t) -> Branch (n, List.map (replace_leaf_funcloc_by_tree tree_map) t)

  and unfold_tree_with_fun_tree fun_tree tree =
    match fun_tree with 
      | Branch ((Ffunc "fun",  _), [Leaf (Fvarloc v, _);t_fun]) -> (* Printf.printf "%s\n" (string_func_tree t_fun);*)   (
          match tree with 
            | Branch ((Ffuncloc s, i), [t]) ->((*Printf.printf "funcloc %s \n" s;Printf.printf "%s\n" (string_func_tree t);*)
                let tree_map = [(v, t)] in
                let new_t_fun = replace_leaf_funcloc_by_tree tree_map t_fun in (* replace Leaf (Fvar s) by t in t_fun *)
                  new_t_fun)
            | Branch ((f, i), t) ->   let branches = List.map (fun b -> unfold_tree_with_fun_tree fun_tree b) t in Branch ((f, void_im()), branches)
            | Leaf(l, i) -> Leaf(l, void_im())                                 

        )
      |_-> print_endline (string_func_tree fun_tree); failwith "not a fun tree"

  and unfold_ineq_tree tree =
    match tree with 
      | Branch ((Ffunc "div_i", i), [a; b]) -> Branch ((Ffunc "mult_i", void_im()), [unfold_ineq_tree a; Branch ((Ffunc "inv_i", void_im()), [unfold_ineq_tree b])])
      | Branch ((Ffunc s, i), t) ->( 
          if List.mem s ml_functions then 
            Branch ((Ffunc s, void_im()), List.map unfold_ineq_tree t)
          else(  
            let (sub_var_list, sub_tree) = Hashtbl.find sphere_table s in
            let sub_tree = unfold_ineq_tree sub_tree in

              if (is_tuple t) then (
                let (tuple_var_list, tuple_sub_tree) = Hashtbl.find sphere_table (func_at_node (List.hd t)) in
                let tuple_sub_tree = unfold_ineq_tree tuple_sub_tree in
                let tree_without_tuple = remove_tuple tuple_sub_tree in
                let tuple_trees  = cut_tuples tuple_sub_tree in
                let list_tuple_tree  = List.map (fun t-> mk_tuple_tree t tree_without_tuple) tuple_trees in

                let funtree = List.hd ( branches (List.hd t)) in
                  if (contains_func tuple_sub_tree) then
                    begin                  
                      let fun_tree = 
                        if (contains_fun funtree) 
                        then find_fun_tree funtree  
                        else build_fun_tree funtree
                      in
                      let new_sub_trees = List.map (unfold_tree_with_fun_tree fun_tree) list_tuple_tree in
                        unfold_ineq_tree (Branch ((Ffunc s, void_im()), List.map unfold_ineq_tree new_sub_trees) )
                    end
                  else failwith "no such case for tuple trees"
              )
              else if contains_func_as_arg t then (
                (*Printf.printf "%s contains funcloc \n" s;*)
                let (func, t_without_func) = extract_func_from_tree t in
                (*Printf.printf "sub_var_list %s\n" (string_of_list (sub_var_list));
                 Printf.printf "func %s\n" (func);*)
                let func_loc = find_funcloc sub_tree in
                  if (func_loc = "") then failwith "cannot deal with several local functions inside a tree"
                  else (
                    let new_sub_tree = (compose_unfold_tree_with_func) func sub_tree in
                    (*Printf.printf "new_sub_tree: %s\n" (string_func_tree
                     * new_sub_tree);*)
                    (*Printf.printf "func_loc %s\n" (func_loc);*)
                    let new_sub_var_list = List.filter (fun n -> (n = func_loc)=false) sub_var_list in
                    (*Printf.printf "new_sub_var_list %s\n" (string_of_list
                     * (new_sub_var_list));*)
                    let tree_map = List.combine new_sub_var_list t_without_func in
                    let new_sub_tree  = replace_leaf_funcloc_by_tree tree_map new_sub_tree in
                      unfold_ineq_tree new_sub_tree)                                         
              )
              else if contains_s "tuple" t then (
                (*Printf.printf "tuple found\n";*)
                let sub_tree_list =  tuple_to_list (List.hd t) in
                  unfold_ineq_tree (Branch ((Ffunc s, void_im()), List.map unfold_ineq_tree sub_tree_list))
              )
              else (
                let tree_map = List.combine sub_var_list (List.map unfold_ineq_tree t) in
                let new_sub_tree  = replace_leaf_funcloc_by_tree tree_map sub_tree in
                  unfold_ineq_tree new_sub_tree
              )
          )
        )
      | Branch ((n, i), t) -> Branch ((n, void_im()), List.map unfold_ineq_tree t)
      | Leaf (v, i) -> Leaf (v, void_im())

  let print_unfold_tree unfold_bool table key = 
    let var_list, tree = Hashtbl.find table key in
    let unfold_tree = if unfold_bool then unfold_ineq_tree tree else tree in
      string_of_func key, var_list, unfold_tree
  (*
   let eval_func_unfold key point = 
   (*let (var_list, tree) = real_hash_value key (List.length point) in	*)
   let (var_list, tree) = Hashtbl.find sphere_table key in
   let tree = unfold_ineq_tree tree in
   let var_point = List.combine var_list point in
   let var_local = [] in
   Obj.obj (eval_func_aux var_point var_local tree)
   *)

  let eval_func_unfold key point = 
    let (var_list, tree) = Hashtbl.find sphere_table key in
    let tree = unfold_ineq_tree tree in
    let var_point = List.combine var_list point in
    let var_hash_table = Hashtbl.create 10 in
      add_list_table var_hash_table var_point;
      let result = eval_func_aux var_hash_table tree in
        (*Printf.printf "%s\n" (string_func_tree tree);*)
        result 

  let eval_func_num key point : num_i = 
    let eval_num = eval_func_unfold key point in
      match eval_num with 
        | Num_eval f -> f
        | Bool_eval _ -> failwith "Bool_eval"
        | Fail_eval s -> failwith s
  (*
   let eval_func_inv_trigo tree var_list point : eval_left_right_type = 
   match tree with 
   | Branch ((Ffunc s, _), [h]) when (s = "atan" || s = "acos" || "asin") -> 
   begin
   let e = eval_tree var_hashtbl h in
   let eval_num = eval_func_unfold key point in
   match eval_num with
   | Num_eval f -> f
   | Bool_eval _ -> failwith "Has to be Num_eval"
   end 
   *)

  let eval_tree tree var_list point =
    let var_map = List.combine var_list point in
    let l = List.length var_map in
    let var_hash_table = Hashtbl.create l in
      add_list_table var_hash_table var_map;
      let result = eval_func_aux var_hash_table tree in
        match result with
          | Num_eval f -> f 
          | Bool_eval _ -> failwith "Bool_eval"
          | Fail_eval s -> failwith s

  let rec get_low_values = function
    | hd::tl -> if (le_i hd (pow_i ten_i (minus_i three_i)) && gt_i hd zero_i) then (hd::get_low_values tl) else get_low_values tl
    | [] -> []

(*
type box_int = Left | Right | Full
let string_of_lfr = function
  | Left -> "Left" | Right -> "Right" | Full-> "Full"
let string_of_lfr_list lfr_l = string_of_list (map string_of_lfr lfr_l)

let rec mk_box_full n  = if n <= 0 then [] else Full::(mk_box_full (n-1))
let rec mk_box_right n = if n <= 0 then [] else Right::(mk_box_right (n-1))
let rec mk_box_left n  = if n <= 0 then [] else Left::(mk_box_left (n-1))

(*
let mk_hypercubes_pair l n = [ ((mk_box_left (n)) @ (Right::(mk_box_full (l-n-1)))) ; ((mk_box_right (n)) @ (Left::(mk_box_full (l-n-1)))) ]
let rec mk_hypercubes_list_aux l n = if n >= l then [mk_box_right l; mk_box_left l] else (mk_hypercubes_pair l n)  @ mk_hypercubes_list_aux l (n+1)
 *)

let mk_hypercube l n = (mk_box_left (n-1)) @ (Right::(mk_box_full (l-n)))
let rec mk_hypercubes_list_aux l n = if n > l then [mk_box_left l] else (mk_hypercube l n) :: mk_hypercubes_list_aux l (n+1)
let mk_hypercubes_list l = List.rev (mk_hypercubes_list_aux l 1)

let map_box_int_bound lrf = function
  | bl, br ->
      begin
        match lrf with 
          | Left -> bl
          | Right -> br
          | Full -> min_i (fst bl) (fst br), max_i (snd bl) (snd br)
      end

let mk_br_bl bounds_i optim_i radius = 
  let under_left = under_i (add_i (fst bounds_i) radius) in
  let upper_left = upper_i (add_i (fst bounds_i) radius) in
  let under_right = under_i (sub_i (snd bounds_i) radius) in
  let upper_right = upper_i (sub_i (snd bounds_i) radius) in
  let dleft = abs_i (sub_i (fst bounds_i) optim_i) in
  let dright = abs_i (sub_i (snd bounds_i) optim_i) in
    (*
    if eq_i (fst bounds_i) optim_i 
     *)
    if le_i dleft dright  
    then (fst bounds_i, upper_left), (under_left, snd bounds_i)
    else (under_right, snd bounds_i), (fst bounds_i, upper_right)

let project_x_on_corner x bounds = 
  let f x_i b_i = 
    let l, r = fst b_i, snd b_i in
    let dl = abs_i (sub_i l x_i) in
    let dr = abs_i (sub_i r x_i) in
      if le_i dl dr then l else r 
  in 
    map2 f x bounds



let mk_box_list_grad bounds x0 gx0 radius : (num_i * num_i) list * (num_i * num_i) list list list = 
  let x0 = Array.of_list x0 in
  let bounds = Array.of_list bounds in
  let gx0_norm = norm_array gx0 in
    (*
  let gx0_norm = norm_inf_array gx0 in
     *)
  let n = size x0 in
  let bounds_lr_array = Array.make n ((zero_i, zero_i), (zero_i, zero_i)) in
    for i = 0 to (n - 1) do
      let b_i, x_i, g_i = bounds. (i), x0. (i), gx0_norm. (i) in
      let ri = (abs_i (mult_i radius g_i)) in
      let w_i = width_I (mk_I b_i) in
      let r_i = if ge_i ri w_i then w_i else ri in
        bounds_lr_array . (i) <- mk_br_bl b_i x_i r_i;
    done;
    let map_lrf lrf_list = map2 map_box_int_bound lrf_list (Array.to_list bounds_lr_array) in
    let box_list = mk_hypercubes_list n in
    let sub_box, partition_lrf = hd_tl box_list in
    let partitions = List.map get_permutations partition_lrf in
    let partitions = List.map (fun idx -> List.map (fun t -> nth t idx) partitions) (int_to_list n) in
      map_lrf sub_box, List.map (fun p -> List.map map_lrf p) partitions


(* Cut the box in (n + 1) boxes with n = length optim, assuming optima is a corner of
 * the box bounds *)

let mk_box_list bounds x0 radius = 
  let bounds_lr_list = map2 (fun b o -> mk_br_bl b o radius) bounds x0 in
  let map_lrf lrf_list = map2 map_box_int_bound lrf_list bounds_lr_list in
  let box12 = mk_hypercubes_list (length x0) in
    List.rev (map map_lrf box12)
 *)
  type eval_interv_type = 
    | Bool_interval of bool
    | Num_interval of interval 

  let to_interval = function
    | Num_interval  i -> i
    | Bool_interval _ -> failwith "Cannot get interval from Bool_interval"

  let to_boolean = function
    | Num_interval _  -> failwith "Cannot get interval from Num_interval"
    | Bool_interval b -> b

  let rec eval_interval var_hashtbl tree : eval_interv_type =
    match tree with
      | Leaf (Fvar v, i_var)-> (
          try
            (*let prev = Unix.gettimeofday() in*)
            let (a, b) = Hashtbl.find var_hashtbl v in 
            let interv = Int (a, b) in 
              i_var.i <- interv; 
              (*let current = Unix.gettimeofday() in*)
              (*Printf.printf "var: %.20f\n" (current -. prev);*)
              Num_interval interv
          with Not_found -> failwith "variable not found"
        )
      | Leaf (Fint f, i) -> 
          let interval = mk_i_I (num_of_int f) in 
            i.i <- interval; Num_interval interval

      | Leaf (Fflo f, i) -> 
          let interval = Int (f, f) in 
            i.i <- interval; Num_interval interval

      | Branch ((Ffunc "and", _), [t1; t2]) -> ( 
          let b1 = eval_interval var_hashtbl t1 and b2 = eval_interval var_hashtbl t2 in 
            match (b1,b2) with 
              | (Bool_interval bool1, Bool_interval bool2) -> Bool_interval (bool1 && bool2)
              | _ -> failwith "Has to be Bool_interval"
        )
      | Branch ((Ffunc "cnd", cnd_interv), [Branch ((Ffunc "if", _),  [t1]); Branch((Ffunc "then", then_interv), [t2])]) -> (
          let bool_cnd = eval_interval var_hashtbl t1 in
            match bool_cnd with
              | Bool_interval bool1 -> 
                  if bool1
                  then
                    let interv = eval_interval var_hashtbl t2 in
                      match interv with 
                        | Num_interval interval -> 
                            then_interv.i <- interval; cnd_interv.i <- interval;
                            eval_interval var_hashtbl t2
                        | Bool_interval _ -> failwith "Has to be Num_interval"
                          else failwith "no alternative evaluation"
                        | _ -> failwith "Has to be Bool_interval"
        )
      | Branch ((Ffunc "cnd", cnd_interv), [Branch ((Ffunc "if", _),  [t1]); Branch((Ffunc "then", then_interv), [t2]); Branch((Ffunc "else", else_interv), [t3])]) -> (
          let bool_cnd = eval_interval var_hashtbl t1 in
            match bool_cnd with
              | Bool_interval bool1 ->( 
                  let interv = eval_interval var_hashtbl (if bool1 then t2 else t3) in
                    match interv with 
                      | Num_interval interval -> (
                          let cnd_interval = if bool1 then then_interv else else_interv in
                            cnd_interval.i <- interval; 
                            cnd_interv.i <- interval;
                            interv )
                      | Bool_interval _ -> failwith "Has to be Num_interval")
              | _ -> failwith "Has to be Bool_interval"
        )
      | Branch ((Ffunc "let", let_interv ), [Leaf (Fvarloc s, i); t1; t2]) -> ( 
          let s_value = eval_interval var_hashtbl t1 in
            match s_value with 
              | Num_interval ( interv )-> ( 
                  match interv with 
                    | Int (a, b) -> (
                        i.i <- interv; Hashtbl.add var_hashtbl s (a, b);
                        let let_interval = eval_interval var_hashtbl t2 in
                          Hashtbl.remove var_hashtbl s;
                          match let_interval with 
                            | Num_interval interv_let ->( let_interv.i <- interv_let; let_interval)
                            | Bool_interval _ -> failwith "Has to be Num_interval"
                      )
                    | _ -> failwith "Interval has to be Int (a, b)"
                )
              | _ -> failwith "Has to be Num_interval of Int (a, b)"
        )
      | Branch ((Ffunc s, i_func), t) -> (*Printf.printf "eval at %s\n" (s);*)(
          try 
            let g = Hashtbl.find func_interval_basic s in
              match t with 
                | [h] -> ( 
                    let interval = eval_interval var_hashtbl h in
                      match interval with 
                        | Num_interval interv ->
                            (*let prev = Unix.gettimeofday() in*)
                            let g_interval = g interv in
                              (*let current = Unix.gettimeofday() in*)
                              (*  Printf.printf "%s: %.20f\n" s (current -. prev);*)
                              i_func.i <- g_interval;
                              Num_interval g_interval
                        | _ -> failwith "Has to be Num_interval"
                  )
                | _ -> failwith "More than one element in the list"
          with Not_found -> 
            try 
              let g = Hashtbl.find func_interval_basic2 s in
                match t with 
                  | [a; b] -> ( 
                      let interval1 = eval_interval var_hashtbl a in
                      let interval2 = eval_interval var_hashtbl b in
                        match interval1,interval2 with 
                          | Num_interval interv1, Num_interval interv2 ->
                              (*let prev = Unix.gettimeofday() in *)
                              let g_interval = g interv1 interv2 in
                                (*let current = Unix.gettimeofday() in*)
                                (*Printf.printf "%s: %.20f\n" s (current -.
                                 * prev);*)
                                i_func.i <- g_interval;
                                Num_interval g_interval
                          | _ -> failwith "Has to be Num_interval"
                    )
                  | _ -> failwith "More than two elements in the list"
            with Not_found -> 
              try 
                let g = Hashtbl.find func_interval_bool s in
                  match t with 
                    | [a; b] -> ( 
                        let interval1 = eval_interval var_hashtbl a in
                        let interval2 = eval_interval var_hashtbl b in
                          match interval1,interval2 with 
                            | Num_interval interv1, Num_interval interv2 -> 
                                let g_interval = g interv1 interv2 in
                                  Bool_interval g_interval
                            | _ -> failwith "Has to be Num_interval"
                      )
                    | _ -> failwith "More than two elements in the list"
              with Not_found -> Printf.printf "At %s:" s; failwith "tree not correctly unfolded"
        )
      | _ -> failwith "unsupported case"


  (*
   * give the result of eval_interval under the form (a, b) where a, b : float
   *)

  let eval_interval_unfold key point = 
    let (var_list, tree) = Hashtbl.find sphere_table key in
    let tree = unfold_ineq_tree tree in
    let var_point = List.combine var_list point in
    let var_hash_table = Hashtbl.create 10 in
      add_list_table var_hash_table var_point;
      let result = eval_interval var_hash_table tree in
        Printf.printf "%s\n" (string_func_tree tree);
        match result with 
          | Num_interval interv -> ( match interv with Int (a, b) -> (a, b) | _ -> failwith "Has to be Int (a, b)" )
          | _ -> failwith "Has to be Num_interval"

  let eval_func_mesh key point base = 
    let mesh = M.mesh_of_point point base in 
    let eval_result_list = List.map (eval_func_num key) mesh in
    let sorted_eval_list = List.sort compare_i eval_result_list in
      Printf.printf "%s\n" (string_of_list_i sorted_eval_list);
      sorted_eval_list
end
