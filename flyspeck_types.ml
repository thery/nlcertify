module type T =
sig
  type num_i
  type inter_mut
  type vstring =
      Fvar of string
    | Fvarloc of string
    | Fflo of num_i
    | Fint of int
  type fstring = Void | Ffunc of string | Ffuncloc of string
  type fineqop = Fstrict | Fnonstrict
  type node = fstring * inter_mut
  val void_im : unit -> inter_mut
  val void_f : fstring * inter_mut
  type func_tree =
      Leaf of vstring * inter_mut
    | Branch of node * func_tree list
  val void_n : node * func_tree list
  type flyspeck_tree =
      Fbox of func_tree list
    | Fdisj of (func_tree * func_tree) list
  type sphere_hash_tree = (string,(string list*func_tree)) Hashtbl.t
  type bounds_hash_tree = (string,(string list*flyspeck_tree)) Hashtbl.t                          
  type ineqs_hash_tree = (string,(string list*flyspeck_tree)) Hashtbl.t
  val sphere_table : sphere_hash_tree
  val bounds_table : bounds_hash_tree
  val ineq_table : ineqs_hash_tree 
  val string_func_tree : func_tree -> string
  val string_of_func : (string * string list) * func_tree -> string
  val string_of_hash_key : sphere_hash_tree -> string -> string
  val nodes_number : func_tree -> int
  val nodes_number_list : func_tree list -> int
  val leaves_nodes_number : func_tree -> int
  val leaves_nodes_number_list : func_tree list -> int
  val depth_aux : int -> (int -> func_tree -> int) -> func_tree list -> int
  val depth : func_tree -> int
  val make_func_tree : node -> func_tree list -> func_tree
  val func_of_node : func_tree -> node
  val branches : func_tree -> func_tree list
  val zero_t : func_tree
  val add_tree : func_tree -> func_tree -> func_tree
  val minus_tree : func_tree -> func_tree
  val degree_map_tree : func_tree -> int
  val string_of_var : string -> string
  val string_of_fun : string -> string
  val mk_branch : func_tree -> func_tree -> func_tree
  val init_leaf : vstring -> func_tree
  val init_tree : fstring -> func_tree
  val rev_tree : func_tree -> func_tree
end


module Make
  (N: Numeric.T)
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t) = struct

  (*open I*)
  type num_i = I.num_i 
  type inter_mut = I.inter_mut 
  type vstring = 
    | Fvar of string
    | Fvarloc of string
    | Fflo of num_i
    | Fint of int

  type fstring =
    | Void 
    | Ffunc of string
    | Ffuncloc of string

  type fineqop = 
    | Fstrict 
    | Fnonstrict

  type node = fstring * inter_mut
  let void_im() = { I.i = I.Void_i}
  let void_f = Void,void_im()

  type func_tree =
    | Leaf of vstring * inter_mut
    | Branch of node * func_tree list
  let void_n = void_f,[]

  type flyspeck_tree = 
    | Fbox of func_tree list
    | Fdisj of (func_tree * func_tree) list


  type sphere_hash_tree = (string,(string list*func_tree)) Hashtbl.t
  type bounds_hash_tree = (string,(string list*flyspeck_tree)) Hashtbl.t                          
  type ineqs_hash_tree = (string,(string list*flyspeck_tree)) Hashtbl.t                          


  let sphere_table = Hashtbl.create 200
  let bounds_table = Hashtbl.create 500
  let ineq_table = Hashtbl.create 500

  let string_func_tree t = 
    let rec print_aux = function
      | Leaf (v,i)-> "Leaf("^ (match v with 
                                 | Fvar s -> "var("^s^")"
                                 | Fvarloc s -> "varloc("^s^")"
                                 | Fint s -> "int("^string_of_int s^")"
                                 | Fflo s -> "flo("^N.string_of_i s^")"
        ) ^ " , " ^ I.string_of_I i ^")"
      | Branch((f,i),t) ->"Branch (("^ (match f with 
                                          | Ffunc s -> "func("^s^")"
                                          | Ffuncloc s -> "funcloc("^s^")"
                                          | Void -> ""
        )
        ^" , " ^I.string_of_I i^ ") , "^ U.string_of_list (List.map print_aux t) ^")"
    in
      print_aux t


let string_of_func f =
  match f with ((fname, var_list), t) -> 
    let s= "("^ fname ^ " , " ^ U.string_of_list var_list ^ ")  " ^ string_func_tree t in
      s
 
let string_of_hash_key table key =
  let (var_list, tree) = Hashtbl.find table key in
    string_of_func ((key,var_list),tree)



let rec nodes_number = function
  | Leaf _ -> 0
  | Branch (_,t_list) -> 1 + nodes_number_list t_list
and nodes_number_list tree = 
  match tree with
    | [] -> 0
    | t::q -> nodes_number t + nodes_number_list q

let rec leaves_nodes_number = function
  | Leaf _ -> 1
  | Branch (_,t_list) -> 1 + leaves_nodes_number_list t_list
and leaves_nodes_number_list = function
  | [] -> 0
  | t::q -> leaves_nodes_number t + leaves_nodes_number_list q

let rec depth_aux a (f:int->func_tree->int) = function
  | [] -> a
  | t :: q -> depth_aux (f a t) f q
let rec depth = function
  | Leaf _ -> 1
  | Branch (_,t_list) -> let f a b = max a (depth b) in 1 + depth_aux 0 f t_list

let make_func_tree node func_tree_list = Branch (node,func_tree_list)

let func_of_node = function 
  | Branch (n,_) -> n
  | Leaf _ -> failwith "cannot extract node from Leaf"

let branches = function 
  | Branch (_,t_list) -> t_list
  | _ -> []

let zero_t = Leaf (Fflo N.zero_i, void_im ())

let add_tree t1 t2 = 
  match t1, t2 with
    | Leaf (Fflo f, _), _  when N.eq_i f N.zero_i -> t2
    | _, Leaf (Fflo f, _)  when N.eq_i f N.zero_i -> t1
    | _ -> Branch ((Ffunc "add_i",void_im()),[t1; t2])

let minus_tree = function
  |  _ as t -> Branch ((Ffunc "minus_i",void_im()),[t])

let rec degree_map_tree = function
  | Leaf (Fflo _, _) | Leaf (Fint _, _) -> 0
  | Leaf (Fvar _, _) -> 1
  | Branch ((Ffunc "mult_i", _), [a ; b]) -> degree_map_tree a + degree_map_tree b
  | Branch ((Ffunc "div_i", _), [a ; b]) -> degree_map_tree a - degree_map_tree b
  | Branch ((Ffunc s, _), [a ; b]) when (s = "add_i" || s = "sub_i") -> max (degree_map_tree a) (degree_map_tree b)
  | Branch ((Ffunc "minus_i", _), [a]) -> degree_map_tree a
  | Branch ((Ffunc "inv_i", _), [a]) when degree_map_tree a = 0 -> 0
  | _ -> 2

(*
let rec is_degree_zero_func = function
  | Leaf (Fflo _, _) | Leaf (Fint _, _) -> true 
  | _ -> false


let rec is_degree_one_func = function
  | Leaf (Fvar _, _) -> true
  | Branch ((Ffunc s, _), [a ; b]) when (s = "add_i" || s = "sub_i") -> is_degree_one_func a 
  | Branch ((Ffunc "mult_i", _), [a ; b]) -> (is_degree_one_func a && is_degree_zero_func b) || (is_degree_one_func b && is_degree_zero_func a)
  | Branch ((Ffunc "minus_i", _), [a]) -> is_degree_one_func a
  | _ -> false
 *)
let string_of_var v = v
let string_of_fun f = f 
(*let string_of_I i_list = concat_string (List.map (fun i -> "[ "^string_of_i (fst i)^"; "^
string_of_i (snd i) ^ "] ") i_list)
let string_of_node n = string_of_fun (fst (fst n)) ^ " , "^ string_of_I (snd n)*)



let mk_branch t1 t2 = 
  match t1 with 
    | Branch ((f,i),l) -> Branch ((f,i),List.rev (t2:: (List.rev l)))
    | Leaf (Fvar s,i) -> (*Printf.printf "func in leaf: %s\n" s;*) Branch ((Ffuncloc s,i),[t2]) (*deals with one variable function for example f in abc_of_quadratic*) 
    | _ -> failwith ("cannot make a tree from a leaf")


let init_leaf f = Leaf (f,void_im())

let init_tree f = 
  match f with 
    | Ffunc s -> Branch ((Ffunc s,void_im()),[])
    | Ffuncloc s -> Branch ((Ffuncloc s,void_im()),[])
    | Void -> Branch (void_f,[])

let rec rev_tree = function
  | (Leaf _) as leaf-> leaf
  | Branch ((f,i),t) -> Branch((f,i),List.map rev_tree (List.rev t))


end
