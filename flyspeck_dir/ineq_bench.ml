(************************************************************************)
(* ineq_bench.ml:  perform benchmarks to compare evaluation of flyspeck *)
(* functions between OCaml interpretor and mk_ast hand-made interpretor *)
(*                                                                      *)
(*  Victor Magron (Lix/Inria)                                           *)
(*                                                                      *)
(************************************************************************)

open Ineq_final

let main () =

  let ineq =  l_QITNPEA1_2_1_9063653052_ineq in
  let n_eval = int_of_string (Sys.argv.(1)) in  
  let i = ref 0 in
  let prev = Unix.gettimeofday() in
  while (!i<n_eval) do
    let _ = ineq 2.4272 2. 2.6508 2.4272 2.  2.  in
    i:=!i+1;
  done;
  let current = Unix.gettimeofday() in
  Printf.printf "Evaluation time is: %f\n" (current -. prev);
  exit 0 

;;
let _ = main () in ()
(* Local Variables: *)
(* coding: utf-8 *)
(* End: *)
