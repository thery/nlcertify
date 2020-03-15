let pi = (4. *. atan(1.));;

        let acs x = acos x;;

        let asn x = asin x;;

	let atn x = atan x;;
let atn2 (x,y)= atan2 x y ;;
let abc_of_quadratic f = 
  let c = f (0.) in
  let  p = f (1.) in
  let n = f ( -.  1.) in
  ((p +.  n) /. (2.)  -.  c, (p  -. n) /. (2.), c);;
let quadratic_root_plus (a, b, c) =
      (  -.  b +.  sqrt(b ** 2.  -.  4. *.  a *.  c)) /.  (2. *.  a);;
let sqrt8 = sqrt (8.) ;;
let sqrt2 = sqrt (2.) ;;
let sqrt3 = sqrt(3.);;
let delta_x x1 x2 x3 x4 x5 x6 =
        x1*. x4*. ( -. x1 +.  x2 +.  x3  -. x4 +.  x5 +.  x6) +. 
        x2*. x5*. (x1  -.  x2 +.  x3 +.  x4  -. x5 +.  x6) +. 
        x3*. x6*. (x1 +.  x2  -.  x3 +.  x4 +.  x5  -.  x6)
         -. x2*. x3*. x4  -.  x1*. x3*. x5  -.  x1*. x2*. x6  -. x4*. x5*. x6;;
let delta_y y1 y2 y3 y4 y5 y6 =
    delta_x (y1*. y1) (y2*. y2) (y3*. y3) (y4*. y4) (y5*. y5) (y6*. y6);;
let edge_flat y1 y2 y3 y5 y6 = 
 sqrt(quadratic_root_plus (abc_of_quadratic (
   fun x4 ->    -.  delta_x (y1*. y1) (y2*. y2)  (y3*. y3)  x4 (y5*. y5)  (y6*. y6))));;
let edge_flat2_x x1 x2 x3 x4 x5 x6 =
  (edge_flat (sqrt x1) (sqrt x2) (sqrt x3) (sqrt x5) (sqrt x6)) ** 2.;;
let delta_x4 x1 x2 x3 x4 x5 x6
        =   -.  x2*.  x3  -.   x1*.  x4 +.  x2*.  x5
        +.  x3*.  x6  -.   x5*.  x6 +.  x1*.  ( -.  x1 +.   x2 +.   x3  -.   x4 +.   x5 +.   x6);;
let ups_x x1 x2 x6 =
     -. x1*. x1  -.  x2*. x2  -.  x6*. x6
    +.  2. *. x1*. x6 +.  2. *. x1*. x2 +.  2. *. x2*. x6;;
let eta_x x1 x2 x3 =
        (sqrt ((x1*. x2*. x3) /. (ups_x x1 x2 x3)))
        ;;
let eta_y y1 y2 y3 =
                let x1 = y1*. y1 in
                let x2 = y2*. y2 in
                let x3 = y3*. y3 in
                eta_x x1 x2 x3;;
let rho_x x1 x2 x3 x4 x5 x6 =
         -. x1*. x1*. x4*. x4  -.  x2*. x2*. x5*. x5  -.  x3*. x3*. x6*. x6 +. 
        (2.)*. x1*. x2*. x4*. x5 +.  (2.)*. x1*. x3*. x4*. x6 +.  (2.)*. x2*. x3*. x5*. x6;;
let dih_x x1 x2 x3 x4 x5 x6 =
       let d_x4 = delta_x4 x1 x2 x3 x4 x5 x6 in
       let d = delta_x x1 x2 x3 x4 x5 x6 in
          pi/.2. +.  atn(-.d_x4 /. (sqrt ((4.) *.  x1 *.  d)));;
let dih_y y1 y2 y3 y4 y5 y6 = dih_x (y1*. y1) (y2*. y2) (y3*. y3) (y4*. y4) (y5*. y5) (y6*. y6);;
let dih2_y y1 y2 y3 y4 y5 y6 =
        dih_y y2 y1 y3 y5 y4 y6;;
let dih3_y y1 y2 y3 y4 y5 y6 =
        dih_y y3 y1 y2 y6 y4 y5;;
let dih2_x x1 x2 x3 x4 x5 x6 =
        dih_x x2 x1 x3 x5 x4 x6;;
let dih3_x x1 x2 x3 x4 x5 x6 =
        dih_x x3 x1 x2 x6 x4 x5;;
let sol_y y1 y2 y3 y4 y5 y6 =
        (dih_y y1 y2 y3 y4 y5 y6) +. 
        (dih_y y2 y3 y1 y5 y6 y4) +.   (dih_y y3 y1 y2 y6 y4 y5)  -.   pi;;
let interp x1 y1 x2 y2 x = y1 +.  (x  -.  x1) *.  (y2 -.  y1) /. (x2 -. x1);;
let const1 = sol_y (2.) (2.) (2.) (2.) (2.) (2.)  /.  pi;;
let ly y = interp (2.) (1.) (2.52) (0.) y;;
let rho y = 1. +.  const1  -.  const1*.  ly y;;
let rhazim y1 y2 y3 y4 y5 y6 = rho y1 *.  dih_y y1 y2 y3 y4 y5 y6;;
let lnazim y1 y2 y3 y4 y5 y6 = ly y1 *.  dih_y y1 y2 y3 y4 y5 y6;;
let taum y1 y2 y3 y4 y5 y6 = sol_y y1 y2 y3 y4 y5 y6 *.  (1. +.  const1)  -.  const1 *.  (lnazim y1 y2 y3 y4 y5 y6 +.  lnazim y2 y3 y1 y5 y6 y4 +.  lnazim y3 y1 y2 y6 y4 y5);;
let node2_y f y1 y2 y3 y4 y5 y6 = f y2 y3 y1 y5 y6 y4;;
let node3_y f y1 y2 y3 y4 y5 y6 = f y3 y1 y2 y6 y4 y5;;
let rhazim2 = node2_y rhazim;;
let rhazim3 = node3_y rhazim;;
let dih4_y y1 y2 y3 y4 y5 y6 = dih_y y4 y2 y6 y1 y5 y3;;
let dih5_y y1 y2 y3 y4 y5 y6 = dih_y y5 y1 y6 y2 y4 y3;;
let dih6_y y1 y2 y3 y4 y5 y6 = dih_y y6 y1 y5 y3 y4 y2;;
let tauq y1 y2 y3 y4 y5 y6 y7 y8 y9 = taum y1 y2 y3 y4 y5 y6 +.  taum y7 y2 y3 y4 y8 y9;;
let vol_x x1 x2 x3 x4 x5 x6 =
        (sqrt (delta_x x1 x2 x3 x4 x5 x6)) /.  (12.);;
let arclength a b c =
        pi /. (2.) +.  (atn2( (sqrt (ups_x (a*. a) (b*. b) (c*. c))),(c*. c  -.  a*. a   -. b*. b)));;
let volR a b c =
        (sqrt (a*. a*. (b*. b -. a*. a)*. (c*. c -. b*. b))) /. (6.);;
let rad2_x x1 x2 x3 x4 x5 x6 =
        (rho_x x1 x2 x3 x4 x5 x6) /. ((delta_x x1 x2 x3 x4 x5 x6)*. (4.));;
let h0 = 1.26;;
let sol0 = 3. *.  acs (1.  /.  3.)   -.  pi;;
let tau0 = 4. *.  pi  -.  20. *.  sol0;;
let mm1 = sol0 *.  sqrt(8.) /. tau0;;
let mm2 = (6. *.  sol0  -.  pi) *.  sqrt(2.)  /. (6. *.  tau0);;
let hplus = 1.3254;;
let marchal_quartic h = 
    (sqrt(2.) -. h)*. (h -.  hplus )*. (9.*. (h ** 2.)  -.  17.*. h +.  3.) /. 
      ((sqrt(2.)  -.  1.)*.  5. *. (hplus  -.  1.));;
let lmfun h = if (h<=h0) then (h0  -.  h) /. (h0  -.  1.) else 0.;;
let lfun h =  (h0  -.  h) /. (h0  -.  1.);;
let flat_term y = sol0 *.  (y  -.  2. *.  h0) /. (2. *.  h0  -.  2.);;
let hminus = 1.2136;;
let y_of_x fx y1 y2 y3 y4 y5 y6 = 
    fx (y1*. y1) (y2*. y2) (y3*. y3) (y4*. y4) (y5*. y5) (y6*. y6);;
let rad2_y = y_of_x rad2_x;;
let delta4_y = y_of_x delta_x4;;
let vol_y = y_of_x vol_x;;
let vol4f y1 y2 y3 y4 y5 y6 f = 
   (2. *.  mm1  /.  pi) *.  
               (sol_y y1 y2 y3 y4 y5 y6 +. 
		  sol_y y1 y5 y6 y4 y2 y3 +. 
		  sol_y y4 y5 y3 y1 y2 y6 +. 
		  sol_y y4 y2 y6 y1 y5 y3)
	        -.  (8. *.  mm2 /. pi) *. 
	       (f(y1 /.  2.)*.  dih_y y1 y2 y3 y4 y5 y6 +. 
		  f(y2 /.  2.)*.  dih_y y2 y3 y1 y5 y6 y4 +. 
		  f(y3 /.  2.)*.  dih_y y3 y1 y2 y6 y4 y5 +. 
		  f(y4 /.  2.)*.  dih_y y4 y3 y5 y1 y6 y2 +. 
		  f(y5 /.  2.)*.  dih_y y5 y1 y6 y2 y4 y3 +. 
		  f(y6 /.  2.)*.  dih_y y6 y1 y5 y3 y4 y2);;
let gamma4f y1 y2 y3 y4 y5 y6 f =
    vol_y y1 y2 y3 y4 y5 y6  -.  vol4f  y1 y2 y3 y4 y5 y6 f;;
let gamma4fgcy y1 y2 y3 y4 y5 y6 f =
   gamma4f y1 y2 y3 y4 y5 y6 f;;
let vol3r y1 y2 y3 r = vol_y r r r y1 y2 y3;;
let vol3f y1 y2 y3 r f = (2. *.  mm1  /.  pi) *.  
        (sol_y y1 y2 r r r y3 +. 
	   sol_y y2 y3 r r r y1 +. 
	   sol_y y3 y1 r r r y2)
     -.  (8. *.  mm2 /. pi) *. 
       (f(y1 /.  2.)*.  dih_y y1 y2 r r r y3 +. 
	  f(y2 /.  2.)*.  dih_y y2 y3 r r r y1 +. 
	  f(y3 /.  2.)*.  dih_y y3 y1 r r r y2);;
let gamma3f y1 y2 y3 r f = vol3r y1 y2 y3 r  -.  vol3f y1 y2 y3 r f;;
let vol2r y r = 2. *.  pi *.  (r*. r  -.  (y  /.  (2.)) ** 2.) /. (3.);;
let vol2f y r f =  (2. *.  mm1  /.  pi) *.   2. *. pi*.  (1. -.  y /.  (r *.  2.))
     -.  (8. *.  mm2 /. pi) *.  2. *.  pi *.  f (y /.  (2.)) ;;
let norm2hh y1 y2 y3 y4 y5 y6 = 
    (y1 -.  hminus  -.  hplus) ** 2. +.  (y2  -.  2.) ** 2. +.  (y3  -.  2.) ** 2. +.  (y4  -.  2.) ** 2. 
     +.  (y5  -.  2.) ** 2. +.  (y6  -.  2.) ** 2.;;
let  bump h = 0.005*. (1.  -.  ((h -.  h0) ** 2.) /. ((hplus  -.  h0) ** 2.));;
let critical_edge_y y = ((2.*. hminus <= y)  && (y <= 2. *. hplus));;
let beta_bump_y y1 y2 y3 y4 y5 y6 =
  (if critical_edge_y y1 then 1. else 0.) *. 
  (if critical_edge_y y2 then 0. else 1.) *. 
  (if critical_edge_y y3 then 0. else 1.) *. 
  (if critical_edge_y y4 then 1. else 0.) *. 
  (if critical_edge_y y5 then 0. else 1.) *. 
  (if critical_edge_y y6 then 0. else 1.) *.  
    (bump (y1 /.  2.)  -.  bump (y4  /.  2.));;
let beta_bump_force_y y1 y2 y3 y4 y5 y6 =
    (bump (y1 /.  2.)  -.  bump (y4  /.  2.));;
let wtcount3_y y1 y2 y3  = 
  (if critical_edge_y y1 then 1. else 0.) +. 
  (if critical_edge_y y2 then 1. else 0.) +. 
  (if critical_edge_y y3 then 1. else 0.) ;;
let wtcount6_y y1 y2 y3 y4 y5 y6 = wtcount3_y y1 y2 y3 +.  wtcount3_y y4 y5 y6;;
let a_spine5 = 0.0560305;;
let b_spine5 =  -.  0.0445813;;
let beta_bump_lb =  -.  0.005;;
let gamma23f y1 y2 y3 y4 y5 y6 w1 w2 r f =
      (gamma3f y1 y2 y6 r f  /.   w1 +.  gamma3f y1 y3 y5 r f  /.   w2
      +.  (dih_y y1 y2 y3 y4 y5 y6  -.  dih_y y1 y2 r r r y6  -.  dih_y y1 y3 r r r y5) *.  (vol2r y1 r  -.  vol2f y1 r f) /. (2. *.  pi)) ;;
let gamma23f_126_03 y1 y2 y3 y4 y5 y6 w1 r f =
      (gamma3f y1 y2 y6 r f  /.   w1 
      +.  (dih_y y1 y2 y3 y4 y5 y6  -.  dih_y y1 y2 r r r y6  -.  0.03) *.  (vol2r y1 r  -.  vol2f y1 r f) /. (2. *.  pi)) ;;
let gamma23f_red_03 y1 y2 y3 y4 y5 y6 r f =
       (dih_y y1 y2 y3 y4 y5 y6  -.  2. *.  0.03) *.  (vol2r y1 r  -.  vol2f y1 r f) /. (2. *.  pi);;
let pathL (a,b) = (a,(a+. b) /.  2.);;
let pathR (a,b) = ((a+. b) /.  2.,b);;
let rotate2 f x1 x2 x3 x4 x5 x6 = 
  f x2 x3 x1 x5 x6 x4;;
let rotate3 f x1 x2 x3 x4 x5 x6 = 
  f x3 x1 x2 x6 x4 x5;;
let rotate4 f x1 x2 x3 x4 x5 x6 = 
  f x4 x2 x6 x1 x5 x3;;
let rotate5 f x1 x2 x3 x4 x5 x6 = 
  f x5 x3 x4 x2 x6 x1;;
let rotate6 f x1 x2 x3 x4 x5 x6 = 
  f x6 x1 x5 x3 x4 x2;;
let sqrt3 = sqrt(3.);;
let rad2_y = y_of_x rad2_x;;
let rhazim_x x1 x2 x3 x4 x5 x6 = 
  rhazim (sqrt x1) (sqrt x2) (sqrt x3) (sqrt x4) (sqrt x5) (sqrt x6);;
let rhazim2_x x1 x2 x3 x4 x5 x6 = 
  rhazim2 (sqrt x1) (sqrt x2) (sqrt x3) (sqrt x4) (sqrt x5) (sqrt x6);;
let rhazim3_x x1 x2 x3 x4 x5 x6 = 
  rhazim3 (sqrt x1) (sqrt x2) (sqrt x3) (sqrt x4) (sqrt x5) (sqrt x6);;
let matan x = 
  if (x = 0.) then 1.
  else if (x > 0.) then atn (sqrt x)  /.  (sqrt x) 
  else  (log ((1. +.  sqrt(  -.  x)) /. (1.  -.  sqrt(  -.  x))))  /.  (2. *.  sqrt ( -.  x));;
let sol_euler_x_div_sqrtdelta x1 x2 x3 x4 x5 x6 = 
  (let a = sqrt(x1*. x2*. x3) +.  sqrt( x1)*. (x2 +.  x3  -.  x4) /.  2. +.  
     sqrt(x2)*. (x1 +.  x3  -.  x5) /.  2. +.  sqrt(x3)*. (x1 +.  x2  -.  x6) /.  2. in
     (matan ((delta_x x1 x2 x3 x4 x5 x6) /. (4. *.  a ** 2. ))) /. ( a));;
let sol_euler246_x_div_sqrtdelta = rotate4 sol_euler_x_div_sqrtdelta;;
let sol_euler345_x_div_sqrtdelta = rotate5 sol_euler_x_div_sqrtdelta;;
let sol_euler156_x_div_sqrtdelta = rotate6 sol_euler_x_div_sqrtdelta;;
let dih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 =
  ( let d_x4 = delta_x4 x1 x2 x3 x4 x5 x6 in
          let d = delta_x x1 x2 x3 x4 x5 x6 in
	     (sqrt(4. *.  x1)  /.  d_x4) *.  matan((4. *.  x1 *.  d) /. (d_x4 ** 2.)));;
let ldih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 =
   lfun(sqrt(x1)  /.  2.) *.  dih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6;;
let ldih2_x_div_sqrtdelta_posbranch =  rotate2 ldih_x_div_sqrtdelta_posbranch;;
let ldih3_x_div_sqrtdelta_posbranch  = rotate3 ldih_x_div_sqrtdelta_posbranch;;
let ldih5_x_div_sqrtdelta_posbranch  = rotate5 ldih_x_div_sqrtdelta_posbranch;;
let ldih6_x_div_sqrtdelta_posbranch  = rotate6 ldih_x_div_sqrtdelta_posbranch;;
let lmdih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 =
   lmfun(sqrt(x1)  /.  2.) *.  dih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6;;
let lmdih2_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 =
         rotate2 lmdih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6;;
let lmdih3_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 =
  rotate3 lmdih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 ;;
let lmdih5_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 =
  rotate5 lmdih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 ;;
let lmdih6_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 =
         rotate6 lmdih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6;;
let taum_y1 a b y1 (y2) (y3) (y4) (y5) (y6) = 
  taum (2.) (2.) (2.) a b y1;;
let taum_y2 a b (y1) (y2) (y3) (y4) (y5) (y6) = 
  taum (2.) (2.) (2.) a b y2;;
let taum_y1_y2 a (y1) (y2) (y3) (y4) (y5) (y6) = 
  taum (2.) (2.) (2.) a y1 y2;;
let arclength_y1 a b 
  (y1) (y2) (y3) (y4) (y5) (y6) =
  arclength y1 a b;;
let arclength_y2 a b 
  (y1) (y2) (y3) (y4) (y5) (y6) =
  arclength y2 a b;;
let arc_hhn = 
  arclength (2. *.  h0) (2. *.  h0) (2.);;
let asn797k k x2 x3 x4 x5 x6 = 
  k *.  asn (cos (0.797) *.  sin (pi  /.  k));;
let asnFnhk h k x3 x4 x5 x6 = 
  k *.  asn (( h *.  sqrt3  /.  4.0 +.  sqrt(1.  -.  (h /.  2.) ** 2.) /.  2.) *.  sin (pi /.  k));;
let lfun_y1 (y1) (y2) (y3) 
  (y4) (y5) (y6) =  lfun y1;;
let acs_sqrt_x1_d4 (x1) (x2) (x3) (x4) (x5) (x6) = 
  acs (sqrt(x1) /.  4.);;
let acs_sqrt_x2_d4 (x1) (x2) (x3) (x4) (x5) (x6) = 
  acs (sqrt(x2)  /.  4.);;
let arclength_x_123  (x1) (x2) (x3) (x4) (x5) (x6) = arclength (sqrt x1) (sqrt x2) (sqrt x3);;
let arclength_x_345  (x1) (x2) (x3) (x4) (x5) (x6) = arclength (sqrt x3) (sqrt x4) (sqrt x5);;
let tame_table_d r s = if (r +.  2.*. s > 3.) 
  then 0.103 *.  (2.  -.   s) +.  0.2759 *.  ( r +.  2.*.   s  -.  4.)
  else 0.0;;
let surfR a b c = 3.0 *.  volR a b c   /.  a;;
let surfRy y1 y2 y6 c = 
  surfR (y1 /.  2.) (eta_y y1 y2 y6) c;;
let surfRdyc2 y1 y2 y6 c2 = 
  surfRy y1 y2 y6 (sqrt c2) +.  surfRy y2 y1 y6 (sqrt c2);;
let surfy y1 y2 y3 y4 y5 y6 = 
  (let c = sqrt(rad2_y y1 y2 y3 y4 y5 y6) in
     surfRy y1 y2 y6 c +.  surfRy y2 y1 y6 c +.  
     surfRy y2 y3 y4 c +.  surfRy y3 y2 y4 c +. 
     surfRy y3 y1 y5 c +.  surfRy y1 y3 y5 c);;
let num1 e1 e2 e3 a2 b2 c2 =
    -.  4.*. ((a2 ** 2.) *. e1 +.  8.*. (b2  -.  c2)*. (e2  -.  e3)  -.  
  a2*. (16.*. e1 +.  ( b2  -.  8. )*. e2 +.  (c2  -.  8.)*. e3));;
let num2 e1 e2 e3 a2 b2 c2 =
  (8. *.  ((2. *.  ((a2 ** 5.) *.  e1)) +.  ((( -.  256.) *.  (((b2 +.  (( -.  1.) *.  c2)) ** 3.)  
 *.  (e2 +.  (( -.  1.) *.  e3)))) +.  ((( -.  1.) *.  ((a2 ** 3.) *.  ((2. *.  ((( -.  256.) +.   
 ((b2 ** 2.) +.  ((( -.  2.) *.  (b2 *.  c2)) +.  (c2 ** 2.)))) *.  e1)) +.  (((((b2 ** 2.)  
 *.  (( -.  8.) +.  c2)) +.  ((( -.  16.) *.  (b2 *.  (3. +.  c2))) +.  (16. *.  (16. +.  (9. *.   
 c2))))) *.  e2) +.  (((b2 *.  (144. +.  ((( -.  16.) *.  c2) +.  (c2 ** 2.)))) +.  (( -.  8.) *.   
 (( -.  32.) +.  ((6. *.  c2) +.  (c2 ** 2.))))) *.  e3))))) +.  (((a2 ** 4.) *.  ((( -.  64.)  
 *.  e1) +.  (( -.  6.) *.  (((( -.  8.) +.  b2) *.  e2) +.  ((( -.  8.) +.  c2) *.  e3))))) +.  ((( -.   
 2.) *.  ((a2 ** 2.) *.  ((b2 +.  (( -.  1.) *.  c2)) *.  (((b2 ** 2.) *.  e2) +.  ((8. *.  (c2  
 *.  ((4. *.  e1) +.  ((9. *.  e2) +.  (( -.  7.) *.  e3))))) +.  ((384. *.  (e2 +.  (( -.  1.) *.   
 e3))) +.  ((( -.  1.) *.  ((c2 ** 2.) *.  e3)) +.  (b2 *.  ((( -.  32.) *.  e1) +.  (((56. +.   
 (( -.  9.) *.  c2)) *.  e2) +.  (9. *.  ((( -.  8.) +.  c2) *.  e3)))))))))))) +.  (16. *.  (a2 *.   
 ((b2 +.  (( -.  1.) *.  c2)) *.  (((b2 ** 2.) *.  (e2 +.  (( -.  3.) *.  e3))) +.  ((( -.  4.) *.   
 (b2 *.  ((8. *.  e1) +.  (((( -.  20.) +.  (3. *.  c2)) *.  e2) +.  (( -.  3.) *.  ((( -.  4.) +.   
 c2) *.  e3)))))) +.  (c2 *.  ((32. *.  e1) +.  ((3. *.  ((16. +.  c2) *.  e2)) +.  (( -.  1.) *.   
 ((80. +.  c2) *.  e3))))))))))))))));;
let rat1 e1 e2 e3 a2 b2 c2 = 
  num1 e1 e2 e3 a2 b2 c2  /.  
    (sqrt(delta_x (4.) (4.) (4.) a2 b2 c2) *.  sqrt(a2) *.  (16.  -.  a2));;
let rat2 e1 e2 e3 a2 b2 c2 = 
  num2 e1 e2 e3 a2 b2 c2  /.  
    (((sqrt(delta_x (4.) (4.) (4.) a2 b2 c2)) ** 3.) *.  a2 *.  ((16.  -.  a2) ** 2.));;
let num_combo1 e1 e2 e3 a2 b2 c2 =
((2.  /.  25.) *.  ((( -.  2.) *.  ((a2 ** 5.) *.  e1)) +.  ((256. *.  (((b2 +.  (( -.  1.) *.   
c2)) ** 3.) *.  (e2 +.  (( -.  1.) *.  e3)))) +.  (((a2 ** 3.) *.  ((2. *.  ((( -.  256.) +.   
((b2 ** 2.) +.  ((( -.  2.) *.  (b2 *.  c2)) +.  (c2 ** 2.)))) *.  e1)) +.  (((((b2 ** 2.)  
*.  (( -.  8.) +.  c2)) +.  ((( -.  16.) *.  (b2 *.  (3. +.  c2))) +.  (16. *.  (16. +.  (9. *.   
c2))))) *.  e2) +.  (((b2 *.  (144. +.  ((( -.  16.) *.  c2) +.  (c2 ** 2.)))) +.  (( -.  8.) *.   
(( -.  32.) +.  ((6. *.  c2) +.  (c2 ** 2.))))) *.  e3)))) +.  ((2. *.  ((a2 ** 4.) *.  ((32.  
*.  e1) +.  (3. *.  (((( -.  8.) +.  b2) *.  e2) +.  ((( -.  8.) +.  c2) *.  e3)))))) +.  ((200. *.   
((((a2 ** 2.) *.  e1) +.  ((8. *.  ((b2 +.  (( -.  1.) *.  c2)) *.  (e2 +.  (( -.  1.) *.  e3))))  
+.  (( -.  1.) *.  (a2 *.  ((16. *.  e1) +.  (((( -.  8.) +.  b2) *.  e2) +.  ((( -.  8.) +.  c2) *.   
e3))))))) ** 2.)) +.  ((2. *.  ((a2 ** 2.) *.  ((b2 +.  (( -.  1.) *.  c2)) *.  (((b2 ** 2.)  
*.  e2) +.  ((8. *.  (c2 *.  ((4. *.  e1) +.  ((9. *.  e2) +.  (( -.  7.) *.  e3))))) +.  ((384. *.   
(e2 +.  (( -.  1.) *.  e3))) +.  ((( -.  1.) *.  ((c2 ** 2.) *.  e3)) +.  (b2 *.  ((( -.  32.) *.   
e1) +.  (((56. +.  (( -.  9.) *.  c2)) *.  e2) +.  (9. *.  ((( -.  8.) +.  c2) *.   
e3)))))))))))) +.  (( -.  16.) *.  (a2 *.  ((b2 +.  (( -.  1.) *.  c2)) *.  (((b2 ** 2.) *.   
(e2 +.  (( -.  3.) *.  e3))) +.  ((( -.  4.) *.  (b2 *.  ((8. *.  e1) +.  (((( -.  20.) +.  (3. *.   
c2)) *.  e2) +.  (( -.  3.) *.  ((( -.  4.) +.  c2) *.  e3)))))) +.  (c2 *.  ((32. *.  e1) +.  ((3.  
*.  ((16. +.  c2) *.  e2)) +.  (( -.  1.) *.  ((80. +.  c2) *.  e3)))))))))))))))));;
let delta_template_B_x x15 x45 x34 x12      x1 x2 x3 x4 x5 (x6) = 
  (let x23 = x12 in
    let x13 = edge_flat2_x x2 x1 x3  (0.)   x23 x12 in
    let x14 = edge_flat2_x x5 x1 x4  (0.)   x45 x15 in 
      (delta_x x1 x3 x4 x34 x14 x13));;
let dih_template_B_x x15 x45 x34 x12 x25      x1 x2 x3 x4 x5 (x6) = 
  (let x23 = x12 in
    let x13 = edge_flat2_x x2 x1 x3  (0.)   x23 x12 in
    let x14 = edge_flat2_x x5 x1 x4  (0.)   x45 x15 in 
      (dih_x x1 x2 x5 x25 x15 x12  -.  dih_x x1 x3 x4 x34 x14 x13));;
let flat_term_x x = flat_term (sqrt x);;
let taum_x x1 x2 x3 x4 x5 x6 = 
    rhazim_x x1 x2 x3 x4 x5 x6 +.  rhazim2_x x1 x2 x3 x4 x5 x6 +.  
     rhazim3_x x1  x2 x3 x4 x5 x6  -.  (1. +.  const1)*.  pi;;
let taum_template_B_x x15 x45 x34 x12      x1 x2 x3 x4 x5 (x6) = 
  (let x23 = x12 in
    let x13 = edge_flat2_x x2 x1 x3  (0.)   x23 x12 in
    let x14 = edge_flat2_x x5 x1 x4  (0.)   x45 x15 in 
      (taum_x x1 x3 x4 x34 x14 x13 +. flat_term_x x2 +.  flat_term_x x5));;
let sqp x = 
    if (x < 1.) then
       3.  /.  8. +.   (1.  -.  x) ** 3. *.  ( -.  0.25 +.  0.7 *.  x) +. 
	 3. *.  x  /.  4.  -.  x *.  x /.  8. else sqrt x;;
let sqn x = 
  if (x < 1.)
  then 0.375 +.  (3.*. x) /.  4.   -.  (x ** 2.) /.  8.  -.    0.3*. ((1.  -.  x) ** 3.)*. (x ** 2.) +.  
   ((1.  -.  x) ** 3.)*. ( -.  0.375 +.  1.3*. (1.  -.  x)*. x) 
  else sqrt x;;
let upper_dih_x x1 x2 x3 x4 x5 x6 =
  (let d = delta_x x1 x2 x3 x4 x5 x6 in
  let d4 = delta_x4 x1 x2 x3 x4 x5 x6 in (
   2. *.  sqrt x1 *.  sqp d *. 
    matan (4. *.  x1 *.  d  /.  (d4 ** 2.) )  /.  d4));;
let upper_dih_y = y_of_x upper_dih_x;;
let gamma3f_135_n y1 y2 y3 y4 y5 y6 =
    sqn(delta_y y1 y2 y3 y4 y5 y6) *.  (1.  /.  12.  -.  
   ( (2. *.  mm1  /.  pi) *. 
         (y_of_x sol_euler_x_div_sqrtdelta y1 y2 y3 y4 y5 y6 
	  +.  y_of_x sol_euler156_x_div_sqrtdelta y1 y2 y3 y4 y5 y6 +.  
	  y_of_x sol_euler345_x_div_sqrtdelta y1 y2 y3 y4 y5 y6)  -. 
         (8. *.  mm2  /.  pi) *. 
         (y_of_x lmdih_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6 +. 
          y_of_x lmdih3_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6 +. 
          y_of_x lmdih5_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6)
   ));;
let gamma3f_126_n y1 y2 y3 y4 y5 y6 =
    sqn(delta_y y1 y2 y3 y4 y5 y6) *.  (1.  /.  12.  -.  
   ( (2. *.  mm1  /.  pi) *. 
         (y_of_x sol_euler_x_div_sqrtdelta y1 y2 y3 y4 y5 y6 
	  +.  y_of_x sol_euler246_x_div_sqrtdelta y1 y2 y3 y4 y5 y6 +.  
	  y_of_x sol_euler156_x_div_sqrtdelta y1 y2 y3 y4 y5 y6)  -. 
         (8. *.  mm2  /.  pi) *. 
         (y_of_x lmdih_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6 +. 
          y_of_x lmdih2_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6 +. 
          y_of_x lmdih6_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6)
   ));;
let gamma23f_n y1 y2 y3 y4 y5 y6 w1 w2 r f =
         gamma3f_126_n y1 y2 sqrt2 sqrt2 sqrt2 y6  /.   w1 +. 
         gamma3f_135_n y1 sqrt2 y3 sqrt2 y5 sqrt2  /.   w2 +. 
         (dih_y y1 y2 y3 y4 y5 y6  -. 
          upper_dih_y y1 y2 r r r y6  -. 
          upper_dih_y y1 y3 r r r y5) *. 
         (vol2r y1 r  -.  vol2f y1 r f)  /.  (2. *.  pi);;
let gamma23f_126_03_n y1 y2 y3 y4 y5 y6 w1 r f =
         gamma3f_126_n y1 y2 sqrt2 sqrt2 sqrt2 y6  /.   w1 +. 
         (dih_y y1 y2 y3 y4 y5 y6  -.  upper_dih_y y1 y2 r r r y6  -.  0.03) *. 
         (vol2r y1 r  -.  vol2f y1 r f)  /.  (2. *.  pi);;
let taum_hexall_x  x14 x12 x23  x1 x2 x3 x4 x5 (x6) = 
   taum_x x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0.) x23 x12) +.  flat_term_x x2;;
let dih_hexall_x x14 x12 x23 x1 x2 x3 x4 x5 (x6) = 
   dih_x x1 x2 x4 ((2. *.  h0) ** 2.) x14 x12  -.  
   dih_x x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0.) x23 x12);;
let dih1_hexall_x x14 x12 x23 x1 x2 x3 x4 x5 (x6) = 
   dih_x x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0.) x23 x12);;
let upper_dih_hexall_x x14 x12 x23 x1 x2 x3 x4 x5 (x6) = 
   dih_x x1 x2 x4 ((2. *.  h0) ** 2.) x14 x12  -.  
   upper_dih_x x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0.) x23 x12);;
let delta_hexall_x x14 x12 x23 x1 x2 x3 x4 x5 (x6) = 
   delta_x x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0.) x23 x12);;
let delta4_hexall_x x14 x12 x23 x1 x2 x3 x4 x5 (x6) = 
   delta_x4 x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0.) x23 x12);;
let eulerA_x x1 x2 x3 x4 x5 x6 =
  sqrt(x1) *.  sqrt(x2) *.  sqrt(x3) +.  sqrt(x1) *.  (x2 +.  x3  -.  x4)  /.  2. +.  sqrt(x2) *.  (x1 +.  x3  -.  x5)  /.  2. +. 
    sqrt(x3) *.  (x1 +.  x2  -.  x6)  /.  2.;;
let eulerA_hexall_x x14 x12 x23 x1 x2 x3 x4 x5 (x6) = 
   eulerA_x x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0.) x23 x12);;
let factor345_hexall_x c (x1) (x2) x3 x4 x5 (x6) = 
   x5  -. x3  -. x4 +.  2. *.  c *.  sqrt(x3) *.  sqrt(x4);;
let law_cosines_234_x c (x1) (x2) (x3) (x4) (x5) (x6) = 
   x4  -. x2  -. x3 +.  2. *.  c *.  sqrt(x2) *.  sqrt(x3);;
let law_cosines_126_x c (x1) (x2) (x3) (x4) (x5) (x6) = 
   x6  -. x1  -. x2 +.  2. *.  c *.  sqrt(x1) *.  sqrt(x2);;
let delta4_squared_x x1 x2 x3 x4 x5 x6 = (delta_x4 x1 x2 x3 x4 x5 x6) ** 2.;;
let delta4_squared_y = y_of_x delta4_squared_x;;
let x1_delta_x x1 x2 x3 x4 x5 x6 = x1 *.  delta_x x1 x2 x3 x4 x5 x6;;
let x1_delta_y = y_of_x x1_delta_x;;
let delta_126_x (x3s) (x4s) (x5s) (x1) (x2) (x3) (x4) (x5) (x6) = 
     delta_x x1 x2 x3s x4s x5s x6;;
let delta_234_x (x1s) (x5s) (x6s) (x1) (x2) (x3) (x4) (x5) (x6) = 
     delta_x x1s x2 x3 x4 x5s x6s;;
let cayleyR x12 x13 x14 x15  x23 x24 x25  x34 x35 x45 = 
   -.  (x14*. x14*. x23*. x23) +.  2. *. x14*. x15*. x23*. x23  -.  x15*. x15*. x23*. x23 +.  2. *. x13*. x14*. x23*. x24  -.  2. *. x13*. x15*. x23*. x24  -.  2. *. x14*. x15*. x23*. x24 +.  
   2. *. x15*. x15*. x23*. x24  -.  x13*. x13*. x24*. x24 +.  2. *. x13*. x15*. x24*. x24  -.  x15*. x15*. x24*. x24  -.  2. *. x13*. x14*. x23*. x25 +.  
   2. *. x14*. x14*. x23*. x25 +.  2. *. x13*. x15*. x23*. x25  -.  2. *. x14*. x15*. x23*. x25 +.  2. *. x13*. x13*. x24*. x25  -.  2. *. x13*. x14*. x24*. x25  -.  2. *. x13*. x15*. x24*. x25 +.  
   2. *. x14*. x15*. x24*. x25  -.  x13*. x13*. x25*. x25 +.  2. *. x13*. x14*. x25*. x25  -.  x14*. x14*. x25*. x25 +.  2. *. x12*. x14*. x23*. x34  -.  2. *. x12*. x15*. x23*. x34  -.  
   2. *. x14*. x15*. x23*. x34 +.  2. *. x15*. x15*. x23*. x34 +.  2. *. x12*. x13*. x24*. x34  -.  2. *. x12*. x15*. x24*. x34  -.  2. *. x13*. x15*. x24*. x34 +.  2. *. x15*. x15*. x24*. x34 +.  
   4. *. x15*. x23*. x24*. x34  -.  2. *. x12*. x13*. x25*. x34  -.  2. *. x12*. x14*. x25*. x34 +.  4. *. x13*. x14*. x25*. x34 +.  4. *. x12*. x15*. x25*. x34  -.  2. *. x13*. x15*. x25*. x34  -.  2. *. x14*. x15*. x25*. x34  -.  
   2. *. x14*. x23*. x25*. x34  -.  2. *. x15*. x23*. x25*. x34  -.  2. *. x13*. x24*. x25*. x34  -.  2. *. x15*. x24*. x25*. x34 +.  2. *. x13*. x25*. x25*. x34 +.  2. *. x14*. x25*. x25*. x34  -.  
   x12*. x12*. x34*. x34 +.  2. *. x12*. x15*. x34*. x34  -.  x15*. x15*. x34*. x34 +.  2. *. x12*. x25*. x34*. x34 +.  2. *. x15*. x25*. x34*. x34  -.  
   x25*. x25*. x34*. x34  -.  2. *. x12*. x14*. x23*. x35 +.  2. *. x14*. x14*. x23*. x35 +.  2. *. x12*. x15*. x23*. x35  -.  2. *. x14*. x15*. x23*. x35  -.  2. *. x12*. x13*. x24*. x35 +.  
   4. *. x12*. x14*. x24*. x35  -.  2. *. x13*. x14*. x24*. x35  -.  2. *. x12*. x15*. x24*. x35 +.  4. *. x13*. x15*. x24*. x35  -.  2. *. x14*. x15*. x24*. x35  -.  2. *. x14*. x23*. x24*. x35  -.  2. *. x15*. x23*. x24*. x35 +.  
   2. *. x13*. x24*. x24*. x35 +.  2. *. x15*. x24*. x24*. x35 +.  2. *. x12*. x13*. x25*. x35  -.  2. *. x12*. x14*. x25*. x35  -.  2. *. x13*. x14*. x25*. x35 +.  2. *. x14*. x14*. x25*. x35 +.  
   4. *. x14*. x23*. x25*. x35  -.  2. *. x13*. x24*. x25*. x35  -.  2. *. x14*. x24*. x25*. x35 +.  2. *. x12*. x12*. x34*. x35  -.  2. *. x12*. x14*. x34*. x35  -.  2. *. x12*. x15*. x34*. x35 +.  
   2. *. x14*. x15*. x34*. x35  -.  2. *. x12*. x24*. x34*. x35  -.  2. *. x15*. x24*. x34*. x35  -.  2. *. x12*. x25*. x34*. x35  -.  2. *. x14*. x25*. x34*. x35 +.  2. *. x24*. x25*. x34*. x35  -.  
   x12*. x12*. x35*. x35 +.  2. *. x12*. x14*. x35*. x35  -.  x14*. x14*. x35*. x35 +.  2. *. x12*. x24*. x35*. x35 +.  2. *. x14*. x24*. x35*. x35  -.  
   x24*. x24*. x35*. x35 +.  4. *. x12*. x13*. x23*. x45  -.  2. *. x12*. x14*. x23*. x45  -.  2. *. x13*. x14*. x23*. x45  -.  2. *. x12*. x15*. x23*. x45  -.  2. *. x13*. x15*. x23*. x45 +.  
   4. *. x14*. x15*. x23*. x45 +.  2. *. x14*. x23*. x23*. x45 +.  2. *. x15*. x23*. x23*. x45  -.  2. *. x12*. x13*. x24*. x45 +.  2. *. x13*. x13*. x24*. x45 +.  2. *. x12*. x15*. x24*. x45  -.  
   2. *. x13*. x15*. x24*. x45  -.  2. *. x13*. x23*. x24*. x45  -.  2. *. x15*. x23*. x24*. x45  -.  2. *. x12*. x13*. x25*. x45 +.  2. *. x13*. x13*. x25*. x45 +.  2. *. x12*. x14*. x25*. x45  -.  
   2. *. x13*. x14*. x25*. x45  -.  2. *. x13*. x23*. x25*. x45  -.  2. *. x14*. x23*. x25*. x45 +.  4. *. x13*. x24*. x25*. x45 +.  2. *. x12*. x12*. x34*. x45  -.  2. *. x12*. x13*. x34*. x45  -.  
   2. *. x12*. x15*. x34*. x45 +.  2. *. x13*. x15*. x34*. x45  -.  2. *. x12*. x23*. x34*. x45  -.  2. *. x15*. x23*. x34*. x45  -.  2. *. x12*. x25*. x34*. x45  -.  2. *. x13*. x25*. x34*. x45 +.  2. *. x23*. x25*. x34*. x45 +.  
   2. *. x12*. x12*. x35*. x45  -.  2. *. x12*. x13*. x35*. x45  -.  2. *. x12*. x14*. x35*. x45 +.  2. *. x13*. x14*. x35*. x45  -.  2. *. x12*. x23*. x35*. x45  -.  2. *. x14*. x23*. x35*. x45  -.  
   2. *. x12*. x24*. x35*. x45  -.  2. *. x13*. x24*. x35*. x45 +.  2. *. x23*. x24*. x35*. x45 +.  4. *. x12*. x34*. x35*. x45  -.  x12*. x12*. x45*. x45 +.  2. *. x12*. x13*. x45*. x45  -.  
   x13*. x13*. x45*. x45 +.  2. *. x12*. x23*. x45*. x45 +.  2. *. x13*. x23*. x45*. x45  -.  x23*. x23*. x45*. x45;;
let muR y1 y2 y3 y4 y5 y6 y7 y8 y9 x = cayleyR (y6*. y6) (y5*. y5) (y1*. y1) (y7*. y7) (y4*. y4) (y2*. y2) (y8*. y8)  (y3*. y3) (y9*. y9) x;;
let enclosed y1 y2 y3 y4 y5 y6 y7 y8 y9 = sqrt 
   (quadratic_root_plus (abc_of_quadratic (muR y1 y2 y3 y4 y5 y6 y7 y8 y9)));;
