module Make
  (N: Numeric.T) 
  (I: Interval.T with type num_i = N.t) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval)  
  (Nq: Numeric.T) 
  (Iq: Interval.T with type num_i = Nq.t) 
  (Pq: Polynomial.T with type num_i = Nq.t and type interval = Iq.interval)  
  = struct

    let num_of_numq q = N.num_of_float (Nq.float_of_num q)
    (* conversions from floating points to numbers for certification *)
    let float_to_num i : Nq.t = Nq.num_of_float (N.float_of_num i)
    let float_to_num_box i : Nq.t = Nq.num_of_float_exact (N.float_of_num i) (*Nq.num_of_rat (N.zarith_rat_of_num i)*)
    let box_float_to_num box = List.map (fun (b1, b2) -> float_to_num_box b1, float_to_num_box b2) box

    let array_float_to_num a = Array.map float_to_num_box a
    let matrix_float_to_num a = Array.map array_float_to_num a  
    let array_to_float = Array.map num_of_numq
    let matrix_to_float = Array.map array_to_float
    let matrix_list_to_float = List.map matrix_to_float

    let block_eigs_float_to_num a = Array.map (fun (e, ev) -> array_float_to_num e,matrix_float_to_num ev) a

    let rec pol_float_to_num conv = function
      | P.Pc c -> Pq.Pc (conv c)
      | P.Pinj (i, pol) -> Pq.Pinj (i, pol_float_to_num conv pol)
      | P.PX (p, j, q) -> Pq.PX (pol_float_to_num conv p, j, pol_float_to_num conv  q)

    let rec pol_num_to_float conv = function
      | Pq.Pc c -> P.Pc (conv c)
      | Pq.Pinj (i, pol) -> P.Pinj ( i, pol_num_to_float conv  pol)
      | Pq.PX (p, j, q) -> P.PX (pol_num_to_float conv  p, j, pol_num_to_float conv  q)

    let pol_to_float = pol_num_to_float num_of_numq 
    let pol_to_num = pol_float_to_num float_to_num_box
  end


