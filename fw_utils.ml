module type T =
sig
  exception Div_refine
  exception Compose_refine
  type num_i
  type positive
  type interval
  type transc_approx
  type fw_pol 
  type pol 
  type cert_itv
  type relax_type = Lasserre | Schor
  val relax_type_of_string : string -> relax_type
  val tan_approx : transc_approx -> num_i * num_i
  val string_of_approx : transc_approx -> string
  val string_approx : transc_approx -> string
  val string_float_approx : transc_approx -> int -> string
  val length_of_fw : fw_pol -> int
  val fw_0 : fw_pol
  val fw_1 : fw_pol
  val string_of_fw : fw_pol -> string
  val string_fw : int -> fw_pol -> string
  val interval_of_fw : fw_pol -> interval
  val ifw : fw_pol -> interval
  val mk_Pw_I_cert : pol -> interval -> cert_itv -> fw_pol
  val mk_Pw_I : pol -> interval -> fw_pol
  val mk_Pw : pol -> fw_pol
  val mk_Max : fw_pol list -> fw_pol
  val assign_interval : interval -> fw_pol -> fw_pol
  val assign_interval_certif : interval -> fw_pol -> cert_itv -> fw_pol
  val ai : interval -> fw_pol -> fw_pol
  val aic : interval -> fw_pol -> cert_itv -> fw_pol
  val fold_fw : fw_pol -> fw_pol
  val elim_sort : fw_pol list -> fw_pol list
  val assign_min : fw_pol list -> fw_pol
  val assign_max : fw_pol list -> fw_pol
  val extract_fw_from_max : fw_pol -> fw_pol
  val fw_addC : num_i -> fw_pol -> fw_pol
  val fw_mulC : num_i -> fw_pol -> fw_pol
  val fw_minus : fw_pol -> fw_pol
  val fw_add : fw_pol -> fw_pol -> fw_pol
  val fw_sub : fw_pol -> fw_pol -> fw_pol
  val fw_ident : fw_pol -> fw_pol
  val approx_fw_add : fw_pol -> fw_pol -> fw_pol -> fw_pol -> fw_pol * fw_pol
  val approx_fw_minus : fw_pol -> fw_pol -> fw_pol * fw_pol
  val approx_fw_sub :fw_pol -> fw_pol -> fw_pol -> fw_pol -> fw_pol * fw_pol
  val fw_mul : fw_pol -> fw_pol -> fw_pol
  val fw_div : fw_pol -> fw_pol -> fw_pol
(*  val fw_mult : fw_pol -> fw_pol -> fw_pol -> fw_pol list*)
  val fw_divide :fw_pol -> fw_pol -> fw_pol -> fw_pol list
  val approx_fw_mult :fw_pol ->fw_pol ->fw_pol -> fw_pol -> fw_pol * fw_pol
  val approx_fw_div :fw_pol ->fw_pol ->fw_pol -> fw_pol -> fw_pol * fw_pol
  val approx_fw_inv :fw_pol -> fw_pol -> fw_pol * fw_pol
  val approx_fw_pow : float ->fw_pol -> fw_pol -> fw_pol * fw_pol
  val approx_fw_sqrt :fw_pol -> fw_pol -> fw_pol * fw_pol
  val compose_fw_approx_for_eval :fw_pol -> transc_approx -> fw_pol
  val eval_fw : (positive, num_i) Hashtbl.t -> fw_pol -> num_i
  val vars_of_fw : fw_pol -> positive list
end


module Make
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval) = struct


    type num_i = N.t
    type positive = Numbers.T.positive
    type interval = I.interval
    type transc_approx = P.transc_approx
    type pol = P.pol
    type fw_pol = P.fw_pol
    type cert_itv = P.cert_itv
    type relax_type = Lasserre | Schor

    let relax_type_of_string = function
    | "Lasserre" -> Lasserre | "Schor" -> Schor | _ as s -> invalid_arg (s ^ ": Not a valid relax_type")

  let tan_approx = function
    | P.Tan (r, p) -> (r, p)
    | _ -> failwith "not a tangent"

    let string_of_approx = function
      | P.Tan (r, p) -> "[ " ^ N.string_of_i r ^ " " ^ N.string_of_i p ^ "]"
      | P.Par (a, b, c, d) -> "[ " ^ N.string_of_i a ^ " " ^ N.string_of_i b ^ " " ^ N.string_of_i c ^ " " ^ N.string_of_i d ^ "]"
      | P.Cub (a, b, c, d, e) -> "[ " ^ N.string_of_i a ^ " " ^ N.string_of_i b ^ " " ^ N.string_of_i c ^ " " ^ N.string_of_i d ^ " " ^ N.string_of_i e ^ "]"
      | P.Minimax l -> I.string_of_list_i l

    let rec length_of_fw = function
      | P.Pw _ -> 1
      | P.Fw  ((p1, p2), _, _) -> length_of_fw p1 + length_of_fw p2
      | P.Min (fw_l, _, _) -> List.fold_right (fun f b -> length_of_fw f + b) fw_l 0
      | P.Max (fw_l, _, _) -> List.fold_right (fun f b -> length_of_fw f + b) fw_l 0
      | P.Plus ((fw1, fw2), _, _) -> length_of_fw fw1 + length_of_fw fw2
      | P.Mult ((fw1, fw2), _, _) -> length_of_fw fw1 + length_of_fw fw2
      | P.Minus (fw, _) -> length_of_fw fw
      | P.Sqrt (fw, _) -> length_of_fw fw
      | P.Comp ((_, fw), _, _) -> length_of_fw fw
      | P.MaxMin ((f1, f2), _, _) -> List.fold_right (fun f b -> length_of_fw f + b) [f1;f2] 0

    let fw_0 = P.Pw (P.Pc N.zero_i, I.zero_I, P.cert_null)
    let fw_1 = P.Pw (P.Pc N.one_i, I.one_I, P.cert_null)
    let fwX = P.Pw (P.mkX, I.one_I, P.cert_null)


    let rec string_of_fw  = function
      | P.Pw (p, i, _) -> P.string_of_pol p ^ I.string_I i
      | P.Fw  ((p1, p2), i, _) -> (*"P.Fw \n" ^*) string_of_fw p1 ^ "\n / \n" ^ string_of_fw p2 ^ I.string_I i
      | P.Min (fw_l, i, _) -> "P.Min \n" ^ (U.concat_string_with_string (List.map string_of_fw fw_l) "; \n") ^ I.string_I i
      | P.Max (fw_l, i, _) -> "P.Max \n" ^ (U.concat_string_with_string (List.map string_of_fw fw_l) "; \n") ^ I.string_I i
      | P.Plus ((fw1, fw2), i, _) -> (*"P.Plus \n ^ "*) (string_of_fw fw1) ^ "\n + \n" ^ (string_of_fw fw2) ^ I.string_I i
      | P.Mult ((fw1, fw2), i, _) -> (*"P.Mult \n" ^ *) string_of_fw fw1 ^ "\n * \n" ^ string_of_fw fw2 ^ I.string_I i
      | P.Minus (fw, i) -> (*"P.Minus \n"*) "P.Minus ( " ^ string_of_fw fw ^ I.string_I i ^ " )"
      | P.Sqrt (fw, i) -> "P.Sqrt \n" ^ string_of_fw fw ^ I.string_I i
      | P.Comp ((a, fw), i, _) -> "P.Comp " ^ string_of_approx a ^ " with " ^ string_of_fw fw ^ I.string_I i
      | P.MaxMin ((f1, f2), i, _) -> "MaxMin (" ^ string_of_fw f1 ^ ", " ^ string_of_fw f2 ^ ")" ^ I.string_I i

    let interval_of_fw = function 
      | P.Pw (_, i, _) | P.Fw (_, i, _) | P.Min (_, i, _) | P.Max (_, i, _) | P.Plus (_, i, _) | P.Mult (_, i, _)| P.Minus (_, i)| P.Sqrt (_, i)| P.Comp (_, i, _) | P.MaxMin(_, i, _) -> i
    let ifw = interval_of_fw


    let mk_Pw_I_cert p i c = P.Pw (p, i, c)
    let mk_Pw_I p i = P.Pw (p, i, P.cert_null)
    let mk_Pw p =  P.Pw (p, I.mk_void_I (), P.cert_null)
    let mk_Max fw_l = P.Max (fw_l,  I.mk_void_I (), P.cert_null)

    let rec assign_interval i = function 
      | P.Pw (p, _, c) -> P.Pw (p, i, c)
      | P.Fw  ((p1, p2), _, c) -> P.Fw  ((p1, p2),i , c)
      | P.Min ( fw_l, _, c) -> P.Min (fw_l, i, c)
      | P.Max (fw_l, _, c) -> P.Max ( fw_l, i, c)
      | P.Plus ((fw1, fw2), _, c) -> P.Plus ((fw1, fw2), i, c)
      | P.Mult ((fw1, fw2), _, c) -> P.Mult ((fw1, fw2), i, c)
      | P.Minus (fw, _) -> P.Minus (fw, i)
      | P.Sqrt (fw, _) -> P.Sqrt (fw, i)
      | P.Comp ((a, fw), _, c) -> P.Comp ((a, fw), i, c)
      | P.MaxMin (_ as f, _, c) -> P.MaxMin (f, i, c) 

    let ai = assign_interval

    let rec assign_interval_certif i f c = match f with
      | P.Pw (p, _, _) -> P.Pw (p, i, c)
      | P.Fw  ((p1, p2), _, _) -> P.Fw  ((p1, p2),i , c)
      | P.Min ( fw_l, _, _) -> P.Min (fw_l, i, c)
      | P.Max (fw_l, _, _) -> P.Max ( fw_l, i, c)
      | P.Plus ((fw1, fw2), _, _) -> P.Plus ((fw1, fw2), i, c)
      | P.Mult ((fw1, fw2), _, _) -> P.Mult ((fw1, fw2), i, c)
      | P.Minus (fw, _) -> P.Minus (fw, i)
      | P.Sqrt (fw, _) -> P.Sqrt (fw, i)
      | P.Comp ((a, fw), _, _) -> P.Comp ((a, fw), i, c)
      | P.MaxMin (_ as f, _, _) -> P.MaxMin (f, i, c) 

    let aic = assign_interval_certif

    let pol_of_approx = function
      | P.Tan (a, b) ->  P.p_addC (P.p_mulC (P.mkX) a) b 
      | P.Par (p1, p2, p3, p4) ->                                   
          begin
            let delta = P.p_addC P.mkX (N.minus_i p4) in
            let delta_square = P.p_square delta in
            let t_2 = P.p_mulC delta_square p1 in
            let t_1 = P.p_mulC delta p2 in
            let t_0 = p3 in
              P.p_add t_2 (P.p_addC t_1 t_0) 
          end
      | P.Cub (c, f''_x0, f'_x0, f_x0, x0) ->  
          begin
            let delta = P.p_addC P.mkX (N.minus_i x0) in
            let delta_square = P.p_square delta in
            let delta_cubic = P.p_mul delta_square delta in
            let t_3 = P.p_mulC delta_cubic c in
            let t_2 = P.p_mulC delta_square f''_x0 in
            let t_1 = P.p_mulC delta f'_x0 in
            let t_0 = f_x0 in
              P.p_add (P.p_add (P.p_addC t_1 t_0) t_2) t_3
          end
      | P.Minimax l -> 
          begin
            let n = List.length l in
            let mon_idx = U.int_to_list n in
            let mon_list = List.map (P.p_pow  P.mkX) mon_idx in
            let summands = List.map2 P.pmulC mon_list l in
              List.fold_left P.p_add (P.Pc N.zero_i) summands
          end

    let approx_of_pol p = 
      let monomials = P.monomials p in
      let supports = List.map (fun m -> snd (P.monomial_support 1 m)) monomials in
        P.Minimax supports

    let approx_add a1 a2 = 
      let a1, a2 = pol_of_approx a1, pol_of_approx a1 in
        approx_of_pol (P.p_add a1 a2)

                        (* 
    let approx_add approx2 = function
        let ( + ), ( - ), ( * ) = N.add_i, N.sub_i, N.mult_i in
      | Tan (a, b) -> 
          begin
            match approx2 with 
              | Tan (c, d) -> Tan (a + c, b + d)
              | Par (p1, p2, p3, p4)  -> Par (p1, p2 + a, p3 + b - a * p4, p4) 
              | Cub (p1, p2, p3, p4, p5) -> Cub (p1, p2, p3 + b, p4 + b - a * p5, p5)
              | Minimax l -> 
                  begin
                    if List.length l <= 1 then 
                  end
          end
   | Par (p1, p2, p3, p4) -> 
      begin
        match a2 with 
          | Par (q1, q2, q3, q4) -> eq_i p1 q1 && eq_i p2 q2 && eq_i p3 q3 && eq_i p4 q4
          | _ -> false
      end
   | Cub (p1, p2, p3, p4, p5) -> 
      begin
        match a2 with 
          | Cub (q1, q2, q3, q4, q5) -> eq_i p1 q1 && eq_i p2 q2 && eq_i p3 q3 && eq_i p4 q4 && eq_i p5 q5
          | _ -> false
      end
  | Minimax l1 -> 
      begin
        match a2 with
          | Minimax l2 -> List.for_all2 eq_i l1 l2
          | _ -> false
      end

        Par (p1, p2, p3, p4) 
    (*
     _pr_ "two elements founds in fw" true false; 
     _pr_ (concat_string (List.map string_of_fw fw_l)) true false;
     *)
                         *)
    let rec fold_fw = function
      | P.Max (fw_l, i, c) ->
          begin
            match fw_l with
              | [f1; f2] -> P.Max (fw_l, i, c)
              | h::tl ->  
                  begin
                    let i_tl = I.interv_of_max (List.map ifw tl) in
                      P.Max ([h; fold_fw (P.Max (tl, i_tl, P.cert_null))], i, c)
                  end
              | _ -> failwith "Not a valid P.Max of fw"
          end
      | P.Min (fw_l, i, c) ->
          begin
            match fw_l with
              | [f1; f2] -> P.Min (fw_l, i, c)
              | h::tl ->
                  begin
                    let i_tl = I.interv_of_min (List.map ifw tl) in
                      P.Min ([h; fold_fw (P.Min (tl, i_tl, P.cert_null))], i, c)
                  end
              | _ -> failwith "Not a valid P.Min of fw"
          end
      | _ as fw -> fw

    let rec elim_sort = function
      | h::tl -> if List.mem h tl then elim_sort tl else h::elim_sort tl
      | [] -> []


    let assign_min fw_l =
      let i = I.interv_of_min (List.map ifw fw_l) in
      let l = elim_sort fw_l in
      let relax_type =  relax_type_of_string Config.Config.relax_type in 
        match l, relax_type with 
          | [f], _ -> f
          | _, Schor -> P.Min (l, i, P.cert_null)
          | _, Lasserre -> fold_fw (P.Min (l, i, P.cert_null))

    let assign_max fw_l = 
      let i = I.interv_of_max (List.map ifw fw_l) in
      let l = elim_sort fw_l in 
      let relax_type = relax_type_of_string Config.Config.relax_type in 
        match l, relax_type with 
          | [f], _ -> f
          | _, Schor -> P.Max (l, i, P.cert_null)
          | _, Lasserre -> (fold_fw (P.Max (l, i, P.cert_null)))

    let extract_fw_from_max = function
      | P.Comp ((a, fw), _, _) -> fw
      | _ as fw -> fw

    let rec fw_addC b = function
      | P.Pw (p, i, c) -> P.Pw ((P.p_addC p b), I.add_I_num i b, c)
      | P.Fw ((p1, p2), i, c) as fw -> P.Plus ((fw, P.Pw (P.Pc b, I.mk_i_I b, P.cert_null)), I.add_I_num i b , c)
      | P.Plus ((fw1, fw2), i, c) -> 
          begin
            match fw1, fw2 with
              | P.Pw _, _ -> P.Plus ((fw_addC b fw1, fw2), I.add_I_num i b, c)
              | _ -> P.Plus ((fw1, fw_addC b fw2), I.add_I_num i b, c)
          end
      | P.Mult ((fw1, fw2), i, c) -> P.Plus ((P.Mult ((fw1, fw2), i, P.cert_null), P.Pw (P.Pc b, I.mk_i_I b, P.cert_null)), I.add_I_num i b, c)
      | P.Max (fw_l, i, c) -> P.Max ((List.map (fw_addC b) fw_l), I.add_I_num i b, c)
      | P.Min (fw_l, i, c) -> P.Min ((List.map (fw_addC b) fw_l), I.add_I_num i b, c)
      | P.Minus (fw, i) as mns -> P.Plus ((mns, P.Pw (P.Pc b, I.mk_i_I b, P.cert_null)), I.add_I_num i b, P.cert_null)
      | P.Sqrt (fw, i) as sq -> P.Plus ((sq, P.Pw (P.Pc b, I.mk_i_I b, P.cert_null)), I.add_I_num i b, P.cert_null)
      | P.Comp ((a, fw), i, c) as sq -> P.Plus ((sq, P.Pw (P.Pc b, I.mk_i_I b, P.cert_null)), 
                                                I.add_I_num i b, c)
      | P.MaxMin ((f1, f2), i, c) ->  P.MaxMin ((fw_addC b f1, fw_addC b f2),  I.add_I_num i b, c) 

    and fw_mulC a = function
      | P.Pw (p, i, c) -> P.Pw ((P.p_mulC p a), I.mult_I_num i a, c)
      | P.Fw ((p1, p2), i, c) -> P.Fw ((fw_mulC a p1, p2), I.mult_I_num i a , c)
      | P.Plus ((fw1, fw2), i, c) -> P.Plus ((fw_mulC a fw1, fw_mulC a fw2), I.mult_I_num i a, c)
      | P.Mult ((fw1, fw2), i, c) -> P.Mult ((fw_mulC a fw1, fw2), I.mult_I_num i a, c)
      | P.Max (fw_l, i, c) -> if N.le_i a N.zero_i then P.Min ((List.map (fw_mulC a) fw_l), I.mult_I_num i a, c) else P.Max ((List.map (fw_mulC a) fw_l), I.mult_I_num i a, c) 
      | P.Min (fw_l, i, c) -> if N.le_i a N.zero_i then P.Max ((List.map (fw_mulC a) fw_l), I.mult_I_num i a, c) else P.Min ((List.map (fw_mulC a) fw_l), I.mult_I_num i a, c)
      | P.Minus ((fw, i)) -> P.Minus ((fw_mulC a fw), I.mult_I_num i a )
      | P.Sqrt (fw, i) -> 
          begin
            let sqr_a = N.sqr_i a and op = if N.lt_i a N.zero_i then fw_minus else fw_ident in 
              op (P.Sqrt ((fw_mulC sqr_a fw), I.mult_I_num i a ))
          end
      | (P.Comp ((app, fw), i, c)) as sq -> P.Mult ((sq, P.Pw (P.Pc a, I.mk_i_I a, P.cert_null)), I.mult_I_num i a, c)
      | P.MaxMin ((f1, f2), i, c) -> if N.le_i a N.zero_i then P.MaxMin ((fw_mulC a f2, fw_mulC a f1),  I.add_I_num i a, c) else P.MaxMin ((fw_mulC a f1, fw_mulC a f2), I.add_I_num i a, c) 


    and fw_minus = function
      | P.Pw (p, i, c) -> P.Pw ((P.p_opp p), I.minus_I i, c)
      | P.Fw ((p1, p2), i, c)-> P.Fw ((fw_minus p1, p2), I.minus_I i, c)
      | P.Plus ((fw1, fw2), i, c) -> P.Plus ((fw_minus fw1, fw_minus fw2), I.minus_I i, c)
      | P.Mult ((fw1, fw2), i, c) -> P.Mult ((fw_minus fw1, fw2), I.minus_I i, c)
      | P.Max (fw_l, i, c) -> P.Min ((List.map fw_minus fw_l), I.minus_I i, c)
      | P.Min (fw_l, i, c) -> P.Max ((List.map fw_minus fw_l), I.minus_I i, c)
      | P.Minus (fw, i) -> fw 
      | P.Sqrt (fw, i) -> P.Minus (P.Sqrt (fw, i), I.minus_I i )
      | (P.Comp ((app, fw), i, c)) as sq -> P.Minus (sq, I.minus_I i)
      | P.MaxMin ((f1, f2), i, c) -> P.MaxMin ((fw_minus f2, fw_minus f1), I.minus_I i, c) 

    and fw_add f1 f2 =
      let len, map2 = List.length, List.map2 in
      let i_plus = I.add_I (ifw f1) (ifw f2) in 
      let c0 = P.cert_null in
        match f1, f2 with
          | P.Pw (p1, _, _), P.Pw (p2, _, _) -> P.Pw (P.p_add p1 p2, i_plus, c0)
          | P.Plus ((n1, n2), _, _), P.Pw (p2, _, _) -> 
              begin
                match n1, n2 with
                  | P.Pw _, _ -> P.Plus ((fw_add n1 f2, n2), i_plus, c0) 
                  | _, P.Pw _ -> P.Plus ((fw_add n2 f2, n1), i_plus, c0)
                  | _ -> P.Plus ((f1, f2), i_plus, c0) 
              end
          | P.Pw (p2, _, _), P.Plus ((n1, n2), _, _) -> 
              begin
                match n1, n2 with
                  | P.Pw _, _ -> P.Plus ((fw_add n1 f1, n2), i_plus, c0) 
                  | _, P.Pw _ -> P.Plus ((fw_add n2 f1, n1), i_plus, c0)
                  | _ -> P.Plus ((f1, f2), i_plus, c0) 
              end
          | P.Plus ((a1, a2), _, _), P.Plus ((a3, a4), _, _) ->
              begin
                match a1, a2, a3, a4 with
                  | P.Pw _, _, P.Pw _, _ -> P.Plus ((fw_add a1 a3, fw_add a2 a4), i_plus, c0)
                  | P.Pw _, _,  _, P.Pw _ -> P.Plus ((fw_add a1 a4, fw_add a2 a3), i_plus, c0)
                  | _, P.Pw _, P.Pw _, _ -> P.Plus ((fw_add a2 a3, fw_add a1 a4), i_plus, c0)
                  | _, P.Pw _,  _, P.Pw _ -> P.Plus ((fw_add a1 a3, fw_add a2 a4), i_plus, c0)
                  | _ -> P.Plus ((fw_add a1 a2, fw_add a3 a4), i_plus, c0)
              end          
          | P.Max (l1, _, _) ,  P.Max (l2, _, _) when len l1 = len l2 -> P.Max (map2 fw_add l1 l2, i_plus, c0)
          | P.Min (l1, _, _) ,  P.Min (l2, _, _) when len l1 = len l2 -> P.Min (map2 fw_add l1 l2, i_plus, c0)
          | P.Comp ((a1, f1), _, _), P.Comp ((a2, f2), _, _) when P.fw_eq f1 f2 -> P.Comp ((approx_add a1 a2, f1), i_plus, c0)
          | _ -> P.Plus ((f1, f2), i_plus, c0)

    and fw_sub f1 f2 = fw_add f1 (fw_minus f2)
    and fw_ident fw = fw

    and fw_mul f1 f2 = 
      let i_mul = I.mult_I (ifw f1) (ifw f2) in
        match f1, f2 with
          | P.Pw ((P.Pc c), _, _), f | f, P.Pw ((P.Pc c), _, _) -> fw_mulC c f
          | P.Pw (p1, _, _), P.Pw (p2, _, _) when P.degree_pol p1 + P.degree_pol p2 <=  Config.Config.max_degree_pol  -> P.Pw (P.p_mul p1 p2, i_mul, P.cert_null)        
          | _ -> P.Mult ((f1, f2), i_mul, P.cert_null)


    let approx_fw_add pmin1 pmax1 pmin2 pmax2 = fw_add pmin1 pmin2, fw_add pmax1 pmax2
    let approx_fw_minus pmin pmax = fw_minus pmax, fw_minus pmin
    let approx_fw_sub pmin1 pmax1 pmin2 pmax2 = approx_fw_add pmin1 pmax1 (fw_minus pmax2) (fw_minus pmin2)

    let fw_div f1 f2 = P.Fw ((f1, f2), I.div_I (ifw f1) (ifw f2), P.cert_null) 

    (* Dummy function
    let rec fw_mult p pmin pmax = 
      begin
        if P.fw_eq pmin pmax 
        then [P.Mult ((p, pmin), I.mult_I (ifw p) (ifw pmin))]
        else [P.Mult ((p, pmin), I.mult_I (ifw p) (ifw pmin)); P.Mult ((p, pmax), I.mult_I (ifw p) (ifw pmax))]
      end
                          *)
    let rec fw_divide p pmin pmax = 
      begin
        if P.fw_eq pmin pmax 
        then 
          begin
            (*         
             _pr_ (string_I (ifw p)) true false;
             _pr_ (string_I (ifw pmin)) true false;
             *)
            [P.Fw ((p, pmin), I.div_I (ifw p) (ifw pmin), P.cert_null)]
          end
        else [P.Fw ((p, pmin), I.div_I (ifw p) (ifw pmin), P.cert_null); P.Fw ((p, pmax), I.div_I (ifw p) (ifw pmax), P.cert_null)]
      end

    let c0 = P.cert_null
    let hard_fw_mult pmin1 pmax1 pmin2 pmax2 i1 i2 : fw_pol * fw_pol = 
      if Config.Config.mmm_relax then 
        begin
          (*
          let first_term = if P.is_Max pmin1 && P.is_Min pmax1 then P.MaxMin ((pmin1, pmax1), i1) else if P.fw_eq pmin1 pmax1 then pmin1 else (U._pr_ (string_of_fw pmin1) true true; U._pr_ (string_of_fw pmax1) true true; failwith "unsupported case for hard_fw_mult") in
          let snd_term = if P.is_Max pmin2 && P.is_Min pmax2 then P.MaxMin ((pmin2, pmax2), i2) else if P.fw_eq pmin2 pmax2 then pmin2 else (U._pr_ (string_of_fw pmin2) true true; U._pr_ (string_of_fw pmax2) true true; failwith "unsupported case for hard_fw_mult" ) in
           *)
          let first_term = if P.fw_eq pmin1 pmax1 then pmin1 else P.MaxMin ((pmin1, pmax1), i1, P.cert_null) in
          let snd_term =  if P.fw_eq pmin2 pmax2 then pmin2 else P.MaxMin ((pmin2, pmax2), i2, c0) in
            fw_mul first_term snd_term, fw_mul first_term snd_term
        end
      else assign_min [fw_mul pmax1 pmin2; fw_mul pmax1 pmax2; fw_mul pmin1 pmin2; fw_mul pmin1 pmax2] , assign_max [fw_mul pmax1 pmin2; fw_mul pmax1 pmax2; fw_mul pmin1 pmin2; fw_mul pmin1 pmax2] 


    let rec approx_fw_mult pmin1 pmax1 pmin2 pmax2 =
      (*
       _pr_ "4 polys:" true false;
       _pr_ (string_of_fw pmin1) true false;
       _pr_ (string_of_fw pmax1) true false;
       _pr_ (string_of_fw pmin2) true false;
       _pr_ (string_of_fw pmax2) true false;
       _pr_ "end polys" true false;
       *)
      let a, b, c, d = ifw pmin1, ifw pmax1, ifw pmin2, ifw pmax2 in
      let interval1, interval2 = I.union_I a b, I.union_I c d in
        (*
         _pr_ ("sgn interval1: " ^ (string_of_int (sgn_I interval1))) true false;
         _pr_ ("sgn interval2: " ^ (string_of_int (sgn_I interval2))) true false;
         *)
        match I.sgn_I interval1, I.sgn_I interval2 with
          | 1, 1 -> fw_mul pmin1 pmin2, fw_mul pmax1 pmax2
          | 1, 0 -> assign_min [fw_mul pmin1 pmin2; fw_mul pmax1 pmin2] , assign_max [fw_mul pmin1 pmax2; fw_mul pmax1 pmax2] 
          | 0, 0 -> hard_fw_mult pmin1 pmax1 pmin2 pmax2 interval1 interval2
          |(-1), _ -> let p1, p2 = approx_fw_mult (fw_minus pmax1) (fw_minus pmin1) pmin2 pmax2 in approx_fw_minus p1 p2
          | _,(-1) -> let p1, p2 = approx_fw_mult (fw_minus pmax2) (fw_minus pmin2) pmin1 pmax1 in approx_fw_minus p1 p2
          | _  -> approx_fw_mult pmin2 pmax2 pmin1 pmax1 

    exception Div_refine

    let rec approx_fw_div pmin1 pmax1 pmin2 pmax2 =
      let a, b, c, d = ifw pmin1, ifw pmax1, ifw pmin2, ifw pmax2 in
      let interval1, interval2 = I.union_I a b, I.union_I c d in
        match I.sgn_I interval1, I.sgn_I interval2 with
          | 1, 1 -> fw_div pmin1 pmax2, fw_div pmax1 pmin2
          | 0, 1 -> assign_min [fw_div pmin1 pmin2; fw_div pmin1 pmax2] , assign_max [fw_div pmax1 pmin2; fw_div pmax1 pmax2] 
          |(-1), 1 -> let p1, p2 = approx_fw_div (fw_minus pmax1) (fw_minus pmin1) pmin2 pmax2 in approx_fw_minus p1 p2
          | _,(-1) -> let p1, p2 = approx_fw_div pmin1 pmax1 (fw_minus pmax2) (fw_minus pmin2) in approx_fw_minus p1 p2
          | _    -> raise Div_refine


    let approx_fw_inv pmin pmax = approx_fw_div fw_1 fw_1 pmin pmax 
    let approx_fw_sqrt pmin pmax (* : fw_poly_num * fw_poly_num*) = 
      match pmin, pmax with
        (*
         | P.Pw (p1, i1), P.Pw(p2, i2) when (degree_pol p1 = 1 && degree_pol p2 = 1) ->  P.Sqrt (pmin, sqrt_I i1), P.Pw (p_mulC (p_addC p2 one_i) 0.5, sqrt_I i2)
         *)
        | P.Pw (P.Pc min, _, _), P.Pw (P.Pc max, _, _) -> 
            begin
              let a, b = (*N.under_i*) (N.sqrt_i min), (*N.upper_i*) (N.sqrt_i max) in
                P.Pw (P.Pc a, I.mk_i_I a, c0), P.Pw (P.Pc b, I.mk_i_I b, c0)
            end
        | _ -> P.Sqrt (pmin, I.sqrt_I (ifw pmin)), P.Sqrt (pmax, I.sqrt_I (ifw pmax))

    let approx_fw_pow f pmin pmax (*: fw_poly_num * fw_poly_num*) = 
      let r = mod_float f 1. in
      let n = int_of_float (floor f) in
      let rec f_aux n pmin pmax = 
        if n = 0 then fw_1, fw_1 
        else 
          let pm, pM = f_aux (n - 1) pmin pmax in
            approx_fw_mult pmin pmax pm pM 
      in
      let pm, pM = f_aux n pmin pmax in
        if r = 0.5 then 
          begin
            let pms, pMs = approx_fw_sqrt pmin pmax in
              approx_fw_mult pm pM pms pMs
          end
        else if r = 0. then pm, pM
        else (U._pr_ (string_of_float f) true true; failwith "approx_fw_pow bad argument: not a half integer")

    let eval_par x = function
      | P.Par (c, f'_x0, f_x0, x0) -> 
          begin
            let ( + ), ( * ), ( - ) = N.add_i, N.mult_i, N.sub_i in
              c * N.sqr_i (x - x0) + f'_x0 * (x - x0) + f_x0
          end
      | _ -> N.zero_i

    exception Compose_refine

    let compose_fw_approx_for_eval fw (*: approx -> fw_poly_num*)  = function
      | P.Tan (a, b) -> fw_addC b (fw_mulC a fw)
      | P.Par (c, f'_x0, f_x0, x0) as p ->  
          begin
            let delta = fw_addC (N.minus_i x0) fw in
            let delta_square = fw_mul delta delta in
            let t_2 = fw_mulC c delta_square in
            let t_1 = fw_mulC f'_x0 delta in
            let t_0 = f_x0 in
            let fw_comp = fw_add t_2 (fw_addC t_0 t_1) in              
            let i1, i2 = try I.tuple_I (ifw fw) with I.Refine -> raise Compose_refine in
            let extrema = N.sub_i x0 (N.div_i f'_x0 (N.mult_i N.two_i c)) in
            let low = if N.ge_i c N.zero_i then eval_par extrema p else N.min_i (eval_par i1 p) (eval_par i2 p) in
            let up = if N.le_i c N.zero_i then eval_par extrema p else N.max_i (eval_par i1 p) (eval_par i2 p) in
              ai (I.Int (low, up)) fw_comp 
          end
      | P.Cub (c, f''_x0, f'_x0, f_x0, x0) ->  
          begin
            let delta = fw_addC (N.minus_i x0) fw in
            let delta_square = fw_mul delta delta in
            let delta_cubic = fw_mul delta_square delta in
            let t_3 = fw_mulC c delta_cubic in
            let t_2 = fw_mulC f''_x0 delta_square in
            let t_1 = fw_mulC f'_x0 delta in
            let t_0 = f_x0 in
              fw_add t_3 (fw_add t_2 (fw_addC t_0 t_1))
          end
      | P.Minimax l ->
          begin
            let n = List.length l in
            let mon_idx = U.int_to_list n in
            let mon_list = List.map (P.p_pow  P.mkX) mon_idx in
            let summands = List.map2 P.pmulC mon_list l in
              mk_Pw (List.fold_left P.p_add (P.Pc N.zero_i) summands)
          end

    let string_approx a = let f = compose_fw_approx_for_eval fwX a in 
      match f with | P.Pw (p, _, _) -> P.string_of_pol p | _ -> "cannot print maxplus approx"

    let string_float_approx a prec = let f = compose_fw_approx_for_eval fwX a in
     let replace_x1_by_z s = Str.global_replace (Str.regexp ("x1")) "z" s in 
      match f with | P.Pw (p, _, _) -> replace_x1_by_z (P.string_of_pol_float p prec) | _ -> "cannot print maxplus approx"

    let rec string_fw prec = function
      | P.Pw (p, i, _) -> P.string_of_pol_float p prec
      | P.Fw  ((p1, p2), i, _) -> "(" ^ string_fw prec p1 ^ ") / (" ^ string_fw prec p2 ^ ")"
      | P.Min (fw_l, i, _) -> "Min [" ^ (U.concat_string_with_string (List.map (fun p -> string_fw prec p) fw_l) ";") ^ "]"
      | P.Max (fw_l, i, _) -> "Max [" ^ (U.concat_string_with_string (List.map (fun p -> string_fw prec p) fw_l) ";") ^ "]"
      | P.Plus ((fw1, fw2), i, _) ->   string_fw prec fw1 ^ " + " ^ string_fw prec fw2
      | P.Mult ((fw1, fw2), i, _) -> "(" ^  string_fw prec fw1 ^ ") * (" ^ string_fw prec fw2 ^ ")"
      | P.Minus (fw, i) ->  "-(" ^ string_fw prec fw ^ ")"
      | P.Sqrt (fw, i) -> "sqrt (" ^ string_fw prec fw ^ ")"
      | P.Comp ((a, fw), i, _) -> let f = compose_fw_approx_for_eval fw a in string_fw prec f
      | P.MaxMin ((f1, f2), i, _) -> "MaxMin [" ^ string_fw prec f1 ^ ", " ^ string_fw prec f2 ^ "]" 

    let eval_fw tbl tree = 
      let rec eval_fw_aux = function
        | P.Pw (p, _, _) -> P.eval_pol tbl p
        | P.Fw ((f1, f2), _, _) -> N.div_i (eval_fw_aux f1) (eval_fw_aux f2)
        | P.Max (fw_l, _, _) -> I.max_list (List.map (eval_fw_aux ) fw_l)
        | P.Min (fw_l, _, _) -> I.min_list (List.map (eval_fw_aux ) fw_l)
        | P.Plus ((f1, f2), _, _) -> N.add_i  (eval_fw_aux f1) (eval_fw_aux f2)
        | P.Mult ((f1, f2), _, _) -> N.mult_i (eval_fw_aux f1) (eval_fw_aux f2) 
        | P.Minus (fw, _) -> N.minus_i (eval_fw_aux fw)
        | P.Sqrt (fw, _) -> N.sqrt_i (eval_fw_aux fw)
        | P.Comp ((a, fw), _, _) -> eval_fw_aux (compose_fw_approx_for_eval fw a)
        | P.MaxMin ((f1, f2), _, _) -> (* TODO need interval for this...*)
            begin
              let e1, _ = eval_fw_aux f1, eval_fw_aux f2 in
              (*let ( * ) = N.mult_i in I.min_list [e1 * e3; e1 * e4; e2 * e3;
               * e2 * e4]*)
                e1
            end
      in
        eval_fw_aux tree

    let vars_of_fw p = 
      let vars = P.vars_of_pol in
      let sort = U.avoid_duplicata Numbers.T.Pos.compare_int in
      let concat = List.concat in
      let rec f = function
        | P.Pw (p, _, _) -> vars p
        | P.Fw ((f1, f2), _, _) 
        | P.Plus ((f1, f2), _, _) 
        | P.Mult ((f1, f2), _, _) | P.MaxMin ((f1, f2), _, _) -> 
            sort ((f f1) @ (f f2))
        | P.Min (fw_l, _, _) | P.Max (fw_l, _, _) -> sort (concat (List.map f fw_l))
        | P.Minus (fw, _) | P.Sqrt (fw, _) | P.Comp ((_, fw), _, _) -> sort (f fw)
      in
        sort (f p)
  end
