
module Make
  (N: Numeric.T) 
  (U: Tutils.T with type t = N.t) 
  (M: Mesh_interval.T with type num_i = N.t) 
  (I: Interval.T with type num_i = N.t) 
  (P: Polynomial.T with type num_i = N.t and type interval = I.interval)  
  = struct
  type num_i = N.t   
    let norm_box n = U.init_list n (N.zero_i, N.one_i)
    let proj_box box n = U.sub_list box 0 (n - 1)
    let ( + ), ( - ), ( * ), ( ^ ) = P.p_add, P.p_sub, P.p_mul, P.p_pow 
    let x1, x2, x3, x4, x5, x6, x7, x8 = P.mkX_i 1, P.mkX_i 2, P.mkX_i 3, P.mkX_i 4, P.mkX_i 5, P.mkX_i 6, P.mkX_i 7, P.mkX_i 8
    let p_scale = P.Pc (N.num_of_float 1.0) 
    let c2 = P.Pc (N.num_of_float (1.0/.3.0)) 
    let c1 =  P.Pc (N.num_of_float 2.1) 
    let tf =  P.Pc (N.num_of_float 25.) 
    let ten =  P.Pc (N.num_of_float 10.)
    let nine =  P.Pc (N.num_of_float 9.)
    let eight =  P.Pc (N.num_of_float 8.)
    let seven =  P.Pc (N.num_of_float 7.)
    let five = P.Pc (N.num_of_float 5.) 
    let fly_M =  P.Pc (N.num_of_float 6.3504)
                   (*
    let x7lonum = (N.num_of_float   45.2549447913)
    let x7upnum = (N.num_of_float  119.4209591728)
    let x8lonum = (N.num_of_float (-0.8911151602))
    let x8upnum = (N.num_of_float  0.8911151602)
                    *)  
    let x7lonum = (N.num_of_string "6369051138894131/140737488355328" (*"452547/10000"*) (*45.2549447913*))
    let x7upnum = (N.num_of_string "4201753875356269/35184372088832" (*"119422/1000"*) (*119.4209591728*))
    let x8lonum = (N.num_of_string "-1057175389494164672844691894289174619/1186328220906505547463893890380859375" (*"-8912/10000"*) (*( -0.8911151602)*))
    let x8upnum = (N.num_of_string "211432706167530215991237646613866716/237265644181301109492778778076171875" (*"8912/10000"*) (*0.8911151602*))
                    (*
    let x7lonum = (N.num_of_float 53.7496581185)
    let x7upnum = (N.num_of_float 74.0166682847)
    let x8lonum = (N.num_of_float ( -0.1571689981))
    let x8upnum = (N.num_of_float  0.2727259223)
                     *)
    let x7lo = P.Pc x7lonum
    let x7up = P.Pc x7upnum
    let x8lo = P.Pc x8lonum
    let x8up =  P.Pc x8upnum
    let eps = P.Pc (N.num_of_float 0.001) 
    let zero, one, two, three, four, six = P.Pc N.zero_i, P.Pc N.one_i, P.Pc N.two_i, P.Pc N.three_i, P.Pc N.four_i, P.Pc N.six_i 

    let fly_box6 = [(N.num_of_float 4., N.num_of_float 6.3504); (N.num_of_float 4., N.num_of_float 6.3504); (N.num_of_float 4., N.num_of_float 6.3504); (N.num_of_float 6.3504, N.num_of_float 8.); (N.num_of_float 4., N.num_of_float 6.3504) ; (N.num_of_float 4., N.num_of_float 6.3504)]
                     (*
    let fly_box6 = [(N.num_of_float 4.5876000000,N.num_of_float  5.1752000000) ; (N.num_of_float 4.5876000000,N.num_of_float  5.1752000000) ; (N.num_of_float 4.0000000000,N.num_of_float  4.5876000000) ; (N.num_of_float 6.3504000000,N.num_of_float  7.1752000000) ; (N.num_of_float 4.0000000000,N.num_of_float  4.5876000000) ; (N.num_of_float 4.0000000000,N.num_of_float  5.1752000000)]
                      *)
    let fly_box8 = fly_box6 @ [(x7lonum, x7upnum);(x8lonum, x8upnum)]
    let fly_box_proj = [(N.num_of_float 4., N.num_of_float 6.3504); (N.num_of_float 4., N.num_of_float 6.3504)] @ [(x7lonum, x7upnum);(x8lonum, x8upnum)]

    let ineqs_fly l = List.concat (List.map (fun x -> [x - four; fly_M - x]) l)
    let fly1 x1 x2 x3 x4 x5 x6 = x1 * x1 - x1 * x2 - x1 * x3 + two * x1 * x4 - x1 * x5 - x1 * x6 + x2 * x3 - x2 * x5 - x3 * x6 + x5 * x6
    let partial_delta_4 x1 x2 x3 x4 x5 x6 = x1 * x1 - x1 * x2 - x1 * x3 + two * x1 * x4 - x1 * x5 - x1 * x6 + x2 * x3 - x2 * x5 - x3 * x6 + x5 * x6 
    let delta_times_x1 () = P.p_opp (four * x1 * x1 * x1 * x4 - four * x1 * x1 * x2 * x4 - four * x1 * x1 * x2 * x5 + four * x1 * x1 * x2 * x6 - four * x1 * x1 * x3 * x4 + four * x1 * x1 * x3 * x5 - four * x1 * x1 * x3 * x6 + four * x1 * x1 * x4 * x4 - four * x1 * x1 * x4 * x5 - four * x1 * x1 * x4 * x6 + four * x1 * x2 * x2 * x5 + four * x1 * x2 * x3 * x4 - four * x1 * x2 * x3 * x5 - four * x1 * x2 * x3 * x6 - four * x1 * x2 * x4 * x5 + four * x1 * x2 * x5 * x5 - four * x1 * x2 * x5 * x6 + four * x1 * x3 * x3 * x6 - four * x1 * x3 * x4 * x6 - four * x1 * x3 * x5 * x6 + four * x1 * x3 * x6 * x6 + four * x1 * x4 * x5 * x6 )
    let fly78 pol x7 x8 = x7 * x8 - pol (* * P.Pc (N.num_of_float (1. /. 10.))*) (** P.Pc (N.num_of_float (1. /. 10.)) *)
    let fly7 pol x = (** P.Pc (N.inv_i (N.sqr_i x7upnum))*)  x * x - pol (**  P.Pc (N.inv_i (N.sqr_i x7upnum)) *)
    let delta_x x1 x2 x3 x4 x5 x6 = P.p_opp (x1 * x1 * x4 -  x1 * x2 * x4 -  x1 * x2 * x5 +  x1 * x2 * x6 -  x1 * x3 * x4 +  x1 * x3 * x5 -  x1 * x3 * x6 +  x1 * x4 * x4 -  x1 * x4 * x5 -  x1 * x4 * x6 +  x2 * x2 * x5 +  x2 * x3 * x4 -  x2 * x3 * x5 -  x2 * x3 * x6 -  x2 * x4 * x5 +  x2 * x5 * x5 -  x2 * x5 * x6 +  x3 * x3 * x6 -  x3 * x4 * x6 -  x3 * x5 * x6 +  x3 * x6 * x6 +  x4 * x5 * x6)
    let rho_x x1 x2 x3 x4 x5 x6 = P.p_opp (x1* x1* x4* x4)  -  x2* x2* x5* x5  -  x3* x3* x6* x6 + two* x1* x2* x4* x5 +  two* x1* x3* x4* x6 +  two* x2* x3* x5* x6

    let fly1_bnd = N.num_of_float 265.64 
    let minimax_3318 = (P.Pc (N.num_of_float 0.0000480411)) * x1 * x1 * x1 * x1 - (P.Pc (N.num_of_float 0.0013127370)) * x1 * x1 * x1 + (P.Pc (N.num_of_float 0.0160065562)) * x1 * x1 - (P.Pc (N.num_of_float 0.1560669721)) * x1 - (P.Pc (N.num_of_float 0.0000631397)) * x2 * x2 * x2 * x2 + (P.Pc (N.num_of_float 0.0017253115)) * x2 * x2 * x2 - (P.Pc (N.num_of_float 0.0210371882)) * x2 * x2 + (P.Pc (N.num_of_float 0.2051165918)) * x2 - (P.Pc (N.num_of_float 0.0000990115)) * x3 * x3 * x3 * x3 + (P.Pc (N.num_of_float 0.0023795728)) * x3 * x3 * x3 - (P.Pc (N.num_of_float 0.0255158436)) * x3 * x3 + (P.Pc (N.num_of_float 0.2187539989)) * x3 + (P.Pc (N.num_of_float 0.0000371816)) * x4 * x4 * x4 * x4 - (P.Pc (N.num_of_float 0.0014075711)) * x4 * x4 * x4 + (P.Pc (N.num_of_float 0.0237773253)) * x4 * x4 - (P.Pc (N.num_of_float 0.3211761861)) * x4 - (P.Pc (N.num_of_float 0.0000990115)) * x5 * x5 * x5 * x5 + (P.Pc (N.num_of_float 0.0023795728)) * x5 * x5 * x5 - (P.Pc (N.num_of_float 0.0255158436)) * x5 * x5 + (P.Pc (N.num_of_float 0.2187539989)) * x5 - (P.Pc (N.num_of_float 0.0000793960)) * x6 * x6 * x6 * x6 + (P.Pc (N.num_of_float 0.0020361569)) * x6 * x6 * x6 - (P.Pc (N.num_of_float 0.0232638067)) * x6 * x6 + (P.Pc (N.num_of_float 0.2121979335)) * x6 + (P.Pc (N.num_of_float 0.0525552453)) * x8 * x8 * x8 * x8 - (P.Pc (N.num_of_float 0.3282469979)) * x8 * x8 * x8 - (P.Pc (N.num_of_float 0.0014608685)) * x8 * x8 + (P.Pc (N.num_of_float 0.9999676144)) * x8 - (P.Pc (N.num_of_float 0.5897064493)) 
    (*
    let minimax_3318 = (P.Pc (N.num_of_float 0.0000409562)) * x1 * x1 * x1 * x1 - (P.Pc (N.num_of_float 0.0011803681)) * x1 * x1 * x1 + (P.Pc (N.num_of_float 0.0150876417)) * x1 * x1 - (P.Pc (N.num_of_float 0.1532602339)) * x1 - (P.Pc (N.num_of_float 0.0000538282)) * x2 * x2 * x2 * x2 + (P.Pc (N.num_of_float 0.0015513409)) * x2 * x2 * x2 - (P.Pc (N.num_of_float 0.0198294719)) * x2 * x2 + (P.Pc (N.num_of_float 0.2014277360)) * x2 - (P.Pc (N.num_of_float 0.0000538282)) * x3 * x3 * x3 * x3 + (P.Pc (N.num_of_float 0.0015513409)) * x3 * x3 * x3 - (P.Pc (N.num_of_float 0.0198294719)) * x3 * x3 + (P.Pc (N.num_of_float 0.2014277360)) * x3 + (P.Pc (N.num_of_float 0.0000304905)) * x4 * x4 * x4 * x4 - (P.Pc (N.num_of_float 0.0012234176)) * x4 * x4 * x4 + (P.Pc (N.num_of_float 0.0218784334)) * x4 * x4 - (P.Pc (N.num_of_float 0.3124818860)) * x4 - (P.Pc (N.num_of_float 0.0000538282)) * x5 * x5 * x5 * x5 + (P.Pc (N.num_of_float 0.0015513409)) * x5 * x5 * x5 - (P.Pc (N.num_of_float 0.0198294719)) * x5 * x5 + (P.Pc (N.num_of_float 0.2014277360)) * x5 - (P.Pc (N.num_of_float 0.0000538282)) * x6 * x6 * x6 * x6 + (P.Pc (N.num_of_float 0.0015513409)) * x6 * x6 * x6 - (P.Pc (N.num_of_float 0.0198294719)) * x6 * x6 + (P.Pc (N.num_of_float 0.2014277360)) * x6 + (P.Pc (N.num_of_float 0.0598854607)) * x8 * x8 * x8 * x8 - (P.Pc (N.num_of_float 0.2528164324)) * x8 * x8 * x8 - (P.Pc (N.num_of_float 0.0213881372)) * x8 * x8 + (P.Pc (N.num_of_float 0.9915982629)) * x8 - (P.Pc (N.num_of_float 0.5520619741))
*)
    let bench_3_3_las x1 x2 x3 x4 x5 x6 = 
      let pol = P.p_opp ((tf * ((x1 - two)^2)) + ((x2 - two)^2) + ((x3 - one)^2) + ((x4 - four)^2) + ((x5 - one)^2) + ((x6 - four)^2) - (P.Pc (N.num_of_float 138.))) in
      let q1 =  ((x3 - three)^2) + x4 - four in
      let q2 =  ((x5 - three)^2) + x6 - four in
      let q3 = two + (three * x2) - x1 in
      let q4 = two - x2 + x1 in
      let q5 = six - (x1 + x2) in
      let q6 = x1 + x2 - two in
      let ineqs = [q1; q2; q3; q4; q5; q6; x3 - one; five - x3; x4; six - x4; x5 - one; five - x5; x6; ten - x6; x1; x2] in
        pol, ineqs

    let half_disk () = 
      (* m = -0.5957
       * m_scale = -0.070902 *)
      let n = 2 in
      let eqs = [] in
       (* 
      let pol = (x1 * x1 ) + (x2 * x2) in        
      let box = norm_box n in
        *)
      let pol = ten * x1 * x1 + nine * x2 * x2 + six * x1 * x1 * x1 + seven * x2 * x2 * x2 - three * x1 - four * x2 in
      let box = [(N.num_of_float (-1.5), N.num_of_float 1.0); (N.num_of_float (-1.5), N.num_of_float 1.0)] in
      let ineqs = [] in
        n, pol, ineqs, eqs, box


    let half_disk_L1_deg2_k2 () = 
      (* m_scale = -0.07156 *)
      let n = 2 in
      let eqs = [] in
      let pol = (P.Pc (N.num_of_float 0.1333302900)) * x1 * x1 - (P.Pc (N.num_of_float 0.1629594100)) * x1 + (P.Pc (N.num_of_float 0.0370339700)) * x2 * x2 - (P.Pc (N.num_of_float 0.0567865500)) * x2 in
      let box = norm_box n in
      let ineqs = [] in
        n, pol, ineqs, eqs, box

    let half_disk_debug () = 
      let n = 2 in
      let eqs = [] in
      let pol = (P.Pc (N.num_of_float 0.6666666667)) * x1 * x1 * x1 - (P.Pc (N.num_of_float 0.7555555556)) * x1 * x1 + (P.Pc (N.num_of_float 0.1333333333)) * x1 + (P.Pc (N.num_of_float 0.7777777778)) * x2 * x2 * x2 - x2 * x2 + (P.Pc (N.num_of_float 0.2888888889)) * x2 -(   (P.Pc (N.num_of_float 0.1333302900)) * x1 * x1 - (P.Pc (N.num_of_float 0.1629594100)) * x1 + (P.Pc (N.num_of_float 0.0370339700)) * x2 * x2 - (P.Pc (N.num_of_float 0.0567865500)) * x2) in  
      let box = norm_box n in
      let ineqs = [] in
        n, pol, ineqs, eqs, box


    let partial_delta_pop () = 
      (* min = -0.416 *)
      let n = 6 in
      let eqs = [] in
      let pol, ineqs = partial_delta_4 x1 x2 x3 x4 x5 x6, [] in
      let box = fly_box6 in
        n, pol, ineqs, eqs, box


    let delta_pop () = 
      (* min = -0.416 for delta; min = ? for delta_times_x1 *)
      let n = 6 in
      let eqs = [] in
      let pol, ineqs =  delta_times_x1 (), [] in
      let box = fly_box6 in
        n, pol, ineqs, eqs, box

    let poston = Numbers.T.Translation.positive_n

    let proj_delta_pop () = 
      let n = 3 in
      let eqs = [] in
      let nums = List.map N.num_of_float [ 6.; 6.; 6.] in
      let vars = List.map poston [4; 5; 6] in
      let proj_p p = List.fold_right2 P.eval_pol_num vars nums p in
      let pol, ineqs =  proj_p (delta_x x1 x2 x3 x4 x5 x6), [] in
      let box = proj_box fly_box6 n in
        n, pol, ineqs, eqs, box


    let delta_pop_L1_deg2_k2 () = 
      (* min = -0.458 *)
      let n = 6 in
      let eqs = [] in
      let pol, ineqs = (P.Pc (N.num_of_float 0.2942097230)) * x1 * x2 + (P.Pc (N.num_of_float 0.2942097230)) * x1 * x3 - (P.Pc (N.num_of_float 0.1210944280)) * x1 * x4 + (P.Pc (N.num_of_float 0.2942097230)) * x1 * x5 + (P.Pc (N.num_of_float 0.2942097230)) * x1 * x6 + (P.Pc (N.num_of_float 0.1615951950)) * x1 - (P.Pc (N.num_of_float 0.2502220630)) * x2 * x2 + (P.Pc (N.num_of_float 0.1551453860)) * x2 * x3 + (P.Pc (N.num_of_float 0.1548859530)) * x2 * x4 + (P.Pc (N.num_of_float 0.0562704500)) * x2 * x5 + (P.Pc (N.num_of_float 0.2168258030)) * x2 * x6 + (P.Pc (N.num_of_float 0.4163873530)) * x2 - (P.Pc (N.num_of_float 0.2502220630)) * x3 * x3 + (P.Pc (N.num_of_float 0.1548859530)) * x3 * x4 + (P.Pc (N.num_of_float 0.2168258030)) * x3 * x5 + (P.Pc (N.num_of_float 0.0562704500)) * x3 * x6 + (P.Pc (N.num_of_float 0.4163873530)) * x3 - (P.Pc (N.num_of_float 0.1375772980)) * x4 * x4 + (P.Pc (N.num_of_float 0.1548859530)) * x4 * x5 + (P.Pc (N.num_of_float 0.1548859530)) * x4 * x6 - (P.Pc (N.num_of_float 0.0450799000)) * x4 - (P.Pc (N.num_of_float 0.2502220630)) * x5 * x5 + (P.Pc (N.num_of_float 0.1551453860)) * x5 * x6 + (P.Pc (N.num_of_float 0.4163873530)) * x5 - (P.Pc (N.num_of_float 0.2502220630)) * x6 * x6 + (P.Pc (N.num_of_float 0.4163873530)) * x6 - (P.Pc (N.num_of_float 0.0007415900)) - (P.Pc (N.num_of_float 0.3163215250)) * x1 * x1 , [] in
      let box = norm_box n in
        n, pol, ineqs, eqs, box

    let delta_pop_L1_deg2_k3 () = 
      (* m = -0.435 *)
      let n = 6 in
      let eqs = [] in
      let pol, ineqs = (P.Pc (N.num_of_float 0.2896689470)) * x1 * x2 + (P.Pc (N.num_of_float 0.2896689470)) * x1 * x3 - (P.Pc (N.num_of_float 0.1075968700)) * x1 * x4 + (P.Pc (N.num_of_float 0.2896689470)) * x1 * x5 + (P.Pc (N.num_of_float 0.2896689470)) * x1 * x6 + (P.Pc (N.num_of_float 0.1605157800)) * x1 - (P.Pc (N.num_of_float 0.2426364900)) * x2 * x2 + (P.Pc (N.num_of_float 0.1483851000)) * x2 * x3 + (P.Pc (N.num_of_float 0.1485227900)) * x2 * x4 + (P.Pc (N.num_of_float 0.0630683500)) * x2 * x5 + (P.Pc (N.num_of_float 0.2119080500)) * x2 * x6 + (P.Pc (N.num_of_float 0.4173834390)) * x2 - (P.Pc (N.num_of_float 0.2426364900)) * x3 * x3 + (P.Pc (N.num_of_float 0.1485227900)) * x3 * x4 + (P.Pc (N.num_of_float 0.2119080500)) * x3 * x5 + (P.Pc (N.num_of_float 0.0630683500)) * x3 * x6 + (P.Pc (N.num_of_float 0.4173834390)) * x3 - (P.Pc (N.num_of_float 0.1225137400)) * x4 * x4 + (P.Pc (N.num_of_float 0.1485227900)) * x4 * x5 + (P.Pc (N.num_of_float 0.1485227900)) * x4 * x6 - (P.Pc (N.num_of_float 0.0520930300)) * x4 - (P.Pc (N.num_of_float 0.2426364900)) * x5 * x5 + (P.Pc (N.num_of_float 0.1483851000)) * x5 * x6 + (P.Pc (N.num_of_float 0.4173834390)) * x5 - (P.Pc (N.num_of_float 0.2426364900)) * x6 * x6 + (P.Pc (N.num_of_float 0.4173834390)) * x6 - (P.Pc (N.num_of_float 0.0000653900)) - (P.Pc (N.num_of_float 0.3136681450)) * x1 * x1 , [] in
      let box = norm_box n in
        n, pol, ineqs, eqs, box

    let sofa () = 
      let n = 3 in
      let eqs = [] in
      let ineqs = [x3*x3*x3*x3*x3 + (x1*x1 + x2*x2*x2) (*;P.p_opp (x3*x3*x3*x3*x3 + (x1*x1 + x2*x2*x2))*)] in
      let box = norm_box n in
        n, x3, ineqs, eqs, box

    let g1g2 () = 
      let n = 8 in 
      let eqs = [] in 
      let ineqs = [x1 - x1 * x1; x2 - x2 * x2; x3 - x3 * x3; x4 - x4 * x4; x5 - x5*x5; x6 - x6 * x6; x7 - x7 * x7; x8 - x8 * x8] in
      let box = norm_box n in
        n, x1 * x2 * x3 * x4 * x5 * x6 * x7 * x8, ineqs, eqs, box

    let rat_test () = 
      let n = 2 in
      let eqs = [] in
      let box = [(N.zero_i, N.one_i); (N.num_of_string "0", N.num_of_string "1")] in
      let p = (one + x1 * x1)*x2 - (one + x1*x1) in
      let ineqs = [p; P.p_opp p] in
        n, x2, ineqs, eqs, box

    let rat_sqrt_test () = 
      let n = 4 in
      let eqs = [] in
      let box = [(N.zero_i, N.one_i); (N.zero_i, N.one_i); (N.num_of_string "8714094228390574423548577/8714094326467802506985472", N.num_of_string "120746035777844392378047325/69712754611742420055883776"); (N.num_of_string "16620815526189464806806990529656186655594936541067/28788098282300088972579795122146606445312500000000", N.num_of_string "14982707348403543627409513431485744015867904/4994235490600979341651715338230133056640625")] in
      let p = (one + x1 * x1 + x2) in
      let ineqs = [x3 * x3 - p; p - (x3 * x3); x3 * x4 - p; p - (x3 * x4)] in
        n, x4, ineqs, eqs, box

    let rat_lasserre () = 
      let n = 3 in
      let eqs = [] in
      let k = one in
      let num =   (x1 + x2) * (k*k + x1 * x1 * x2 * x2 + x1 * x1 * x1 * x1) - ((one + k * x2 * x2) * (x1 * x1 * x1 * x1 + x2 * x2 + two * k)) in
      let den = (x1*x1*x1*x1 + x2*x2 + two*k) * (k*k + x1*x1 + x1*x1*x2*x2 + x2*x2*x2*x2) in
      let box = [(N.num_of_float (-10.), N.num_of_float 10.0); (N.num_of_float (-10.), N.num_of_float 10.0); (N.num_of_float (-20.), N.num_of_float 10.0)] in
        n, x3, [x3 * den - num; num - (x3 * den)], eqs, box

    let rat_3318_pop () = 
      (* -0.608 for k = 2 and -0.445 for k = 3 *)
      let n = 8 in
      let eqs = [] in
      let p, q = (fly7 (delta_times_x1 ()) x7), (fly78 (partial_delta_4 x1 x2 x3 x4 x5 x6  ) x7 x8) in
      let pol, ineqs =   x8, [p;P.p_opp p; q; P.p_opp q] in
      let box = fly_box8 in
        n, pol, ineqs, eqs, box

    let rat_3318_proj () = 
      (*  *)
      let n = 4 in
      let eqs = [] in
      let nums = List.map N.num_of_float [ 5.; 7.; 5.; 5.] in
      let vars = List.map poston [3; 4; 5; 6] in
      let proj_p p = List.fold_right2 P.eval_pol_num vars nums p in
      let proj7, proj78 =  proj_p (delta_times_x1 ()), proj_p (partial_delta_4 x1 x2 x3 x4 x5 x6 ) in
        U.debug (P.string_of_pol proj7); U.debug (P.string_of_pol proj78);
       (* 
        let proj7 = (P.Pc (N.num_of_float 64.0000000000)) * x1 * x1 - (P.Pc (N.num_of_float 1024.0000000000)) * x1 + (P.Pc (N.num_of_float 64.0000000000)) * x2 * x2 - (P.Pc (N.num_of_float 1024.0000000000)) * x2 + (P.Pc (N.num_of_float 4096.0000000000)) in
        let proj78 = x1 * x2 - (P.Pc (N.num_of_float 8.0000000000)) * x1 - (P.Pc (N.num_of_float 8.0000000000)) * x2 + (P.Pc (N.num_of_float 64.0000000000)) in
        *)
      let p, q = P.p_opp (fly7 proj7 x3), P.p_opp (fly78 proj78 x3 x4) in
      let pol, ineqs = x4, [P.p_opp p;p; q; P.p_opp q] in
      let box = fly_box_proj in
        n, pol, ineqs, eqs, box


    let rat_rad_proj () = 
      (*  *)
      let n = 3 in
      let eqs = [] in
      let nums = List.map N.num_of_float [ 8.; 8.; 8.; 8.] in
      let vars = List.map poston [3; 4; 5; 6] in
      let proj_p p = List.fold_right2 P.eval_pol_num vars nums p in
      let projnum, projden =  proj_p (rho_x x1 x2 x3 x4 x5 x6), proj_p (delta_x x1 x2 x3 x4 x5 x6 ) in
        U.debug (P.string_of_pol projnum); U.debug (P.string_of_pol projden);       
      let pol, ineqs = x3, [projnum - x3 * projden; x3 * projden - projnum] in
      let box = [(N.four_i, N.num_of_float 8.); (N.four_i, N.num_of_float 8.); (N.zero_i, N.num_of_float 100.)] in
        n, pol, ineqs, eqs, box


     let rat_3318_L1_deg2_k2 () = 
       (* -1.1704 *)
      let n = 6 in
      let eqs = [] in
      let pol, ineqs = ( (P.Pc (N.num_of_float 0.0053358317)) * x1 * x1 + (P.Pc (N.num_of_float 0.0028288811)) * x1 * x2 + (P.Pc (N.num_of_float 0.0028288811)) * x1 * x3 - (P.Pc (N.num_of_float 0.0039988301)) * x1 * x4 + (P.Pc (N.num_of_float 0.0028288811)) * x1 * x5 + (P.Pc (N.num_of_float 0.0028288811)) * x1 * x6 - (P.Pc (N.num_of_float 0.0215411513)) * x1 - (P.Pc (N.num_of_float 0.0137725646)) * x2 * x2 - (P.Pc (N.num_of_float 0.0038586309)) * x2 * x3 + (P.Pc (N.num_of_float 0.0391952460)) * x2 * x4 - (P.Pc (N.num_of_float 0.0344577778)) * x2 * x5 - (P.Pc (N.num_of_float 0.0118744257)) * x2 * x6 + (P.Pc (N.num_of_float 0.0197744583)) * x2 - (P.Pc (N.num_of_float 0.0137725646)) * x3 * x3 + (P.Pc (N.num_of_float 0.0391952460)) * x3 * x4 - (P.Pc (N.num_of_float 0.0118744257)) * x3 * x5 - (P.Pc (N.num_of_float 0.0344577778)) * x3 * x6 + (P.Pc (N.num_of_float 0.0197744583)) * x3 - (P.Pc (N.num_of_float 0.0392851638)) * x4 * x4 + (P.Pc (N.num_of_float 0.0391952460)) * x4 * x5 + (P.Pc (N.num_of_float 0.0391952460)) * x4 * x6 - (P.Pc (N.num_of_float 0.0475110986)) * x4 - (P.Pc (N.num_of_float 0.0137725646)) * x5 * x5 - (P.Pc (N.num_of_float 0.0038586309)) * x5 * x6 + (P.Pc (N.num_of_float 0.0197744583)) * x5 - (P.Pc (N.num_of_float 0.0137725646)) * x6 * x6 + (P.Pc (N.num_of_float 0.0197744583)) * x6 - (P.Pc (N.num_of_float 0.0246431694))  )  , [] in
      let box = fly_box6 in
        n, pol, ineqs, eqs, box
                          
    let rat_3318_L1_deg2_k3 () = 
      (* -0.4478238767 *)
      let n = 6 in
      let eqs, ineqs = [], [] in
      let pol = (P.Pc (N.num_of_float 0.0016533775)) * x1 * x1 - (P.Pc (N.num_of_float 0.0053460727)) * x1 * x2 - (P.Pc (N.num_of_float 0.0053460727)) * x1 * x3 + (P.Pc (N.num_of_float 0.0032290734)) * x1 * x4 - (P.Pc (N.num_of_float 0.0053460727)) * x1 * x5 - (P.Pc (N.num_of_float 0.0053460727)) * x1 * x6 + (P.Pc (N.num_of_float 0.1325378414)) * x1 - (P.Pc (N.num_of_float 0.0001714069)) * x2 * x2 + (P.Pc (N.num_of_float 0.0218503548)) * x2 * x3 - (P.Pc (N.num_of_float 0.0038485842)) * x2 * x4 - (P.Pc (N.num_of_float 0.0099265991)) * x2 * x5 + (P.Pc (N.num_of_float 0.0103840795)) * x2 * x6 - (P.Pc (N.num_of_float 0.1205848557)) * x2 - (P.Pc (N.num_of_float 0.0001714069)) * x3 * x3 - (P.Pc (N.num_of_float 0.0038485842)) * x3 * x4 + (P.Pc (N.num_of_float 0.0103840795)) * x3 * x5 - (P.Pc (N.num_of_float 0.0099265991)) * x3 * x6 - (P.Pc (N.num_of_float 0.1205848557)) * x3 - (P.Pc (N.num_of_float 0.0043325888)) * x4 * x4 - (P.Pc (N.num_of_float 0.0038485842)) * x4 * x5 - (P.Pc (N.num_of_float 0.0038485842)) * x4 * x6 + (P.Pc (N.num_of_float 0.2586490558)) * x4 - (P.Pc (N.num_of_float 0.0001714069)) * x5 * x5 + (P.Pc (N.num_of_float 0.0218503548)) * x5 * x6 - (P.Pc (N.num_of_float 0.1205848557)) * x5 - (P.Pc (N.num_of_float 0.0001714069)) * x6 * x6 - (P.Pc (N.num_of_float 0.1205848557)) * x6 - (P.Pc (N.num_of_float 0.0987874814)) in
      let box = fly_box6 in
        n, pol, ineqs, eqs, box

    let rat_3318_test2 () (* deg2 k2 *) = 
     (* worst difference value: 0.8023665768 *) 
      let n = 8 in
      let p, q = P.p_opp (fly7 (delta_times_x1 ()) x7), P.p_opp (fly78 (partial_delta_4 x1 x2 x3 x4 x5 x6  ) x7 x8) in
      let pol, ineqs = P.p_opp ( x8  -( (P.Pc (N.num_of_float 0.0053358317)) * x1 * x1 + (P.Pc (N.num_of_float 0.0028288811)) * x1 * x2 + (P.Pc (N.num_of_float 0.0028288811)) * x1 * x3 - (P.Pc (N.num_of_float 0.0039988301)) * x1 * x4 + (P.Pc (N.num_of_float 0.0028288811)) * x1 * x5 + (P.Pc (N.num_of_float 0.0028288811)) * x1 * x6 - (P.Pc (N.num_of_float 0.0215411513)) * x1 - (P.Pc (N.num_of_float 0.0137725646)) * x2 * x2 - (P.Pc (N.num_of_float 0.0038586309)) * x2 * x3 + (P.Pc (N.num_of_float 0.0391952460)) * x2 * x4 - (P.Pc (N.num_of_float 0.0344577778)) * x2 * x5 - (P.Pc (N.num_of_float 0.0118744257)) * x2 * x6 + (P.Pc (N.num_of_float 0.0197744583)) * x2 - (P.Pc (N.num_of_float 0.0137725646)) * x3 * x3 + (P.Pc (N.num_of_float 0.0391952460)) * x3 * x4 - (P.Pc (N.num_of_float 0.0118744257)) * x3 * x5 - (P.Pc (N.num_of_float 0.0344577778)) * x3 * x6 + (P.Pc (N.num_of_float 0.0197744583)) * x3 - (P.Pc (N.num_of_float 0.0392851638)) * x4 * x4 + (P.Pc (N.num_of_float 0.0391952460)) * x4 * x5 + (P.Pc (N.num_of_float 0.0391952460)) * x4 * x6 - (P.Pc (N.num_of_float 0.0475110986)) * x4 - (P.Pc (N.num_of_float 0.0137725646)) * x5 * x5 - (P.Pc (N.num_of_float 0.0038586309)) * x5 * x6 + (P.Pc (N.num_of_float 0.0197744583)) * x5 - (P.Pc (N.num_of_float 0.0137725646)) * x6 * x6 + (P.Pc (N.num_of_float 0.0197744583)) * x6 - (P.Pc (N.num_of_float 0.0246431694))  )) , [P.p_opp p;p; q; P.p_opp q] in
      let eqs = [] in
      let box = fly_box8 in
        n, pol, ineqs, eqs, box

 let rat_3318_test3 ()  (* deg2 k3 *)  =
     (* worst difference value: 0.37083 *) 
      let n = 8 in
      let p, q = P.p_opp (fly7 (delta_times_x1 ()) x7), P.p_opp (fly78 (partial_delta_4  x1 x2 x3 x4 x5 x6    ) x7 x8) in
      let pol, ineqs =  ( x8  -( (P.Pc (N.num_of_float 0.0016533775)) * x1 * x1 - (P.Pc (N.num_of_float 0.0053460727)) * x1 * x2 - (P.Pc (N.num_of_float 0.0053460727)) * x1 * x3 + (P.Pc (N.num_of_float 0.0032290734)) * x1 * x4 - (P.Pc (N.num_of_float 0.0053460727)) * x1 * x5 - (P.Pc (N.num_of_float 0.0053460727)) * x1 * x6 + (P.Pc (N.num_of_float 0.1325378414)) * x1 - (P.Pc (N.num_of_float 0.0001714069)) * x2 * x2 + (P.Pc (N.num_of_float 0.0218503548)) * x2 * x3 - (P.Pc (N.num_of_float 0.0038485842)) * x2 * x4 - (P.Pc (N.num_of_float 0.0099265991)) * x2 * x5 + (P.Pc (N.num_of_float 0.0103840795)) * x2 * x6 - (P.Pc (N.num_of_float 0.1205848557)) * x2 - (P.Pc (N.num_of_float 0.0001714069)) * x3 * x3 - (P.Pc (N.num_of_float 0.0038485842)) * x3 * x4 + (P.Pc (N.num_of_float 0.0103840795)) * x3 * x5 - (P.Pc (N.num_of_float 0.0099265991)) * x3 * x6 - (P.Pc (N.num_of_float 0.1205848557)) * x3 - (P.Pc (N.num_of_float 0.0043325888)) * x4 * x4 - (P.Pc (N.num_of_float 0.0038485842)) * x4 * x5 - (P.Pc (N.num_of_float 0.0038485842)) * x4 * x6 + (P.Pc (N.num_of_float 0.2586490558)) * x4 - (P.Pc (N.num_of_float 0.0001714069)) * x5 * x5 + (P.Pc (N.num_of_float 0.0218503548)) * x5 * x6 - (P.Pc (N.num_of_float 0.1205848557)) * x5 - (P.Pc (N.num_of_float 0.0001714069)) * x6 * x6 - (P.Pc (N.num_of_float 0.1205848557)) * x6 - (P.Pc (N.num_of_float 0.0987874814))    )) , [P.p_opp p;p; q; P.p_opp q] in
      let eqs = [] in
      let box = fly_box8 in
        n, pol, ineqs, eqs, box

    let hard_3318_pop () = 
      let n = 8 in
      let eqs = [] in
      let p, q = P.p_opp (fly7 (delta_times_x1 ()) x7), P.p_opp (fly78 (partial_delta_4  x1 x2 x3 x4 x5 x6    ) x7 x8) in
      let pol, ineqs =  minimax_3318,  (*P.p_opp x8*)(*  (x7 - x7lo)::(x7up - x7)::(x8 - x8lo)::(x8up - x8):: *) (*(x1^2) + (x2^2) - (two * x1 * x2) *)(*fly1 x1 x2 x3 x4 x5 x6,*) (* (x4 - fly_M)::(eight - x4):: (ineqs_fly [x1; x2; x3; x5; x6])*) [p; q] in
      let box = fly_box8(* [(N.num_of_float 0., N.num_of_float 1.0); (N.num_of_float 0., N.num_of_float 1.0)]*) in
        n, pol, ineqs, eqs, box
    (*
      let pol =  p_scale * ((((x^2) + one )^2) + (((y^2) + one)^2) + (((x + y + one)^2)) - three ) in
         *)
        (*
      let pol = eps * ((x^2) + (y^2)) + (four * (x^2)) - (c1 * (x^4)) + c2 * (x^6) + (x * y) - (four * (y^2)) + (four * (y^4)) in
         *)
       (* 
      let pol = (x^2) * (y^2) * ((x^2) + (y^2) - one) in 
        *)
        (*
      let pol = P.p_opp ((x + y -z)^2) in
         *)
        (*
      let q = three - ((x^2) + (y^2) + (z^2)) in
         *)
        (*
      let eqs = [(fly7 (delta_times_x1 ()) x7); P.p_opp (fly78 (partial_delta_4 ()) x7 x8)] in
         *)

end
