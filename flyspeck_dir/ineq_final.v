



















Lemma l_TSKAJXY_TADIAMB : forall y1 y2 y3 y4 y5 y6 , 2 * hplus <= y1 -> y1 <= sqrt8 -> 2 * hplus <= y2 -> y2 <= sqrt8 -> (20/10) <= y3 -> y3 <= sqrt8 -> (20/10) <= y4 -> y4 <= sqrt8 -> (20/10) <= y5 -> y5 <= sqrt8 -> (20/10) <= y6 -> y6 <= sqrt8 -> 
	      (
                 (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).



Lemma l_TSKAJXY_RIBCYXU_sharp : forall y1 y2 y3 y4 y5 y6 , (20/10) <= y1 -> y1 <= (2001/1000) -> (20/10) <= y2 -> y2 <= (2001/1000) -> (20/10) <= y3 -> y3 <= (2001/1000) -> (20/10) <= y4 -> y4 <= (2001/1000) -> (20/10) <= y5 -> y5 <= (2001/1000) -> (20/10) <= y6 -> y6 <= (2001/1000) -> 
	      (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun >= 0).

Lemma l_TSKAJXY_RIBCYXU_sym : forall y1 y2 y3 y4 y5 y6 , (2001/1000) <= y1 -> y1 <= 2 * hminus -> (20/10) <= y2 -> y2 <= 2 * hminus -> (20/10) <= y3 -> y3 <= 2 * hminus -> (20/10) <= y4 -> y4 <= 2 * hminus -> (20/10) <= y5 -> y5 <= 2 * hminus -> (20/10) <= y6 -> y6 <= 2 * hminus -> 
	      ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun > 0) \/
           (y1 < y2) \/ (y1 < y3) \/ (y1 < y4) \/ (y1 < y5) \/ (y1 < y6) \/
           (y2 < y3) \/ (y2 < y5) \/ (y2 < y6)).


Lemma l_TSKAJXY_IYOUOBF_sym : forall y1 y2 y3 y4 y5 y6 , 2 * hplus <= y1 -> y1 <= sqrt8 -> (2001/1000) <= y2 -> y2 <= 2 * hminus -> (20/10) <= y3 -> y3 <= 2 * hminus -> (20/10) <= y4 -> y4 <= 2 * hminus -> (20/10) <= y5 -> y5 <= 2 * hminus -> (20/10) <= y6 -> y6 <= 2 * hminus -> 
	      ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun >= 0) \/
               (y2 < y3 ) \/ (y2 < y5) \/ (y2 < y6) ).

Lemma l_TSKAJXY_IYOUOBF_sharp : forall y1 y2 y3 y4 y5 y6 , 2 * hplus <= y1 -> y1 <= sqrt8 -> (20/10) <= y2 -> y2 <= (2001/1000) -> (20/10) <= y3 -> y3 <= (2001/1000) -> (20/10) <= y4 -> y4 <= (2001/1000) -> (20/10) <= y5 -> y5 <= (2001/1000) -> (20/10) <= y6 -> y6 <= (2001/1000) -> 
	      (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun >= 0).


Lemma l_TSKAJXY_WKGUESB_sym : forall y1 y2 y3 y4 y5 y6 , 2 * hplus <= y1 -> y1 <= sqrt8 -> (201/100) <= y2 -> y2 <= 2 * hminus -> (20/10) <= y3 -> y3 <= 2 * hminus -> 2 * hplus <= y4 -> y4 <= sqrt8 -> (20/10) <= y5 -> y5 <= 2 * hminus -> (20/10) <= y6 -> y6 <= 2 * hminus -> 
	      ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun > 0) \/
         (y2 < y3) \/ (y2 < y5) \/ (y2 < y6) \/ (y1 < y4) ).

Lemma l_TSKAJXY_XLLIPLS : forall y1 y2 y3 y4 y5 y6 , 2 * hplus <= y1 -> y1 <= (28/10) -> (20/10) <= y2 -> y2 <= (201/100) -> (20/10) <= y3 -> y3 <= (201/100) -> 2 * hplus <= y4 -> y4 <= sqrt8 -> (20/10) <= y5 -> y5 <= (201/100) -> (20/10) <= y6 -> y6 <= (201/100) -> 
	      ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun > 0) ).

Lemma l_TSKAJXY_GXSABWC_DIV : forall x1 x2 x3 x4 x5 x6 , (28/10) ^ 2 <= x1 -> x1 <= 8 -> 4 <= x2 -> x2 <= (201/100) ^ 2 -> 4 <= x3 -> x3 <= (201/100) ^ 2 -> (28/10) ^ 2 <= x4 -> x4 <= 8 -> 4 <= x5 -> x5 <= (201/100) ^ 2 -> 4 <= x6 -> x6 <= (201/100) ^ 2 -> 
	      ((1 / 12 - 
		( 
		  (2 * mm1 / PI) *
		    (sol_euler_x_div_sqrtdelta x1 x2 x3 x4 x5 x6 +
		       sol_euler345_x_div_sqrtdelta x1 x2 x3 x4 x5 x6 +
		       sol_euler156_x_div_sqrtdelta x1 x2 x3 x4 x5 x6 +
		       sol_euler246_x_div_sqrtdelta x1 x2 x3 x4 x5 x6) -
		    (8 * mm2 / PI) * (
		      ldih2_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 +
		      ldih3_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 +
		      ldih5_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 +
		      ldih6_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6
		    )
		) >= 0)   \/   
	      (delta_x x1 x2 x3 x4 x5 x6 < 0) ).


Lemma l_GLFVCVK4_2477216213 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2 <= y2 -> y2 <= sqrt8 -> 2 <= y3 -> y3 <= sqrt8 -> 2 <= y4 -> y4 <= sqrt8 -> 2 <= y5 -> y5 <= sqrt8 -> 2 <= y6 -> y6 <= sqrt8 -> 
    ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun > 0)\/ 
    (norm2hh y1 y2 y3 y4 y5 y6 <  (hplus- hminus) ^ 2) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_GLFVCVK4a_8328676778 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus  -> 2  <= y2 -> y2 <= 2 * hminus  -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus   <= y4 -> y4 <= 2 * hplus  -> 2 <= y5 -> y5 <= 2 * hminus  -> 2 <= y6 -> y6 <= 2 * hminus  -> 
    ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 +
    beta_bump_force_y y1 y2 y3 y4 y5 y6 > 0)\/ 
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).



Lemma l_GLFVCVK3_a_sharp : forall  y1 y2 y3 y4 y5 y6 , 2  <=  y1 ->  y1 <=  (2001/1000) -> 2 <= y2 -> y2 <= (2001/1000) -> sqrt2 <= y3 -> y3 <= sqrt2 -> sqrt2 <= y4 -> y4 <= sqrt2 -> sqrt2 <= y5 -> y5 <= sqrt2 -> 2 <= y6 -> y6 <= (2001/1000) -> 
    ((vol_y y1 y2 y3 y4 y5 y6 - ( (2 * mm1 / PI) *
         (2 * dih_y y1 y2 y3 y4 y5 y6 + 2 * dih2_y y1 y2 y3 y4 y5 y6 +
          2 * dih6_y y1 y2 y3 y4 y5 y6 + dih3_y y1 y2 y3 y4 y5 y6 +
	  dih4_y y1 y2 y3 y4 y5 y6 + dih5_y y1 y2 y3 y4 y5 y6 - 3 * PI) -
         (8 * mm2 / PI) *
         (lmfun (y1 / 2) * dih_y y1 y2 y3 y4 y5 y6 +
          lmfun (y2 / 2) * dih2_y y1 y2 y3 y4 y5 y6 +
          lmfun (y6 / 2) * dih6_y y1 y2 y3 y4 y5 y6)) >= 0)\/ 
     (delta_y y1 y2 y3 y4 y5 y6 < (099/100)) ).

Lemma l_GLFVCVK3_a_nonsharp : forall  y1 y2 y3 y4 y5 y6 , (2001/1000)  <=  y1 ->  y1 <=  sqrt8 -> 2 <= y2 -> y2 <= sqrt8 -> sqrt2 <= y3 -> y3 <= sqrt2 -> sqrt2 <= y4 -> y4 <= sqrt2 -> sqrt2 <= y5 -> y5 <= sqrt2 -> 2 <= y6 -> y6 <= sqrt8 -> 
    ((vol_y y1 y2 y3 y4 y5 y6 - ( (2 * mm1 / PI) *
         (2 * dih_y y1 y2 y3 y4 y5 y6 + 2 * dih2_y y1 y2 y3 y4 y5 y6 +
          2 * dih6_y y1 y2 y3 y4 y5 y6 + dih3_y y1 y2 y3 y4 y5 y6 +
	  dih4_y y1 y2 y3 y4 y5 y6 + dih5_y y1 y2 y3 y4 y5 y6 - 3 * PI) -
         (8 * mm2 / PI) *
         (lmfun (y1 / 2) * dih_y y1 y2 y3 y4 y5 y6 +
          lmfun (y2 / 2) * dih2_y y1 y2 y3 y4 y5 y6 +
          lmfun (y6 / 2) * dih6_y y1 y2 y3 y4 y5 y6))  >= 0)\/ 
       (y1 < y2) \/ (y2 < y6) \/
     (delta_y y1 y2 y3 y4 y5 y6 < (099/100)) ).

Lemma l_GLFVCVK3_b : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= sqrt8 -> sqrt2 <= y2 -> y2 <= sqrt2 -> 2 <= y3 -> y3 <= sqrt8 -> sqrt2 <= y4 -> y4 <= sqrt2 -> 2 <= y5 -> y5 <= sqrt8 -> sqrt2 <= y6 -> y6 <= sqrt2 -> 
    (( 1 / 12 - 
   ( (2 * mm1 / PI) *
         (y_of_x sol_euler_x_div_sqrtdelta y1 y2 y3 y4 y5 y6 
	  + y_of_x sol_euler156_x_div_sqrtdelta y1 y2 y3 y4 y5 y6 + 
	  y_of_x sol_euler345_x_div_sqrtdelta y1 y2 y3 y4 y5 y6) -
         (8 * mm2 / PI) *
         (y_of_x lmdih_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6 +
          y_of_x lmdih3_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6 +
          y_of_x lmdih5_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6)

   )  > 0) \/ 
     (delta_y y1 y2 y3 y4 y5 y6 < 0) \/
          (delta_y y1 y2 y3 y4 y5 y6 > (10/10) )  ).


Lemma l_GLFVCVK2_a : forall y , (20/10) <= y -> y <= 2 * h0  -> 
   (vol2r y sqrt2 - vol2f y sqrt2 lfun > 0).

Lemma l_GLFVCVK2_b : forall y , 2 * h0 <= y -> y <= sqrt8  -> 
   (vol2r y sqrt2 -  (2 * mm1 / PI) * 2 * PI * (1 - y / (sqrt2 * 2)) > 0).


Lemma l_HJKDESR1a : forall  r , sqrt2 <=  r ->  r <=  sqrt2 -> 
   ( 4 * PI * (r ^ 3) / (3)  -  (2 * mm1 / PI) * 4 * PI >= 0) .



Lemma l_FHBVYXZ_a : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus  -> 2  <= y2 -> y2 <= 2 * hminus  -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus  -> 2 <= y6 -> y6 <= 2 * hminus  -> 
      ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  
	> 0)\/ 
	 (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2) \/ (eta_y y1 y3 y5 ^ 2 < (134/100) ^ 2)).

Lemma l_FHBVYXZ_b : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus  -> 2 <= y2 -> y2 <= 2 * hminus  -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus  -> 2 <= y6 -> y6 <= 2 * hminus  -> 
      ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  + gamma3f y1 y2 y6 sqrt2 lmfun
	> 0)\/ 
	 (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2) \/ (eta_y y1 y2 y6 ^ 2 > (134/100) ^ 2)).




Lemma l_ZTGIJCF0 : forall dummy , 1 <= dummy -> dummy <= 1 -> 
   ( 5 * a_spine5 + b_spine5 * 2 * PI  > 0).


















Lemma l_BIXPCGW_9455898160 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <=  2 * hminus -> 2 <= y4 -> y4 <=  2 * hminus -> 2 <= y5 -> y5 <=  2 * hminus -> 2 <= y6 -> y6 <=  2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun > - (000569/100000)) .

Lemma l_BIXPCGW_2300537674 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <=  2 * hminus -> 2 <= y4 -> y4 <=  2 * hminus -> 2 <= y5 -> y5 <=  2 * hminus -> 2 <= y6 -> y6 <=  2 * hminus -> 
    ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun > 0) \/ (dih_y y1 y2 y3 y4 y5 y6 < (165/100))).

Lemma l_BIXPCGW_6652007036_a : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  sqrt8 -> 2 <= y3 -> y3 <=  sqrt8 -> 2 <= y4 -> y4 <=  sqrt8 -> 2 <= y5 -> y5 <=  sqrt8 -> 2 <= y6 -> y6 <=  sqrt8 -> 
   ((dih_y y1 y2 y3 y4 y5 y6 < (28/10)) \/ (delta_y y1 y2 y3 y4 y5 y6 < 60)).

Lemma l_BIXPCGW_7080972881_a : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 * hminus <= y2 -> y2 <=  sqrt8 -> 2 <= y3 -> y3 <=  sqrt8 -> 2 <= y4 -> y4 <=  sqrt8 -> 2 <= y5 -> y5 <=  sqrt8 -> 2 <= y6 -> y6 <=  sqrt8 -> 
    ((dih_y y1 y2 y3 y4 y5 y6 < (23/10)) \/ (delta_y y1 y2 y3 y4 y5 y6 < 60)).

Lemma l_BIXPCGW_1738910218_a : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  sqrt8 -> 2 <= y3 -> y3 <=  sqrt8 -> 2 <= y4 -> y4 <=  2 * hplus -> 2 <= y5 -> y5 <=  sqrt8 -> 2 <= y6 -> y6 <=  sqrt8 -> 
   ( (dih_y y1 y2 y3 y4 y5 y6 < (23/10)) \/ (delta_y y1 y2 y3 y4 y5 y6 < 60)).

Lemma l_BIXPCGW_b : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  sqrt8 -> 2 <= y3 -> y3 <=  sqrt8 -> 2 <= y4 -> y4 <=  2 * hplus -> 2 <= y5 -> y5 <=  sqrt8 -> 2 <= y6 -> y6 <=  sqrt8 -> 
   ( (delta4_y y1 y2 y3 y4 y5 y6 > 0) \/ (delta_y y1 y2 y3 y4 y5 y6 > 60) \/ (delta_y y1 y2 y3 y4 y5 y6 < 0)).

Lemma l_BIXPCGW_7274157868 : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  sqrt8 -> 2 <= y3 -> y3 <=  sqrt8 -> 2 <= y4 -> y4 <=  sqrt8 -> 2 <= y5 -> y5 <=  sqrt8 -> 2 <= y6 -> y6 <=  sqrt8 -> 
    ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun > (00057/10000)) \/
    (dih_y y1 y2 y3 y4 y5 y6 < (23/10))).

Lemma l_QITNPEA_5653753305 : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <=  2 * hminus -> 2 <= y4 -> y4 <=  2 * hminus -> 2 <= y5 -> y5 <=  2 * hminus -> 2 <= y6 -> y6 <=  2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun + (00659/10000) 
      - (0042/1000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)).

Lemma l_QITNPEA_9939613598 : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <=  2 * hminus -> 2 * hplus <= y4 -> y4 <=  sqrt8 -> 2 <= y5 -> y5 <=  2 * hminus -> 2 <= y6 -> y6 <=  2 * hminus -> 
    ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun - (000457511/100000000) 
    - (000609451/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
   (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA_4003532128_a : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  sqrt8 -> sqrt2 <= y3 -> y3 <= sqrt2 -> sqrt2 <= y4 -> y4 <= sqrt2 -> sqrt2 <= y5 -> y5 <= sqrt2 -> 2 <= y6 -> y6 <=  sqrt8 -> 
    (
     (delta4_y y1 y2 y3 y4 y5 y6 > 25) \/
   (delta_y y1 y2 y3 y4 y5 y6 > (014/100)) \/
    (delta_y y1 y2 y3 y4 y5 y6 < 0) ).


Lemma l_QITNPEA_4003532128_b_sym : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <=  2 * hminus -> (21/10)  <= y4 -> y4 <=  sqrt8 -> 2 <= y5 -> y5 <=  2 * hminus -> 2 <= y6 -> y6 <=  2 * hminus -> 
    ( (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < (014/100)) \/
  (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
 (y2 < y3) \/ (y2 < y5) \/ (y2 < y6) \/
     (gamma23f_n y1 y2 y3 y4 y5 y6 1 1 sqrt2 lmfun - (000457511/100000000) 
    - (000609451/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) 
   ).

Lemma l_QITNPEA_4003532128_b2 : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <=  2 * hminus -> (21/10)  <= y4 -> y4 <=  (21/10) -> 2 <= y5 -> y5 <=  2 * hminus -> 2 <= y6 -> y6 <=  2 * hminus -> 
    ( (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < (014/100)) \/
  (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
   (gamma23f_n y1 y2 y3 y4 y5 y6 1 1 sqrt2 lmfun - (000457511/100000000) 
    - (000609451/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10))
   ).

Lemma l_QITNPEA_4003532128_c : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <=  2 * hminus -> (21/10)  <= y4 -> y4 <=  (21/10) -> 2 <= y5 -> y5 <=  2 * hminus -> 2 <= y6 -> y6 <=  2 * hminus -> 
    (    (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < 0) \/  
   (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 > (014/100)) \/
   ( gamma23f_126_03_n y1 y2 y3 y4 y5 y6 1 sqrt2 lmfun  
       - (000457511/100000000) 
    - (000609451/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10))
 ).

Lemma l_QITNPEA_4003532128_d : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <=  2 * hminus -> (21/10)  <= y4 -> y4 <=  sqrt8 -> 2 <= y5 -> y5 <=  2 * hminus -> 2 <= y6 -> y6 <=  2 * hminus -> 
    ((   
      gamma23f_red_03 y1 y2 y3 y4 y5 y6 sqrt2 lmfun   
	 - (000457511/100000000) 
    - (000609451/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 > (014/100) ) \/
    (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < 0 ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 > (014/100))  \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < 0)   ).

Lemma l_QITNPEA_3725403817 : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <=  2 * hminus -> (2)  <= y4 -> y4 <=  (21/10) -> 2 <= y5 -> y5 <=  2 * hminus -> 2 <= y6 -> y6 <=  2 * hminus -> 
    (dih_y y1 y2 y3 y4 y5 y6 < (156/100)) .

Lemma l_QITNPEA_6206775865 : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <=  2 * hminus -> (2)  <= y4 -> y4 <=  2 * hminus -> 2 <= y5 -> y5 <=  2 * hminus -> 2 <= y6 -> y6 <=  2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun + (00142852/10000000) - (000609451/100000000) *dih_y y1 y2 y3 y4 y5 y6 > (00/10)) .

Lemma l_QITNPEA_5814748276 : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <=  2 * hminus -> (2)  <= y4 -> y4 <=  2 * hminus -> 2 <= y5 -> y5 <=  2 * hminus -> 2 <= y6 -> y6 <=  2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun - (000127562/100000000) + (000522841/100000000) * dih_y y1 y2 y3 y4 y5 y6 > (00/10)) .

Lemma l_QITNPEA_3848804089 : forall y1 y2 y3 y4 y5 y6 , 2 * hminus <= y1 -> y1 <=  2 * hplus -> 2 <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <=  2 * hminus -> (2)  <= y4 -> y4 <=  2 * hminus -> 2 <= y5 -> y5 <=  2 * hminus -> 2 <= y6 -> y6 <=  2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun - (0161517/1000000) + (0119482/1000000)* dih_y y1 y2 y3 y4 y5 y6 > (00/10)) .







Lemma l_QITNPEA_2134082733 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2  <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2  <= y5 -> y5 <= 2 * hminus -> 2  <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + beta_bump_lb 
         - (0213849/1000000) + (0119482/1000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10) ) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA__5400790175_a : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2  <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2  <= y5 -> y5 <= 2 * hminus -> 2  <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + beta_bump_lb  > (00057/10000))  \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2) \/
    (eta_y y1 y2 y6 ^ 2 < (134/100) ^ 2)).

Lemma l_QITNPEA__5400790175_b : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2  <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2  <= y5 -> y5 <= 2 * hminus -> 2  <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + beta_bump_lb 
       + gamma3f y1 y2 y6 sqrt2 lmfun > (00057/10000))  \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2) \/
    (eta_y y1 y2 y6 ^ 2 > (134/100) ^ 2)).



Lemma l_1965189142_34 : forall x1 x2 x3 x4 x5 x6 , (10/10) <= x1 -> x1 <= (126/100) -> 1 <= x2 -> x2 <= 1 -> 1 <= x3 -> x3 <= 1 -> 1 <= x4 -> x4 <= 1 -> 1 <= x5 -> x5 <= 1 -> 1 <= x6 -> x6 <= 1 -> 
  ((0591/1000) - (00331/10000) * 34 + (0506/1000) * lfun_y1 x1 x2 x3 x4 x5 x6 < 0).

Lemma l_1965189142_a : forall x1 x2 x3 x4 x5 x6 , (10/10) <= x1 -> x1 <= (126/100) -> (30/10) <= x2 -> x2 <= (340/10) -> 1 <= x3 -> x3 <= 1 -> 1 <= x4 -> x4 <= 1 -> 1 <= x5 -> x5 <= 1 -> 1 <= x6 -> x6 <= 1 -> 
        (2 * PI - 2 * asnFnhk x1 x2 x3 x4 x5 x6 > (0591/1000) - (00331/10000) * x2 + (0506/1000) * lfun_y1 x1 x2 x3 x4 x5 x6).

Lemma l_8055810915 : forall  x1 x2 x3 x4 x5 x6 , 4 <=  x1 ->  x1 <=  (252/100) ^ 2 -> 4 <= x2 -> x2 <= 4 -> (2 * h0) ^ 2 <= x3 -> x3 <= (2 * h0) ^ 2 -> 1 <= x4 -> x4 <= 1 -> 1 <= x5 -> x5 <= 1 -> 1 <= x6 -> x6 <= 1 -> 
 (acs_sqrt_x1_d4 x1 x2 x3 x4 x5 x6 - PI/ (6) + (0797/1000) < arclength_x_123 x1 x2 x3 x4 x5 x6).

Lemma l_6096597438_a : forall h , (10/10) <= h -> h <= (10/10) -> 
  ((0591/1000) - (00331/10000) * 64 + (0506/1000) * lfun (1) + (10/10) < 0).

Lemma l_6096597438_b : forall x1 x2 x3 x4 x5 x6 , (30/10) <= x1 -> x1 <= (640/10) -> 1 <= x2 -> x2 <= 1 -> 1 <= x3 -> x3 <= 1 -> 1 <= x4 -> x4 <= 1 -> 1 <= x5 -> x5 <= 1 -> 1 <= x6 -> x6 <= 1 ->     
        (2 * PI - 2 * asn797k x1 x2 x3 x4 x5 x6 > 
          (0591/1000) - (00331/10000) * x1 + (0506/1000) * lfun (1) + (10/10)).


Lemma l_4717061266 : forall  y1  y2  y3  y4  y5  y6 , 2 <=  y1 ->  y1 <=  2*h0 -> 2 <=  y2 ->  y2 <=  2*h0 -> 2 <=  y3 ->  y3 <=  2*h0 -> 2 <=  y4 ->  y4 <=  2*h0 -> 2 <=  y5 ->  y5 <=  2*h0 -> 2 <=  y6 ->  y6 <=  2*h0 -> 
  (delta_y y1 y2 y3 y4 y5 y6 > 0).


Lemma l_OMKYNLT_3336871894 : forall y1 y2 y3 y4 y5 y6 , (20/10) <= y1 -> y1 <= (252/100) -> (20/10) <= y2 -> y2 <= (252/100) -> (20/10) <= y3 -> y3 <= (252/100) -> 2 <= y4 -> y4 <= 2 -> 2 <= y5 -> y5 <= 2 -> 2 <= y6 -> y6 <= 2 -> 
( taum y1 y2 y3 y4 y5 y6 >= (00/10)).

Lemma l_OMKYNLT_2_1 : forall y1 y2 y3 y4 y5  y6 , (20/10) <= y1 -> y1 <= (252/100) -> (20/10) <= y2 -> y2 <= (252/100) -> (20/10) <= y3 -> y3 <= (252/100) -> 2 <= y4 -> y4 <= 2 -> 2 <= y5 -> y5 <= 2 -> 2 * h0 <=  y6 ->  y6 <=  2 * h0 -> 
( taum y1 y2 y3 y4 y5 y6  > tame_table_d 2 1).

Lemma l_OMKYNLT_1_2 : forall y1 y2 y3 y4 y5 y6 , (20/10) <= y1 -> y1 <= (252/100) -> (20/10) <= y2 -> y2 <= (252/100) -> (20/10) <= y3 -> y3 <= (252/100) -> 2 <= y4 -> y4 <= 2 -> 2 * h0 <= y5 -> y5 <= 2 * h0 -> 2 * h0 <= y6 -> y6 <= 2 * h0 -> 
( taum y1 y2 y3 y4 y5 y6 > tame_table_d 1 2).

Lemma l_OMKYNLT_0_3 : forall y1 y2 y3 y4 y5 y6 , (20/10) <= y1 -> y1 <= (252/100) -> (20/10) <= y2 -> y2 <= (252/100) -> (20/10) <= y3 -> y3 <= (252/100) -> (252/100) <= y4 -> y4 <= (252/100) -> (252/100) <= y5 -> y5 <= (252/100) -> (252/100) <= y6 -> y6 <= (252/100) -> 
( taum y1 y2 y3 y4 y5 y6 > tame_table_d 0 3).

Lemma l_SDCCMGA_a : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= (252/100) -> 1 <= y2 -> y2 <= 1 -> 1 <= y3 -> y3 <= 1 -> 1 <= y4 -> y4 <= 1 -> 1 <= y5 -> y5 <= 1 -> 1 <= y6 -> y6 <= 1 -> 
 (arclength_y1 (2) (2 * h0) y1 y2 y3 y4 y5 y6 + 
  arclength_y1  (2) (2 * h0) y1 y2 y3 y4 y5 y6 <
   arclength_y1 (2*h0) (2 * h0) y1 y2 y3 y4 y5 y6 + 
    2 * arc_hhn).

Lemma l_SDCCMGA_b : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= (252/100) -> 1 <= y2 -> y2 <= 1 -> 1 <= y3 -> y3 <= 1 -> 1 <= y4 -> y4 <= 1 -> 1 <= y5 -> y5 <= 1 -> 1 <= y6 -> y6 <= 1 -> 
 (arclength_y1 (2) (2 * h0) y1 y2 y3 y4 y5 y6 + 
  arclength_y1 (2) (2 * h0) y1 y2 y3 y4 y5 y6 <
   arclength_y1 (2*h0) (2) y1 y2 y3 y4 y5 y6 + 
  PI / 3   + arc_hhn).

Lemma l_JNTEFVP_1 : forall x1 x2 x3 x4 x5 x6 , 4 <= x1 -> x1 <= (2 * h0) ^ 2 -> 4 <= x2 -> x2 <= (2 * h0) ^ 2 -> 4 <= x3 -> x3 <= (2 * h0) ^ 2 -> 4 <= x4 -> x4 <= (2 * h0) ^ 2 -> 4 <= x5 -> x5 <= (2 * h0) ^ 2 -> 8  <= x6 -> x6 <=  (4 * h0) ^ 2 -> 
  (delta_x4 x1 x2 x3 x4 x5 x6 > 0).


Lemma l_4652969746_1 : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= (252/100) -> 2 <= y2 -> y2 <= (252/100) -> 2 <= y3 -> y3 <= (252/100) -> (21771/10000) <= y4 -> y4 <= (252/100) -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100) -> 
 (taum y1 y2 y3 y4 y5 y6 > (004/100)).

Lemma l_4652969746_2 : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= (252/100) -> 2 <= y2 -> y2 <= (252/100) -> 2 <= y3 -> y3 <= (252/100) -> 2 <= y4 -> y4 <= (21771/10000) -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100) -> 
 (taum y1 y2 y3 y4 y5 y6 - (0312/1000) * (dih_y y1 y2 y3 y4 y5 y6 - 2 * PI/ 5)  > (004/100) / 5).

Lemma l_2570626711 : forall y1 y2 y3 y4 y5 y6 , (20/10) <= y1 -> y1 <= 2 * h0 -> (20/10) <= y2 -> y2 <= 2 * h0 -> (20/10) <= y3 -> y3 <= 2 * h0 -> 2 * h0 <= y4 -> y4 <= 2 * h0 -> (20/10) <= y5 -> y5 <= 2 * h0 -> (20/10) <= y6 -> y6 <= 2 * h0 -> 
   (dih_y y1 y2 y3 y4 y5 y6 > (115/100)).




Definition dart_std4 y1 y2 y3 y4 y5 y6 y7 y8 y9  := (20/10) <= y1 -> y1 <= 2 * h0 -> (20/10) <= y2 -> y2 <= 2 * h0 -> (20/10) <= y3 -> y3 <= 2 * h0 -> 2 * h0 <= y4 -> y4 <= (437/100) -> (20/10) <= y5 -> y5 <= 2 * h0 -> (20/10) <= y6 -> y6 <= 2 * h0 -> (20/10) <= y7 -> y7 <= 2 * h0 -> (20/10) <= y8 -> y8 <= 2 * h0 -> (20/10) <= y9 -> y9 <= 2 * h0.


Lemma l_8673686234_a : forall y1 y2 y3 y4 y5 y6 , sqrt8 <= y1 -> y1 <= (30/10) -> 2 <= y2 -> y2 <= (207/100) -> 2 <= y3 -> y3 <= (207/100) -> sqrt8 <= y4 -> y4 <= 4 * h0 -> 2 <= y5 -> y5 <= (207/100) -> 2 <= y6 -> y6 <= (207/100) -> 
    ((y2 + y3 + y5 + y6 - (799/100) - (000385/100000) * delta_y y1 y2 y3 y4 y5 y6 >   (275/100) * ((y1 + y4)/ 2 - sqrt8)) 
    )  .

Lemma l_8673686234_b : forall y1 y2 y3 y4 y5 y6 , sqrt8 <= y1 -> y1 <= (30/10) -> (207/100) <= y2 -> y2 <= 2 * h0 -> 2 <= y3 -> y3 <= 2 * h0 -> (30/10) <= y4 -> y4 <= (30/10) -> 2 <= y5 -> y5 <= 2 * h0 -> 2 <= y6 -> y6 <= 2 * h0 -> 
    ((y2 + y3 + y5 + y6 - (799/100) > (275/100) * (y1 - sqrt8)) \/
     (delta_y y1 y2 y3 y4 y5 y6 < 0)  )  .

Lemma l_8673686234_c : forall y1 y2 y3 y4 y5 y6 , sqrt8 <= y1 -> y1 <= (30/10) -> (207/100) <= y2 -> y2 <= 2 * h0 -> 2 <= y3 -> y3 <= 2 * h0 -> sqrt8 <= y4 -> y4 <= (30/10) -> 2 <= y5 -> y5 <= 2 * h0 -> 2 <= y6 -> y6 <= 2 * h0 -> 
    ((y2 + y3 + y5 + y6 - (799/100) >   (275/100) * ((y1 + y4)/ 2 - sqrt8)) \/
   (y2 + y3 + y5 + y6 - (799/100) - (000385/100000) * delta_y y1 y2 y3 y4 y5 y6 >   (275/100) * ((y1 + y4)/ 2 - sqrt8)) \/
     (delta_y y1 y2 y3 y4 y5 y6 < 0)  )  .


Lemma l_7043724150_a : forall y1 y2 y3 y4 y5 y6 y7 y8 y9  , dart_std4 y1 y2 y3 y4 y5 y6 y7 y8 y9 -> 
(( tauq y1 y2 y3 y4 y5 y6 y7 y8 y9 + (472/100) * dih_y y1 y2 y3 y4 y5 y6 - (6248/1000) > (00/10)) \/
  ( enclosed y1 y5 y6 y4 y2 y3 y7 y8 y9 < sqrt8 ) ).

Lemma l_7043724150_a_reduced : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= 2 * h0 -> 2 <= y2 -> y2 <= 2 * h0 -> 2 <= y3 -> y3 <= 2 * h0 -> 2 <= y4 -> y4 <= 2 * h0 -> 2 * h0 <= y5 -> y5 <= 2 * h0 -> 2 <= y6 -> y6 <= 2 * h0 -> 
( taum y1 y2 y3 y4 y5 y6 + (472/100) * dih_y y1 y2 y3 y4 y5 y6 - (6248/1000) / 2 > (00/10)).

Lemma l_6944699408_a : forall y1 y2 y3 y4 y5 y6 y7 y8 y9  , dart_std4 y1 y2 y3 y4 y5 y6 y7 y8 y9 -> 
(( tauq y1 y2 y3 y4 y5 y6 y7 y8 y9 + (0972/1000) * dih_y y1 y2 y3 y4 y5 y6 -  (1707/1000) > (00/10)) \/
   ( enclosed y1 y5 y6 y4 y2 y3 y7 y8 y9 < sqrt8 )).

Lemma l_6944699408_a_reduced : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= 2 * h0 -> 2 <= y2 -> y2 <= 2 * h0 -> 2 <= y3 -> y3 <= 2 * h0 -> 2 <= y4 -> y4 <= 2 * h0 -> 2 * h0 <= y5 -> y5 <= sqrt8 -> 2 <= y6 -> y6 <= 2 * h0 -> 
( taum y1 y2 y3 y4 y5 y6 + (0972/1000) * dih_y y1 y2 y3 y4 y5 y6 -  (1707/1000) / 2 > (00/10)).

Lemma l_4240815464_a : forall y1 y2 y3 y4 y5 y6 y7 y8 y9  , dart_std4 y1 y2 y3 y4 y5 y6 y7 y8 y9 -> 
(( tauq y1 y2 y3 y4 y5 y6 y7 y8 y9 + 
   (07573/10000) *dih_y y1 y2 y3 y4 y5 y6 - (1433/1000) > (00/10)) \/
  ( enclosed y1 y5 y6 y4 y2 y3 y7 y8 y9 < sqrt8 ) \/
( delta_y y1 y2 y3 y4 y5 y6 < 0) \/
( delta_y y7 y2 y3 y4 y8 y9 < 0)) .

Lemma l_4240815464_a_reduced : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= 2 * h0 -> 2 <= y2 -> y2 <= 2 * h0 -> 2 <= y3 -> y3 <= 2 * h0 -> 2 <= y4 -> y4 <= 2 * h0 -> 2 * h0 <= y5 -> y5 <= sqrt8 -> 2 <= y6 -> y6 <= 2 * h0 -> 
( taum y1 y2 y3 y4 y5 y6 + 
   (07573/10000) *dih_y y1 y2 y3 y4 y5 y6 - (1433/1000) / 2 > (00/10)).

Lemma l_3862621143_revised : forall y1 y2 y3 y4 y5 y6 y7 y8 y9  , dart_std4 y1 y2 y3 y4 y5 y6 y7 y8 y9 -> 
(( tauq y1 y2 y3 y4 y5 y6 y7 y8 y9 - (0453/1000) * dih_y y1 y2 y3 y4 y5 y6 +  (0777/1000) > (00/10)) \/
 ( enclosed y1 y5 y6 y4 y2 y3 y7 y8 y9 < (301/100) )  \/
( delta_y y1 y2 y3 y4 y5 y6 < 0) \/
  (y4 < (29/10)) \/
( delta_y y7 y2 y3 y4 y8 y9 < 0)) .

Lemma l_3862621143_side : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= 2 * h0 -> 2 <= y2 -> y2 <= 2 * h0 -> 2 <= y3 -> y3 <= 2 * h0 -> 2 <= y4 -> y4 <= 2 * h0 -> 2 * h0 <= y5 -> y5 <= (301/100) -> 2 <= y6 -> y6 <= 2 * h0 -> 
( taum y1 y2 y3 y4 y5 y6 - (0453/1000) * dih_y y1 y2 y3 y4 y5 y6 +  (0777/1000) / 2  > (00/10)).

Lemma l_3862621143_front : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= 2 * h0 -> 2 <= y2 -> y2 <= 2 * h0 -> 2 <= y3 -> y3 <= 2 * h0 -> 2 * h0 <= y4 -> y4 <= (29/10) -> 2  <= y5 -> y5 <= 2 * h0 -> 2 <= y6 -> y6 <= 2 * h0 -> 
( taum y1 y2 y3 y4 y5 y6 + tame_table_d 2 1 - (0453/1000) * dih_y y1 y2 y3 y4 y5 y6 +  (0777/1000)   > (00/10)).

Lemma l_3862621143_back : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= 2 * h0 -> 2 <= y2 -> y2 <= 2 * h0 -> 2 <= y3 -> y3 <= 2 * h0 -> sqrt8 <= y4 -> y4 <= (301/100) -> 2  <= y5 -> y5 <= 2 * h0 -> 2 <= y6 -> y6 <= 2 * h0 -> 
( taum y1 y2 y3 y4 y5 y6    > tame_table_d 2 1).



Lemma l_5691615370 : forall y1 y2 y3 y4 y5 y6 , (30/10) <= y1 -> y1 <= (30/10) -> 2 <= y2 -> y2 <= (252/100) -> 2 <= y3 -> y3 <= (252/100) -> (30/10) <= y4 -> y4 <= (30/10) -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100) -> 
  ((delta_y y1 y2 y3 y4 y5 y6 < 0) \/ (y2 + y3 + y5 + y6 > (8472/1000)) \/
   (y2 < y3) \/ (y2 < y5) \/ (y2 < y6 ) \/ (y3 < y6)).

Definition dart4_diag3_b y1 y2 y3 y4 y5 y6 y7 y8 y9  := 2 <= y1 -> y1 <= (252/100) -> 2 <= y2 -> y2 <= (252/100) -> 2 <= y3 -> y3 <= (252/100) -> 3 <= y4 -> y4 <= 3 -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100) -> 2 <= y7 -> y7 <= (252/100) -> 2 <= y8 -> y8 <= (252/100) -> 2 <= y9 -> y9 <= (252/100).

Lemma l_9563139965D : forall y1 y2 y3 y4 y5 y6 y7 y8 y9  , dart4_diag3_b y1 y2 y3 y4 y5 y6 y7 y8 y9 -> 
((tauq y1 y2 y3 y4 y5 y6 y7 y8 y9  > (0467/1000)) \/ 
  (enclosed  y1 y5 y6 y4 y2 y3 y7 y8 y9 < 3 )).

Lemma l_9563139965_d : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= 2 * h0 -> 2 <= y2 -> y2 <= 2 * h0 -> 2 <= y3 -> y3 <= 2 * h0 -> 3 <= y4 -> y4 <= 3 -> 2 <= y5 -> y5 <= (2472/1000) -> 2 <= y6 -> y6 <= (2472/1000) -> 
((taum y1 y2 y3 y4 y5 y6  + (05/10) * ( (8472/1000) / 2 - y5 - y6) > (0467/1000) / 2)).

Lemma l_9563139965_e : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= 2 * h0 -> 2 <= y2 -> y2 <= 2 * h0 -> 2 <= y3 -> y3 <= 2 * h0 -> 3 <= y4 -> y4 <= 3 -> (2467/1000) <= y5 -> y5 <= 2 * h0 -> 2 <= y6 -> y6 <= 2 * h0 -> 
((taum y1 y2 y3 y4 y5 y6   > (0467/1000) - (0115/1000))).

Lemma l_9563139965_f : forall y1 y2 y3 y4 y5 y6 , 2 <= y1 -> y1 <= 2 * h0 -> 2 <= y2 -> y2 <= 2 * h0 -> 2 <= y3 -> y3 <= 2 * h0 -> 3 <= y4 -> y4 <= 3 -> 2 <= y5 -> y5 <= 2 * h0 -> 2 <= y6 -> y6 <= 2 * h0 -> 
((taum y1 y2 y3 y4 y5 y6   >  (0115/1000))).


Definition dart_std3 y1 y2 y3 y4 y5 y6  := (20/10) <= y1 -> y1 <= (252/100) -> (20/10) <= y2 -> y2 <= (252/100) -> (20/10) <= y3 -> y3 <= (252/100) -> (20/10) <= y4 -> y4 <= (252/100) -> (20/10) <= y5 -> y5 <= (252/100) -> (20/10) <= y6 -> y6 <= (252/100).

Lemma l_5735387903 : forall y1 y2 y3 y4 y5 y6  , dart_std3 y1 y2 y3 y4 y5 y6 -> 
   (dih_y y1 y2 y3 y4 y5 y6 > (0852/1000)).

Lemma l_5490182221 : forall y1 y2 y3 y4 y5 y6  , dart_std3 y1 y2 y3 y4 y5 y6 -> 
   (dih_y y1 y2 y3 y4 y5 y6 < (1893/1000)).

Lemma l_3296257235 : forall y1 y2 y3 y4 y5 y6  , dart_std3 y1 y2 y3 y4 y5 y6 -> 
 (taum y1 y2 y3 y4 y5 y6 + (0626/1000) * dih_y y1 y2 y3 y4 y5 y6 - (077/100) > (00/10)).

Lemma l_8519146937 : forall y1 y2 y3 y4 y5 y6  , dart_std3 y1 y2 y3 y4 y5 y6 -> 
    ( taum y1 y2 y3 y4 y5 y6 -  (0259/1000) * dih_y y1 y2 y3 y4 y5 y6 + (032/100) > (00/10)).

Lemma l_4667071578 : forall y1 y2 y3 y4 y5 y6  , dart_std3 y1 y2 y3 y4 y5 y6 -> 
    ( taum y1 y2 y3 y4 y5 y6 -  (0507/1000) * dih_y y1 y2 y3 y4 y5 y6 + (0724/1000) > (00/10)).

Lemma l_1395142356 : forall y1 y2 y3 y4 y5 y6  , dart_std3 y1 y2 y3 y4 y5 y6 -> 
   ( taum y1 y2 y3 y4 y5 y6 + (0001/1000) - (018/100) * (y1 + y2 + y3 - (60/10)) -
  (0125/1000) * (y4 + y5 + y6 - (60/10)) > (00/10)).

Lemma l_7394240696 : forall y1 y2 y3 y4 y5 y6  , dart_std3 y1 y2 y3 y4 y5 y6 -> 
( sol_y y1 y2 y3 y4 y5 y6 - (055125/100000) - (0196/1000) * (y4 + y5 + y6 - (60/10)) +
  (038/100) * (y1 + y2 + y3 - (60/10)) > (00/10)).

Lemma l_7726998381 : forall y1 y2 y3 y4 y5 y6  , dart_std3 y1 y2 y3 y4 y5 y6 ->  
( - sol_y y1 y2 y3 y4 y5 y6 + (05513/10000) + 
  (03232/10000) * (y4 + y5 + y6 - (60/10)) -
  (0151/1000) * (y1 + y2 + y3 - (60/10))  > (00/10)).

Lemma l_4047599236 : forall y1 y2 y3 y4 y5 y6  , dart_std3 y1 y2 y3 y4 y5 y6 -> 
( (dih_y y1 y2 y3 y4 y5 y6) - (12308/10000) +  
  ((03639/10000) * (y2 + y3 + y5 + y6 - (80/10))) -
  ((0235/1000) * (y1 - (20/10))) -((0685/1000) * (y4 - (20/10))) > (00/10)).

Lemma l_3526497018 : forall y1 y2 y3 y4 y5 y6  , dart_std3 y1 y2 y3 y4 y5 y6 -> 
  ( (-dih_y y1 y2 y3 y4 y5 y6) + (1231/1000) - 
  ((0152/1000) * (y2 + y3 + y5 + y6 - (80/10)))+
  ((05/10) * (y1 - (20/10))) + ((0773/1000) * (y4 - (20/10)))> (00/10)).

Lemma l_5957966880 : forall y1 y2 y3 y4 y5 y6  , dart_std3 y1 y2 y3 y4 y5 y6 -> 
( (rhazim y1 y2 y3 y4 y5 y6) - (12308/10000) +  
  ((03639/10000) * (y2 + y3 + y5 + y6 - (80/10))) -
  ((06/10) * (y1 - (20/10))) -((0685/1000) * (y4 - (20/10))) > (00/10)).


Definition dartX y1 y2 y3 y4 y5 y6  := (20/10) <= y1 -> y1 <= (252/100) -> (20/10) <= y2 -> y2 <= (252/100) -> (20/10) <= y3 -> y3 <= (252/100) -> (252/100) <= y4 -> y4 <= (252/100) -> (20/10) <= y5 -> y5 <= (252/100) -> (20/10) <= y6 -> y6 <= (252/100).

Lemma l_3020140039 : forall y1 y2 y3 y4 y5 y6  , dartX y1 y2 y3 y4 y5 y6 -> 
( (dih_y y1 y2 y3 y4 y5 y6) - (1629/1000) +  
  ((0402/1000) * (y2 + y3 + y5 + y6 - (80/10))) -
  ((0315/1000) * (y1 - (20/10)))  > (00/10)).

Definition dartY y1 y2 y3 y4 y5 y6  := (20/10) <= y1 -> y1 <= (252/100) -> (20/10) <= y2 -> y2 <= (252/100) -> (20/10) <= y3 -> y3 <= (252/100) -> sqrt8 <= y4 -> y4 <= sqrt8 -> (20/10) <= y5 -> y5 <= (252/100) -> (20/10) <= y6 -> y6 <= (252/100).

Lemma l_9414951439 : forall y1 y2 y3 y4 y5 y6  , dartY y1 y2 y3 y4 y5 y6 -> 
( (dih_y y1 y2 y3 y4 y5 y6) - (191/100) +  
  ((0458/1000) * (y2 + y3 + y5 + y6 - (80/10))) -
  ((0342/1000) * (y1 - (20/10)))  > (00/10)).

Definition dart4_diag3 y1 y2 y3 y4 y5 y6  := (20/10) <= y1 -> y1 <= (252/100) -> (20/10) <= y2 -> y2 <= (252/100) -> (20/10) <= y3 -> y3 <= (252/100) -> (30/10) <= y4 -> y4 <= (30/10) -> (20/10) <= y5 -> y5 <= (252/100) -> (20/10) <= y6 -> y6 <= (252/100).

Lemma l_9995621667 : forall y1 y2 y3 y4 y5 y6  , dart4_diag3 y1 y2 y3 y4 y5 y6 -> 
( (dih_y y1 y2 y3 y4 y5 y6) - (209/100) +  
  ((0578/1000) * (y2 + y3 + y5 + y6 - (80/10))) -
  ((054/100) * (y1 - (20/10)))  > (00/10)).

Definition apex_flat y1 y2 y3 y4 y5 y6  := (20/10) <= y1 -> y1 <= (252/100) -> (20/10) <= y2 -> y2 <= (252/100) -> (20/10) <= y3 -> y3 <= (252/100) -> (252/100) <= y4 -> y4 <= sqrt8 -> (20/10) <= y5 -> y5 <= (252/100) -> (20/10) <= y6 -> y6 <= (252/100).

Lemma l_6988401556 : forall y1 y2 y3 y4 y5 y6  , apex_flat y1 y2 y3 y4 y5 y6 ->  
(taum y1 y2 y3 y4 y5 y6 > (0103/1000)).

Lemma l_8248508703 : forall y1 y2 y3 y4 y5 y6  , apex_flat y1 y2 y3 y4 y5 y6 -> 
( (taum y1 y2 y3 y4 y5 y6) - (01/10) -  
  ((0265/1000) * (y5 + y6 - (40/10))) -
  ((006/100) * (y4 - (252/100))) - ((016/100) * (y1 - (20/10))) - 
  ((0115/1000) * (y2 + y3 - (40/10)))  > (00/10)).

Lemma l_3318775219 : forall y1 y2 y3 y4 y5 y6  , apex_flat y1 y2 y3 y4 y5 y6 -> 
( (dih_y y1 y2 y3 y4 y5 y6) - (1629/1000) +  
  ((0414/1000) * (y2 + y3 + y5 + y6 - (80/10))) -
  ((0763/1000) * (y4 - (252/100))) - 
  ((0315/1000) * (y1 - (20/10)))  > (00/10)).

Lemma l_9922699028 : forall y1 y2 y3 y4 y5 y6  , apex_flat y1 y2 y3 y4 y5 y6 -> 
( (-dih_y y1 y2 y3 y4 y5 y6) + (16294/10000) -  
  ((02213/10000) * (y2 + y3 + y5 + y6 - (80/10))) +
  ((0913/1000) * (y4 - (252/100))) + 
  ((0728/1000) * (y1 - (20/10)))  > (00/10)).

Lemma l_5000076558 : forall y1 y2 y3 y4 y5 y6  , apex_flat y1 y2 y3 y4 y5 y6 -> 
( (dih2_y y1 y2 y3 y4 y5 y6) - (1083/1000) +  
  ((06365/10000) * (y1 - (20/10))) -
  ((0198/1000) * (y2 - (20/10))) + 
  ((0352/1000) * (y3 - (20/10))) + 
  ((0416/1000) * (y4 - (252/100))) - 
  ((066/100) * (y5 - (20/10))) + 
  ((0071/1000) * (y6 - (20/10))) > (00/10)).

Lemma l_9251360200 : forall y1 y2 y3 y4 y5 y6  , apex_flat y1 y2 y3 y4 y5 y6 -> 
( (rhazim y1 y2 y3 y4 y5 y6) - (1629/1000) -  
  ((0866/1000) * (y1 - (20/10))) +
  ((03805/10000) * (y2 + y3 -  (40/10))) - 
  ((0841/1000) * (y4 - (252/100))) + 
  ((0501/1000) * (y5 + y6 -  (40/10)))  > (00/10)).

Lemma l_9756015945 : forall y1 y2 y3 y4 y5 y6  , apex_flat y1 y2 y3 y4 y5 y6 -> 
( (rhazim2 y1 y2 y3 y4 y5 y6) - (108/100) +  
  ((06362/10000) * (y1 - (20/10))) -
  ((0565/1000) * (y2 - (20/10))) + 
  ((0359/1000) * (y3 - (20/10))) + 
  ((0416/1000) * (y4 - (252/100))) - 
  ((0666/1000) * (y5 - (20/10))) + 
  ((0061/1000) * (y6 - (20/10))) > (00/10)).

Definition apex_A y1 y2 y3 y4 y5 y6  := (20/10) <=  y1 ->  y1 <=  (252/100) -> (20/10) <=  y2 ->  y2 <=  (252/100) -> (20/10) <=  y3 ->  y3 <=  (252/100) -> (20/10) <=  y4 ->  y4 <=  (252/100) -> (252/100) <=  y5 ->  y5 <=  sqrt8 -> (252/100) <=  y6 ->  y6 <=  sqrt8.

Lemma l_8082208587 : forall y1 y2 y3 y4 y5 y6  , apex_A y1 y2 y3 y4 y5 y6 -> 
(taum y1 y2 y3 y4 y5 y6 > (02759/10000)).

Lemma l_5760733457 : forall y1 y2 y3 y4 y5 y6  , apex_A y1 y2 y3 y4 y5 y6 -> 
   (dih_y y1 y2 y3 y4 y5 y6 - (10705/10000) -( (01/10) * (y1 - (2))) + 
   ((0424/1000) * (y2 - (20/10))) + 
   ((0424/1000) * (y3 - (20/10))) - 
   ((0594/1000) * (y4 - (20/10))) + 
   ((0124/1000) * (y5 - (252/100))) + 
   ((0124/1000) * (y6 - (252/100))) > (00/10)).

Lemma l_2563100177 : forall y1 y2 y3 y4 y5 y6  , apex_A y1 y2 y3 y4 y5 y6 -> 
( rhazim y1 y2 y3 y4 y5 y6 - (10685/10000) - 
((04635/10000) * (y1 - (20/10))) + 
((0424/1000) * (y2 - (20/10))) + 
((0424/1000) * (y3 - (20/10))) - 
((0594/1000) * (y4 - (20/10))) + 
((0124/1000) * (y5 - (252/100))) + 
((0124/1000) * (y6 - (252/100))) > (00/10)).

Lemma l_7931207804 : forall y1 y2 y3 y4 y5 y6  , apex_A y1 y2 y3 y4 y5 y6 -> 
( taum y1 y2 y3 y4 y5 y6 - (027/100) +
((00295/10000) * (y1 - (20/10))) - 
((00778/10000) * (y2 - (20/10))) - 
((00778/10000) * (y3 - (20/10))) - 
((037/100) * (y4 - (20/10))) - 
((027/100) * (y5 - (252/100))) - 
((027/100) * (y6 - (252/100))) > (00/10)).

Definition dart_std3_small y1 y2 y3 y4 y5 y6  := (20/10) <=  y1 ->  y1 <=  (252/100) -> (20/10) <=  y2 ->  y2 <=  (252/100) -> (20/10) <=  y3 ->  y3 <=  (252/100) -> (20/10) <=  y4 ->  y4 <=  (225/100) -> (20/10) <=  y5 ->  y5 <=  (225/100) -> (20/10) <=  y6 ->  y6 <=  (225/100).

Lemma l_9225295803 : forall y1 y2 y3 y4 y5 y6  , dart_std3_small y1 y2 y3 y4 y5 y6 -> 
(taum y1 y2 y3 y4 y5 y6 + (00034/10000) - 
((0166/1000) * (y1 + y2 + y3 - (60/10))) - 
((022/100) * (y4 + y5 + y6 - (60/10))) > (00/10)).

Lemma l_9291937879 : forall y1 y2 y3 y4 y5 y6  , dart_std3_small y1 y2 y3 y4 y5 y6 -> 
(dih_y y1 y2 y3 y4 y5 y6 - (123/100) - 
((0235/1000) * (y1 - (20/10))) + 
((0362/1000) * (y2 + y3 - (40/10))) - 
((0694/1000) * (y4 - (20/10))) + 
((026/100) * (y5 + y6 - (40/10))) > (00/10)).

Definition dart_std3_big  := dart_std3.

Lemma l_7761782916 : forall y1 y2 y3 y4 y5 y6  , dart_std3_big y1 y2 y3 y4 y5 y6 -> 
((taum y1 y2 y3 y4 y5 y6 - (005/100) - ((0137/1000) * (y1 + y2 + y3 - (60/10))) 
  - ((017/100) * (y4 + y5 + y6 - (625/100))) > (00/10))\/
(y4 + y5 + y6 < (625/100))).

Lemma l_6224332984 : forall y1 y2 y3 y4 y5 y6  , dart_std3_big y1 y2 y3 y4 y5 y6 -> 
((sol_y y1 y2 y3 y4 y5 y6 - (0589/1000) + 
((039/100) * (y1 + y2 + y3 - (60/10))) - 
((0235/1000) * (y4 + y5 + y6 - (625/100))) > (00/10)) \/
(y4 + y5 + y6 < (625/100))).

Definition apex_sup_flat y1 y2 y3 y4 y5 y6  := (20/10) <=  y1 ->  y1 <=  (252/100) -> (20/10) <=  y2 ->  y2 <=  (252/100) -> (20/10) <=  y3 ->  y3 <=  (252/100) -> sqrt8 <=  y4 ->  y4 <=  (30/10) -> (20/10) <=  y5 ->  y5 <=  (252/100) -> (20/10) <=  y6 ->  y6 <=  (252/100).

Lemma l_5451229371 : forall y1 y2 y3 y4 y5 y6  , apex_sup_flat y1 y2 y3 y4 y5 y6 -> 
    (taum y1 y2 y3 y4 y5 y6 - (011/100)
    - (014132/100000) * (y1 + (y2 + y3) / 2 - 4) 
       - (038/100) * (y5 + y6 - 4) > 0).

Lemma l_4840774900 : forall y1 y2 y3 y4 y5 y6  , apex_sup_flat y1 y2 y3 y4 y5 y6 -> 
  (
 taum y1 y2 y3 y4 y5 y6      - (01054/10000) 
    - (014132/100000)*(y1 + y2 / 2 + y3 / 2 - 4)
    - (036499/100000)*(y5 +y6 - 4) > 0).

Lemma l_1642527039 : forall y1 y2 y3 y4 y5 y6  , apex_sup_flat y1 y2 y3 y4 y5 y6 -> 
  (
 taum y1 y2 y3 y4 y5 y6      - (0128/1000) 
  - (0053/1000)*((y5 +y6 - 4) - ((275/100)/ 2)*(y4 - sqrt8)) > 0).

Lemma l_7863247282 : forall y1 y2 y3 y4 y5 y6  , apex_sup_flat y1 y2 y3 y4 y5 y6 -> 
  (taum y1 y2 y3 y4 y5 y6  - (0053/1000)*((y5 +y6 - 4) - ((275/100)/ 2)*(y4 - sqrt8))
    - (012/100) 
    - (014132/100000)*(y1 + y2 / 2 + y3 / 2 - 4)
    - (0328/1000)*(y5 +y6 - 4) > 0).

Lemma l_7718591733 : forall y1 y2 y3 y4 y5 y6  , apex_sup_flat y1 y2 y3 y4 y5 y6 -> 
  (dih2_y y1 y2 y3 y4 y5 y6  - (0955/1000) 
   - (02356/10000)*(y2 - 2)
       + (032/100)*(y3 - 2) + (0792/1000)*(y1 - 2)
   - (0707/1000)*(y5 - 2) 
        + (00844/10000)*(y6 - 2) + (0821/1000)*(y4 - sqrt8) > 0).

Lemma l_3566713650 : forall y1 y2 y3 y4 y5 y6  , apex_sup_flat y1 y2 y3 y4 y5 y6 -> 
  (
  - dih_y y1 y2 y3 y4 y5 y6  + (1911/1000) + (101/100) *(y1  - 2)
  - (0284/1000)*(y2 +y3 +y5 +y6 - 8)
   + (107/100)*(y4 - sqrt8) > 0).

Lemma l_1085358243 : forall y1 y2 y3 y4 y5 y6  , apex_sup_flat y1 y2 y3 y4 y5 y6 -> 
  (
  dih_y y1 y2 y3 y4 y5 y6  - (1903/1000) - (04/10)*(y1  - 2)
  + (049688/100000)*(y2 +y3 +y5 +y6 - 8)
   -(y4 -sqrt8) > 0).

Definition dart_std3_mini y1 y2 y3 y4 y5 y6  := (2) <= y1 -> y1 <= (218/100) -> 2 <= y2 -> y2 <= (218/100) -> 2 <= y3 -> y3 <= (218/100) -> 2 <= y4 -> y4 <= (225/100) -> 2 <= y5 -> y5 <= (225/100) -> 2 <= y6 -> y6 <= (225/100).

Lemma l_9229542852 : forall y1 y2 y3 y4 y5 y6  , dart_std3_mini y1 y2 y3 y4 y5 y6 -> 
(dih_y y1 y2 y3 y4 y5 y6 - (1230/1000) - 
((02357/10000) * (y1 - (20/10))) + 
((02493/10000) * (y2 + y3 - (40/10))) - 
((0682/1000) * (y4 - (20/10))) + 
((03035/10000) * (y5 + y6 - (40/10))) > (00/10)).

Lemma l_1550635295 : forall y1 y2 y3 y4 y5 y6  , dart_std3_mini y1 y2 y3 y4 y5 y6 -> 
(-(dih_y y1 y2 y3 y4 y5 y6) + (1232/1000) + 
((0261/1000) * (y1 - (20/10))) - 
((0203/1000) * (y2 + y3 - (40/10))) + 
((0772/1000) * (y4 - (20/10))) - 
((0191/1000) * (y5 + y6 - (40/10))) > (00/10)).

Lemma l_4491491732 : forall y1 y2 y3 y4 y5 y6  , dart_std3_mini y1 y2 y3 y4 y5 y6 -> 
(taum y1 y2 y3 y4 y5 y6 + (00008/10000) - 
((01631/10000) * (y1 + y2 + y3 - (60/10))) - 
((02127/10000) * (y4 + y5 + y6 - (60/10))) > (00/10)).

Definition apex_flat_hll  y1 y2 y3 y4 y5 y6  := (218/100) <=  y1 ->  y1 <=  (252/100) -> (20/10) <=  y2 ->  y2 <=  (218/100) -> (20/10) <=  y3 ->  y3 <=  (218/100) -> (252/100) <=  y4 ->  y4 <=  sqrt8 -> (20/10) <=  y5 ->  y5 <=  (252/100) -> (20/10) <=  y6 ->  y6 <=  (252/100).

Lemma l_8282573160 : forall y1 y2 y3 y4 y5 y6  , apex_flat_hll  y1 y2 y3 y4 y5 y6 -> 
(taum y1 y2 y3 y4 y5 y6 - (01413/10000) - 
((0214/1000) * (y1 - (218/100))) - 
((01259/10000) * (y2 + y3 - (40/10))) - 
((0067/1000) * (y4 - (252/100))) - 
((0241/1000) * (y5 + y6 - (40/10))) > (00/10)).

Definition dart_std3_big_200_218  y1 y2 y3 y4 y5 y6  := (20/10) <=  y1 ->  y1 <=  (218/100) -> (20/10) <=  y2 ->  y2 <=  (218/100) -> (20/10) <=  y3 ->  y3 <=  (218/100) -> (20/10) <=  y4 ->  y4 <=  (252/100) -> (20/10) <=  y5 ->  y5 <=  (252/100) -> (20/10) <=  y6 ->  y6 <=  (252/100).

Lemma l_8611785756 : forall y1 y2 y3 y4 y5 y6  , dart_std3_big_200_218  y1 y2 y3 y4 y5 y6 -> 
((sol_y y1 y2 y3 y4 y5 y6 - (0589/1000) + 
((024/100) * (y1 + y2 + y3 - (60/10))) - 
((016/100) * (y4 + y5 + y6 - (625/100))) > (00/10)) \/
(y4 + y5 + y6 < (625/100))).





















Definition apex_std3_hll y1 y2 y3 y4 y5 y6  := (218/100) <= y1 -> y1 <= (252/100) -> 2 <= y2 -> y2 <= (218/100) -> 2 <= y3 -> y3 <= (218/100) -> 2 <= y4 -> y4 <= (252/100) -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100).

Definition apex_std3_small_hll y1 y2 y3 y4 y5 y6  := (218/100) <= y1 -> y1 <= (252/100) -> 2 <= y2 -> y2 <= (218/100) -> 2 <= y3 -> y3 <= (218/100) -> 2 <= y4 -> y4 <= (225/100) -> 2 <= y5 -> y5 <= (225/100) -> 2 <= y6 -> y6 <= (225/100).









Definition dart_mll_w y1 y2 y3 y4 y5 y6  := (218/100) <= y1 -> y1 <= (236/100) -> 2 <= y2 -> y2 <= (218/100) -> 2 <= y3 -> y3 <= (218/100) -> (225/100) <= y4 -> y4 <= (252/100) -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100).

Definition dart_mll_n y1 y2 y3 y4 y5 y6  := (218/100) <= y1 -> y1 <= (236/100) -> 2 <= y2 -> y2 <= (218/100) -> 2 <= y3 -> y3 <= (218/100) -> 2 <= y4 -> y4 <= (225/100) -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100).

Definition dart_Hll_n y1 y2 y3 y4 y5 y6  := (236/100) <= y1 -> y1 <= (252/100) -> 2 <= y2 -> y2 <= (218/100) -> 2 <= y3 -> y3 <= (218/100) -> 2 <= y4 -> y4 <= (225/100) -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100).

Definition dart_Hll_w y1 y2 y3 y4 y5 y6  := (236/100) <= y1 -> y1 <= (252/100) -> 2 <= y2 -> y2 <= (218/100) -> 2 <= y3 -> y3 <= (218/100) -> (225/100) <= y4 -> y4 <= (252/100) -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100).






















Definition dart_std3_lw y1 y2 y3 y4 y5 y6  := (200/100) <= y1 -> y1 <= (218/100) -> 2 <= y2 -> y2 <= (252/100) -> 2 <= y3 -> y3 <= (252/100) -> (225/100) <= y4 -> y4 <= (252/100) -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100).

Lemma l_4750199435 : forall y1 y2 y3 y4 y5 y6  , apex_flat y1 y2 y3 y4 y5 y6 -> 
         (-dih2_y y1 y2 y3 y4 y5 y6 + (00031/10000) >
          -  (108346/100000) +
          (0288794/1000000) * (- 2 + y1) +
          - (0292829/1000000) * (- 2 + y2) +
          (0036457/1000000) * (- 2 + y3) +
          (0348796/1000000) * (- (252/100) + y4) +
          - (0762602/1000000) * (- 2 + y5) +
          - (0112679/1000000) * (- 2 + y6)).


Lemma l_8384511215 : forall y1 y2 y3 y4 y5 y6  , apex_flat y1 y2 y3 y4 y5 y6 -> 
         (dih2_y y1 y2 y3 y4 y5 y6 + (00015/10000) >
          (0913186/1000000) +
          - (0390288/1000000) * (- 2 + y1) +
          (0115895/1000000) * (- 2 + y2) +
          (0164805/1000000) * (- (252/100) + y3) +
          - (0271329/1000000) * (- (282843/100000) + y4) +
          (0584817/1000000) * (- 2 + y5) +
          - (0170218/1000000) * (- 2 + y6)).


Lemma l_7819193535 : forall y1 y2 y3 y4 y5 y6  , dart_std3_lw y1 y2 y3 y4 y5 y6 -> 
         (dih2_y y1 y2 y3 y4 y5 y6 + (00011/10000) >
          (116613/100000) +
          - (0296776/1000000) * (- 2 + y1) +
          (0208935/1000000) * (- 2 + y2) +
          - (0243302/1000000) * (- 2 + y3) +
          - (0360575/1000000) * (- (225/100) + y4) +
          (0636205/1000000) * (- 2 + y5) +
          - (0295156/1000000) * (- 2 + y6)).


Lemma l_6987934000 : forall y1 y2 y3 y4 y5 y6  , dart_mll_w y1 y2 y3 y4 y5 y6 -> 
         (dih2_y y1 y2 y3 y4 y5 y6 + (00042/10000) >
          (0952682/1000000) +
          - (0268837/1000000) * (- (236/100) + y1) +
          (0130607/1000000) * (- 2 + y2) +
          - (0168729/1000000) * (- 2 + y3) +
          - (00831764/10000000) * (- (252/100) + y4) +
          (0580152/1000000) * (- 2 + y5) +
          (00656612/10000000) * (- (225/100) + y6)).


Lemma l_7291663656 : forall y1 y2 y3 y4 y5 y6  , apex_flat y1 y2 y3 y4 y5 y6 -> 
         (dih2_y y1 y2 y3 y4 y5 y6 + (00009/10000) >
          (0947391/1000000) +
          - (0637397/1000000) * (- 2 + y1) +
          (0120003/1000000) * (- 2 + y2) +
          - (0100814/1000000) * (- (23/10) + y3) +
          - (0302956/1000000) * (- (265/100) + y4) +
          (0547359/1000000) * (- 2 + y5) +
          - (0157745/1000000) * (- (22/10) + y6)).


Lemma l_2390583444 : forall y1 y2 y3 y4 y5 y6  , dart_std3_mini y1 y2 y3 y4 y5 y6 -> 
         (dih_y y1 y2 y3 y4 y5 y6 + (00012/10000) >
          (108627/100000) +
          (0159149/1000000) * (- 2 + y1) +
          - (0198496/1000000) * (- (21/10) + y2) +
          - (0199306/1000000) * (- (21/10) + y3) +
          (0590083/1000000) * (- 2 + y4) +
          - (00888111/10000000) * (- (225/100) + y5) +
          - (00881846/10000000) * (- (225/100) + y6)).


Definition apex_flat_l y1 y2 y3 y4 y5 y6  := (2) <= y1 -> y1 <= (218/100) -> 2 <= y2 -> y2 <= (252/100) -> 2 <= y3 -> y3 <= (252/100) -> (252/100) <= y4 -> y4 <= sqrt8 -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100).

Definition apex_flat_h y1 y2 y3 y4 y5 y6  := (218/100) <= y1 -> y1 <= (252/100) -> 2 <= y2 -> y2 <= (252/100) -> 2 <= y3 -> y3 <= (252/100) -> (252/100) <= y4 -> y4 <= sqrt8 -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100).

Lemma l_9641946727 : forall y1 y2 y3 y4 y5 y6  , apex_flat_l y1 y2 y3 y4 y5 y6 -> 
         (dih2_y y1 y2 y3 y4 y5 y6 + (00071/10000) >
          (098362/100000) +
          - (0264094/1000000) * (- (218/100) + y1) +
          (0149308/1000000) * (- (218/100) + y2) +
          - (0312683/1000000) * (- 2 + y3) +
          - (0282792/1000000) * (- (265/100) + y4) +
          (0581552/1000000) * (- 2 + y5) +
          (0143669/1000000) * (- (23/10) + y6)).

Definition apex_std3_lll_xww y1 y2 y3 y4 y5 y6  := 2 <= y1 -> y1 <= (218/100) -> 2 <= y2 -> y2 <= (218/100) -> 2 <= y3 -> y3 <= (218/100) -> 2 <= y4 -> y4 <= (252/100) -> (225/100) <= y5 -> y5 <= (252/100) -> (225/100) <= y6 -> y6 <= (252/100).

Lemma l_4222324842 : forall y1 y2 y3 y4 y5 y6  , apex_std3_lll_xww y1 y2 y3 y4 y5 y6 -> 
         (dih_y y1 y2 y3 y4 y5 y6 + (00071/10000) >
          (109969/100000) +
          (0146345/1000000) * (- 2 + y1) +
          - (0160538/1000000) * (- 2 + y2) +
          - (0151698/1000000) * (- (214/100) + y3) +
          (061314/100000) * (- 2 + y4) +
          - (0236149/1000000) * (- (225/100) + y5) +
          - (0242043/1000000) * (- (225/100) + y6)).

Definition apex_std3_lll_wxx y1 y2 y3 y4 y5 y6  := 2 <= y1 -> y1 <= (218/100) -> 2 <= y2 -> y2 <= (218/100) -> 2 <= y3 -> y3 <= (218/100) -> (225/100) <= y4 -> y4 <= (252/100) -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100).

Lemma l_5756588587 : forall y1 y2 y3 y4 y5 y6  , apex_std3_lll_wxx y1 y2 y3 y4 y5 y6 -> 
         (dih2_y y1 y2 y3 y4 y5 y6 + (00025/10000) >
          (116613/100000) +
          - (0296776/1000000) * (- 2 + y1) +
          (0208935/1000000) * (- 2 + y2) +
          - (0196313/1000000) * (- 2 + y3) +
          - (0360575/1000000) * (- (225/100) + y4) +
          (0652861/1000000) * (- 2 + y5) +
          - (0218063/1000000) * (- 2 + y6)).

Lemma l_3425739813 : forall y1 y2 y3 y4 y5 y6  , apex_flat y1 y2 y3 y4 y5 y6 -> 
         (-dih_y y1 y2 y3 y4 y5 y6 + (00011/10000) >
          - (167609/100000) +
          - (0506322/1000000) * (- (218/100) + y1) +
          (0212075/1000000) * (- (21/10) + y2) +
          (0230669/1000000) * (- (21/10) + y3) +
          - (128579/100000) * (- (252/100) + y4) +
          (0249199/1000000) * (- 2 + y5) +
          (0193545/1000000) * (- 2 + y6)).

Lemma l_7316455966 : forall y1 y2 y3 y4 y5 y6  , apex_std3_lll_wxx y1 y2 y3 y4 y5 y6 -> 
         (dih2_y y1 y2 y3 y4 y5 y6 + (00050/10000) >
          (102005/100000) +
          - (0256494/1000000) * (- (218/100) + y1) +
          (0121497/1000000) * (- 2 + y2) +
          - (0256494/1000000) * (- 2 + y3) +
          - (00116869/10000000) * (- (252/100) + y4) +
          (0598233/1000000) * (- 2 + y5) +
          (00187672/10000000) * (- (225/100) + y6)).

Lemma l_6410081357 : forall y1 y2 y3 y4 y5 y6  , apex_std3_lll_wxx y1 y2 y3 y4 y5 y6 -> 
         (-dih3_y y1 y2 y3 y4 y5 y6 + (00087/10000) >
          - (118616/100000) +
          (0436647/1000000) * (- (218/100) + y1) +
          (0032258/1000000) * (- 2 + y2) +
          - (0289629/1000000) * (- 2 + y3) +
          (0397053/1000000) * (- (252/100) + y4) +
          - (00210289/10000000) * (- 2 + y5) +
          - (0683341/1000000) * (- (225/100) + y6)).

Lemma l_2923748598 : forall y1 y2 y3 y4 y5 y6  , dart_mll_n y1 y2 y3 y4 y5 y6 -> 
         (-dih_y y1 y2 y3 y4 y5 y6 + (00083/10000) >
          - (129912/100000) +
          - (0284457/1000000) * (- (218/100) + y1) +
          (0337354/1000000) * (- 2 + y2) +
          (0186287/1000000) * (- 2 + y3) +
          - (0645382/1000000) * (- (225/100) + y4) +
          (0367671/1000000) * (- (252/100) + y5) +
          (00536051/10000000) * (- 2 + y6)).

Lemma l_4306175952 : forall y1 y2 y3 y4 y5 y6  , dart_mll_n y1 y2 y3 y4 y5 y6 -> 
         (dih2_y y1 y2 y3 y4 y5 y6 + (00035/10000) >
          (105036/100000) +
          - (0222178/1000000) * (- (218/100) + y1) +
          (0132628/1000000) * (- 2 + y2) +
          - (0219284/1000000) * (- 2 + y3) +
          (000563427/100000000) * (- (225/100) + y4) +
          (059096/100000) * (- 2 + y5) +
          - (00771574/10000000) * (- (252/100) + y6)).

Lemma l_2763799127 : forall y1 y2 y3 y4 y5 y6  , apex_sup_flat y1 y2 y3 y4 y5 y6 -> 
         (-dih3_y y1 y2 y3 y4 y5 y6 + (00076/10000) >
          - (0956317/1000000) +
          (0419124/1000000) * (- 2 + y1) +
          - (00753922/10000000) * (- 2 + y2) +
          - (0252307/1000000) * (- 2 + y3) +
          (05/10) * (- (282843/100000) + y4) +
          - (0246082/1000000) * (- 2 + y5) +
          - (0788717/1000000) * (- 2 + y6)).

Lemma l_5943578801 : forall y1 y2 y3 y4 y5 y6  , apex_sup_flat y1 y2 y3 y4 y5 y6 -> 
         (dih2_y y1 y2 y3 y4 y5 y6 + (00047/10000) >
          (0936544/1000000) +
          - (0636113/1000000) * (- (21/10) + y1) +
          (0140759/1000000) * (- (21/10) + y2) +
          - (00771734/10000000) * (- (23/10) + y3) +
          - (129068/100000) * (- (282843/100000) + y4) +
          (0591328/1000000) * (- (21/10) + y5) +
          - (00521775/10000000) * (- (21/10) + y6)).

Definition apex_std3_lhh y1 y2 y3 y4 y5 y6  := 2 <= y1 -> y1 <= (218/100) -> (218/100) <= y2 -> y2 <= (252/100) -> (218/100) <= y3 -> y3 <= (252/100) -> 2 <= y4 -> y4 <= (252/100) -> 2 <= y5 -> y5 <= (252/100) -> 2 <= y6 -> y6 <= (252/100).

Lemma l_1836408787 : forall y1 y2 y3 y4 y5 y6  , apex_std3_lhh y1 y2 y3 y4 y5 y6 -> 
         (dih_y y1 y2 y3 y4 y5 y6 + (00012/10000) >
          (101332/100000) +
          (0148615/1000000) * (- 2 + y1) +
          - (0379006/1000000) * (- (218/100) + y2) +
          - (0379441/1000000) * (- (218/100) + y3) +
          (0583676/1000000) * (- 2 + y4) +
          - (0184708/1000000) * (- (225/100) + y5) +
          - (018471/100000) * (- (225/100) + y6)).

Lemma l_1248932983 : forall y1 y2 y3 y4 y5 y6  , apex_std3_lhh y1 y2 y3 y4 y5 y6 -> 
         (-dih2_y y1 y2 y3 y4 y5 y6 + (00059/10000) >
          - (133909/100000) +
          (00724529/10000000) * (- 2 + y1) +
          - (0486824/1000000) * (- (218/100) + y2) +
          (0317329/1000000) * (- (218/100) + y3) +
          - (000479451/100000000) * (- 2 + y4) +
          - (0751179/1000000) * (- (225/100) + y5) +
          (0350857/1000000) * (- (225/100) + y6)).

Lemma l_6725783616 : forall y1 y2 y3 y4 y5 y6  , apex_flat y1 y2 y3 y4 y5 y6 -> 
         (dih3_y y1 y2 y3 y4 y5 y6 + (00046/10000) >
          (088473/100000) +
          - (0443946/1000000) * (- (236/100) + y1) +
          - (0244711/1000000) * (- (21/10) + y2) +
          (0205592/1000000) * (- (21/10) + y3) +
          - (0739126/1000000) * (- (255/100) + y4) +
          - (0127198/1000000) * (- (21/10) + y5) +
          (061582/100000) * (- 2 + y6)).

Lemma l_9185711902 : forall y1 y2 y3 y4 y5 y6  , apex_std3_hll y1 y2 y3 y4 y5 y6 -> 
         (-dih3_y y1 y2 y3 y4 y5 y6 + (00116/10000) >
          - (130119/100000) +
          (0392915/1000000) * (- (236/100) + y1) +
          (0142563/1000000) * (- (21/10) + y2) +
          - (0258747/1000000) * (- (21/10) + y3) +
          (0417088/1000000) * (- (245/100) + y4) +
          - (00606764/10000000) * (- 2 + y5) +
          - (0637966/1000000) * (- (245/100) + y6)).

Lemma l_6284721194 : forall y1 y2 y3 y4 y5 y6  , apex_std3_hll y1 y2 y3 y4 y5 y6 -> 
         (dih2_y y1 y2 y3 y4 y5 y6 + (00011/10000) >
          (0957661/1000000) +
          - (0250506/1000000) * (- (236/100) + y1) +
          (0145114/1000000) * (- (21/10) + y2) +
          - (00549376/10000000) * (- (21/10) + y3) +
          - (00384445/10000000) * (- (245/100) + y4) +
          (05275/10000) * (- 2 + y5) +
          (0118819/1000000) * (- (245/100) + y6)).

Lemma l_3137600529 : forall y1 y2 y3 y4 y5 y6  , apex_flat_h y1 y2 y3 y4 y5 y6 -> 
         (dih2_y y1 y2 y3 y4 y5 y6 + (00042/10000) >
          (0868174/1000000) +
          - (0701906/1000000) * (- (225/100) + y1) +
          (0136514/1000000) * (- 2 + y2) +
          - (0209239/1000000) * (- (218/100) + y3) +
          - (0493373/1000000) * (- (265/100) + y4) +
          (0537385/1000000) * (- 2 + y5) +
          (00187672/10000000) * (- (22/10) + y6)).


Lemma l_ZTGIJCF4_0_0_0_0_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_0_0_0_1_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 2 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_0_0_1_0_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 2 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_0_0_1_1_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 3 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_0_1_0_0_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_0_1_0_1_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 3 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_0_1_1_0_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 3 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_0_1_1_1_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 4 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_1_0_0_0_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 2 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_1_0_0_1_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 3 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_1_0_1_0_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 <= y4 -> y4 <= 2 * hminus -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 3 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_1_0_1_1_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 <= y4 -> y4 <= 2 * hminus -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 4 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_1_1_0_0_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 3 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_1_1_0_1_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 4 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_1_1_1_0_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 4 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF4_1_1_1_1_1821661595 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 5 + 0 *beta_bump_lb  >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_ZTGIJCF23_0_0_0_7907792228_b : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2  <= y4 -> y4 <=  sqrt8  -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ( (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < (014/100)) \/
   (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
  (gamma23f_n y1 y2 y3 y4 y5 y6 1 1 sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
   ).

Lemma l_ZTGIJCF23_0_0_1_7907792228_b : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2  <= y4 -> y4 <=  sqrt8  -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ( (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < (014/100)) \/
   (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
  (gamma23f_n y1 y2 y3 y4 y5 y6 2 1 sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
   ).

Lemma l_ZTGIJCF23_1_0_1_7907792228_b : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2  <= y4 -> y4 <=  sqrt8  -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ( (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < (014/100)) \/
   (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
  (gamma23f_n y1 y2 y3 y4 y5 y6 2 2 sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
   ).

Lemma l_ZTGIJCF23_0_1_1_7907792228_b : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2  <= y4 -> y4 <=  sqrt8  -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ( (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < (014/100)) \/
   (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
  (gamma23f_n y1 y2 y3 y4 y5 y6 2 2 sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
   ).

Lemma l_ZTGIJCF23_0_0_0_7907792228_b2 : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2  <= y4 -> y4 <=  2  -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ( (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < (014/100)) \/
   (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
  (gamma23f_n y1 y2 y3 y4 y5 y6 1 1 sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
   ).

Lemma l_ZTGIJCF23_0_0_1_7907792228_b2 : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2  <= y4 -> y4 <=  2  -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ( (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < (014/100)) \/
   (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
  (gamma23f_n y1 y2 y3 y4 y5 y6 2 1 sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
   ).

Lemma l_ZTGIJCF23_1_0_1_7907792228_b2 : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2  <= y4 -> y4 <=  2  -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ( (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < (014/100)) \/
   (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
  (gamma23f_n y1 y2 y3 y4 y5 y6 2 2 sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
   ).

Lemma l_ZTGIJCF23_0_1_1_7907792228_b2 : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2  <= y4 -> y4 <=  2  -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ( (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < (014/100)) \/
   (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
  (gamma23f_n y1 y2 y3 y4 y5 y6 2 2 sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
   ).

Lemma l_ZTGIJCF23_0_0_0_7907792228_c : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2  <= y4 -> y4 <=  2  -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (
(delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 > (014/100))  \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < 0) \/
(gamma23f_126_03_n y1 y2 y3 y4 y5 y6 1 sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
      ).

Lemma l_ZTGIJCF23_0_0_1_7907792228_c : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2  <= y4 -> y4 <=  2  -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    (
(delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 > (014/100))  \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < 0) \/
(gamma23f_126_03_n y1 y2 y3 y4 y5 y6 2 sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
      ).

Lemma l_ZTGIJCF23_1_0_1_7907792228_c : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2  <= y4 -> y4 <=  2  -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    (
(delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 > (014/100))  \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < 0) \/
(gamma23f_126_03_n y1 y2 y3 y4 y5 y6 2 sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
      ).

Lemma l_ZTGIJCF23_0_1_1_7907792228_c : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2  <= y4 -> y4 <=  2  -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    (
(delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < (014/100) ) \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 > (014/100))  \/
    (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < 0) \/
(gamma23f_126_03_n y1 y2 y3 y4 y5 y6 2 sqrt2 lmfun    >
       a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6)
      ).

Lemma l_ZTGIJCF23_0_0_0_7907792228_d : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2  <= y4 -> y4 <=  sqrt8  -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
((gamma23f_red_03 y1 y2 y3 y4 y5 y6 sqrt2 lmfun    >
    a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
  (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
   (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 > (014/100) ) \/
    (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < 0 ) \/
     (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 > (014/100))  \/
      (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < 0)   ).

Lemma l_ZTGIJCF23_0_0_1_7907792228_d : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2  <= y4 -> y4 <=  sqrt8  -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
((gamma23f_red_03 y1 y2 y3 y4 y5 y6 sqrt2 lmfun    >
    a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
  (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
   (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 > (014/100) ) \/
    (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < 0 ) \/
     (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 > (014/100))  \/
      (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < 0)   ).

Lemma l_ZTGIJCF23_1_0_1_7907792228_d : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2  <= y4 -> y4 <=  sqrt8  -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
((gamma23f_red_03 y1 y2 y3 y4 y5 y6 sqrt2 lmfun    >
    a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
  (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
   (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 > (014/100) ) \/
    (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < 0 ) \/
     (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 > (014/100))  \/
      (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < 0)   ).

Lemma l_ZTGIJCF23_0_1_1_7907792228_d : forall  y1 y2 y3 y4 y5 y6 , 2 *  hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2  <= y4 -> y4 <=  sqrt8  -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
((gamma23f_red_03 y1 y2 y3 y4 y5 y6 sqrt2 lmfun    >
    a_spine5 + b_spine5 * dih_y y1 y2 y3 y4 y5 y6) \/
  (y_of_x rad2_x y1 y2 y3 y4 y5 y6 < 2) \/
   (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 > (014/100) ) \/
    (delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6 < 0 ) \/
     (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 > (014/100))  \/
      (delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2 < 0)   ).


Lemma l_QITNPEA4_0_0_0_1_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 2 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_0_0_1_0_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 2 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_0_0_1_1_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 3 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_0_1_0_0_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_0_1_0_1_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 3 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_0_1_1_0_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 3 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_0_1_1_1_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 4 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_1_0_0_0_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 2 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_1_0_0_1_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 3 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_1_0_1_0_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 <= y4 -> y4 <= 2 * hminus -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 3 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_1_0_1_1_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 <= y4 -> y4 <= 2 * hminus -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 4 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_1_1_0_0_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 3 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_1_1_0_1_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 4 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_1_1_1_0_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 4 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA4_1_1_1_1_3803737830 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= sqrt8 -> 2 * hminus <= y4 -> y4 <= sqrt8 -> 2 * hminus <= y5 -> y5 <= sqrt8 -> 2 * hminus <= y6 -> y6 <= sqrt8 -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 5 + 0 * beta_bump_force_y y1 y2 y3 y4 y5 y6
        - (00105256/10000000) +  (000522841/100000000)*dih_y y1 y2 y3 y4 y5 y6 > (00/10)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).




Lemma l_QITNPEA1_1_0_9063653052 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= 2 * hplus -> 2 <= y4 -> y4 <= 2 * hminus -> 2  <= y5 -> y5 <= 2 *hminus -> 2  <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 2 + 0 *beta_bump_lb
         > (00057/10000)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA1_1_1_9063653052 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= 2 * hplus -> 2 * hminus <= y4 -> y4 <= 2 * hplus -> 2  <= y5 -> y5 <= 2 *hminus -> 2  <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 3 + 0 *beta_bump_lb
         > (00057/10000)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA1_1_2_9063653052 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hminus <= y3 -> y3 <= 2 * hplus -> 2 * hplus <= y4 -> y4 <= sqrt8 -> 2  <= y5 -> y5 <= 2 *hminus -> 2  <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 2 + 0 *beta_bump_lb
         > (00057/10000)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA1_2_0_9063653052 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hplus <= y3 -> y3 <= sqrt8 -> 2 <= y4 -> y4 <= 2 * hminus -> 2  <= y5 -> y5 <= 2 *hminus -> 2  <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_lb
         > (00057/10000)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA1_2_1_9063653052 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hplus <= y3 -> y3 <= sqrt8 -> 2 * hminus <= y4 -> y4 <= 2 * hplus -> 2  <= y5 -> y5 <= 2 *hminus -> 2  <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_lb
         > (00057/10000)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_QITNPEA1_2_2_9063653052 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 *hminus -> 2 * hplus <= y3 -> y3 <= sqrt8 -> 2 * hplus <= y4 -> y4 <= sqrt8 -> 2  <= y5 -> y5 <= 2 *hminus -> 2  <= y6 -> y6 <= 2 * hminus -> 
    ((gamma4f y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_lb
         > (00057/10000)) \/
    (y_of_x rad2_x y1 y2 y3 y4 y5 y6 > 2)).

Lemma l_OXLZLEZ_6346351218_0_0 : forall  y1 y12 y23 y34 y41 , 2 * hminus <=  y1 ->  y1 <=   2 * h0 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0129913/1000000)) + ((-(0060416/1000000))+((001764/100000))+((0045166/1000000))+((0021777/1000000)))* y1 
       + 2 * (((0002372/1000000))+(-(0002372/1000000))) * y12 + 2 *((-(0002372/1000000)) + ((0002372/1000000))) * y23 + 2 *(((0002372/1000000)) + (-(0002372/1000000))) * y34 + 2 *
        ((-(0002372/1000000))+((0002372/1000000)))* y41
      + (-(0113134/1000000)) + (-(0198777/1000000)) + (-(0306092/1000000)) + (-(0259166/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_0 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0060416/1000000))* y1 
     +((0002372/1000000))* (y2 + y3 + y5 + y6)
     +(-(0113134/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_0 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((001764/100000))* y1 
     +(-(0002372/1000000))* (y2 + y3 + y5 + y6)
     +(-(0198777/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_0 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0045166/1000000))* y1 
     +((0002372/1000000))* (y2 + y3 + y5 + y6)
     +(-(0306092/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_1 : forall  y1 y12 y23 y34 y41 , 2 * hminus <=  y1 ->  y1 <=   2 * h0 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0129699/1000000)) + ((-(0060316/1000000))+((0019214/1000000))+((0021887/1000000))+((0019214/1000000)))* y1 
       + 2 * (((0002264/1000000))+(-(0002264/1000000))) * y12 + 2 *((-(0002264/1000000)) + ((0002264/1000000))) * y23 + 2 *(((0002264/1000000)) + (-(0002264/1000000))) * y34 + 2 *
        ((-(0002264/1000000))+((0002264/1000000)))* y41
      + (-(0112116/1000000)) + (-(0203309/1000000)) + (-(029619/100000)) + (-(0203309/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_1 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129699/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0060316/1000000))* y1 
     +((0002264/1000000))* (y2 + y3 + y5 + y6)
     +(-(0112116/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_1 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129699/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0019214/1000000))* y1 
     +(-(0002264/1000000))* (y2 + y3 + y5 + y6)
     +(-(0203309/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_1 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+2 * hminus)/ 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129699/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0021887/1000000))* y1 
     +((0002264/1000000))* (y2 + y3 + y5 + y6)
     +(-(029619/100000))> 0).

Lemma l_OXLZLEZ_6346351218_0_2 : forall  y1 y12 y23 y34 y41 , 2 * hminus <=  y1 ->  y1 <=   2 * h0 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0129913/1000000)) + ((-(0060416/1000000))+((0021777/1000000))+((0045166/1000000))+((001764/100000)))* y1 
       + 2 * (((0002372/1000000))+(-(0002372/1000000))) * y12 + 2 *((-(0002372/1000000)) + ((0002372/1000000))) * y23 + 2 *(((0002372/1000000)) + (-(0002372/1000000))) * y34 + 2 *
        ((-(0002372/1000000))+((0002372/1000000)))* y41
      + (-(0113134/1000000)) + (-(0259166/1000000)) + (-(0306092/1000000)) + (-(0198777/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_2 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0060416/1000000))* y1 
     +((0002372/1000000))* (y2 + y3 + y5 + y6)
     +(-(0113134/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_2 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+2 * hminus)/ 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0021777/1000000))* y1 
     +(-(0002372/1000000))* (y2 + y3 + y5 + y6)
     +(-(0259166/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_2 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0045166/1000000))* y1 
     +((0002372/1000000))* (y2 + y3 + y5 + y6)
     +(-(0306092/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_3 : forall  y1 y12 y23 y34 y41 , 2 * hminus <=  y1 ->  y1 <=   2 * h0 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0114872/1000000)) + (((0133539/1000000))+((0148605/1000000))+((008743/100000))+((0148605/1000000)))* y1 
       + 2 * ((-(0080919/1000000))+((0080919/1000000))) * y12 + 2 *(((0080919/1000000)) + (-(0080919/1000000))) * y23 + 2 *((-(0080919/1000000)) + ((0080919/1000000))) * y34 + 2 *
        (((0080919/1000000))+(-(0080919/1000000)))* y41
      + ((0532524/1000000)) + (-(0855148/1000000)) + ((0593722/1000000)) + (-(0855148/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_3 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0114872/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0133539/1000000))* y1 
     +(-(0080919/1000000))* (y2 + y3 + y5 + y6)
     +((0532524/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_3 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0114872/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0148605/1000000))* y1 
     +((0080919/1000000))* (y2 + y3 + y5 + y6)
     +(-(0855148/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_3 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0114872/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((008743/100000))* y1 
     +(-(0080919/1000000))* (y2 + y3 + y5 + y6)
     +((0593722/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_4 : forall  y1 y12 y23 y34 y41 , 2 * hminus <=  y1 ->  y1 <=   2 * h0 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0065103/1000000)) + ((-(0008732/1000000))+((0072591/1000000))+((0042651/1000000))+((0055356/1000000)))* y1 
       + 2 * ((-(0024884/1000000))+((0024884/1000000))) * y12 + 2 *(((0024884/1000000)) + (-(0024884/1000000))) * y23 + 2 *((-(0024884/1000000)) + ((0024884/1000000))) * y34 + 2 *
        (((0024884/1000000))+(-(0024884/1000000)))* y41
      + ((0097156/1000000)) + (-(0464803/1000000)) + ((0008797/1000000)) + (-(0458108/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_4 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0008732/1000000))* y1 
     +(-(0024884/1000000))* (y2 + y3 + y5 + y6)
     +((0097156/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_4 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0072591/1000000))* y1 
     +((0024884/1000000))* (y2 + y3 + y5 + y6)
     +(-(0464803/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_4 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0042651/1000000))* y1 
     +(-(0024884/1000000))* (y2 + y3 + y5 + y6)
     +((0008797/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_5 : forall  y1 y12 y23 y34 y41 , 2 * hminus <=  y1 ->  y1 <=   2 * h0 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0065103/1000000)) + ((-(0029778/1000000))+((0072591/1000000))+((0055356/1000000))+((0072591/1000000)))* y1 
       + 2 * ((-(0027449/1000000))+((0027449/1000000))) * y12 + 2 *(((0027449/1000000)) + (-(0027449/1000000))) * y23 + 2 *((-(0027449/1000000)) + ((0027449/1000000))) * y34 + 2 *
        (((0027449/1000000))+(-(0027449/1000000)))* y41
      + ((0170713/1000000)) + (-(0485323/1000000)) + (-(0039438/1000000)) + (-(0485323/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_5 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0029778/1000000))* y1 
     +(-(0027449/1000000))* (y2 + y3 + y5 + y6)
     +((0170713/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_5 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0072591/1000000))* y1 
     +((0027449/1000000))* (y2 + y3 + y5 + y6)
     +(-(0485323/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_5 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+2 * hminus)/ 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0055356/1000000))* y1 
     +(-(0027449/1000000))* (y2 + y3 + y5 + y6)
     +(-(0039438/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_6 : forall  y1 y12 y23 y34 y41 , 2 * hminus <=  y1 ->  y1 <=   2 * h0 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0065103/1000000)) + ((-(0008732/1000000))+((0055356/1000000))+((0072591/1000000))+((0037947/1000000)))* y1 
       + 2 * (((0025458/1000000))+(-(0025458/1000000))) * y12 + 2 *((-(0025458/1000000)) + ((0025458/1000000))) * y23 + 2 *(((0025458/1000000)) + (-(0025458/1000000))) * y34 + 2 *
        ((-(0025458/1000000))+((0025458/1000000)))* y41
      + (-(030558/100000)) + (-(0055371/1000000)) + (-(0469389/1000000)) + ((0025236/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_6 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0008732/1000000))* y1 
     +((0025458/1000000))* (y2 + y3 + y5 + y6)
     +(-(030558/100000))> 0).

Lemma l_OXLZLEZ_6346351218_2_6 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+2 * hminus)/ 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0055356/1000000))* y1 
     +(-(0025458/1000000))* (y2 + y3 + y5 + y6)
     +(-(0055371/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_6 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0072591/1000000))* y1 
     +((0025458/1000000))* (y2 + y3 + y5 + y6)
     +(-(0469389/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_7 : forall  y1 y12 y23 y34 y41 , 2 * hminus <=  y1 ->  y1 <=   2 * h0 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0114872/1000000)) + (((0116669/1000000))+((008743/100000))+((0148605/1000000))+((008743/100000)))* y1 
       + 2 * (((0080919/1000000))+(-(0080919/1000000))) * y12 + 2 *((-(0080919/1000000)) + ((0080919/1000000))) * y23 + 2 *(((0080919/1000000)) + (-(0080919/1000000))) * y34 + 2 *
        ((-(0080919/1000000))+((0080919/1000000)))* y41
      + (-(0725145/1000000)) + ((0595546/1000000)) + (-(0853324/1000000)) + ((0595546/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_7 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0114872/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0116669/1000000))* y1 
     +((0080919/1000000))* (y2 + y3 + y5 + y6)
     +(-(0725145/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_7 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0114872/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((008743/100000))* y1 
     +(-(0080919/1000000))* (y2 + y3 + y5 + y6)
     +((0595546/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_7 : forall  y1 y2 y3 y4 y5 y6 , 2 * hminus <=  y1 ->  y1 <=  2 * h0 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0114872/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0148605/1000000))* y1 
     +((0080919/1000000))* (y2 + y3 + y5 + y6)
     +(-(0853324/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_8 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0129913/1000000)) + ((-(009152/100000))+((0347659/1000000))+(-(0105208/1000000))+(-(0150931/1000000)))* y1 
       + 2 * (((0002372/1000000))+(-(0002372/1000000))) * y12 + 2 *((-(0002372/1000000)) + ((0002372/1000000))) * y23 + 2 *(((0002372/1000000)) + (-(0002372/1000000))) * y34 + 2 *
        ((-(0002372/1000000))+((0002372/1000000)))* y41
      + (-(0034749/1000000)) + (-(1030425/1000000)) + ((0072849/1000000)) + ((0176057/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_8 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(009152/100000))* y1 
     +((0002372/1000000))* (y2 + y3 + y5 + y6)
     +(-(0034749/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_8 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0347659/1000000))* y1 
     +(-(0002372/1000000))* (y2 + y3 + y5 + y6)
     +(-(1030425/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_8 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0105208/1000000))* y1 
     +((0002372/1000000))* (y2 + y3 + y5 + y6)
     +((0072849/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_9 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0129913/1000000)) + (((0340765/1000000))+(-(0094917/1000000))+(-(0150931/1000000))+(-(0094917/1000000)))* y1 
       + 2 * (((0002372/1000000))+(-(0002372/1000000))) * y12 + 2 *((-(0002372/1000000)) + ((0002372/1000000))) * y23 + 2 *(((0002372/1000000)) + (-(0002372/1000000))) * y34 + 2 *
        ((-(0002372/1000000))+((0002372/1000000)))* y41
      + (-(1124108/1000000)) + ((0084866/1000000)) + ((0138108/1000000)) + ((0084866/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_9 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0340765/1000000))* y1 
     +((0002372/1000000))* (y2 + y3 + y5 + y6)
     +(-(1124108/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_9 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0094917/1000000))* y1 
     +(-(0002372/1000000))* (y2 + y3 + y5 + y6)
     +((0084866/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_9 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+2 * hminus)/ 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0150931/1000000))* y1 
     +((0002372/1000000))* (y2 + y3 + y5 + y6)
     +((0138108/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_10 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0129913/1000000)) + ((-(009152/100000))+((0291645/1000000))+(-(0105208/1000000))+(-(0094917/1000000)))* y1 
       + 2 * (((0002372/1000000))+(-(0002372/1000000))) * y12 + 2 *((-(0002372/1000000)) + ((0002372/1000000))) * y23 + 2 *(((0002372/1000000)) + (-(0002372/1000000))) * y34 + 2 *
        ((-(0002372/1000000))+((0002372/1000000)))* y41
      + (-(0034749/1000000)) + (-(0939234/1000000)) + ((0072849/1000000)) + ((0084866/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_10 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(009152/100000))* y1 
     +((0002372/1000000))* (y2 + y3 + y5 + y6)
     +(-(0034749/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_10 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+2 * hminus)/ 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0291645/1000000))* y1 
     +(-(0002372/1000000))* (y2 + y3 + y5 + y6)
     +(-(0939234/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_10 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0129913/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0105208/1000000))* y1 
     +((0002372/1000000))* (y2 + y3 + y5 + y6)
     +((0072849/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_11 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0128506/1000000)) + (((0290371/1000000))+(-(0070878/1000000))+(-(0097658/1000000))+(-(0121835/1000000)))* y1 
       + 2 * (((0003287/1000000))+(-(0003287/1000000))) * y12 + 2 *((-(0003287/1000000)) + ((0003287/1000000))) * y23 + 2 *(((0003287/1000000)) + (-(0003287/1000000))) * y34 + 2 *
        ((-(0003287/1000000))+((0003287/1000000)))* y41
      + (-(1026581/1000000)) + ((0033394/1000000)) + ((0050047/1000000)) + ((013571/100000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_11 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0128506/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0290371/1000000))* y1 
     +((0003287/1000000))* (y2 + y3 + y5 + y6)
     +(-(1026581/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_11 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0128506/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0070878/1000000))* y1 
     +(-(0003287/1000000))* (y2 + y3 + y5 + y6)
     +((0033394/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_11 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0128506/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0097658/1000000))* y1 
     +((0003287/1000000))* (y2 + y3 + y5 + y6)
     +((0050047/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_12 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0128506/1000000)) + (((0263591/1000000))+(-(0070878/1000000))+(-(0121835/1000000))+(-(0070878/1000000)))* y1 
       + 2 * (((0003287/1000000))+(-(0003287/1000000))) * y12 + 2 *((-(0003287/1000000)) + ((0003287/1000000))) * y23 + 2 *(((0003287/1000000)) + (-(0003287/1000000))) * y34 + 2 *
        ((-(0003287/1000000))+((0003287/1000000)))* y41
      + (-(0957343/1000000)) + ((0033394/1000000)) + ((0083125/1000000)) + ((0033394/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_12 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0128506/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0263591/1000000))* y1 
     +((0003287/1000000))* (y2 + y3 + y5 + y6)
     +(-(0957343/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_12 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0128506/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0070878/1000000))* y1 
     +(-(0003287/1000000))* (y2 + y3 + y5 + y6)
     +((0033394/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_12 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+(2+2 * hminus)/ 2)/ 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0128506/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0121835/1000000))* y1 
     +((0003287/1000000))* (y2 + y3 + y5 + y6)
     +((0083125/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_13 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0128506/1000000)) + ((-(0066254/1000000))+((0234791/1000000))+(-(0097658/1000000))+(-(0070878/1000000)))* y1 
       + 2 * (((0003287/1000000))+(-(0003287/1000000))) * y12 + 2 *((-(0003287/1000000)) + ((0003287/1000000))) * y23 + 2 *(((0003287/1000000)) + (-(0003287/1000000))) * y34 + 2 *
        ((-(0003287/1000000))+((0003287/1000000)))* y41
      + (-(0104563/1000000)) + (-(0786309/1000000)) + ((0050047/1000000)) + ((0033394/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_13 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0128506/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0066254/1000000))* y1 
     +((0003287/1000000))* (y2 + y3 + y5 + y6)
     +(-(0104563/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_13 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+(2+2 * hminus)/ 2)/ 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0128506/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0234791/1000000))* y1 
     +(-(0003287/1000000))* (y2 + y3 + y5 + y6)
     +(-(0786309/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_13 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0128506/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0097658/1000000))* y1 
     +((0003287/1000000))* (y2 + y3 + y5 + y6)
     +((0050047/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_14 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0127166/1000000)) + ((-(007331/100000))+((023984/100000))+(-(0096981/1000000))+(-(0069548/1000000)))* y1 
       + 2 * (((0003788/1000000))+(-(0003788/1000000))) * y12 + 2 *((-(0003788/1000000)) + ((0003788/1000000))) * y23 + 2 *(((0003788/1000000)) + (-(0003788/1000000))) * y34 + 2 *
        ((-(0003788/1000000))+((0003788/1000000)))* y41
      + (-(0105909/1000000)) + (-(0767737/1000000)) + ((004248/100000)) + ((0032155/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_14 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2 * h0+2 * hplus)/ 2 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0127166/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(007331/100000))* y1 
     +((0003788/1000000))* (y2 + y3 + y5 + y6)
     +(-(0105909/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_14 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0127166/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((023984/100000))* y1 
     +(-(0003788/1000000))* (y2 + y3 + y5 + y6)
     +(-(0767737/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_14 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0127166/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0096981/1000000))* y1 
     +((0003788/1000000))* (y2 + y3 + y5 + y6)
     +((004248/100000))> 0).

Lemma l_OXLZLEZ_6346351218_0_15 : forall  y1 y12 y23 y34 y41 , ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0126777/1000000)) + ((-(0053069/1000000))+((0196466/1000000))+(-(0093532/1000000))+(-(0049865/1000000)))* y1 
       + 2 * (((0003525/1000000))+(-(0003525/1000000))) * y12 + 2 *((-(0003525/1000000)) + ((0003525/1000000))) * y23 + 2 *(((0003525/1000000)) + (-(0003525/1000000))) * y34 + 2 *
        ((-(0003525/1000000))+((0003525/1000000)))* y41
      + (-(0142652/1000000)) + (-(0667227/1000000)) + ((0035622/1000000)) + (-(0022307/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_15 : forall  y1 y2 y3 y4 y5 y6 , ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= (2 * h0+2 * hplus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0126777/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0053069/1000000))* y1 
     +((0003525/1000000))* (y2 + y3 + y5 + y6)
     +(-(0142652/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_15 : forall  y1 y2 y3 y4 y5 y6 , ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0126777/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0196466/1000000))* y1 
     +(-(0003525/1000000))* (y2 + y3 + y5 + y6)
     +(-(0667227/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_15 : forall  y1 y2 y3 y4 y5 y6 , ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0126777/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0093532/1000000))* y1 
     +((0003525/1000000))* (y2 + y3 + y5 + y6)
     +((0035622/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_16 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(00469/10000)) + (((0051237/1000000))+(-(0014413/1000000))+(-(0014413/1000000))+(-(002241/100000)))* y1 
       + 2 * (((0060747/1000000))+(-(0060747/1000000))) * y12 + 2 *((-(0060747/1000000)) + ((0060747/1000000))) * y23 + 2 *(((0060747/1000000)) + (-(0060747/1000000))) * y34 + 2 *
        ((-(0060747/1000000))+((0060747/1000000)))* y41
      + (-(0530637/1000000)) + ((0594377/1000000)) + (-(0377571/1000000)) + ((0608509/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_16 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= (2 * h0+2 * hplus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0051237/1000000))* y1 
     +((0060747/1000000))* (y2 + y3 + y5 + y6)
     +(-(0530637/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_16 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0014413/1000000))* y1 
     +(-(0060747/1000000))* (y2 + y3 + y5 + y6)
     +((0594377/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_16 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0014413/1000000))* y1 
     +((0060747/1000000))* (y2 + y3 + y5 + y6)
     +(-(0377571/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_17 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(00469/10000)) + (((0051237/1000000))+(-(0014413/1000000))+(-(002241/100000))+(-(0014413/1000000)))* y1 
       + 2 * (((0060747/1000000))+(-(0060747/1000000))) * y12 + 2 *((-(0060747/1000000)) + ((0060747/1000000))) * y23 + 2 *(((0060747/1000000)) + (-(0060747/1000000))) * y34 + 2 *
        ((-(0060747/1000000))+((0060747/1000000)))* y41
      + (-(0530636/1000000)) + ((0594377/1000000)) + (-(036344/100000)) + ((0594377/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_17 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= (2 * h0+2 * hplus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0051237/1000000))* y1 
     +((0060747/1000000))* (y2 + y3 + y5 + y6)
     +(-(0530636/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_17 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0014413/1000000))* y1 
     +(-(0060747/1000000))* (y2 + y3 + y5 + y6)
     +((0594377/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_17 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(002241/100000))* y1 
     +((0060747/1000000))* (y2 + y3 + y5 + y6)
     +(-(036344/100000))> 0).

Lemma l_OXLZLEZ_6346351218_0_18 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(00469/10000)) + (((0051237/1000000))+(-(002241/100000))+(-(0014413/1000000))+(-(0014413/1000000)))* y1 
       + 2 * (((0060747/1000000))+(-(0060747/1000000))) * y12 + 2 *((-(0060747/1000000)) + ((0060747/1000000))) * y23 + 2 *(((0060747/1000000)) + (-(0060747/1000000))) * y34 + 2 *
        ((-(0060747/1000000))+((0060747/1000000)))* y41
      + (-(0530637/1000000)) + ((0608509/1000000)) + (-(0377571/1000000)) + ((0594377/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_18 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= (2 * h0+2 * hplus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0051237/1000000))* y1 
     +((0060747/1000000))* (y2 + y3 + y5 + y6)
     +(-(0530637/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_18 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(002241/100000))* y1 
     +(-(0060747/1000000))* (y2 + y3 + y5 + y6)
     +((0608509/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_18 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0014413/1000000))* y1 
     +((0060747/1000000))* (y2 + y3 + y5 + y6)
     +(-(0377571/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_19 : forall  y1 y12 y23 y34 y41 , ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 <=  y1 ->  y1 <=   ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0036939/1000000)) + (((0050064/1000000))+(-(0016688/1000000))+(-(0016688/1000000))+(-(0016688/1000000)))* y1 
       + 2 * ((-(0057593/1000000))+((0057593/1000000))) * y12 + 2 *(((0057593/1000000)) + (-(0057593/1000000))) * y23 + 2 *((-(0057593/1000000)) + (-(0057593/1000000))) * y34 + 2 *
        ((-(0057593/1000000))+(-(0057593/1000000)))* y41
      + ((0397884/1000000)) + (-(0362427/1000000)) + ((0559062/1000000)) + ((0559062/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_19 : forall  y1 y2 y3 y4 y5 y6 , ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= (2 * h0+2 * hplus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0036939/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0050064/1000000))* y1 
     +(-(0057593/1000000))* (y2 + y3 + y5 + y6)
     +((0397884/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_19 : forall  y1 y2 y3 y4 y5 y6 , ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0036939/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0016688/1000000))* y1 
     +((0057593/1000000))* (y2 + y3 + y5 + y6)
     +(-(0362427/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_19 : forall  y1 y2 y3 y4 y5 y6 , ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0036939/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0016688/1000000))* y1 
     +(-(0057593/1000000))* (y2 + y3 + y5 + y6)
     +((0559062/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_20 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0049823/1000000)) + (((0047052/1000000))+(-(0015684/1000000))+(-(0015684/1000000))+(-(0015684/1000000)))* y1 
       + 2 * ((-(0061687/1000000))+((0061687/1000000))) * y12 + 2 *(((0061687/1000000)) + (-(0061687/1000000))) * y23 + 2 *((-(0061687/1000000)) + ((0061687/1000000))) * y34 + 2 *
        (((0061687/1000000))+(-(0061687/1000000)))* y41
      + ((0463622/1000000)) + (-(0379191/1000000)) + ((0607807/1000000)) + (-(0379191/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_20 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 <= y4 -> y4 <= (2 * h0+2 * hplus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0049823/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0047052/1000000))* y1 
     +(-(0061687/1000000))* (y2 + y3 + y5 + y6)
     +((0463622/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_20 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0049823/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0015684/1000000))* y1 
     +((0061687/1000000))* (y2 + y3 + y5 + y6)
     +(-(0379191/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_20 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0049823/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0015684/1000000))* y1 
     +(-(0061687/1000000))* (y2 + y3 + y5 + y6)
     +((0607807/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_21 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0053582/1000000)) + (((0049452/1000000))+(-(0013853/1000000))+(-(0020791/1000000))+(-(0013853/1000000)))* y1 
       + 2 * ((-(006302/100000))+((006302/100000))) * y12 + 2 *(((006302/100000)) + (-(006302/100000))) * y23 + 2 *((-(006302/100000)) + (-(0062897/1000000))) * y34 + 2 *
        ((-(0062897/1000000))+(-(006302/100000)))* y41
      + ((0475514/1000000)) + (-(0389234/1000000)) + ((0637132/1000000)) + ((0618101/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_21 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0053582/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0049452/1000000))* y1 
     +(-(006302/100000))* (y2 + y3 + y5 + y6)
     +((0475514/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_21 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0053582/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0013853/1000000))* y1 
     +((006302/100000))* (y2 + y3 + y5 + y6)
     +(-(0389234/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_21 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0053582/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0020791/1000000))* y1 
     +(-(006302/100000))* (y2 + y3 + y5 + y6)
     +((0637132/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_22 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   (2 * h0+2 * hplus)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0066935/1000000)) + (((0079693/1000000))+(-(0021495/1000000))+(-(0021495/1000000))+(-(0036704/1000000)))* y1 
       + 2 * (((0066241/1000000))+(-(0066241/1000000))) * y12 + 2 *((-(0066241/1000000)) + ((0066241/1000000))) * y23 + 2 *(((0066241/1000000)) + (-(0066241/1000000))) * y34 + 2 *
        ((-(0066241/1000000))+((0066241/1000000)))* y41
      + (-(0605497/1000000)) + ((0685308/1000000)) + (-(0374549/1000000)) + ((0715304/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_22 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0066935/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0079693/1000000))* y1 
     +((0066241/1000000))* (y2 + y3 + y5 + y6)
     +(-(0605497/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_22 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0066935/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0021495/1000000))* y1 
     +(-(0066241/1000000))* (y2 + y3 + y5 + y6)
     +((0685308/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_22 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0066935/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0021495/1000000))* y1 
     +((0066241/1000000))* (y2 + y3 + y5 + y6)
     +(-(0374549/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_23 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   (2 * h0+2 * hplus)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0066935/1000000)) + (((0028887/1000000))+(-(0021495/1000000))+((0014102/1000000))+(-(0021495/1000000)))* y1 
       + 2 * (((0066241/1000000))+(-(0066241/1000000))) * y12 + 2 *((-(0066241/1000000)) + ((0066241/1000000))) * y23 + 2 *(((0066241/1000000)) + (-(0066241/1000000))) * y34 + 2 *
        ((-(0066241/1000000))+((0066241/1000000)))* y41
      + (-(0477466/1000000)) + ((0685308/1000000)) + (-(0472584/1000000)) + ((0685308/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_23 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0066935/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0028887/1000000))* y1 
     +((0066241/1000000))* (y2 + y3 + y5 + y6)
     +(-(0477466/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_23 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0066935/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0021495/1000000))* y1 
     +(-(0066241/1000000))* (y2 + y3 + y5 + y6)
     +((0685308/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_23 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+(2+2 * hminus)/ 2)/ 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0066935/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0014102/1000000))* y1 
     +((0066241/1000000))* (y2 + y3 + y5 + y6)
     +(-(0472584/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_24 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   (2 * h0+2 * hplus)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0066935/1000000)) + (((0028887/1000000))+((0014102/1000000))+(-(0021495/1000000))+(-(0021495/1000000)))* y1 
       + 2 * ((-(0066241/1000000))+((0066241/1000000))) * y12 + 2 *(((0066241/1000000)) + (-(0066241/1000000))) * y23 + 2 *((-(0066241/1000000)) + ((0066241/1000000))) * y34 + 2 *
        (((0066241/1000000))+(-(0066241/1000000)))* y41
      + ((0582391/1000000)) + (-(0472584/1000000)) + ((0685308/1000000)) + (-(0374549/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_24 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0066935/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0028887/1000000))* y1 
     +(-(0066241/1000000))* (y2 + y3 + y5 + y6)
     +((0582391/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_24 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+(2+2 * hminus)/ 2)/ 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0066935/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0014102/1000000))* y1 
     +((0066241/1000000))* (y2 + y3 + y5 + y6)
     +(-(0472584/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_24 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0066935/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0021495/1000000))* y1 
     +(-(0066241/1000000))* (y2 + y3 + y5 + y6)
     +((0685308/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_25 : forall  y1 y12 y23 y34 y41 , (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 <=  y1 ->  y1 <=   (2 * h0+2 * hplus)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0070081/1000000)) + (((0043025/1000000))+(-(0014342/1000000))+(-(0014342/1000000))+(-(0014342/1000000)))* y1 
       + 2 * (((006775/100000))+(-(006775/100000))) * y12 + 2 *((-(006775/100000)) + ((006775/100000))) * y23 + 2 *(((006775/100000)) + (-(006775/100000))) * y34 + 2 *
        ((-(006775/100000))+((006775/100000)))* y41
      + (-(0520998/1000000)) + ((0681778/1000000)) + (-(0402228/1000000)) + ((0681778/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_25 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2 * h0+2 * hplus)/ 2 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0070081/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0043025/1000000))* y1 
     +((006775/100000))* (y2 + y3 + y5 + y6)
     +(-(0520998/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_25 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0070081/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0014342/1000000))* y1 
     +(-(006775/100000))* (y2 + y3 + y5 + y6)
     +((0681778/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_25 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0070081/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0014342/1000000))* y1 
     +((006775/100000))* (y2 + y3 + y5 + y6)
     +(-(0402228/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_26 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0074623/1000000)) + (((0079355/1000000))+(-(0023711/1000000))+(-(0023711/1000000))+(-(0031932/1000000)))* y1 
       + 2 * (((0068595/1000000))+(-(0068595/1000000))) * y12 + 2 *((-(0068595/1000000)) + ((0068595/1000000))) * y23 + 2 *(((0068595/1000000)) + (-(0068595/1000000))) * y34 + 2 *
        ((-(0068595/1000000))+((0068595/1000000)))* y41
      + (-(0608613/1000000)) + ((0719631/1000000)) + (-(037789/100000)) + ((0735738/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_26 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2 * h0+2 * hplus)/ 2 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0074623/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0079355/1000000))* y1 
     +((0068595/1000000))* (y2 + y3 + y5 + y6)
     +(-(0608613/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_26 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0074623/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0023711/1000000))* y1 
     +(-(0068595/1000000))* (y2 + y3 + y5 + y6)
     +((0719631/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_26 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0074623/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0023711/1000000))* y1 
     +((0068595/1000000))* (y2 + y3 + y5 + y6)
     +(-(037789/100000))> 0).

Lemma l_OXLZLEZ_6346351218_0_27 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0074623/1000000)) + (((0019702/1000000))+(-(0023711/1000000))+(-(0031932/1000000))+((0035942/1000000)))* y1 
       + 2 * ((-(0081204/1000000))+((0081204/1000000))) * y12 + 2 *(((0081204/1000000)) + (-(0081204/1000000))) * y23 + 2 *((-(0081204/1000000)) + ((0081204/1000000))) * y34 + 2 *
        (((0081204/1000000))+(-(0081204/1000000)))* y41
      + ((0740105/1000000)) + (-(047876/100000)) + ((0836608/1000000)) + (-(0629086/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_27 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2 * h0+2 * hplus)/ 2 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0074623/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0019702/1000000))* y1 
     +(-(0081204/1000000))* (y2 + y3 + y5 + y6)
     +((0740105/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_27 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0074623/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0023711/1000000))* y1 
     +((0081204/1000000))* (y2 + y3 + y5 + y6)
     +(-(047876/100000))> 0).

Lemma l_OXLZLEZ_6346351218_3_27 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0074623/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0031932/1000000))* y1 
     +(-(0081204/1000000))* (y2 + y3 + y5 + y6)
     +((0836608/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_28 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0074623/1000000)) + (((0019702/1000000))+(-(0031932/1000000))+(-(0023711/1000000))+((0035942/1000000)))* y1 
       + 2 * ((-(0068595/1000000))+((0068595/1000000))) * y12 + 2 *(((0068595/1000000)) + (-(0068595/1000000))) * y23 + 2 *((-(0068595/1000000)) + ((0068595/1000000))) * y34 + 2 *
        (((0068595/1000000))+(-(0068595/1000000)))* y41
      + ((0639237/1000000)) + (-(0361784/1000000)) + ((0719631/1000000)) + (-(0528217/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_28 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2 * h0+2 * hplus)/ 2 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0074623/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0019702/1000000))* y1 
     +(-(0068595/1000000))* (y2 + y3 + y5 + y6)
     +((0639237/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_28 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0074623/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0031932/1000000))* y1 
     +((0068595/1000000))* (y2 + y3 + y5 + y6)
     +(-(0361784/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_28 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0074623/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0023711/1000000))* y1 
     +(-(0068595/1000000))* (y2 + y3 + y5 + y6)
     +((0719631/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_29 : forall  y1 y12 y23 y34 y41 , (2 * h0+(2 * h0+(2 * h0+2 * hplus)/ 2)/ 2)/ 2 <=  y1 ->  y1 <=   (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0090009/1000000)) + (((004151/100000))+(-(0013837/1000000))+(-(0013837/1000000))+(-(0013837/1000000)))* y1 
       + 2 * (((0073665/1000000))+(-(0073665/1000000))) * y12 + 2 *((-(0073665/1000000)) + ((0073665/1000000))) * y23 + 2 *(((0073665/1000000)) + (-(0073665/1000000))) * y34 + 2 *
        ((-(0073665/1000000))+((0073665/1000000)))* y41
      + (-(0523458/1000000)) + ((0755879/1000000)) + (-(0422755/1000000)) + ((0755879/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_29 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+(2 * h0+(2 * h0+2 * hplus)/ 2)/ 2)/ 2 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0090009/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((004151/100000))* y1 
     +((0073665/1000000))* (y2 + y3 + y5 + y6)
     +(-(0523458/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_29 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+(2 * h0+(2 * h0+2 * hplus)/ 2)/ 2)/ 2 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0090009/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0013837/1000000))* y1 
     +(-(0073665/1000000))* (y2 + y3 + y5 + y6)
     +((0755879/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_29 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+(2 * h0+(2 * h0+2 * hplus)/ 2)/ 2)/ 2 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0090009/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0013837/1000000))* y1 
     +((0073665/1000000))* (y2 + y3 + y5 + y6)
     +(-(0422755/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_30 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   (2 * h0+(2 * h0+(2 * h0+2 * hplus)/ 2)/ 2)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(017025/100000)) + (((0094709/1000000))+(-(0021455/1000000))+((0009749/1000000))+(-(0021455/1000000)))* y1 
       + 2 * (((0098535/1000000))+(-(0098535/1000000))) * y12 + 2 *((-(0098535/1000000)) + ((0098535/1000000))) * y23 + 2 *(((0098535/1000000)) + (-(0098535/1000000))) * y34 + 2 *
        ((-(0098535/1000000))+((0098535/1000000)))* y41
      + (-(0692034/1000000)) + ((1087114/1000000)) + (-(0568591/1000000)) + ((1087114/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_30 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+(2 * h0+2 * hplus)/ 2)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 <= y4 -> y4 <= 2 * hplus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(017025/100000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0094709/1000000))* y1 
     +((0098535/1000000))* (y2 + y3 + y5 + y6)
     +(-(0692034/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_30 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+(2 * h0+2 * hplus)/ 2)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(017025/100000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0021455/1000000))* y1 
     +(-(0098535/1000000))* (y2 + y3 + y5 + y6)
     +((1087114/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_30 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+(2 * h0+2 * hplus)/ 2)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(017025/100000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0009749/1000000))* y1 
     +((0098535/1000000))* (y2 + y3 + y5 + y6)
     +(-(0568591/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_31 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0172166/1000000)) + (((009973/100000))+((0014169/1000000))+(-(0017353/1000000))+((0014169/1000000)))* y1 
       + 2 * ((-(0099785/1000000))+((0099785/1000000))) * y12 + 2 *(((0099785/1000000)) + (-(0099785/1000000))) * y23 + 2 *((-(0099785/1000000)) + ((0099785/1000000))) * y34 + 2 *
        (((0099785/1000000))+(-(0099785/1000000)))* y41
      + ((0882284/1000000)) + (-(0586728/1000000)) + ((10903/10000)) + (-(0586728/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_31 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2 * h0+2 * hplus)/ 2 <= y4 -> y4 <= ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0172166/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((009973/100000))* y1 
     +(-(0099785/1000000))* (y2 + y3 + y5 + y6)
     +((0882284/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_31 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0172166/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0014169/1000000))* y1 
     +((0099785/1000000))* (y2 + y3 + y5 + y6)
     +(-(0586728/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_31 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+(2 * h0+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0172166/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0017353/1000000))* y1 
     +(-(0099785/1000000))* (y2 + y3 + y5 + y6)
     +((10903/10000))> 0).

Lemma l_OXLZLEZ_6346351218_0_32 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   (2 * h0+2 * hplus)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0084789/1000000)) + (((0039845/1000000))+(-(0013282/1000000))+(-(0013282/1000000))+(-(0013282/1000000)))* y1 
       + 2 * ((-(0071708/1000000))+(-(0071708/1000000))) * y12 + 2 *((-(0071708/1000000)) + (-(0071708/1000000))) * y23 + 2 *((-(0071708/1000000)) + ((0071708/1000000))) * y34 + 2 *
        (((0071708/1000000))+(-(0071708/1000000)))* y41
      + ((0632521/1000000)) + ((0731624/1000000)) + ((0731624/1000000)) + (-(0415701/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_32 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * h0 <= y4 -> y4 <= (2 * h0+2 * hplus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0084789/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0039845/1000000))* y1 
     +(-(0071708/1000000))* (y2 + y3 + y5 + y6)
     +((0632521/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_32 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0084789/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0013282/1000000))* y1 
     +(-(0071708/1000000))* (y2 + y3 + y5 + y6)
     +((0731624/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_32 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  (2 * h0+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0084789/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0013282/1000000))* y1 
     +(-(0071708/1000000))* (y2 + y3 + y5 + y6)
     +((0731624/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_33 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0065103/1000000)) + ((-(0052337/1000000))+((023854/100000))+(-(0073933/1000000))+(-(011227/100000)))* y1 
       + 2 * ((-(002292/100000))+((002292/100000))) * y12 + 2 *(((002292/100000)) + (-(002292/100000))) * y23 + 2 *((-(002292/100000)) + ((002292/100000))) * y34 + 2 *
        (((002292/100000))+(-(002292/100000)))* y41
      + ((0191326/1000000)) + (-(0867278/1000000)) + ((0286871/1000000)) + (-(0019974/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_33 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0052337/1000000))* y1 
     +(-(002292/100000))* (y2 + y3 + y5 + y6)
     +((0191326/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_33 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((023854/100000))* y1 
     +((002292/100000))* (y2 + y3 + y5 + y6)
     +(-(0867278/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_33 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0073933/1000000))* y1 
     +(-(002292/100000))* (y2 + y3 + y5 + y6)
     +((0286871/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_34 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0065103/1000000)) + ((-(0052337/1000000))+((023854/100000))+(-(011227/100000))+(-(0073933/1000000)))* y1 
       + 2 * (((002292/100000))+(-(002292/100000))) * y12 + 2 *((-(002292/100000)) + ((002292/100000))) * y23 + 2 *(((002292/100000)) + (-(002292/100000))) * y34 + 2 *
        ((-(002292/100000))+((002292/100000)))* y41
      + (-(017539/100000)) + (-(0500562/1000000)) + (-(0019974/1000000)) + ((0286871/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_34 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0052337/1000000))* y1 
     +((002292/100000))* (y2 + y3 + y5 + y6)
     +(-(017539/100000))> 0).

Lemma l_OXLZLEZ_6346351218_2_34 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((023854/100000))* y1 
     +(-(002292/100000))* (y2 + y3 + y5 + y6)
     +(-(0500562/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_34 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+2 * hminus)/ 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(011227/100000))* y1 
     +((002292/100000))* (y2 + y3 + y5 + y6)
     +(-(0019974/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_35 : forall  y1 y12 y23 y34 y41 , 2 * h0 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0065103/1000000)) + ((-(0052337/1000000))+(-(011227/100000))+((023854/100000))+(-(0073933/1000000)))* y1 
       + 2 * (((002292/100000))+(-(002292/100000))) * y12 + 2 *((-(002292/100000)) + ((002292/100000))) * y23 + 2 *(((002292/100000)) + (-(002292/100000))) * y34 + 2 *
        ((-(002292/100000))+((002292/100000)))* y41
      + (-(0175391/1000000)) + ((0346743/1000000)) + (-(0867278/1000000)) + ((0286871/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_35 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0052337/1000000))* y1 
     +((002292/100000))* (y2 + y3 + y5 + y6)
     +(-(0175391/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_35 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+2 * hminus)/ 2 <= y4 -> y4 <= 2 * hminus -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(011227/100000))* y1 
     +(-(002292/100000))* (y2 + y3 + y5 + y6)
     +((0346743/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_35 : forall  y1 y2 y3 y4 y5 y6 , 2 * h0 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0065103/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((023854/100000))* y1 
     +((002292/100000))* (y2 + y3 + y5 + y6)
     +(-(0867278/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_36 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0062681/1000000)) + ((-(0026929/1000000))+(-(006441/100000))+((0176245/1000000))+(-(0084906/1000000)))* y1 
       + 2 * (((0023742/1000000))+(-(0023742/1000000))) * y12 + 2 *((-(0023742/1000000)) + ((0023742/1000000))) * y23 + 2 *(((0023742/1000000)) + (-(0023742/1000000))) * y34 + 2 *
        ((-(0023742/1000000))+((0023742/1000000)))* y41
      + (-(0242815/1000000)) + ((0273568/1000000)) + (-(072849/100000)) + ((03039/10000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_36 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0062681/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0026929/1000000))* y1 
     +((0023742/1000000))* (y2 + y3 + y5 + y6)
     +(-(0242815/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_36 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0062681/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(006441/100000))* y1 
     +(-(0023742/1000000))* (y2 + y3 + y5 + y6)
     +((0273568/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_36 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0062681/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0176245/1000000))* y1 
     +((0023742/1000000))* (y2 + y3 + y5 + y6)
     +(-(072849/100000))> 0).

Lemma l_OXLZLEZ_6346351218_0_37 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0062681/1000000)) + ((-(0026929/1000000))+((0176245/1000000))+(-(0084906/1000000))+(-(006441/100000)))* y1 
       + 2 * (((0023742/1000000))+(-(0023742/1000000))) * y12 + 2 *((-(0023742/1000000)) + ((0023742/1000000))) * y23 + 2 *(((0023742/1000000)) + (-(0023742/1000000))) * y34 + 2 *
        ((-(0023742/1000000))+((0023742/1000000)))* y41
      + (-(0242815/1000000)) + (-(0348621/1000000)) + (-(0075969/1000000)) + ((0273568/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_37 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0062681/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0026929/1000000))* y1 
     +((0023742/1000000))* (y2 + y3 + y5 + y6)
     +(-(0242815/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_37 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0062681/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0176245/1000000))* y1 
     +(-(0023742/1000000))* (y2 + y3 + y5 + y6)
     +(-(0348621/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_37 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+(2+2 * hminus)/ 2)/ 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0062681/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0084906/1000000))* y1 
     +((0023742/1000000))* (y2 + y3 + y5 + y6)
     +(-(0075969/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_38 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0062681/1000000)) + ((-(0026929/1000000))+(-(0084906/1000000))+((0176245/1000000))+(-(006441/100000)))* y1 
       + 2 * (((0023742/1000000))+(-(0023742/1000000))) * y12 + 2 *((-(0023742/1000000)) + ((0023742/1000000))) * y23 + 2 *(((0023742/1000000)) + (-(0023742/1000000))) * y34 + 2 *
        ((-(0023742/1000000))+((0023742/1000000)))* y41
      + (-(0242815/1000000)) + ((03039/10000)) + (-(072849/100000)) + ((0273568/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_38 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0062681/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0026929/1000000))* y1 
     +((0023742/1000000))* (y2 + y3 + y5 + y6)
     +(-(0242815/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_38 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+(2+2 * hminus)/ 2)/ 2 <= y4 -> y4 <= (2+2 * hminus)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0062681/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0084906/1000000))* y1 
     +(-(0023742/1000000))* (y2 + y3 + y5 + y6)
     +((03039/10000))> 0).

Lemma l_OXLZLEZ_6346351218_3_38 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0062681/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0176245/1000000))* y1 
     +((0023742/1000000))* (y2 + y3 + y5 + y6)
     +(-(072849/100000))> 0).

Lemma l_OXLZLEZ_6346351218_0_39 : forall  y1 y12 y23 y34 y41 , ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 <=  y1 ->  y1 <=   2 * hplus -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * ((0061714/1000000)) + ((-(0014502/1000000))+((0134266/1000000))+(-(0059882/1000000))+(-(0059882/1000000)))* y1 
       + 2 * ((-(002407/100000))+((002407/100000))) * y12 + 2 *(((002407/100000)) + (-(002407/100000))) * y23 + 2 *((-(002407/100000)) + (-(002407/100000))) * y34 + 2 *
        ((-(002407/100000))+(-(002407/100000)))* y41
      + ((0104941/1000000)) + (-(0631477/1000000)) + ((0261947/1000000)) + ((0261947/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_39 : forall  y1 y2 y3 y4 y5 y6 , ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0061714/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0014502/1000000))* y1 
     +(-(002407/100000))* (y2 + y3 + y5 + y6)
     +((0104941/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_39 : forall  y1 y2 y3 y4 y5 y6 , ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0061714/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0134266/1000000))* y1 
     +((002407/100000))* (y2 + y3 + y5 + y6)
     +(-(0631477/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_39 : forall  y1 y2 y3 y4 y5 y6 , ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 <=  y1 ->  y1 <=  2 * hplus -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +((0061714/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0059882/1000000))* y1 
     +(-(002407/100000))* (y2 + y3 + y5 + y6)
     +((0261947/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_40 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(00469/10000)) + (((0051237/1000000))+(-(0014413/1000000))+(-(0014413/1000000))+(-(002241/100000)))* y1 
       + 2 * (((0060747/1000000))+(-(0060747/1000000))) * y12 + 2 *((-(0060747/1000000)) + ((0060747/1000000))) * y23 + 2 *(((0060747/1000000)) + (-(0060747/1000000))) * y34 + 2 *
        ((-(0060747/1000000))+((0060747/1000000)))* y41
      + (-(0530637/1000000)) + ((0594377/1000000)) + (-(0377571/1000000)) + ((0608509/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_40 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0051237/1000000))* y1 
     +((0060747/1000000))* (y2 + y3 + y5 + y6)
     +(-(0530637/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_40 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0014413/1000000))* y1 
     +(-(0060747/1000000))* (y2 + y3 + y5 + y6)
     +((0594377/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_40 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0014413/1000000))* y1 
     +((0060747/1000000))* (y2 + y3 + y5 + y6)
     +(-(0377571/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_41 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(00469/10000)) + (((0051237/1000000))+(-(0014413/1000000))+(-(002241/100000))+(-(0014413/1000000)))* y1 
       + 2 * ((-(0073427/1000000))+((0073427/1000000))) * y12 + 2 *(((0073427/1000000)) + (-(0073427/1000000))) * y23 + 2 *((-(0073427/1000000)) + ((0073427/1000000))) * y34 + 2 *
        (((0073427/1000000))+(-(0073427/1000000)))* y41
      + ((0542756/1000000)) + (-(0479016/1000000)) + ((0709954/1000000)) + (-(0479016/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_41 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0051237/1000000))* y1 
     +(-(0073427/1000000))* (y2 + y3 + y5 + y6)
     +((0542756/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_41 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0014413/1000000))* y1 
     +((0073427/1000000))* (y2 + y3 + y5 + y6)
     +(-(0479016/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_41 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(002241/100000))* y1 
     +(-(0073427/1000000))* (y2 + y3 + y5 + y6)
     +((0709954/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_42 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(00469/10000)) + (((0051237/1000000))+(-(002241/100000))+(-(0014413/1000000))+(-(0014413/1000000)))* y1 
       + 2 * ((-(0060747/1000000))+((0060747/1000000))) * y12 + 2 *(((0060747/1000000)) + (-(0060747/1000000))) * y23 + 2 *((-(0060747/1000000)) + ((0060747/1000000))) * y34 + 2 *
        (((0060747/1000000))+(-(0060747/1000000)))* y41
      + ((0441312/1000000)) + (-(036344/100000)) + ((0594377/1000000)) + (-(0377571/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_42 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0051237/1000000))* y1 
     +(-(0060747/1000000))* (y2 + y3 + y5 + y6)
     +((0441312/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_42 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 <= y4 -> y4 <= (2+(2+2 * hminus)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(002241/100000))* y1 
     +((0060747/1000000))* (y2 + y3 + y5 + y6)
     +(-(036344/100000))> 0).

Lemma l_OXLZLEZ_6346351218_3_42 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(00469/10000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0014413/1000000))* y1 
     +(-(0060747/1000000))* (y2 + y3 + y5 + y6)
     +((0594377/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_43 : forall  y1 y12 y23 y34 y41 , ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 <=  y1 ->  y1 <=   ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0036939/1000000)) + (((0050064/1000000))+(-(0016688/1000000))+(-(0016688/1000000))+(-(0016688/1000000)))* y1 
       + 2 * (((0057593/1000000))+(-(0057593/1000000))) * y12 + 2 *((-(0057593/1000000)) + ((0057593/1000000))) * y23 + 2 *(((0057593/1000000)) + (-(0057593/1000000))) * y34 + 2 *
        ((-(0057593/1000000))+((0057593/1000000)))* y41
      + (-(0523604/1000000)) + ((0559062/1000000)) + (-(0362427/1000000)) + ((0559062/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_43 : forall  y1 y2 y3 y4 y5 y6 , ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0036939/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0050064/1000000))* y1 
     +((0057593/1000000))* (y2 + y3 + y5 + y6)
     +(-(0523604/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_43 : forall  y1 y2 y3 y4 y5 y6 , ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0036939/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0016688/1000000))* y1 
     +(-(0057593/1000000))* (y2 + y3 + y5 + y6)
     +((0559062/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_43 : forall  y1 y2 y3 y4 y5 y6 , ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0036939/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +(-(0016688/1000000))* y1 
     +((0057593/1000000))* (y2 + y3 + y5 + y6)
     +(-(0362427/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_0_44 : forall  y1 y12 y23 y34 y41 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=   ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 -> 2  <= y12 -> y12 <=  2 * hminus -> 2 <= y23 -> y23 <=  2 * hminus -> 2 <= y34 -> y34 <=  2 * hminus -> 2 <= y41 -> y41 <=  2 * hminus -> 
    (2 * PI * (-(0177145/1000000)) + (((0151334/1000000))+((0041584/1000000))+((000995/100000))+((0041584/1000000)))* y1 
       + 2 * ((-(0103308/1000000))+((0103308/1000000))) * y12 + 2 *(((0103308/1000000)) + (-(0103308/1000000))) * y23 + 2 *((-(0103308/1000000)) + ((0103308/1000000))) * y34 + 2 *
        (((0103308/1000000))+(-(0103308/1000000)))* y41
      + ((0774954/1000000)) + (-(0677721/1000000)) + ((1057518/1000000)) + (-(0677721/1000000))  < 0).

Lemma l_OXLZLEZ_6346351218_1_44 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 * hminus <= y4 -> y4 <= 2 * h0 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 2 + 1 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0177145/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0151334/1000000))* y1 
     +(-(0103308/1000000))* (y2 + y3 + y5 + y6)
     +((0774954/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_2_44 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0177145/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((0041584/1000000))* y1 
     +((0103308/1000000))* (y2 + y3 + y5 + y6)
     +(-(0677721/1000000))> 0).

Lemma l_OXLZLEZ_6346351218_3_44 : forall  y1 y2 y3 y4 y5 y6 , (2 * h0+2 * hplus)/ 2 <=  y1 ->  y1 <=  ((2 * h0+2 * hplus)/ 2+((2 * h0+2 * hplus)/ 2+2 * hplus)/ 2)/ 2 -> 2  <= y2 -> y2 <=  2 * hminus -> 2 <= y3 -> y3 <= 2 * hminus -> 2 <= y4 -> y4 <= (2+(2+(2+2 * hminus)/ 2)/ 2)/ 2 -> 2 <= y5 -> y5 <= 2 * hminus -> 2 <= y6 -> y6 <= 2 * hminus -> 
    (gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun / 1 + 0 *beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +(-(0177145/1000000))* dih_y y1 y2 y3 y4 y5 y6  
     +((000995/100000))* y1 
     +(-(0103308/1000000))* (y2 + y3 + y5 + y6)
     +((1057518/1000000))> 0).

Lemma l_181212899_0 : forall  y1  y2  y3  y4  y5  y6 , (20/10) <=  y1 ->  y1 <=  (252/100) -> (20/10) <=  y2 ->  y2 <=  (252/100) -> (20/10) <=  y3 ->  y3 <=  (252/100) -> (252/100) <=  y4 ->  y4 <=  sqrt8 -> (20/10) <=  y5 ->  y5 <=  (252/100) -> (252/100) <=  y6 ->  y6 <=  sqrt8 ->  (dih_y y1 y2 y3 y4 y5 y6 - (1448/1000) - 
((0266/1000) * (y1 - (20/10))) + 
((0295/1000) * (y2 - (20/10))) + 
((057/100) * (y3 - (20/10))) - 
((0745/1000) * (y4 - (252/100))) + 
((0268/1000) * (y5 - (20/10))) + 
((0385/1000) * (y6 - (252/100))) > (00/10)).

Lemma l_181212899_1 : forall  y1  y2  y3  y4  y5  y6 , (20/10) <=  y1 ->  y1 <=  (252/100) -> (20/10) <=  y2 ->  y2 <=  (252/100) -> (20/10) <=  y3 ->  y3 <=  (252/100) -> (252/100) <=  y4 ->  y4 <=  sqrt8 -> (252/100) <=  y5 ->  y5 <=  sqrt8 -> (20/10) <=  y6 ->  y6 <=  (252/100) ->  (dih_y y1 y2 y3 y4 y5 y6 - (1448/1000) - 
((0266/1000) * (y1 - (20/10))) + 
((0295/1000) * (y3 - (20/10))) + 
((057/100) * (y2 - (20/10))) - 
((0745/1000) * (y4 - (252/100))) + 
((0268/1000) * (y6 - (20/10))) + 
((0385/1000) * (y5 - (252/100))) > (00/10)).

Lemma l_181212899_2 : forall  y1  y2  y3  y4  y5  y6 , (20/10) <=  y1 ->  y1 <=  (252/100) -> (20/10) <=  y2 ->  y2 <=  (252/100) -> (20/10) <=  y3 ->  y3 <=  (252/100) -> sqrt8 <=  y4 ->  y4 <=  sqrt8 -> (20/10) <=  y5 ->  y5 <=  (252/100) -> (252/100) <=  y6 ->  y6 <=  sqrt8 ->  (dih_y y1 y2 y3 y4 y5 y6 - (1448/1000) - 
((0266/1000) * (y1 - (20/10))) + 
((0295/1000) * (y2 - (20/10))) + 
((057/100) * (y3 - (20/10))) - 
((0745/1000) * (sqrt8 - (252/100))) + 
((0268/1000) * (y5 - (20/10))) + 
((0385/1000) * (y6 - (252/100))) > (00/10)).

Lemma l_181212899_3 : forall  y1  y2  y3  y4  y5  y6 , (20/10) <=  y1 ->  y1 <=  (252/100) -> (20/10) <=  y2 ->  y2 <=  (252/100) -> (20/10) <=  y3 ->  y3 <=  (252/100) -> sqrt8 <=  y4 ->  y4 <=  sqrt8 -> (252/100) <=  y5 ->  y5 <=  sqrt8 -> (20/10) <=  y6 ->  y6 <=  (252/100) ->  (dih_y y1 y2 y3 y4 y5 y6 - (1448/1000) - 
((0266/1000) * (y1 - (20/10))) + 
((0295/1000) * (y3 - (20/10))) + 
((057/100) * (y2 - (20/10))) - 
((0745/1000) * (sqrt8 - (252/100))) + 
((0268/1000) * (y6 - (20/10))) + 
((0385/1000) * (y5 - (252/100))) > (00/10)).

Lemma l_181212899_4 : forall  y1  y2  y3  y4  y5  y6 , (20/10) <=  y1 ->  y1 <=  (252/100) -> (20/10) <=  y2 ->  y2 <=  (252/100) -> (20/10) <=  y3 ->  y3 <=  (252/100) -> (252/100) <=  y4 ->  y4 <=  (252/100) -> (20/10) <=  y5 ->  y5 <=  (252/100) -> (252/100) <=  y6 ->  y6 <=  sqrt8 ->  (dih_y y1 y2 y3 y4 y5 y6 - (1448/1000) - 
((0266/1000) * (y1 - (20/10))) + 
((0295/1000) * (y2 - (20/10))) + 
((057/100) * (y3 - (20/10))) - 
((0745/1000) * ((252/100) - (252/100))) + 
((0268/1000) * (y5 - (20/10))) + 
((0385/1000) * (y6 - (252/100))) > (00/10)).

Lemma l_181212899_5 : forall  y1  y2  y3  y4  y5  y6 , (20/10) <=  y1 ->  y1 <=  (252/100) -> (20/10) <=  y2 ->  y2 <=  (252/100) -> (20/10) <=  y3 ->  y3 <=  (252/100) -> (252/100) <=  y4 ->  y4 <=  (252/100) -> (252/100) <=  y5 ->  y5 <=  sqrt8 -> (20/10) <=  y6 ->  y6 <=  (252/100) ->  (dih_y y1 y2 y3 y4 y5 y6 - (1448/1000) - 
((0266/1000) * (y1 - (20/10))) + 
((0295/1000) * (y3 - (20/10))) + 
((057/100) * (y2 - (20/10))) - 
((0745/1000) * ((252/100) - (252/100))) + 
((0268/1000) * (y6 - (20/10))) + 
((0385/1000) * (y5 - (252/100))) > (00/10)).

Lemma l_2151506422 : forall y1 y2 y3 y4 y5 y6  , apex_std3_hll y1 y2 y3 y4 y5 y6  ->    ( 1 * dih_y y1 y2 y3 y4 y5 y6 > (12777/10000)
      + (0281/1000) * (y1 - (218/100)) + - (0278364/1000000) *(y2- 2) + - (0278364/1000000) * (y3 - 2) +
          (07117/10000) * (y4 - 2) + - (034336/100000) *(y5- 2) + - (034336/100000) * (y6 - 2)).

Lemma l_6836427086 : forall y1 y2 y3 y4 y5 y6  , apex_std3_hll y1 y2 y3 y4 y5 y6  ->    ( - 1 * dih_y y1 y2 y3 y4 y5 y6 > - (127799/100000)
      + - (0356217/1000000) * (y1 - (218/100)) + (0229466/1000000) *(y2- 2) + (0229466/1000000) * (y3 - 2) +
          - (0949067/1000000) * (y4 - 2) + (0172726/1000000) *(y5- 2) + (0172726/1000000) * (y6 - 2)).

Lemma l_3636849632 : forall y1 y2 y3 y4 y5 y6  , apex_std3_hll y1 y2 y3 y4 y5 y6  ->    ( 1 * taum y1 y2 y3 y4 y5 y6 > (00345/10000)
      + (0185545/1000000) * (y1 - (218/100)) + (0193139/1000000) *(y2- 2) + (0193139/1000000) * (y3 - 2) +
          (0170148/1000000) * (y4 - 2) + (013195/100000) *(y5- 2) + (013195/100000) * (y6 - 2)).

Lemma l_5298513205 : forall y1 y2 y3 y4 y5 y6  , apex_std3_hll y1 y2 y3 y4 y5 y6  ->    ( 1 * dih2_y y1 y2 y3 y4 y5 y6 > (1185/1000)
      + - (0302913/1000000) * (y1 - (218/100)) + (0214849/1000000) *(y2- 2) + - (0163775/1000000) * (y3 - 2) +
          - (0443449/1000000) * (y4 - 2) + (067364/100000) *(y5- 2) + - (0314532/1000000) * (y6 - 2)).

Lemma l_7743522046 : forall y1 y2 y3 y4 y5 y6  , apex_std3_hll y1 y2 y3 y4 y5 y6  ->    ( - 1 * dih2_y y1 y2 y3 y4 y5 y6 > - (11865/10000)
      + (020758/100000) * (y1 - (218/100)) + - (0236153/1000000) *(y2- 2) + (014172/100000) * (y3 - 2) +
          (0263834/1000000) * (y4 - 2) + - (0771203/1000000) *(y5- 2) + (00457292/10000000) * (y6 - 2)).

Lemma l_8657368829 : forall y1 y2 y3 y4 y5 y6  , apex_std3_small_hll y1 y2 y3 y4 y5 y6  ->    ( 1 * dih_y y1 y2 y3 y4 y5 y6 > (1277/1000)
      + (0273298/1000000) * (y1 - (218/100)) + - (0273853/1000000) *(y2- 2) + - (0273853/1000000) * (y3 - 2) +
          (0708818/1000000) * (y4 - 2) + - (0313988/1000000) *(y5- 2) + - (0313988/1000000) * (y6 - 2)).

Lemma l_6619134733 : forall y1 y2 y3 y4 y5 y6  , apex_std3_small_hll y1 y2 y3 y4 y5 y6  ->    ( - 1 * dih_y y1 y2 y3 y4 y5 y6 > - (127799/100000)
      + - (0439002/1000000) * (y1 - (218/100)) + (0229466/1000000) *(y2- 2) + (0229466/1000000) * (y3 - 2) +
          - (0771733/1000000) * (y4 - 2) + (0208429/1000000) *(y5- 2) + (0208429/1000000) * (y6 - 2)).

Lemma l_1284543870 : forall y1 y2 y3 y4 y5 y6  , apex_std3_small_hll y1 y2 y3 y4 y5 y6  ->    ( 1 * dih2_y y1 y2 y3 y4 y5 y6 > (1185/1000)
      + - (0372262/1000000) * (y1 - (218/100)) + (0214849/1000000) *(y2- 2) + - (0163775/1000000) * (y3 - 2) +
          - (0293508/1000000) * (y4 - 2) + (0656172/1000000) *(y5- 2) + - (0267157/1000000) * (y6 - 2)).

Lemma l_4041673283 : forall y1 y2 y3 y4 y5 y6  , apex_std3_small_hll y1 y2 y3 y4 y5 y6  ->    ( - 1 * dih2_y y1 y2 y3 y4 y5 y6 > - (11864/10000)
      + (020758/100000) * (y1 - (218/100)) + - (0236153/1000000) *(y2- 2) + (014172/100000) * (y3 - 2) +
          (0263109/1000000) * (y4 - 2) + - (0737003/1000000) *(y5- 2) + (012047/100000) * (y6 - 2)).

Lemma l_3872614111 : forall y1 y2 y3 y4 y5 y6  , dart_mll_w y1 y2 y3 y4 y5 y6  ->    ( - 1 * dih_y y1 y2 y3 y4 y5 y6 > - (1542/1000)
      + - (0362519/1000000) * (y1 - (236/100)) + (0298691/1000000) *(y2- 2) + (0287065/1000000) * (y3 - 2) +
          - (0920785/1000000) * (y4 - (225/100)) + (0190917/1000000) *(y5- 2) + (0219132/1000000) * (y6 - 2)).

Lemma l_3139693500 : forall y1 y2 y3 y4 y5 y6  , dart_mll_n y1 y2 y3 y4 y5 y6  ->    ( - 1 * dih_y y1 y2 y3 y4 y5 y6 > - (1542/1000)
      + - (0346773/1000000) * (y1 - (236/100)) + (0300751/1000000) *(y2- 2) + (0300751/1000000) * (y3 - 2) +
          - (0702567/1000000) * (y4 - (225/100)) + (0172726/1000000) *(y5- 2) + (0172727/1000000) * (y6 - 2)).

Lemma l_4841020453 : forall y1 y2 y3 y4 y5 y6  , dart_Hll_n y1 y2 y3 y4 y5 y6  ->    ( - 1 * dih_y y1 y2 y3 y4 y5 y6 > - (1542/1000)
      + - (0490439/1000000) * (y1 - (236/100)) + (0318125/1000000) *(y2- 2) + (032468/100000) * (y3 - 2) +
          - (0740079/1000000) * (y4 - (225/100)) + (0178868/1000000) *(y5- 2) + (0205819/1000000) * (y6 - 2)).

Lemma l_9925287433 : forall y1 y2 y3 y4 y5 y6  , dart_Hll_w y1 y2 y3 y4 y5 y6  ->    ( - 1 * dih_y y1 y2 y3 y4 y5 y6 > - (1542/1000)
      + - (0490439/1000000) * (y1 - (236/100)) + (0321849/1000000) *(y2- 2) + (0320956/1000000) * (y3 - 2) +
          - (100902/100000) * (y4 - (225/100)) + (0240709/1000000) *(y5- 2) + (0218081/1000000) * (y6 - 2)).

Lemma l_7409690040 : forall y1 y2 y3 y4 y5 y6  , dart_mll_w y1 y2 y3 y4 y5 y6  ->    ( 1 * dih2_y y1 y2 y3 y4 y5 y6 > (10494/10000)
      + - (0297823/1000000) * (y1 - (236/100)) + (0215328/1000000) *(y2- 2) + - (00792439/10000000) * (y3 - 2) +
          - (0422674/1000000) * (y4 - (225/100)) + (0647416/1000000) *(y5- 2) + - (0207561/1000000) * (y6 - 2)).

Lemma l_4002562507 : forall y1 y2 y3 y4 y5 y6  , dart_mll_n y1 y2 y3 y4 y5 y6  ->    ( 1 * dih2_y y1 y2 y3 y4 y5 y6 > (10494/10000)
      + - (029013/100000) * (y1 - (236/100)) + (0215328/1000000) *(y2- 2) + - (00715511/10000000) * (y3 - 2) +
          - (0267157/1000000) * (y4 - (225/100)) + (0650269/1000000) *(y5- 2) + - (0295198/1000000) * (y6 - 2)).

Lemma l_5835568093 : forall y1 y2 y3 y4 y5 y6  , dart_Hll_n y1 y2 y3 y4 y5 y6  ->    ( 1 * dih2_y y1 y2 y3 y4 y5 y6 > (10494/10000)
      + - (0404131/1000000) * (y1 - (236/100)) + (0212119/1000000) *(y2- 2) + - (00402827/10000000) * (y3 - 2) +
          - (0299046/1000000) * (y4 - (225/100)) + (0643273/1000000) *(y5- 2) + - (0266118/1000000) * (y6 - 2)).

Lemma l_1894886027 : forall y1 y2 y3 y4 y5 y6  , dart_Hll_w y1 y2 y3 y4 y5 y6  ->    ( 1 * dih2_y y1 y2 y3 y4 y5 y6 > (10494/10000)
      + - (0401543/1000000) * (y1 - (236/100)) + (0207551/1000000) *(y2- 2) + - (00294227/10000000) * (y3 - 2) +
          - (0494954/1000000) * (y4 - (225/100)) + (0605453/1000000) *(y5- 2) + - (0156385/1000000) * (y6 - 2)).

