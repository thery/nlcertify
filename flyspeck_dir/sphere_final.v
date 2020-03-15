Require Import Reals.
Open Scope R_scope.

Axiom atn : R -> R.
Axiom asn : R -> R.
Axiom acs : R -> R.
Axiom tanK : forall x, atn (tan x) = x.
Axiom atnK : forall x, - PI / 2 < x < PI/2 -> tan (atn x) = x.
Axiom atn_inv_plus : forall x, x > 0 -> atn(1 / x) + atn(x) = PI/2.
Axiom atn_inv_minus : forall x, x < 0 -> atn(1 / x) + atn(x) = -PI/2.
Axiom total_order_T : forall r1 r2:R, {r1 < r2} + {r1 = r2} + {r1 > r2}.
Lemma atn0: atn 0 = 0.
rewrite <- tan_0;rewrite tanK;rewrite tan_0.
auto.
Qed.
Definition atn2 x y  :=
    match total_order_T ( Rabs y  ) ( x )  with
 inleft (left _) => atn(y / x) 
 | _ => 
    (  match total_order_T (0  ) ( y)  with
 inleft (left _) => ((PI / 2) - atn(x / y)) 
 | _ => 
    (  match total_order_T (y  ) ( 0)  with
 inleft (left _) => (- (PI/ 2) - atn (x / y)) 
 | _ =>  (  PI )end)end)end  .
Definition abc_of_quadratic f := 
  let c := f (0) in
  let  p := f (1) in
  let n := f (- 1) in
  ((p + n)/(2) - c, (p -n)/(2), c).
Definition quadratic_root_plus t:=
match t with (a,b,c) => ( - b + sqrt(b ^ 2 - 4 * a * c))/ (2 * a)end.
Definition sqrt8 := sqrt (8) .
Definition sqrt2 := sqrt (2) .

Definition delta_x x1 x2 x3 x4 x5 x6 :=
        x1*x4*(-x1 + x2 + x3 -x4 + x5 + x6) +
        x2*x5*(x1 - x2 + x3 + x4 -x5 + x6) +
        x3*x6*(x1 + x2 - x3 + x4 + x5 - x6)
        -x2*x3*x4 - x1*x3*x5 - x1*x2*x6 -x4*x5*x6.
Definition delta_y y1 y2 y3 y4 y5 y6 :=
    delta_x (y1*y1) (y2*y2) (y3*y3) (y4*y4) (y5*y5) (y6*y6).
Definition edge_flat y1 y2 y3 y5 y6 := 
 sqrt(quadratic_root_plus (abc_of_quadratic (
   fun x4 =>   - delta_x (y1*y1) (y2*y2)  (y3*y3)  x4 (y5*y5)  (y6*y6)))).
Definition edge_flat2_x (x1 x2 x3 x4 x5 x6 : R) :=
  (edge_flat (sqrt x1) (sqrt x2) (sqrt x3) (sqrt x5) (sqrt x6)) ^ 2.
Definition delta_x4 x1 x2 x3 x4 x5 x6
        :=  - x2* x3 -  x1* x4 + x2* x5
        + x3* x6 -  x5* x6 + x1* (- x1 +  x2 +  x3 -  x4 +  x5 +  x6).
Definition ups_x x1 x2 x6 :=
    -x1*x1 - x2*x2 - x6*x6
    + 2 *x1*x6 + 2 *x1*x2 + 2 *x2*x6.
Definition eta_x x1 x2 x3 :=
        (sqrt ((x1*x2*x3)/(ups_x x1 x2 x3)))
        .
Definition eta_y y1 y2 y3 :=
                let x1 := y1*y1 in
                let x2 := y2*y2 in
                let x3 := y3*y3 in
                eta_x x1 x2 x3.
Definition rho_x x1 x2 x3 x4 x5 x6 :=
        -x1*x1*x4*x4 - x2*x2*x5*x5 - x3*x3*x6*x6 +
        (2)*x1*x2*x4*x5 + (2)*x1*x3*x4*x6 + (2)*x2*x3*x5*x6.
Definition dih_x x1 x2 x3 x4 x5 x6 :=
       let d_x4 := delta_x4 x1 x2 x3 x4 x5 x6 in
       let d := delta_x x1 x2 x3 x4 x5 x6 in
       PI/ (2) +  atn2 ( (sqrt ((4) * x1 * d)))  (-  d_x4) .
Definition dih_y y1 y2 y3 y4 y5 y6 :=
       let fresh_x := (y1*y1,y2*y2,y3*y3,y4*y4,y5*y5,y6*y6) in
match fresh_x with (x1,x2,x3,x4,x5,x6)=> 
       dih_x x1 x2 x3 x4 x5 x6 end.
Definition dih2_y y1 y2 y3 y4 y5 y6 :=
        dih_y y2 y1 y3 y5 y4 y6.
Definition dih3_y y1 y2 y3 y4 y5 y6 :=
        dih_y y3 y1 y2 y6 y4 y5.
Definition dih2_x x1 x2 x3 x4 x5 x6 :=
        dih_x x2 x1 x3 x5 x4 x6.
Definition dih3_x x1 x2 x3 x4 x5 x6 :=
        dih_x x3 x1 x2 x6 x4 x5.
Definition sol_y y1 y2 y3 y4 y5 y6 :=
        (dih_y y1 y2 y3 y4 y5 y6) +
        (dih_y y2 y3 y1 y5 y6 y4) +  (dih_y y3 y1 y2 y6 y4 y5) -  PI.
Definition interp x1 y1 x2 y2 x := y1 + (x - x1) * (y2- y1)/(x2-x1).
Definition const1 := sol_y (2) (2) (2) (2) (2) (2) / PI.
Definition ly y := interp (2) (1) ((252/100)) (0) y.
Definition rho y := 1 + const1 - const1* ly y.
Definition rhazim y1 y2 y3 y4 y5 y6 := rho y1 * dih_y y1 y2 y3 y4 y5 y6.
Definition lnazim y1 y2 y3 y4 y5 y6 := ly y1 * dih_y y1 y2 y3 y4 y5 y6.
Definition taum y1 y2 y3 y4 y5 y6 := sol_y y1 y2 y3 y4 y5 y6 * (1 + const1) - const1 * (lnazim y1 y2 y3 y4 y5 y6 + lnazim y2 y3 y1 y5 y6 y4 + lnazim y3 y1 y2 y6 y4 y5).
Definition node2_y (f : R->R->R->R->R->R->R) y1 y2 y3 y4 y5 y6 := f y2 y3 y1 y5 y6 y4.
Definition node3_y (f : R->R->R->R->R->R->R) y1 y2 y3 y4 y5 y6 := f y3 y1 y2 y6 y4 y5.
Definition rhazim2 := node2_y rhazim.
Definition rhazim3 := node3_y rhazim.
Definition dih4_y y1 y2 y3 y4 y5 y6 := dih_y y4 y2 y6 y1 y5 y3.
Definition dih5_y y1 y2 y3 y4 y5 y6 := dih_y y5 y1 y6 y2 y4 y3.
Definition dih6_y y1 y2 y3 y4 y5 y6 := dih_y y6 y1 y5 y3 y4 y2.
Definition tauq y1 y2 y3 y4 y5 y6 y7 y8 y9 := taum y1 y2 y3 y4 y5 y6 + taum y7 y2 y3 y4 y8 y9.
Definition vol_x x1 x2 x3 x4 x5 x6 :=
        (sqrt (delta_x x1 x2 x3 x4 x5 x6))/ (12).
Definition arclength a b c :=
        PI/(2) + (atn2 ( (sqrt (ups_x (a*a) (b*b) (c*c))))  ((c*c - a*a  -b*b))) .
Definition volR a b c :=
        (sqrt (a*a*(b*b-a*a)*(c*c-b*b)))/(6).
Definition rad2_x x1 x2 x3 x4 x5 x6 :=
        (rho_x x1 x2 x3 x4 x5 x6)/((delta_x x1 x2 x3 x4 x5 x6)*(4)).
Definition h0 := (126/100).
Definition sol0 := 3 * acs (1 / 3)  - PI.
Definition tau0 := 4 * PI - 20 * sol0.
Definition mm1 := sol0 * sqrt(8)/tau0.
Definition mm2 := (6 * sol0 - PI) * sqrt(2) /(6 * tau0).
Definition hplus := (13254/10000).
Definition marchal_quartic h := 
    (sqrt(2)-h)*(h- hplus )*(9*(h ^ 2) - 17*h + 3)/
      ((sqrt(2) - 1)* 5 *(hplus - 1)).
Definition lmfun h := match total_order_T (h) (h0)  with
 inright _ => 0
 | _ =>  (h0 - h)/(h0 - 1)  end .
Definition lfun h :=  (h0 - h)/(h0 - 1).
Definition flat_term y := sol0 * (y - 2 * h0)/(2 * h0 - 2).
Definition hminus:= 12136/10000.
Definition y_of_x (fx : R->R->R->R->R->R->R) y1 y2 y3 y4 y5 y6 := 
    fx (y1*y1) (y2*y2) (y3*y3) (y4*y4) (y5*y5) (y6*y6).

Definition delta4_y := y_of_x delta_x4.
Definition vol_y := y_of_x vol_x.
Definition vol4f y1 y2 y3 y4 y5 y6 f := 
   (2 * mm1 / PI) * 
               (sol_y y1 y2 y3 y4 y5 y6 +
		  sol_y y1 y5 y6 y4 y2 y3 +
		  sol_y y4 y5 y3 y1 y2 y6 +
		  sol_y y4 y2 y6 y1 y5 y3)
	       - (8 * mm2/PI) *
	       (f(y1/ 2)* dih_y y1 y2 y3 y4 y5 y6 +
		  f(y2/ 2)* dih_y y2 y3 y1 y5 y6 y4 +
		  f(y3/ 2)* dih_y y3 y1 y2 y6 y4 y5 +
		  f(y4/ 2)* dih_y y4 y3 y5 y1 y6 y2 +
		  f(y5/ 2)* dih_y y5 y1 y6 y2 y4 y3 +
		  f(y6/ 2)* dih_y y6 y1 y5 y3 y4 y2).
Definition gamma4f y1 y2 y3 y4 y5 y6 f :=
    vol_y y1 y2 y3 y4 y5 y6 - vol4f  y1 y2 y3 y4 y5 y6 f.
Definition gamma4fgcy y1 y2 y3 y4 y5 y6 f :=
   gamma4f y1 y2 y3 y4 y5 y6 f.
Definition vol3r y1 y2 y3 r := vol_y r r r y1 y2 y3.
Definition vol3f y1 y2 y3 r f := (2 * mm1 / PI) * 
        (sol_y y1 y2 r r r y3 +
	   sol_y y2 y3 r r r y1 +
	   sol_y y3 y1 r r r y2)
    - (8 * mm2/PI) *
       (f(y1/ 2)* dih_y y1 y2 r r r y3 +
	  f(y2/ 2)* dih_y y2 y3 r r r y1 +
	  f(y3/ 2)* dih_y y3 y1 r r r y2).
Definition gamma3f y1 y2 y3 r f := vol3r y1 y2 y3 r - vol3f y1 y2 y3 r f.
Definition vol2r y r := 2 * PI * (r*r - (y / (2)) ^ 2)/(3).
Definition vol2f y r f :=  (2 * mm1 / PI) *  2 *PI* (1- y/ (r * 2))
    - (8 * mm2/PI) * 2 * PI * f (y/ (2)) .
Definition norm2hh y1 y2 y3 y4 y5 y6 := 
    (y1- hminus - hplus) ^ 2 + (y2 - 2) ^ 2 + (y3 - 2) ^ 2 + (y4 - 2) ^ 2 
     + (y5 - 2) ^ 2 + (y6 - 2) ^ 2.
Definition  bump h := (0005/1000)*(1 - ((h- h0) ^ 2)/((hplus - h0) ^ 2)).
Definition critical_edge_y y := 
        match total_order_T y (2*hminus)  with 
        |inright _ => 
          match total_order_T (2*hplus) y with 
            |inright _ => true
              |_ => false
                end
        |_ => false
        end.
Definition beta_bump_y y1 y2 y3 y4 y5 y6 :=
          (if critical_edge_y y1 then 1 else 0) *
            (if critical_edge_y y2 then 0 else 1) *
              (if critical_edge_y y3 then 0 else 1) *
                (if critical_edge_y y4 then 1 else 0) *
                  (if critical_edge_y y5 then 0 else 1) *
                    (if critical_edge_y y6 then 0 else 1) *
                        (bump (y1/ 2) - bump (y4 / 2)).
Definition beta_bump_force_y (y1 y2 y3 y4 y5 y6 : R) :=
    (bump (y1/ 2) - bump (y4 / 2)).
Definition wtcount3_y y1 y2 y3  :=
          (if critical_edge_y y1 then 1 else 0) +
            (if critical_edge_y y2 then 1 else 0) +
              (if critical_edge_y y3 then 1 else 0).
Definition wtcount6_y y1 y2 y3 y4 y5 y6 := wtcount3_y y1 y2 y3 + wtcount3_y y4 y5 y6.
Definition a_spine5 := (00560305/10000000).
Definition b_spine5 := - (00445813/10000000).
Definition beta_bump_lb := - (0005/1000).
Definition gamma23f y1 y2 y3 y4 y5 y6 w1 w2 r f :=
      (gamma3f y1 y2 y6 r f / w1 + gamma3f y1 y3 y5 r f / w2
      + (dih_y y1 y2 y3 y4 y5 y6 - dih_y y1 y2 r r r y6 - dih_y y1 y3 r r r y5) * (vol2r y1 r - vol2f y1 r f)/(2 * PI)) .
Definition gamma23f_126_03 y1 y2 y3 y4 y5 y6 w1 r f :=
      (gamma3f y1 y2 y6 r f / w1 
      + (dih_y y1 y2 y3 y4 y5 y6 - dih_y y1 y2 r r r y6 - (003/100)) * (vol2r y1 r - vol2f y1 r f)/(2 * PI)) .
Definition gamma23f_red_03 y1 y2 y3 y4 y5 y6 r f :=
       (dih_y y1 y2 y3 y4 y5 y6 - 2 * (003/100)) * (vol2r y1 r - vol2f y1 r f)/(2 * PI).
Definition rotate2 (f : R->R->R->R->R->R->R) x1 x2 x3 x4 x5 x6 := 
  f x2 x3 x1 x5 x6 x4.
Definition rotate3 (f : R->R->R->R->R->R->R) x1 x2 x3 x4 x5 x6 := 
  f x3 x1 x2 x6 x4 x5.
Definition rotate4 (f : R->R->R->R->R->R->R) x1 x2 x3 x4 x5 x6 := 
  f x4 x2 x6 x1 x5 x3.
Definition rotate5 (f : R->R->R->R->R->R->R) x1 x2 x3 x4 x5 x6 := 
  f x5 x3 x4 x2 x6 x1.
Definition rotate6 (f : R->R->R->R->R->R->R) x1 x2 x3 x4 x5 x6 := 
  f x6 x1 x5 x3 x4 x2.
Definition sqrt3 := sqrt(3).
Definition rad2_y := y_of_x rad2_x.
Definition rhazim_x x1 x2 x3 x4 x5 x6 := 
  rhazim (sqrt x1) (sqrt x2) (sqrt x3) (sqrt x4) (sqrt x5) (sqrt x6).
Definition rhazim2_x x1 x2 x3 x4 x5 x6 := 
  rhazim2 (sqrt x1) (sqrt x2) (sqrt x3) (sqrt x4) (sqrt x5) (sqrt x6).
Definition rhazim3_x x1 x2 x3 x4 x5 x6 := 
  rhazim3 (sqrt x1) (sqrt x2) (sqrt x3) (sqrt x4) (sqrt x5) (sqrt x6).
Definition matan x :=match total_order_T (x ) ( 0)  with
         inleft (right _) => 1
         | inright _ =>  atn (sqrt x) / (sqrt x) 
         | _ => (ln ((1 + sqrt( - x))/(1 - sqrt( - x)))) / (2 * sqrt (- x))
         end. 
Definition sol_euler_x_div_sqrtdelta x1 x2 x3 x4 x5 x6 := 
  (let a := sqrt(x1*x2*x3) + sqrt( x1)*(x2 + x3 - x4)/ 2 + 
     sqrt(x2)*(x1 + x3 - x5)/ 2 + sqrt(x3)*(x1 + x2 - x6)/ 2 in
     (matan ((delta_x x1 x2 x3 x4 x5 x6)/(4 * a ^ 2 )))/( a)).
Definition sol_euler246_x_div_sqrtdelta := rotate4 sol_euler_x_div_sqrtdelta.
Definition sol_euler345_x_div_sqrtdelta := rotate5 sol_euler_x_div_sqrtdelta.
Definition sol_euler156_x_div_sqrtdelta := rotate6 sol_euler_x_div_sqrtdelta.
Definition dih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 :=
  ( let d_x4 := delta_x4 x1 x2 x3 x4 x5 x6 in
          let d := delta_x x1 x2 x3 x4 x5 x6 in
	     (sqrt(4 * x1) / d_x4) * matan((4 * x1 * d)/(d_x4 ^ 2))).
Definition ldih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 :=
   lfun(sqrt(x1) / 2) * dih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6.
Definition ldih2_x_div_sqrtdelta_posbranch :=  rotate2 ldih_x_div_sqrtdelta_posbranch.
Definition ldih3_x_div_sqrtdelta_posbranch  := rotate3 ldih_x_div_sqrtdelta_posbranch.
Definition ldih5_x_div_sqrtdelta_posbranch  := rotate5 ldih_x_div_sqrtdelta_posbranch.
Definition ldih6_x_div_sqrtdelta_posbranch  := rotate6 ldih_x_div_sqrtdelta_posbranch.
Definition lmdih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 :=
   lmfun(sqrt(x1) / 2) * dih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6.
Definition lmdih2_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 :=
         rotate2 lmdih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6.
Definition lmdih3_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 :=
  rotate3 lmdih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 .
Definition lmdih5_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 :=
  rotate5 lmdih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 .
Definition lmdih6_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 :=
         rotate6 lmdih_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6.
Definition taum_y1 a b y1 (y2:R) (y3:R) (y4:R) (y5:R) (y6:R) := 
  taum (2) (2) (2) a b y1.
Definition taum_y2 a b (y1:R) (y2:R) (y3:R) (y4:R) (y5:R) (y6:R) := 
  taum (2) (2) (2) a b y2.
Definition taum_y1_y2 a (y1:R) (y2:R) (y3:R) (y4:R) (y5:R) (y6:R) := 
  taum (2) (2) (2) a y1 y2.
Definition arclength_y1 a b 
  (y1:R) (y2:R) (y3:R) (y4:R) (y5:R) (y6:R) :=
  arclength y1 a b.
Definition arclength_y2 a b 
  (y1:R) (y2:R) (y3:R) (y4:R) (y5:R) (y6:R) :=
  arclength y2 a b.
Definition arc_hhn := 
  arclength (2 * h0) (2 * h0) (2).
Definition asn797k k (x2 x3 x4 x5 x6 : R) := 
  k * asn (cos ((0797/1000)) * sin (PI / k)).
Definition asnFnhk h k (x3 x4 x5 x6 : R) := 
  k * asn (( h * sqrt3 / (40/10) + sqrt(1 - (h/ 2) ^ 2)/ 2) * sin (PI/ k)).
Definition lfun_y1 (y1:R) (y2:R) (y3:R) 
  (y4:R) (y5:R) (y6:R) :=  lfun y1.
Definition acs_sqrt_x1_d4 (x1:R) (x2:R) (x3:R) (x4:R) (x5:R) (x6:R) := 
  acs (sqrt(x1)/ 4).
Definition acs_sqrt_x2_d4 (x1:R) (x2:R) (x3:R) (x4:R) (x5:R) (x6:R) := 
  acs (sqrt(x2) / 4).
Definition arclength_x_123  (x1:R) (x2:R) (x3:R) (x4:R) (x5:R) (x6:R) := arclength (sqrt x1) (sqrt x2) (sqrt x3).
Definition arclength_x_345  (x1:R) (x2:R) (x3:R) (x4:R) (x5:R) (x6:R) := arclength (sqrt x3) (sqrt x4) (sqrt x5).
Definition tame_table_d r s := match total_order_T (r + 2*s ) ( 3) 
   with
 inright _ => (0103/1000) * (2 - s) + (02759/10000) * (r + 2* s - 4)
  
 | _ =>  (00/10) end .
Definition surfR a b c := (30/10) * volR a b c  / a.
Definition surfRy y1 y2 y6 c := 
  surfR (y1/ 2) (eta_y y1 y2 y6) c.
Definition surfRdyc2 y1 y2 y6 c2 := 
  surfRy y1 y2 y6 (sqrt c2) + surfRy y2 y1 y6 (sqrt c2).
Definition surfy y1 y2 y3 y4 y5 y6 := 
  (let c := sqrt(rad2_y y1 y2 y3 y4 y5 y6) in
     surfRy y1 y2 y6 c + surfRy y2 y1 y6 c + 
     surfRy y2 y3 y4 c + surfRy y3 y2 y4 c +
     surfRy y3 y1 y5 c + surfRy y1 y3 y5 c).
Definition num1 e1 e2 e3 a2 b2 c2 :=
   - 4*((a2 ^ 2) *e1 + 8*(b2 - c2)*(e2 - e3) - 
  a2*(16*e1 + ( b2 - 8 )*e2 + (c2 - 8)*e3)).
Definition num2 e1 e2 e3 a2 b2 c2 :=
  (8 * ((2 * ((a2 ^ 5) * e1)) + (((- 256) * (((b2 + ((- 1) * c2)) ^ 3)  
 * (e2 + ((- 1) * e3)))) + (((- 1) * ((a2 ^ 3) * ((2 * (((- 256) +  
 ((b2 ^ 2) + (((- 2) * (b2 * c2)) + (c2 ^ 2)))) * e1)) + (((((b2 ^ 2)  
 * ((- 8) + c2)) + (((- 16) * (b2 * (3 + c2))) + (16 * (16 + (9 *  
 c2))))) * e2) + (((b2 * (144 + (((- 16) * c2) + (c2 ^ 2)))) + ((- 8) *  
 ((- 32) + ((6 * c2) + (c2 ^ 2))))) * e3))))) + (((a2 ^ 4) * (((- 64)  
 * e1) + ((- 6) * ((((- 8) + b2) * e2) + (((- 8) + c2) * e3))))) + (((-  
 2) * ((a2 ^ 2) * ((b2 + ((- 1) * c2)) * (((b2 ^ 2) * e2) + ((8 * (c2  
 * ((4 * e1) + ((9 * e2) + ((- 7) * e3))))) + ((384 * (e2 + ((- 1) *  
 e3))) + (((- 1) * ((c2 ^ 2) * e3)) + (b2 * (((- 32) * e1) + (((56 +  
 ((- 9) * c2)) * e2) + (9 * (((- 8) + c2) * e3)))))))))))) + (16 * (a2 *  
 ((b2 + ((- 1) * c2)) * (((b2 ^ 2) * (e2 + ((- 3) * e3))) + (((- 4) *  
 (b2 * ((8 * e1) + ((((- 20) + (3 * c2)) * e2) + ((- 3) * (((- 4) +  
 c2) * e3)))))) + (c2 * ((32 * e1) + ((3 * ((16 + c2) * e2)) + ((- 1) *  
 ((80 + c2) * e3)))))))))))))))).
Definition rat1 e1 e2 e3 a2 b2 c2 := 
  num1 e1 e2 e3 a2 b2 c2 / 
    (sqrt(delta_x (4) (4) (4) a2 b2 c2) * sqrt(a2) * (16 - a2)).
Definition rat2 e1 e2 e3 a2 b2 c2 := 
  num2 e1 e2 e3 a2 b2 c2 / 
    (((sqrt(delta_x (4) (4) (4) a2 b2 c2)) ^ 3) * a2 * ((16 - a2) ^ 2)).
Definition num_combo1 e1 e2 e3 a2 b2 c2 :=
((2 / 25) * (((- 2) * ((a2 ^ 5) * e1)) + ((256 * (((b2 + ((- 1) *  
c2)) ^ 3) * (e2 + ((- 1) * e3)))) + (((a2 ^ 3) * ((2 * (((- 256) +  
((b2 ^ 2) + (((- 2) * (b2 * c2)) + (c2 ^ 2)))) * e1)) + (((((b2 ^ 2)  
* ((- 8) + c2)) + (((- 16) * (b2 * (3 + c2))) + (16 * (16 + (9 *  
c2))))) * e2) + (((b2 * (144 + (((- 16) * c2) + (c2 ^ 2)))) + ((- 8) *  
((- 32) + ((6 * c2) + (c2 ^ 2))))) * e3)))) + ((2 * ((a2 ^ 4) * ((32  
* e1) + (3 * ((((- 8) + b2) * e2) + (((- 8) + c2) * e3)))))) + ((200 *  
((((a2 ^ 2) * e1) + ((8 * ((b2 + ((- 1) * c2)) * (e2 + ((- 1) * e3))))  
+ ((- 1) * (a2 * ((16 * e1) + ((((- 8) + b2) * e2) + (((- 8) + c2) *  
e3))))))) ^ 2)) + ((2 * ((a2 ^ 2) * ((b2 + ((- 1) * c2)) * (((b2 ^ 2)  
* e2) + ((8 * (c2 * ((4 * e1) + ((9 * e2) + ((- 7) * e3))))) + ((384 *  
(e2 + ((- 1) * e3))) + (((- 1) * ((c2 ^ 2) * e3)) + (b2 * (((- 32) *  
e1) + (((56 + ((- 9) * c2)) * e2) + (9 * (((- 8) + c2) *  
e3)))))))))))) + ((- 16) * (a2 * ((b2 + ((- 1) * c2)) * (((b2 ^ 2) *  
(e2 + ((- 3) * e3))) + (((- 4) * (b2 * ((8 * e1) + ((((- 20) + (3 *  
c2)) * e2) + ((- 3) * (((- 4) + c2) * e3)))))) + (c2 * ((32 * e1) + ((3  
* ((16 + c2) * e2)) + ((- 1) * ((80 + c2) * e3))))))))))))))))).
Definition delta_template_B_x x15 x45 x34 x12      x1 x2 x3 x4 x5 (x6:R) := 
  (let x23 := x12 in
    let x13 := edge_flat2_x x2 x1 x3  (0)   x23 x12 in
    let x14 := edge_flat2_x x5 x1 x4  (0)   x45 x15 in 
      (delta_x x1 x3 x4 x34 x14 x13)).
Definition dih_template_B_x x15 x45 x34 x12 x25      x1 x2 x3 x4 x5 (x6:R) := 
  (let x23 := x12 in
    let x13 := edge_flat2_x x2 x1 x3  (0)   x23 x12 in
    let x14 := edge_flat2_x x5 x1 x4  (0)   x45 x15 in 
      (dih_x x1 x2 x5 x25 x15 x12 - dih_x x1 x3 x4 x34 x14 x13)).
Definition flat_term_x x := flat_term (sqrt x).
Definition taum_x x1 x2 x3 x4 x5 x6 := 
    rhazim_x x1 x2 x3 x4 x5 x6 + rhazim2_x x1 x2 x3 x4 x5 x6 + 
     rhazim3_x x1  x2 x3 x4 x5 x6 - (1 + const1)* PI.
Definition taum_template_B_x x15 x45 x34 x12      x1 x2 x3 x4 x5 (x6:R) := 
  (let x23 := x12 in
    let x13 := edge_flat2_x x2 x1 x3  (0)   x23 x12 in
    let x14 := edge_flat2_x x5 x1 x4  (0)   x45 x15 in 
      (taum_x x1 x3 x4 x34 x14 x13 +flat_term_x x2 + flat_term_x x5)).
Definition sqp x := 
    match total_order_T (x  ) ( 1)  with
 inleft (left _) =>
       3 / 8 +  (1 - x) ^ 3 * (- (025/100) + (07/10) * x) +
	 3 * x / 4 - x * x/ 8 
 | _ =>  sqrt x end .
Definition sqn x := 
  match total_order_T (x  ) ( 1)
   with
 inleft (left _) => (0375/1000) + (3*x)/ 4  - (x ^ 2)/ 8 -   (03/10)*((1 - x) ^ 3)*(x ^ 2) + 
   ((1 - x) ^ 3)*(- (0375/1000) + (13/10)*(1 - x)*x) 
  
 | _ =>  sqrt x end .
Definition upper_dih_x x1 x2 x3 x4 x5 x6 :=
  (let d := delta_x x1 x2 x3 x4 x5 x6 in
  let d4 := delta_x4 x1 x2 x3 x4 x5 x6 in (
   2 * sqrt x1 * sqp d *
    matan (4 * x1 * d / (d4 ^ 2) ) / d4)).
Definition upper_dih_y := y_of_x upper_dih_x.
Definition gamma3f_135_n y1 y2 y3 y4 y5 y6 :=
    sqn(delta_y y1 y2 y3 y4 y5 y6) * (1 / 12 - 
   ( (2 * mm1 / PI) *
         (y_of_x sol_euler_x_div_sqrtdelta y1 y2 y3 y4 y5 y6 
	  + y_of_x sol_euler156_x_div_sqrtdelta y1 y2 y3 y4 y5 y6 + 
	  y_of_x sol_euler345_x_div_sqrtdelta y1 y2 y3 y4 y5 y6) -
         (8 * mm2 / PI) *
         (y_of_x lmdih_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6 +
          y_of_x lmdih3_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6 +
          y_of_x lmdih5_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6)
   )).
Definition gamma3f_126_n y1 y2 y3 y4 y5 y6 :=
    sqn(delta_y y1 y2 y3 y4 y5 y6) * (1 / 12 - 
   ( (2 * mm1 / PI) *
         (y_of_x sol_euler_x_div_sqrtdelta y1 y2 y3 y4 y5 y6 
	  + y_of_x sol_euler246_x_div_sqrtdelta y1 y2 y3 y4 y5 y6 + 
	  y_of_x sol_euler156_x_div_sqrtdelta y1 y2 y3 y4 y5 y6) -
         (8 * mm2 / PI) *
         (y_of_x lmdih_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6 +
          y_of_x lmdih2_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6 +
          y_of_x lmdih6_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6)
   )).
Definition gamma23f_n y1 y2 y3 y4 y5 y6 w1 w2 r f :=
         gamma3f_126_n y1 y2 sqrt2 sqrt2 sqrt2 y6 / w1 +
         gamma3f_135_n y1 sqrt2 y3 sqrt2 y5 sqrt2 / w2 +
         (dih_y y1 y2 y3 y4 y5 y6 -
          upper_dih_y y1 y2 r r r y6 -
          upper_dih_y y1 y3 r r r y5) *
         (vol2r y1 r - vol2f y1 r f) / (2 * PI).
Definition gamma23f_126_03_n y1 y2 y3 y4 y5 y6 w1 r f :=
         gamma3f_126_n y1 y2 sqrt2 sqrt2 sqrt2 y6 / w1 +
         (dih_y y1 y2 y3 y4 y5 y6 - upper_dih_y y1 y2 r r r y6 - (003/100)) *
         (vol2r y1 r - vol2f y1 r f) / (2 * PI).
Definition taum_hexall_x  x14 x12 x23  x1 x2 x3 x4 x5 (x6:R) := 
   taum_x x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0) x23 x12) + flat_term_x x2.
Definition dih_hexall_x x14 x12 x23 x1 x2 x3 x4 x5 (x6:R) := 
   dih_x x1 x2 x4 ((2 * h0) ^ 2) x14 x12 - 
   dih_x x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0) x23 x12).
Definition dih1_hexall_x x14 x12 x23 x1 x2 x3 x4 x5 (x6:R) := 
   dih_x x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0) x23 x12).
Definition upper_dih_hexall_x x14 x12 x23 x1 x2 x3 x4 x5 (x6:R) := 
   dih_x x1 x2 x4 ((2 * h0) ^ 2) x14 x12 - 
   upper_dih_x x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0) x23 x12).
Definition delta_hexall_x x14 x12 x23 x1 x2 x3 x4 x5 (x6:R) := 
   delta_x x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0) x23 x12).
Definition delta4_hexall_x x14 x12 x23 x1 x2 x3 x4 x5 (x6:R) := 
   delta_x4 x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0) x23 x12).
Definition eulerA_x x1 x2 x3 x4 x5 x6 :=
  sqrt(x1) * sqrt(x2) * sqrt(x3) + sqrt(x1) * (x2 + x3 - x4) / 2 + sqrt(x2) * (x1 + x3 - x5) / 2 +
    sqrt(x3) * (x1 + x2 - x6) / 2.
Definition eulerA_hexall_x x14 x12 x23 x1 x2 x3 x4 x5 (x6:R) := 
   eulerA_x x1 x3 x4 x5 x14 (edge_flat2_x x2 x1 x3 (0) x23 x12).
Definition factor345_hexall_x c (x1:R) (x2:R) x3 x4 x5 (x6:R) := 
   x5 -x3 -x4 + 2 * c * sqrt(x3) * sqrt(x4).
Definition law_cosines_234_x c (x1:R) (x2:R) (x3:R) (x4:R) (x5:R) (x6:R) := 
   x4 -x2 -x3 + 2 * c * sqrt(x2) * sqrt(x3).
Definition law_cosines_126_x c (x1:R) (x2:R) (x3:R) (x4:R) (x5:R) (x6:R) := 
   x6 -x1 -x2 + 2 * c * sqrt(x1) * sqrt(x2).
Definition delta4_squared_x x1 x2 x3 x4 x5 x6 := (delta_x4 x1 x2 x3 x4 x5 x6) ^ 2.
Definition delta4_squared_y := y_of_x delta4_squared_x.
Definition x1_delta_x x1 x2 x3 x4 x5 x6 := x1 * delta_x x1 x2 x3 x4 x5 x6.
Definition x1_delta_y := y_of_x x1_delta_x.
Definition delta_126_x (x3s:R) (x4s:R) (x5s:R) (x1:R) (x2:R) (x3:R) (x4:R) (x5:R) (x6:R) := 
     delta_x x1 x2 x3s x4s x5s x6.
Definition delta_234_x (x1s:R) (x5s:R) (x6s:R) (x1:R) (x2:R) (x3:R) (x4:R) (x5:R) (x6:R) := 
     delta_x x1s x2 x3 x4 x5s x6s.
Definition cayleyR x12 x13 x14 x15  x23 x24 x25  x34 x35 x45 := 
  - (x14*x14*x23*x23) + 2 *x14*x15*x23*x23 - x15*x15*x23*x23 + 2 *x13*x14*x23*x24 - 2 *x13*x15*x23*x24 - 2 *x14*x15*x23*x24 + 
   2 *x15*x15*x23*x24 - x13*x13*x24*x24 + 2 *x13*x15*x24*x24 - x15*x15*x24*x24 - 2 *x13*x14*x23*x25 + 
   2 *x14*x14*x23*x25 + 2 *x13*x15*x23*x25 - 2 *x14*x15*x23*x25 + 2 *x13*x13*x24*x25 - 2 *x13*x14*x24*x25 - 2 *x13*x15*x24*x25 + 
   2 *x14*x15*x24*x25 - x13*x13*x25*x25 + 2 *x13*x14*x25*x25 - x14*x14*x25*x25 + 2 *x12*x14*x23*x34 - 2 *x12*x15*x23*x34 - 
   2 *x14*x15*x23*x34 + 2 *x15*x15*x23*x34 + 2 *x12*x13*x24*x34 - 2 *x12*x15*x24*x34 - 2 *x13*x15*x24*x34 + 2 *x15*x15*x24*x34 + 
   4 *x15*x23*x24*x34 - 2 *x12*x13*x25*x34 - 2 *x12*x14*x25*x34 + 4 *x13*x14*x25*x34 + 4 *x12*x15*x25*x34 - 2 *x13*x15*x25*x34 - 2 *x14*x15*x25*x34 - 
   2 *x14*x23*x25*x34 - 2 *x15*x23*x25*x34 - 2 *x13*x24*x25*x34 - 2 *x15*x24*x25*x34 + 2 *x13*x25*x25*x34 + 2 *x14*x25*x25*x34 - 
   x12*x12*x34*x34 + 2 *x12*x15*x34*x34 - x15*x15*x34*x34 + 2 *x12*x25*x34*x34 + 2 *x15*x25*x34*x34 - 
   x25*x25*x34*x34 - 2 *x12*x14*x23*x35 + 2 *x14*x14*x23*x35 + 2 *x12*x15*x23*x35 - 2 *x14*x15*x23*x35 - 2 *x12*x13*x24*x35 + 
   4 *x12*x14*x24*x35 - 2 *x13*x14*x24*x35 - 2 *x12*x15*x24*x35 + 4 *x13*x15*x24*x35 - 2 *x14*x15*x24*x35 - 2 *x14*x23*x24*x35 - 2 *x15*x23*x24*x35 + 
   2 *x13*x24*x24*x35 + 2 *x15*x24*x24*x35 + 2 *x12*x13*x25*x35 - 2 *x12*x14*x25*x35 - 2 *x13*x14*x25*x35 + 2 *x14*x14*x25*x35 + 
   4 *x14*x23*x25*x35 - 2 *x13*x24*x25*x35 - 2 *x14*x24*x25*x35 + 2 *x12*x12*x34*x35 - 2 *x12*x14*x34*x35 - 2 *x12*x15*x34*x35 + 
   2 *x14*x15*x34*x35 - 2 *x12*x24*x34*x35 - 2 *x15*x24*x34*x35 - 2 *x12*x25*x34*x35 - 2 *x14*x25*x34*x35 + 2 *x24*x25*x34*x35 - 
   x12*x12*x35*x35 + 2 *x12*x14*x35*x35 - x14*x14*x35*x35 + 2 *x12*x24*x35*x35 + 2 *x14*x24*x35*x35 - 
   x24*x24*x35*x35 + 4 *x12*x13*x23*x45 - 2 *x12*x14*x23*x45 - 2 *x13*x14*x23*x45 - 2 *x12*x15*x23*x45 - 2 *x13*x15*x23*x45 + 
   4 *x14*x15*x23*x45 + 2 *x14*x23*x23*x45 + 2 *x15*x23*x23*x45 - 2 *x12*x13*x24*x45 + 2 *x13*x13*x24*x45 + 2 *x12*x15*x24*x45 - 
   2 *x13*x15*x24*x45 - 2 *x13*x23*x24*x45 - 2 *x15*x23*x24*x45 - 2 *x12*x13*x25*x45 + 2 *x13*x13*x25*x45 + 2 *x12*x14*x25*x45 - 
   2 *x13*x14*x25*x45 - 2 *x13*x23*x25*x45 - 2 *x14*x23*x25*x45 + 4 *x13*x24*x25*x45 + 2 *x12*x12*x34*x45 - 2 *x12*x13*x34*x45 - 
   2 *x12*x15*x34*x45 + 2 *x13*x15*x34*x45 - 2 *x12*x23*x34*x45 - 2 *x15*x23*x34*x45 - 2 *x12*x25*x34*x45 - 2 *x13*x25*x34*x45 + 2 *x23*x25*x34*x45 + 
   2 *x12*x12*x35*x45 - 2 *x12*x13*x35*x45 - 2 *x12*x14*x35*x45 + 2 *x13*x14*x35*x45 - 2 *x12*x23*x35*x45 - 2 *x14*x23*x35*x45 - 
   2 *x12*x24*x35*x45 - 2 *x13*x24*x35*x45 + 2 *x23*x24*x35*x45 + 4 *x12*x34*x35*x45 - x12*x12*x45*x45 + 2 *x12*x13*x45*x45 - 
   x13*x13*x45*x45 + 2 *x12*x23*x45*x45 + 2 *x13*x23*x45*x45 - x23*x23*x45*x45.
Definition muR y1 y2 y3 y4 y5 y6 y7 y8 y9 x := cayleyR (y6*y6) (y5*y5) (y1*y1) (y7*y7) (y4*y4) (y2*y2) (y8*y8)  (y3*y3) (y9*y9) x.
Definition enclosed y1 y2 y3 y4 y5 y6 y7 y8 y9 := sqrt 
   (quadratic_root_plus (abc_of_quadratic (muR y1 y2 y3 y4 y5 y6 y7 y8 y9))).
