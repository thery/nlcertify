open Sphere_final ;;




















let box_TSKAJXY_TADIAMB y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hplus , sqrt8 ) ; ( 2. *.  hplus , sqrt8 ) ; ( 2.0 , sqrt8 ) ; ( 2.0 , sqrt8 ) ; ( 2.0 , sqrt8 ) ; ( 2.0 , sqrt8 ) ]
 ;;
let obj_TSKAJXY_TADIAMB y1 y2 y3 y4 y5 y6  = [ ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;



let box_TSKAJXY_RIBCYXU_sharp y1 y2 y3 y4 y5 y6  = [ ( 2.0 , 2.001 ) ; ( 2.0 , 2.001 ) ; ( 2.0 , 2.001 ) ; ( 2.0 , 2.001 ) ; ( 2.0 , 2.001 ) ; ( 2.0 , 2.001 ) ]
 ;;
let obj_TSKAJXY_RIBCYXU_sharp y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  ,  0. ) ]
 ;;

let box_TSKAJXY_RIBCYXU_sym y1 y2 y3 y4 y5 y6  = [ ( 2.001 , 2. *.  hminus ) ; ( 2.0 , 2. *.  hminus ) ; ( 2.0 , 2. *.  hminus ) ; ( 2.0 , 2. *.  hminus ) ; ( 2.0 , 2. *.  hminus ) ; ( 2.0 , 2. *.  hminus ) ]
 ;;
let obj_TSKAJXY_RIBCYXU_sym y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  ,  0. ) ; (  y2 , y1  ) ; (  y3 , y1  ) ; (  y4 , y1  ) ; (  y5 , y1  ) ; (  y6 , y1  ) ; (  y3 , y2  ) ; (  y5 , y2  ) ; (  y6 , y2  ) ]
 ;;


let box_TSKAJXY_IYOUOBF_sym y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hplus , sqrt8 ) ; ( 2.001 , 2. *.  hminus ) ; ( 2.0 , 2. *.  hminus ) ; ( 2.0 , 2. *.  hminus ) ; ( 2.0 , 2. *.  hminus ) ; ( 2.0 , 2. *.  hminus ) ]
 ;;
let obj_TSKAJXY_IYOUOBF_sym y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  ,  0. ) ; (  y3  , y2  ) ; (  y5 , y2  ) ; (  y6 , y2  ) ]
 ;;

let box_TSKAJXY_IYOUOBF_sharp y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hplus , sqrt8 ) ; ( 2.0 , 2.001 ) ; ( 2.0 , 2.001 ) ; ( 2.0 , 2.001 ) ; ( 2.0 , 2.001 ) ; ( 2.0 , 2.001 ) ]
 ;;
let obj_TSKAJXY_IYOUOBF_sharp y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  ,  0. ) ]
 ;;


let box_TSKAJXY_WKGUESB_sym y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hplus , sqrt8 ) ; ( 2.01 , 2. *.  hminus ) ; ( 2.0 , 2. *.  hminus ) ; ( 2. *.  hplus , sqrt8 ) ; ( 2.0 , 2. *.  hminus ) ; ( 2.0 , 2. *.  hminus ) ]
 ;;
let obj_TSKAJXY_WKGUESB_sym y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  ,  0. ) ; (  y3 , y2  ) ; (  y5 , y2  ) ; (  y6 , y2  ) ; (  y4 , y1  ) ]
 ;;

let box_TSKAJXY_XLLIPLS y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hplus , 2.8 ) ; ( 2.0 , 2.01 ) ; ( 2.0 , 2.01 ) ; ( 2. *.  hplus , sqrt8 ) ; ( 2.0 , 2.01 ) ; ( 2.0 , 2.01 ) ]
 ;;
let obj_TSKAJXY_XLLIPLS y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  ,  0. ) ]
 ;;

let box_TSKAJXY_GXSABWC_DIV x1 x2 x3 x4 x5 x6  = [ ( 2.8 ** 2. , 8. ) ; ( 4. , 2.01 ** 2. ) ; ( 4. , 2.01 ** 2. ) ; ( 2.8 ** 2. , 8. ) ; ( 4. , 2.01 ** 2. ) ; ( 4. , 2.01 ** 2. ) ]
 ;;
let obj_TSKAJXY_GXSABWC_DIV x1 x2 x3 x4 x5 x6  = [ ( 1.  /.  12.  -.  
		( 
		  (2. *.  mm1  /.  pi) *. 
		    (sol_euler_x_div_sqrtdelta x1 x2 x3 x4 x5 x6 +. 
		       sol_euler345_x_div_sqrtdelta x1 x2 x3 x4 x5 x6 +. 
		       sol_euler156_x_div_sqrtdelta x1 x2 x3 x4 x5 x6 +. 
		       sol_euler246_x_div_sqrtdelta x1 x2 x3 x4 x5 x6)  -. 
		    (8. *.  mm2  /.  pi) *.  (
		      ldih2_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 +. 
		      ldih3_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 +. 
		      ldih5_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6 +. 
		      ldih6_x_div_sqrtdelta_posbranch x1 x2 x3 x4 x5 x6
		    )
		)  ,  0. ) ; (  0. , delta_x x1 x2 x3 x4 x5 x6  ) ]
 ;;


let box_GLFVCVK4_2477216213  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. , sqrt8 ) ; ( 2. , sqrt8 ) ; ( 2. , sqrt8 ) ; ( 2. , sqrt8 ) ; ( 2. , sqrt8 ) ]
 ;;
let obj_GLFVCVK4_2477216213  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  ,  0. ) ; (   (hplus -.  hminus) ** 2. , norm2hh y1 y2 y3 y4 y5 y6  ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_GLFVCVK4a_8328676778  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus  ) ; ( 2.  , 2. *.  hminus  ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus   , 2. *.  hplus  ) ; ( 2. , 2. *.  hminus  ) ; ( 2. , 2. *.  hminus  ) ]
 ;;
let obj_GLFVCVK4a_8328676778  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +. 
    beta_bump_force_y y1 y2 y3 y4 y5 y6  ,  0. ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;



let box_GLFVCVK3_a_sharp  y1 y2 y3 y4 y5 y6  = [ ( 2.  ,  2.001 ) ; ( 2. , 2.001 ) ; ( sqrt2 , sqrt2 ) ; ( sqrt2 , sqrt2 ) ; ( sqrt2 , sqrt2 ) ; ( 2. , 2.001 ) ]
 ;;
let obj_GLFVCVK3_a_sharp  y1 y2 y3 y4 y5 y6  = [ ( vol_y y1 y2 y3 y4 y5 y6  -.  ( (2. *.  mm1  /.  pi) *. 
         (2. *.  dih_y y1 y2 y3 y4 y5 y6 +.  2. *.  dih2_y y1 y2 y3 y4 y5 y6 +. 
          2. *.  dih6_y y1 y2 y3 y4 y5 y6 +.  dih3_y y1 y2 y3 y4 y5 y6 +. 
	  dih4_y y1 y2 y3 y4 y5 y6 +.  dih5_y y1 y2 y3 y4 y5 y6  -.  3. *.  pi)  -. 
         (8. *.  mm2  /.  pi) *. 
         (lmfun (y1  /.  2.) *.  dih_y y1 y2 y3 y4 y5 y6 +. 
          lmfun (y2  /.  2.) *.  dih2_y y1 y2 y3 y4 y5 y6 +. 
          lmfun (y6  /.  2.) *.  dih6_y y1 y2 y3 y4 y5 y6))  ,  0. ) ; (  0.99 , delta_y y1 y2 y3 y4 y5 y6  ) ]
 ;;

let box_GLFVCVK3_a_nonsharp  y1 y2 y3 y4 y5 y6  = [ ( 2.001  ,  sqrt8 ) ; ( 2. , sqrt8 ) ; ( sqrt2 , sqrt2 ) ; ( sqrt2 , sqrt2 ) ; ( sqrt2 , sqrt2 ) ; ( 2. , sqrt8 ) ]
 ;;
let obj_GLFVCVK3_a_nonsharp  y1 y2 y3 y4 y5 y6  = [ ( vol_y y1 y2 y3 y4 y5 y6  -.  ( (2. *.  mm1  /.  pi) *. 
         (2. *.  dih_y y1 y2 y3 y4 y5 y6 +.  2. *.  dih2_y y1 y2 y3 y4 y5 y6 +. 
          2. *.  dih6_y y1 y2 y3 y4 y5 y6 +.  dih3_y y1 y2 y3 y4 y5 y6 +. 
	  dih4_y y1 y2 y3 y4 y5 y6 +.  dih5_y y1 y2 y3 y4 y5 y6  -.  3. *.  pi)  -. 
         (8. *.  mm2  /.  pi) *. 
         (lmfun (y1  /.  2.) *.  dih_y y1 y2 y3 y4 y5 y6 +. 
          lmfun (y2  /.  2.) *.  dih2_y y1 y2 y3 y4 y5 y6 +. 
          lmfun (y6  /.  2.) *.  dih6_y y1 y2 y3 y4 y5 y6))   ,  0. ) ; (  y2 , y1  ) ; (  y6 , y2  ) ; (  0.99 , delta_y y1 y2 y3 y4 y5 y6  ) ]
 ;;

let box_GLFVCVK3_b y1 y2 y3 y4 y5 y6  = [ ( 2. , sqrt8 ) ; ( sqrt2 , sqrt2 ) ; ( 2. , sqrt8 ) ; ( sqrt2 , sqrt2 ) ; ( 2. , sqrt8 ) ; ( sqrt2 , sqrt2 ) ]
 ;;
let obj_GLFVCVK3_b y1 y2 y3 y4 y5 y6  = [ (  1.  /.  12.  -.  
   ( (2. *.  mm1  /.  pi) *. 
         (y_of_x sol_euler_x_div_sqrtdelta y1 y2 y3 y4 y5 y6 
	  +.  y_of_x sol_euler156_x_div_sqrtdelta y1 y2 y3 y4 y5 y6 +.  
	  y_of_x sol_euler345_x_div_sqrtdelta y1 y2 y3 y4 y5 y6)  -. 
         (8. *.  mm2  /.  pi) *. 
         (y_of_x lmdih_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6 +. 
          y_of_x lmdih3_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6 +. 
          y_of_x lmdih5_x_div_sqrtdelta_posbranch y1 y2 y3 y4 y5 y6)

   )   ,  0. ) ; (  0. , delta_y y1 y2 y3 y4 y5 y6  ) ; ( delta_y y1 y2 y3 y4 y5 y6  ,  1.0  ) ]
 ;;


let box_GLFVCVK2_a y  = [ ( 2.0 , 2. *.  h0  ) ]
 ;;
let obj_GLFVCVK2_a y  = [ ( vol2r y sqrt2  -.  vol2f y sqrt2 lfun  ,  0. ) ]
 ;;

let box_GLFVCVK2_b y  = [ ( 2. *.  h0 , sqrt8  ) ]
 ;;
let obj_GLFVCVK2_b y  = [ ( vol2r y sqrt2  -.   (2. *.  mm1  /.  pi) *.  2. *.  pi *.  (1.  -.  y  /.  (sqrt2 *.  2.))  ,  0. ) ]
 ;;


let box_HJKDESR1a  r  = [ ( sqrt2 ,  sqrt2 ) ]
 ;;
let obj_HJKDESR1a  r  = [ (  4. *.  pi *.  (r ** 3.)  /.  (3.)   -.   (2. *.  mm1  /.  pi) *.  4. *.  pi  ,  0. ) ]
 ;;



let box_FHBVYXZ_a  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus  ) ; ( 2.  , 2. *.  hminus  ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus  ) ; ( 2. , 2. *.  hminus  ) ]
 ;;
let obj_FHBVYXZ_a  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  
	 ,  0. ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ; (  1.34 ** 2. , eta_y y1 y3 y5 ** 2.  ) ]
 ;;

let box_FHBVYXZ_b  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus  ) ; ( 2. , 2. *.  hminus  ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus  ) ; ( 2. , 2. *.  hminus  ) ]
 ;;
let obj_FHBVYXZ_b  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  +.  gamma3f y1 y2 y6 sqrt2 lmfun
	 ,  0. ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ; ( eta_y y1 y2 y6 ** 2.  ,  1.34 ** 2. ) ]
 ;;




let box_ZTGIJCF0 dummy  = [ ( 1. , 1. ) ]
 ;;
let obj_ZTGIJCF0 dummy  = [ (  5. *.  a_spine5 +.  b_spine5 *.  2. *.  pi   ,  0. ) ]
 ;;


















let box_BIXPCGW_9455898160  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_BIXPCGW_9455898160  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  ,   -.  0.00569 ) ]
 ;;

let box_BIXPCGW_2300537674  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_BIXPCGW_2300537674  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  ,  0. ) ; (  1.65 , dih_y y1 y2 y3 y4 y5 y6  ) ]
 ;;

let box_BIXPCGW_6652007036_a  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ]
 ;;
let obj_BIXPCGW_6652007036_a  y1 y2 y3 y4 y5 y6  = [ (  2.8 , dih_y y1 y2 y3 y4 y5 y6  ) ; (  60. , delta_y y1 y2 y3 y4 y5 y6  ) ]
 ;;

let box_BIXPCGW_7080972881_a y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. *.  hminus ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ]
 ;;
let obj_BIXPCGW_7080972881_a y1 y2 y3 y4 y5 y6  = [ (  2.3 , dih_y y1 y2 y3 y4 y5 y6  ) ; (  60. , delta_y y1 y2 y3 y4 y5 y6  ) ]
 ;;

let box_BIXPCGW_1738910218_a y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  2. *.  hplus ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ]
 ;;
let obj_BIXPCGW_1738910218_a y1 y2 y3 y4 y5 y6  = [ (  2.3 , dih_y y1 y2 y3 y4 y5 y6  ) ; (  60. , delta_y y1 y2 y3 y4 y5 y6  ) ]
 ;;

let box_BIXPCGW_b y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  2. *.  hplus ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ]
 ;;
let obj_BIXPCGW_b y1 y2 y3 y4 y5 y6  = [ ( delta4_y y1 y2 y3 y4 y5 y6  ,  0. ) ; ( delta_y y1 y2 y3 y4 y5 y6  ,  60. ) ; (  0. , delta_y y1 y2 y3 y4 y5 y6  ) ]
 ;;

let box_BIXPCGW_7274157868 y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ; ( 2. ,  sqrt8 ) ]
 ;;
let obj_BIXPCGW_7274157868 y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  ,  0.0057 ) ; (  2.3 , dih_y y1 y2 y3 y4 y5 y6  ) ]
 ;;

let box_QITNPEA_5653753305 y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_QITNPEA_5653753305 y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun +.  0.0659 
       -.  0.042*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ]
 ;;

let box_QITNPEA_9939613598 y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. *.  hplus ,  sqrt8 ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_QITNPEA_9939613598 y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  -.  0.00457511 
     -.  0.00609451*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA_4003532128_a y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  sqrt8 ) ; ( sqrt2 , sqrt2 ) ; ( sqrt2 , sqrt2 ) ; ( sqrt2 , sqrt2 ) ; ( 2. ,  sqrt8 ) ]
 ;;
let obj_QITNPEA_4003532128_a y1 y2 y3 y4 y5 y6  = [ ( delta4_y y1 y2 y3 y4 y5 y6  ,  25. ) ; ( delta_y y1 y2 y3 y4 y5 y6  ,  0.14 ) ; (  0. , delta_y y1 y2 y3 y4 y5 y6  ) ]
 ;;


let box_QITNPEA_4003532128_b_sym y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2.1  ,  sqrt8 ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_QITNPEA_4003532128_b_sym y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; (  0.14 , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; (  y3 , y2  ) ; (  y5 , y2  ) ; (  y6 , y2  ) ; ( gamma23f_n y1 y2 y3 y4 y5 y6  1.  1. sqrt2 lmfun  -.  0.00457511 
     -.  0.00609451*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ]
 ;;

let box_QITNPEA_4003532128_b2 y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2.1  ,  2.1 ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_QITNPEA_4003532128_b2 y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; (  0.14 , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; ( gamma23f_n y1 y2 y3 y4 y5 y6  1.  1. sqrt2 lmfun  -.  0.00457511 
     -.  0.00609451*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ]
 ;;

let box_QITNPEA_4003532128_c y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2.1  ,  2.1 ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_QITNPEA_4003532128_c y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; (  0. , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; ( delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ,  0.14 ) ; (  gamma23f_126_03_n y1 y2 y3 y4 y5 y6  1.  sqrt2 lmfun  
        -.  0.00457511 
     -.  0.00609451*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ]
 ;;

let box_QITNPEA_4003532128_d y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2.1  ,  sqrt8 ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_QITNPEA_4003532128_d y1 y2 y3 y4 y5 y6  = [ (    
      gamma23f_red_03 y1 y2 y3 y4 y5 y6 sqrt2 lmfun   
	  -.  0.00457511 
     -.  0.00609451*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ,  0.14  ) ; (  0.  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; ( delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ,  0.14 ) ; (  0. , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ]
 ;;

let box_QITNPEA_3725403817 y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; (  2.   ,  2.1 ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_QITNPEA_3725403817 y1 y2 y3 y4 y5 y6  = [ (  1.56 , dih_y y1 y2 y3 y4 y5 y6  ) ]
 ;;

let box_QITNPEA_6206775865 y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; (  2.   ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_QITNPEA_6206775865 y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun +.  0.0142852  -.  0.00609451 *. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ]
 ;;

let box_QITNPEA_5814748276 y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; (  2.   ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_QITNPEA_5814748276 y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  -.  0.00127562 +.  0.00522841 *.  dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ]
 ;;

let box_QITNPEA_3848804089 y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; (  2.   ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_QITNPEA_3848804089 y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  -.  0.161517 +.  0.119482*.  dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ]
 ;;







let box_QITNPEA_2134082733  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2.  , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2.  , 2. *.  hminus ) ; ( 2.  , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA_2134082733  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  beta_bump_lb 
          -.  0.213849 +.  0.119482*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0  ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA__5400790175_a  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2.  , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2.  , 2. *.  hminus ) ; ( 2.  , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA__5400790175_a  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  beta_bump_lb   ,  0.0057 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ; (  1.34 ** 2. , eta_y y1 y2 y6 ** 2.  ) ]
 ;;

let box_QITNPEA__5400790175_b  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2.  , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2.  , 2. *.  hminus ) ; ( 2.  , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA__5400790175_b  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  beta_bump_lb 
       +.  gamma3f y1 y2 y6 sqrt2 lmfun  ,  0.0057 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ; ( eta_y y1 y2 y6 ** 2.  ,  1.34 ** 2. ) ]
 ;;



let box_1965189142_34 x1 x2 x3 x4 x5 x6  = [ ( 1.0 , 1.26 ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ]
 ;;
let obj_1965189142_34 x1 x2 x3 x4 x5 x6  = [ (  0. , 0.591  -.  0.0331 *.  34. +.  0.506 *.  lfun_y1 x1 x2 x3 x4 x5 x6  ) ]
 ;;

let box_1965189142_a x1 x2 x3 x4 x5 x6  = [ ( 1.0 , 1.26 ) ; ( 3.0 , 34.0 ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ]
 ;;
let obj_1965189142_a x1 x2 x3 x4 x5 x6  = [ ( 2. *.  pi  -.  2. *.  asnFnhk x1 x2 x3 x4 x5 x6  ,  0.591  -.  0.0331 *.  x2 +.  0.506 *.  lfun_y1 x1 x2 x3 x4 x5 x6 ) ]
 ;;

let box_8055810915  x1 x2 x3 x4 x5 x6  = [ ( 4. ,  2.52 ** 2. ) ; ( 4. , 4. ) ; ( (2. *.  h0) ** 2. , (2. *.  h0) ** 2. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ]
 ;;
let obj_8055810915  x1 x2 x3 x4 x5 x6  = [ (  arclength_x_123 x1 x2 x3 x4 x5 x6 , acs_sqrt_x1_d4 x1 x2 x3 x4 x5 x6  -.  pi /.  (6.) +.  0.797  ) ]
 ;;

let box_6096597438_a h  = [ ( 1.0 , 1.0 ) ]
 ;;
let obj_6096597438_a h  = [ (  0. , 0.591  -.  0.0331 *.  64. +.  0.506 *.  lfun (1.) +.  1.0  ) ]
 ;;

let box_6096597438_b x1 x2 x3 x4 x5 x6  = [ ( 3.0 , 64.0 ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ]
 ;;
let obj_6096597438_b x1 x2 x3 x4 x5 x6  = [ ( 2. *.  pi  -.  2. *.  asn797k x1 x2 x3 x4 x5 x6  ,  
          0.591  -.  0.0331 *.  x1 +.  0.506 *.  lfun (1.) +.  1.0 ) ]
 ;;


let box_4717061266  y1  y2  y3  y4  y5  y6  = [ ( 2. ,  2.*. h0 ) ; ( 2. ,  2.*. h0 ) ; ( 2. ,  2.*. h0 ) ; ( 2. ,  2.*. h0 ) ; ( 2. ,  2.*. h0 ) ; ( 2. ,  2.*. h0 ) ]
 ;;
let obj_4717061266  y1  y2  y3  y4  y5  y6  = [ ( delta_y y1 y2 y3 y4 y5 y6  ,  0. ) ]
 ;;


let box_OMKYNLT_3336871894 y1 y2 y3 y4 y5 y6  = [ ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2. , 2. ) ; ( 2. , 2. ) ; ( 2. , 2. ) ]
 ;;
let obj_OMKYNLT_3336871894 y1 y2 y3 y4 y5 y6  = [ (  taum y1 y2 y3 y4 y5 y6  ,  0.0 ) ]
 ;;

let box_OMKYNLT_2_1 y1 y2 y3 y4 y5  y6  = [ ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2. , 2. ) ; ( 2. , 2. ) ; ( 2. *.  h0 ,  2. *.  h0 ) ]
 ;;
let obj_OMKYNLT_2_1 y1 y2 y3 y4 y5  y6  = [ (  taum y1 y2 y3 y4 y5 y6   ,  tame_table_d  2.  1. ) ]
 ;;

let box_OMKYNLT_1_2 y1 y2 y3 y4 y5 y6  = [ ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2. , 2. ) ; ( 2. *.  h0 , 2. *.  h0 ) ; ( 2. *.  h0 , 2. *.  h0 ) ]
 ;;
let obj_OMKYNLT_1_2 y1 y2 y3 y4 y5 y6  = [ (  taum y1 y2 y3 y4 y5 y6  ,  tame_table_d  1.  2. ) ]
 ;;

let box_OMKYNLT_0_3 y1 y2 y3 y4 y5 y6  = [ ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.52 , 2.52 ) ; ( 2.52 , 2.52 ) ; ( 2.52 , 2.52 ) ]
 ;;
let obj_OMKYNLT_0_3 y1 y2 y3 y4 y5 y6  = [ (  taum y1 y2 y3 y4 y5 y6  ,  tame_table_d  0.  3. ) ]
 ;;

let box_SDCCMGA_a y1 y2 y3 y4 y5 y6  = [ ( 2. , 2.52 ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ]
 ;;
let obj_SDCCMGA_a y1 y2 y3 y4 y5 y6  = [ ( 
   arclength_y1 (2.*. h0) (2. *.  h0) y1 y2 y3 y4 y5 y6 +.  
    2. *.  arc_hhn , arclength_y1 (2.) (2. *.  h0) y1 y2 y3 y4 y5 y6 +.  
  arclength_y1  (2.) (2. *.  h0) y1 y2 y3 y4 y5 y6  ) ]
 ;;

let box_SDCCMGA_b y1 y2 y3 y4 y5 y6  = [ ( 2. , 2.52 ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ; ( 1. , 1. ) ]
 ;;
let obj_SDCCMGA_b y1 y2 y3 y4 y5 y6  = [ ( 
   arclength_y1 (2.*. h0) (2.) y1 y2 y3 y4 y5 y6 +.  
  pi  /.  3.   +.  arc_hhn , arclength_y1 (2.) (2. *.  h0) y1 y2 y3 y4 y5 y6 +.  
  arclength_y1 (2.) (2. *.  h0) y1 y2 y3 y4 y5 y6  ) ]
 ;;

let box_JNTEFVP_1 x1 x2 x3 x4 x5 x6  = [ ( 4. , (2. *.  h0) ** 2. ) ; ( 4. , (2. *.  h0) ** 2. ) ; ( 4. , (2. *.  h0) ** 2. ) ; ( 4. , (2. *.  h0) ** 2. ) ; ( 4. , (2. *.  h0) ** 2. ) ; ( 8.  ,  (4. *.  h0) ** 2. ) ]
 ;;
let obj_JNTEFVP_1 x1 x2 x3 x4 x5 x6  = [ ( delta_x4 x1 x2 x3 x4 x5 x6  ,  0. ) ]
 ;;


let box_4652969746_1 y1 y2 y3 y4 y5 y6  = [ ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 2.1771 , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;
let obj_4652969746_1 y1 y2 y3 y4 y5 y6  = [ ( taum y1 y2 y3 y4 y5 y6  ,  0.04 ) ]
 ;;

let box_4652969746_2 y1 y2 y3 y4 y5 y6  = [ ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.1771 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;
let obj_4652969746_2 y1 y2 y3 y4 y5 y6  = [ ( taum y1 y2 y3 y4 y5 y6  -.  0.312 *.  (dih_y y1 y2 y3 y4 y5 y6  -.  2. *.  pi /.  5.)   ,  0.04  /.  5. ) ]
 ;;

let box_2570626711 y1 y2 y3 y4 y5 y6  = [ ( 2.0 , 2. *.  h0 ) ; ( 2.0 , 2. *.  h0 ) ; ( 2.0 , 2. *.  h0 ) ; ( 2. *.  h0 , 2. *.  h0 ) ; ( 2.0 , 2. *.  h0 ) ; ( 2.0 , 2. *.  h0 ) ]
 ;;
let obj_2570626711 y1 y2 y3 y4 y5 y6  = [ ( dih_y y1 y2 y3 y4 y5 y6  ,  1.15 ) ]
 ;;




let dart_std4 y1 y2 y3 y4 y5 y6 y7 y8 y9  = [ ( 2.0 , 2. *.  h0 ) ; ( 2.0 , 2. *.  h0 ) ; ( 2.0 , 2. *.  h0 ) ; ( 2. *.  h0 , 4.37 ) ; ( 2.0 , 2. *.  h0 ) ; ( 2.0 , 2. *.  h0 ) ; ( 2.0 , 2. *.  h0 ) ; ( 2.0 , 2. *.  h0 ) ; ( 2.0 , 2. *.  h0 ) ]
 ;;


let box_8673686234_a y1 y2 y3 y4 y5 y6  = [ ( sqrt8 , 3.0 ) ; ( 2. , 2.07 ) ; ( 2. , 2.07 ) ; ( sqrt8 , 4. *.  h0 ) ; ( 2. , 2.07 ) ; ( 2. , 2.07 ) ]
 ;;
let obj_8673686234_a y1 y2 y3 y4 y5 y6  = [ ( y2 +.  y3 +.  y5 +.  y6  -.  7.99  -.  0.00385 *.  delta_y y1 y2 y3 y4 y5 y6  ,    2.75 *.  ((y1 +.  y4) /.  2.  -.  sqrt8) ) ]
 ;;

let box_8673686234_b y1 y2 y3 y4 y5 y6  = [ ( sqrt8 , 3.0 ) ; ( 2.07 , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 3.0 , 3.0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ]
 ;;
let obj_8673686234_b y1 y2 y3 y4 y5 y6  = [ ( y2 +.  y3 +.  y5 +.  y6  -.  7.99  ,  2.75 *.  (y1  -.  sqrt8) ) ; (  0. , delta_y y1 y2 y3 y4 y5 y6  ) ]
 ;;

let box_8673686234_c y1 y2 y3 y4 y5 y6  = [ ( sqrt8 , 3.0 ) ; ( 2.07 , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( sqrt8 , 3.0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ]
 ;;
let obj_8673686234_c y1 y2 y3 y4 y5 y6  = [ ( y2 +.  y3 +.  y5 +.  y6  -.  7.99  ,    2.75 *.  ((y1 +.  y4) /.  2.  -.  sqrt8) ) ; ( y2 +.  y3 +.  y5 +.  y6  -.  7.99  -.  0.00385 *.  delta_y y1 y2 y3 y4 y5 y6  ,    2.75 *.  ((y1 +.  y4) /.  2.  -.  sqrt8) ) ; (  0. , delta_y y1 y2 y3 y4 y5 y6  ) ]
 ;;


let box_7043724150_a y1 y2 y3 y4 y5 y6 y7 y8 y9   = dart_std4 y1 y2 y3 y4 y5 y6 y7 y8 y9 ;;
let obj_7043724150_a y1 y2 y3 y4 y5 y6 y7 y8 y9   = [ (  tauq y1 y2 y3 y4 y5 y6 y7 y8 y9 +.  4.72 *.  dih_y y1 y2 y3 y4 y5 y6  -.  6.248  ,  0.0 ) ; (  sqrt8  ,  enclosed y1 y5 y6 y4 y2 y3 y7 y8 y9  ) ]
 ;;

let box_7043724150_a_reduced y1 y2 y3 y4 y5 y6  = [ ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. *.  h0 , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ]
 ;;
let obj_7043724150_a_reduced y1 y2 y3 y4 y5 y6  = [ (  taum y1 y2 y3 y4 y5 y6 +.  4.72 *.  dih_y y1 y2 y3 y4 y5 y6  -.  6.248  /.  2.  ,  0.0 ) ]
 ;;

let box_6944699408_a y1 y2 y3 y4 y5 y6 y7 y8 y9   = dart_std4 y1 y2 y3 y4 y5 y6 y7 y8 y9 ;;
let obj_6944699408_a y1 y2 y3 y4 y5 y6 y7 y8 y9   = [ (  tauq y1 y2 y3 y4 y5 y6 y7 y8 y9 +.  0.972 *.  dih_y y1 y2 y3 y4 y5 y6  -.   1.707  ,  0.0 ) ; (  sqrt8  ,  enclosed y1 y5 y6 y4 y2 y3 y7 y8 y9  ) ]
 ;;

let box_6944699408_a_reduced y1 y2 y3 y4 y5 y6  = [ ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. *.  h0 , sqrt8 ) ; ( 2. , 2. *.  h0 ) ]
 ;;
let obj_6944699408_a_reduced y1 y2 y3 y4 y5 y6  = [ (  taum y1 y2 y3 y4 y5 y6 +.  0.972 *.  dih_y y1 y2 y3 y4 y5 y6  -.   1.707  /.  2.  ,  0.0 ) ]
 ;;

let box_4240815464_a y1 y2 y3 y4 y5 y6 y7 y8 y9   = dart_std4 y1 y2 y3 y4 y5 y6 y7 y8 y9 ;;
let obj_4240815464_a y1 y2 y3 y4 y5 y6 y7 y8 y9   = [ (  tauq y1 y2 y3 y4 y5 y6 y7 y8 y9 +.  
   0.7573 *. dih_y y1 y2 y3 y4 y5 y6  -.  1.433  ,  0.0 ) ; (  sqrt8  ,  enclosed y1 y5 y6 y4 y2 y3 y7 y8 y9  ) ; (  0. ,  delta_y y1 y2 y3 y4 y5 y6  ) ; (  0. ,  delta_y y7 y2 y3 y4 y8 y9  ) ]
 ;;

let box_4240815464_a_reduced y1 y2 y3 y4 y5 y6  = [ ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. *.  h0 , sqrt8 ) ; ( 2. , 2. *.  h0 ) ]
 ;;
let obj_4240815464_a_reduced y1 y2 y3 y4 y5 y6  = [ (  taum y1 y2 y3 y4 y5 y6 +.  
   0.7573 *. dih_y y1 y2 y3 y4 y5 y6  -.  1.433  /.  2.  ,  0.0 ) ]
 ;;

let box_3862621143_revised y1 y2 y3 y4 y5 y6 y7 y8 y9   = dart_std4 y1 y2 y3 y4 y5 y6 y7 y8 y9 ;;
let obj_3862621143_revised y1 y2 y3 y4 y5 y6 y7 y8 y9   = [ (  tauq y1 y2 y3 y4 y5 y6 y7 y8 y9  -.  0.453 *.  dih_y y1 y2 y3 y4 y5 y6 +.   0.777  ,  0.0 ) ; (  3.01  ,  enclosed y1 y5 y6 y4 y2 y3 y7 y8 y9  ) ; (  0. ,  delta_y y1 y2 y3 y4 y5 y6  ) ; (  2.9 , y4  ) ; (  0. ,  delta_y y7 y2 y3 y4 y8 y9  ) ]
 ;;

let box_3862621143_side y1 y2 y3 y4 y5 y6  = [ ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. *.  h0 , 3.01 ) ; ( 2. , 2. *.  h0 ) ]
 ;;
let obj_3862621143_side y1 y2 y3 y4 y5 y6  = [ (  taum y1 y2 y3 y4 y5 y6  -.  0.453 *.  dih_y y1 y2 y3 y4 y5 y6 +.   0.777  /.  2.   ,  0.0 ) ]
 ;;

let box_3862621143_front y1 y2 y3 y4 y5 y6  = [ ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. *.  h0 , 2.9 ) ; ( 2.  , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ]
 ;;
let obj_3862621143_front y1 y2 y3 y4 y5 y6  = [ (  taum y1 y2 y3 y4 y5 y6 +.  tame_table_d  2.  1.  -.  0.453 *.  dih_y y1 y2 y3 y4 y5 y6 +.   0.777    ,  0.0 ) ]
 ;;

let box_3862621143_back y1 y2 y3 y4 y5 y6  = [ ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( sqrt8 , 3.01 ) ; ( 2.  , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ]
 ;;
let obj_3862621143_back y1 y2 y3 y4 y5 y6  = [ (  taum y1 y2 y3 y4 y5 y6     ,  tame_table_d  2.  1. ) ]
 ;;



let box_5691615370 y1 y2 y3 y4 y5 y6  = [ ( 3.0 , 3.0 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 3.0 , 3.0 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;
let obj_5691615370 y1 y2 y3 y4 y5 y6  = [ (  0. , delta_y y1 y2 y3 y4 y5 y6  ) ; ( y2 +.  y3 +.  y5 +.  y6  ,  8.472 ) ; (  y3 , y2  ) ; (  y5 , y2  ) ; (  y6  , y2  ) ; (  y6 , y3  ) ]
 ;;

let dart4_diag3_b y1 y2 y3 y4 y5 y6 y7 y8 y9  = [ ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 3. , 3. ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let box_9563139965D y1 y2 y3 y4 y5 y6 y7 y8 y9   = dart4_diag3_b y1 y2 y3 y4 y5 y6 y7 y8 y9 ;;
let obj_9563139965D y1 y2 y3 y4 y5 y6 y7 y8 y9   = [ ( tauq y1 y2 y3 y4 y5 y6 y7 y8 y9   ,  0.467 ) ; (  3.  , enclosed  y1 y5 y6 y4 y2 y3 y7 y8 y9  ) ]
 ;;

let box_9563139965_d y1 y2 y3 y4 y5 y6  = [ ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 3. , 3. ) ; ( 2. , 2.472 ) ; ( 2. , 2.472 ) ]
 ;;
let obj_9563139965_d y1 y2 y3 y4 y5 y6  = [ ( taum y1 y2 y3 y4 y5 y6  +.  0.5 *.  ( 8.472  /.  2.  -.  y5  -.  y6)  ,  0.467  /.  2. ) ]
 ;;

let box_9563139965_e y1 y2 y3 y4 y5 y6  = [ ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 3. , 3. ) ; ( 2.467 , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ]
 ;;
let obj_9563139965_e y1 y2 y3 y4 y5 y6  = [ ( taum y1 y2 y3 y4 y5 y6    ,  0.467  -.  0.115 ) ]
 ;;

let box_9563139965_f y1 y2 y3 y4 y5 y6  = [ ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ; ( 3. , 3. ) ; ( 2. , 2. *.  h0 ) ; ( 2. , 2. *.  h0 ) ]
 ;;
let obj_9563139965_f y1 y2 y3 y4 y5 y6  = [ ( taum y1 y2 y3 y4 y5 y6    ,   0.115 ) ]
 ;;


let dart_std3 y1 y2 y3 y4 y5 y6  = [ ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ]
 ;;

let box_5735387903 y1 y2 y3 y4 y5 y6   = dart_std3 y1 y2 y3 y4 y5 y6 ;;
let obj_5735387903 y1 y2 y3 y4 y5 y6   = [ ( dih_y y1 y2 y3 y4 y5 y6  ,  0.852 ) ]
 ;;

let box_5490182221 y1 y2 y3 y4 y5 y6   = dart_std3 y1 y2 y3 y4 y5 y6 ;;
let obj_5490182221 y1 y2 y3 y4 y5 y6   = [ (  1.893 , dih_y y1 y2 y3 y4 y5 y6  ) ]
 ;;

let box_3296257235 y1 y2 y3 y4 y5 y6   = dart_std3 y1 y2 y3 y4 y5 y6 ;;
let obj_3296257235 y1 y2 y3 y4 y5 y6   = [ ( taum y1 y2 y3 y4 y5 y6 +.  0.626 *.  dih_y y1 y2 y3 y4 y5 y6  -.  0.77  ,  0.0 ) ]
 ;;

let box_8519146937 y1 y2 y3 y4 y5 y6   = dart_std3 y1 y2 y3 y4 y5 y6 ;;
let obj_8519146937 y1 y2 y3 y4 y5 y6   = [ (  taum y1 y2 y3 y4 y5 y6  -.   0.259 *.  dih_y y1 y2 y3 y4 y5 y6 +.  0.32  ,  0.0 ) ]
 ;;

let box_4667071578 y1 y2 y3 y4 y5 y6   = dart_std3 y1 y2 y3 y4 y5 y6 ;;
let obj_4667071578 y1 y2 y3 y4 y5 y6   = [ (  taum y1 y2 y3 y4 y5 y6  -.   0.507 *.  dih_y y1 y2 y3 y4 y5 y6 +.  0.724  ,  0.0 ) ]
 ;;

let box_1395142356 y1 y2 y3 y4 y5 y6   = dart_std3 y1 y2 y3 y4 y5 y6 ;;
let obj_1395142356 y1 y2 y3 y4 y5 y6   = [ (  taum y1 y2 y3 y4 y5 y6 +.  0.001  -.  0.18 *.  (y1 +.  y2 +.  y3  -.  6.0)  -. 
  0.125 *.  (y4 +.  y5 +.  y6  -.  6.0)  ,  0.0 ) ]
 ;;

let box_7394240696 y1 y2 y3 y4 y5 y6   = dart_std3 y1 y2 y3 y4 y5 y6 ;;
let obj_7394240696 y1 y2 y3 y4 y5 y6   = [ (  sol_y y1 y2 y3 y4 y5 y6  -.  0.55125  -.  0.196 *.  (y4 +.  y5 +.  y6  -.  6.0) +. 
  0.38 *.  (y1 +.  y2 +.  y3  -.  6.0)  ,  0.0 ) ]
 ;;

let box_7726998381 y1 y2 y3 y4 y5 y6   = dart_std3 y1 y2 y3 y4 y5 y6 ;;
let obj_7726998381 y1 y2 y3 y4 y5 y6   = [ (   -.  sol_y y1 y2 y3 y4 y5 y6 +.  0.5513 +.  
  0.3232 *.  (y4 +.  y5 +.  y6  -.  6.0)  -. 
  0.151 *.  (y1 +.  y2 +.  y3  -.  6.0)   ,  0.0 ) ]
 ;;

let box_4047599236 y1 y2 y3 y4 y5 y6   = dart_std3 y1 y2 y3 y4 y5 y6 ;;
let obj_4047599236 y1 y2 y3 y4 y5 y6   = [ (  (dih_y y1 y2 y3 y4 y5 y6)  -.  1.2308 +.   
  (0.3639 *.  (y2 +.  y3 +.  y5 +.  y6  -.  8.0))  -. 
  (0.235 *.  (y1  -.  2.0))  -. (0.685 *.  (y4  -.  2.0))  ,  0.0 ) ]
 ;;

let box_3526497018 y1 y2 y3 y4 y5 y6   = dart_std3 y1 y2 y3 y4 y5 y6 ;;
let obj_3526497018 y1 y2 y3 y4 y5 y6   = [ (  ( -. dih_y y1 y2 y3 y4 y5 y6) +.  1.231  -.  
  (0.152 *.  (y2 +.  y3 +.  y5 +.  y6  -.  8.0))+. 
  (0.5 *.  (y1  -.  2.0)) +.  (0.773 *.  (y4  -.  2.0)) ,  0.0 ) ]
 ;;

let box_5957966880 y1 y2 y3 y4 y5 y6   = dart_std3 y1 y2 y3 y4 y5 y6 ;;
let obj_5957966880 y1 y2 y3 y4 y5 y6   = [ (  (rhazim y1 y2 y3 y4 y5 y6)  -.  1.2308 +.   
  (0.3639 *.  (y2 +.  y3 +.  y5 +.  y6  -.  8.0))  -. 
  (0.6 *.  (y1  -.  2.0))  -. (0.685 *.  (y4  -.  2.0))  ,  0.0 ) ]
 ;;


let dartX y1 y2 y3 y4 y5 y6  = [ ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.52 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ]
 ;;

let box_3020140039 y1 y2 y3 y4 y5 y6   = dartX y1 y2 y3 y4 y5 y6 ;;
let obj_3020140039 y1 y2 y3 y4 y5 y6   = [ (  (dih_y y1 y2 y3 y4 y5 y6)  -.  1.629 +.   
  (0.402 *.  (y2 +.  y3 +.  y5 +.  y6  -.  8.0))  -. 
  (0.315 *.  (y1  -.  2.0))   ,  0.0 ) ]
 ;;

let dartY y1 y2 y3 y4 y5 y6  = [ ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( sqrt8 , sqrt8 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ]
 ;;

let box_9414951439 y1 y2 y3 y4 y5 y6   = dartY y1 y2 y3 y4 y5 y6 ;;
let obj_9414951439 y1 y2 y3 y4 y5 y6   = [ (  (dih_y y1 y2 y3 y4 y5 y6)  -.  1.91 +.   
  (0.458 *.  (y2 +.  y3 +.  y5 +.  y6  -.  8.0))  -. 
  (0.342 *.  (y1  -.  2.0))   ,  0.0 ) ]
 ;;

let dart4_diag3 y1 y2 y3 y4 y5 y6  = [ ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ; ( 3.0 , 3.0 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ]
 ;;

let box_9995621667 y1 y2 y3 y4 y5 y6   = dart4_diag3 y1 y2 y3 y4 y5 y6 ;;
let obj_9995621667 y1 y2 y3 y4 y5 y6   = [ (  (dih_y y1 y2 y3 y4 y5 y6)  -.  2.09 +.   
  (0.578 *.  (y2 +.  y3 +.  y5 +.  y6  -.  8.0))  -. 
  (0.54 *.  (y1  -.  2.0))   ,  0.0 ) ]
 ;;

let apex_flat_modified y1 y2 y3 y4 y5 y6  = [ ( 2.0 , 2.1) ; (2.0 , 2.1) ; ( 2.0 , 2.1) ; ( 2.65 , sqrt8 ) ; ( 2.0 , 2.1 ) ; ( 2.0 , 2.1 ) ]
 ;;

let apex_flat y1 y2 y3 y4 y5 y6  = [ ( 2.0 , 2.52) ; (2.0 , 2.52) ; ( 2.0 , 2.52) ; (2.52 , sqrt8 ) ; ( 2.0 , 2.52 ) ; ( 2.0 , 2.52 ) ]
 ;;

let box_6988401556 y1 y2 y3 y4 y5 y6   = apex_flat y1 y2 y3 y4 y5 y6 ;;
let obj_6988401556 y1 y2 y3 y4 y5 y6   = [ ( taum y1 y2 y3 y4 y5 y6  ,  0.103 ) ]
 ;;

let box_8248508703 y1 y2 y3 y4 y5 y6   = apex_flat y1 y2 y3 y4 y5 y6 ;;
let obj_8248508703 y1 y2 y3 y4 y5 y6   = [ (  (taum y1 y2 y3 y4 y5 y6)  -.  0.1  -.   
  (0.265 *.  (y5 +.  y6  -.  4.0))  -. 
  (0.06 *.  (y4  -.  2.52))  -.  (0.16 *.  (y1  -.  2.0))  -.  
  (0.115 *.  (y2 +.  y3  -.  4.0))   ,  0.0 ) ]
 ;;

let box_3318775219 y1 y2 y3 y4 y5 y6   = apex_flat y1 y2 y3 y4 y5 y6 ;;
let obj_3318775219 y1 y2 y3 y4 y5 y6   = [ (  dih_y y1 y2 y3 y4 y5 y6    ,  0.0 ) ]
 ;;

let box_9922699028 y1 y2 y3 y4 y5 y6   = apex_flat y1 y2 y3 y4 y5 y6 ;;
let obj_9922699028 y1 y2 y3 y4 y5 y6   = [ (  ( -. dih_y y1 y2 y3 y4 y5 y6) +.  1.6294  -.   
  (0.2213 *.  (y2 +.  y3 +.  y5 +.  y6  -.  8.0)) +. 
  (0.913 *.  (y4  -.  2.52)) +.  
  (0.728 *.  (y1  -.  2.0))   ,  0.0 ) ]
 ;;

let box_9922699028_modified y1 y2 y3 y4 y5 y6   = apex_flat_modified y1 y2 y3 y4 y5 y6 ;;
let obj_9922699028_modified y1 y2 y3 y4 y5 y6   = [ (  ( -. dih_y y1 y2 y3 y4 y5 y6) +.  1.6294  -.   
  (0.2213 *.  (y2 +.  y3 +.  y5 +.  y6  -.  8.0)) +. 
  (0.913 *.  (y4  -.  2.52)) +.  
  (0.728 *.  (y1  -.  2.0))   ,  0.0 ) ]
 ;;

let box_5000076558 y1 y2 y3 y4 y5 y6   = apex_flat y1 y2 y3 y4 y5 y6 ;;
let obj_5000076558 y1 y2 y3 y4 y5 y6   = [ (  (dih2_y y1 y2 y3 y4 y5 y6)  -.  1.083 +.   
  (0.6365 *.  (y1  -.  2.0))  -. 
  (0.198 *.  (y2  -.  2.0)) +.  
  (0.352 *.  (y3  -.  2.0)) +.  
  (0.416 *.  (y4  -.  2.52))  -.  
  (0.66 *.  (y5  -.  2.0)) +.  
  (0.071 *.  (y6  -.  2.0))  ,  0.0 ) ]
 ;;

let box_9251360200 y1 y2 y3 y4 y5 y6   = apex_flat y1 y2 y3 y4 y5 y6 ;;
let obj_9251360200 y1 y2 y3 y4 y5 y6   = [ (  (rhazim y1 y2 y3 y4 y5 y6)  -.  1.629  -.   
  (0.866 *.  (y1  -.  2.0)) +. 
  (0.3805 *.  (y2 +.  y3  -.   4.0))  -.  
  (0.841 *.  (y4  -.  2.52)) +.  
  (0.501 *.  (y5 +.  y6  -.   4.0))   ,  0.0 ) ]
 ;;

let box_9756015945 y1 y2 y3 y4 y5 y6   = apex_flat y1 y2 y3 y4 y5 y6 ;;
let obj_9756015945 y1 y2 y3 y4 y5 y6   = [ (  (rhazim2 y1 y2 y3 y4 y5 y6)  -.  1.08 +.   
  (0.6362 *.  (y1  -.  2.0))  -. 
  (0.565 *.  (y2  -.  2.0)) +.  
  (0.359 *.  (y3  -.  2.0)) +.  
  (0.416 *.  (y4  -.  2.52))  -.  
  (0.666 *.  (y5  -.  2.0)) +.  
  (0.061 *.  (y6  -.  2.0))  ,  0.0 ) ]
 ;;

let apex_A y1 y2 y3 y4 y5 y6  = [ ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.52 ,  sqrt8 ) ; ( 2.52 ,  sqrt8 ) ]
 ;;

let box_8082208587 y1 y2 y3 y4 y5 y6   = apex_A y1 y2 y3 y4 y5 y6 ;;
let obj_8082208587 y1 y2 y3 y4 y5 y6   = [ ( taum y1 y2 y3 y4 y5 y6  ,  0.2759 ) ]
 ;;

let box_5760733457 y1 y2 y3 y4 y5 y6   = apex_A y1 y2 y3 y4 y5 y6 ;;
let obj_5760733457 y1 y2 y3 y4 y5 y6   = [ ( dih_y y1 y2 y3 y4 y5 y6  -.  1.0705  -. ( 0.1 *.  (y1  -.  2.) ) +.  
   (0.424 *.  (y2  -.  2.0)) +.  
   (0.424 *.  (y3  -.  2.0))  -.  
   (0.594 *.  (y4  -.  2.0)) +.  
   (0.124 *.  (y5  -.  2.52)) +.  
   (0.124 *.  (y6  -.  2.52))  ,  0.0 ) ]
 ;;

let box_2563100177 y1 y2 y3 y4 y5 y6   = apex_A y1 y2 y3 y4 y5 y6 ;;
let obj_2563100177 y1 y2 y3 y4 y5 y6   = [ (  rhazim y1 y2 y3 y4 y5 y6  -.  1.0685  -.  
(0.4635 *.  (y1  -.  2.0)) +.  
(0.424 *.  (y2  -.  2.0)) +.  
(0.424 *.  (y3  -.  2.0))  -.  
(0.594 *.  (y4  -.  2.0)) +.  
(0.124 *.  (y5  -.  2.52)) +.  
(0.124 *.  (y6  -.  2.52))  ,  0.0 ) ]
 ;;

let box_7931207804 y1 y2 y3 y4 y5 y6   = apex_A y1 y2 y3 y4 y5 y6 ;;
let obj_7931207804 y1 y2 y3 y4 y5 y6   = [ (  taum y1 y2 y3 y4 y5 y6  -.  0.27 +. 
(0.0295 *.  (y1  -.  2.0))  -.  
(0.0778 *.  (y2  -.  2.0))  -.  
(0.0778 *.  (y3  -.  2.0))  -.  
(0.37 *.  (y4  -.  2.0))  -.  
(0.27 *.  (y5  -.  2.52))  -.  
(0.27 *.  (y6  -.  2.52))  ,  0.0 ) ]
 ;;

let dart_std3_small y1 y2 y3 y4 y5 y6  = [ ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.25 ) ; ( 2.0 ,  2.25 ) ; ( 2.0 ,  2.25 ) ]
 ;;

let box_9225295803 y1 y2 y3 y4 y5 y6   = dart_std3_small y1 y2 y3 y4 y5 y6 ;;
let obj_9225295803 y1 y2 y3 y4 y5 y6   = [ ( taum y1 y2 y3 y4 y5 y6 +.  0.0034  -.  
(0.166 *.  (y1 +.  y2 +.  y3  -.  6.0))  -.  
(0.22 *.  (y4 +.  y5 +.  y6  -.  6.0))  ,  0.0 ) ]
 ;;

let box_9291937879 y1 y2 y3 y4 y5 y6   = dart_std3_small y1 y2 y3 y4 y5 y6 ;;
let obj_9291937879 y1 y2 y3 y4 y5 y6   = [ ( dih_y y1 y2 y3 y4 y5 y6  -.  1.23  -.  
(0.235 *.  (y1  -.  2.0)) +.  
(0.362 *.  (y2 +.  y3  -.  4.0))  -.  
(0.694 *.  (y4  -.  2.0)) +.  
(0.26 *.  (y5 +.  y6  -.  4.0))  ,  0.0 ) ]
 ;;

let dart_std3_big  = dart_std3 ;;

let box_7761782916 y1 y2 y3 y4 y5 y6   = dart_std3_big y1 y2 y3 y4 y5 y6 ;;
let obj_7761782916 y1 y2 y3 y4 y5 y6   = [ ( taum y1 y2 y3 y4 y5 y6  -.  0.05  -.  (0.137 *.  (y1 +.  y2 +.  y3  -.  6.0)) 
   -.  (0.17 *.  (y4 +.  y5 +.  y6  -.  6.25))  ,  0.0 ) ; (  6.25 , y4 +.  y5 +.  y6  ) ]
 ;;

let box_6224332984 y1 y2 y3 y4 y5 y6   = dart_std3_big y1 y2 y3 y4 y5 y6 ;;
let obj_6224332984 y1 y2 y3 y4 y5 y6   = [ ( sol_y y1 y2 y3 y4 y5 y6  -.  0.589 +.  
(0.39 *.  (y1 +.  y2 +.  y3  -.  6.0))  -.  
(0.235 *.  (y4 +.  y5 +.  y6  -.  6.25))  ,  0.0 ) ; (  6.25 , y4 +.  y5 +.  y6  ) ]
 ;;

let apex_sup_flat y1 y2 y3 y4 y5 y6  = [ ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( sqrt8 ,  3.0 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ]
 ;;

let box_5451229371 y1 y2 y3 y4 y5 y6   = apex_sup_flat y1 y2 y3 y4 y5 y6 ;;
let obj_5451229371 y1 y2 y3 y4 y5 y6   = [ ( taum y1 y2 y3 y4 y5 y6  -.  0.11
     -.  0.14132 *.  (y1 +.  (y2 +.  y3)  /.  2.  -.  4.) 
        -.  0.38 *.  (y5 +.  y6  -.  4.)  ,  0. ) ]
 ;;

let box_4840774900 y1 y2 y3 y4 y5 y6   = apex_sup_flat y1 y2 y3 y4 y5 y6 ;;
let obj_4840774900 y1 y2 y3 y4 y5 y6   = [ ( 
 taum y1 y2 y3 y4 y5 y6       -.  0.1054 
     -.  0.14132*. (y1 +.  y2  /.  2. +.  y3  /.  2.  -.  4.)
     -.  0.36499*. (y5 +. y6  -.  4.)  ,  0. ) ]
 ;;

let box_1642527039 y1 y2 y3 y4 y5 y6   = apex_sup_flat y1 y2 y3 y4 y5 y6 ;;
let obj_1642527039 y1 y2 y3 y4 y5 y6   = [ ( 
 taum y1 y2 y3 y4 y5 y6       -.  0.128 
   -.  0.053*. ((y5 +. y6  -.  4.)  -.  (2.75 /.  2.)*. (y4  -.  sqrt8))  ,  0. ) ]
 ;;

let box_7863247282 y1 y2 y3 y4 y5 y6   = apex_sup_flat y1 y2 y3 y4 y5 y6 ;;
let obj_7863247282 y1 y2 y3 y4 y5 y6   = [ ( taum y1 y2 y3 y4 y5 y6   -.  0.053*. ((y5 +. y6  -.  4.)  -.  (2.75 /.  2.)*. (y4  -.  sqrt8))
     -.  0.12 
     -.  0.14132*. (y1 +.  y2  /.  2. +.  y3  /.  2.  -.  4.)
     -.  0.328*. (y5 +. y6  -.  4.)  ,  0. ) ]
 ;;

let box_7718591733 y1 y2 y3 y4 y5 y6   = apex_sup_flat y1 y2 y3 y4 y5 y6 ;;
let obj_7718591733 y1 y2 y3 y4 y5 y6   = [ ( dih2_y y1 y2 y3 y4 y5 y6   -.  0.955 
    -.  0.2356*. (y2  -.  2.)
       +.  0.32*. (y3  -.  2.) +.  0.792*. (y1  -.  2.)
    -.  0.707*. (y5  -.  2.) 
        +.  0.0844*. (y6  -.  2.) +.  0.821*. (y4  -.  sqrt8)  ,  0. ) ]
 ;;

let box_3566713650 y1 y2 y3 y4 y5 y6   = apex_sup_flat y1 y2 y3 y4 y5 y6 ;;
let obj_3566713650 y1 y2 y3 y4 y5 y6   = [ ( 
   -.  dih_y y1 y2 y3 y4 y5 y6  +.  1.911 +.  1.01 *. (y1   -.  2.)
   -.  0.284*. (y2 +. y3 +. y5 +. y6  -.  8.)
   +.  1.07*. (y4  -.  sqrt8)  ,  0. ) ]
 ;;

let box_1085358243 y1 y2 y3 y4 y5 y6   = apex_sup_flat y1 y2 y3 y4 y5 y6 ;;
let obj_1085358243 y1 y2 y3 y4 y5 y6   = [ ( 
  dih_y y1 y2 y3 y4 y5 y6   -.  1.903  -.  0.4*. (y1   -.  2.)
  +.  0.49688*. (y2 +. y3 +. y5 +. y6  -.  8.)
    -. (y4  -. sqrt8)  ,  0. ) ]
 ;;

let dart_std3_mini y1 y2 y3 y4 y5 y6  = [ (  2.  , 2.18 ) ; ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2. , 2.25 ) ; ( 2. , 2.25 ) ; ( 2. , 2.25 ) ]
 ;;

let box_9229542852 y1 y2 y3 y4 y5 y6   = dart_std3_mini y1 y2 y3 y4 y5 y6 ;;
let obj_9229542852 y1 y2 y3 y4 y5 y6   = [ ( dih_y y1 y2 y3 y4 y5 y6  -.  1.230  -.  
(0.2357 *.  (y1  -.  2.0)) +.  
(0.2493 *.  (y2 +.  y3  -.  4.0))  -.  
(0.682 *.  (y4  -.  2.0)) +.  
(0.3035 *.  (y5 +.  y6  -.  4.0))  ,  0.0 ) ]
 ;;

let box_1550635295 y1 y2 y3 y4 y5 y6   = dart_std3_mini y1 y2 y3 y4 y5 y6 ;;
let obj_1550635295 y1 y2 y3 y4 y5 y6   = [ (  -. (dih_y y1 y2 y3 y4 y5 y6) +.  1.232 +.  
(0.261 *.  (y1  -.  2.0))  -.  
(0.203 *.  (y2 +.  y3  -.  4.0)) +.  
(0.772 *.  (y4  -.  2.0))  -.  
(0.191 *.  (y5 +.  y6  -.  4.0))  ,  0.0 ) ]
 ;;

let box_4491491732 y1 y2 y3 y4 y5 y6   = dart_std3_mini y1 y2 y3 y4 y5 y6 ;;
let obj_4491491732 y1 y2 y3 y4 y5 y6   = [ ( taum y1 y2 y3 y4 y5 y6 +.  0.0008  -.  
(0.1631 *.  (y1 +.  y2 +.  y3  -.  6.0))  -.  
(0.2127 *.  (y4 +.  y5 +.  y6  -.  6.0))  ,  0.0 ) ]
 ;;

let apex_flat_hll  y1 y2 y3 y4 y5 y6  = [ ( 2.18 ,  2.52 ) ; ( 2.0 ,  2.18 ) ; ( 2.0 ,  2.18 ) ; ( 2.52 ,  sqrt8 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ]
 ;;

let box_8282573160 y1 y2 y3 y4 y5 y6   = apex_flat_hll  y1 y2 y3 y4 y5 y6 ;;
let obj_8282573160 y1 y2 y3 y4 y5 y6   = [ ( taum y1 y2 y3 y4 y5 y6  -.  0.1413  -.  
(0.214 *.  (y1  -.  2.18))  -.  
(0.1259 *.  (y2 +.  y3  -.  4.0))  -.  
(0.067 *.  (y4  -.  2.52))  -.  
(0.241 *.  (y5 +.  y6  -.  4.0))  ,  0.0 ) ]
 ;;

let dart_std3_big_200_218  y1 y2 y3 y4 y5 y6  = [ ( 2.0 ,  2.18 ) ; ( 2.0 ,  2.18 ) ; ( 2.0 ,  2.18 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ]
 ;;

let box_8611785756 y1 y2 y3 y4 y5 y6   = dart_std3_big_200_218  y1 y2 y3 y4 y5 y6 ;;
let obj_8611785756 y1 y2 y3 y4 y5 y6   = [ ( sol_y y1 y2 y3 y4 y5 y6  -.  0.589 +.  
(0.24 *.  (y1 +.  y2 +.  y3  -.  6.0))  -.  
(0.16 *.  (y4 +.  y5 +.  y6  -.  6.25))  ,  0.0 ) ; (  6.25 , y4 +.  y5 +.  y6  ) ]
 ;;





















let apex_std3_hll y1 y2 y3 y4 y5 y6  = [ ( 2.18 , 2.52 ) ; ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let apex_std3_small_hll y1 y2 y3 y4 y5 y6  = [ ( 2.18 , 2.52 ) ; ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2. , 2.25 ) ; ( 2. , 2.25 ) ; ( 2. , 2.25 ) ]
 ;;

let dart_mll_w y1 y2 y3 y4 y5 y6  = [ ( 2.18 , 2.36 ) ; ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2.25 , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let dart_mll_n y1 y2 y3 y4 y5 y6  = [ ( 2.18 , 2.36 ) ; ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2. , 2.25 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let dart_Hll_n y1 y2 y3 y4 y5 y6  = [ ( 2.36 , 2.52 ) ; ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2. , 2.25 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let dart_Hll_w y1 y2 y3 y4 y5 y6  = [ ( 2.36 , 2.52 ) ; ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2.25 , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let dart_mll_w y1 y2 y3 y4 y5 y6  = [ ( 2.18 , 2.36 ) ; ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2.25 , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let dart_mll_n y1 y2 y3 y4 y5 y6  = [ ( 2.18 , 2.36 ) ; ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2. , 2.25 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let dart_Hll_n y1 y2 y3 y4 y5 y6  = [ ( 2.36 , 2.52 ) ; ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2. , 2.25 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let dart_Hll_w y1 y2 y3 y4 y5 y6  = [ ( 2.36 , 2.52 ) ; ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2.25 , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;






















let dart_std3_lw y1 y2 y3 y4 y5 y6  = [ ( 2.00 , 2.18 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 2.25 , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let box_4750199435 y1 y2 y3 y4 y5 y6   = apex_flat y1 y2 y3 y4 y5 y6 ;;
let obj_4750199435 y1 y2 y3 y4 y5 y6   = [ (  -. dih2_y y1 y2 y3 y4 y5 y6 +.  0.0031  , 
           -.   1.08346 +. 
          0.288794 *.  ( -.  2. +.  y1) +. 
           -.  0.292829 *.  ( -.  2. +.  y2) +. 
          0.036457 *.  ( -.  2. +.  y3) +. 
          0.348796 *.  ( -.  2.52 +.  y4) +. 
           -.  0.762602 *.  ( -.  2. +.  y5) +. 
           -.  0.112679 *.  ( -.  2. +.  y6) ) ]
 ;;


let box_8384511215 y1 y2 y3 y4 y5 y6   = apex_flat y1 y2 y3 y4 y5 y6 ;;
let obj_8384511215 y1 y2 y3 y4 y5 y6   = [ ( dih2_y y1 y2 y3 y4 y5 y6 +.  0.0015  , 
          0.913186 +. 
           -.  0.390288 *.  ( -.  2. +.  y1) +. 
          0.115895 *.  ( -.  2. +.  y2) +. 
          0.164805 *.  ( -.  2.52 +.  y3) +. 
           -.  0.271329 *.  ( -.  2.82843 +.  y4) +. 
          0.584817 *.  ( -.  2. +.  y5) +. 
           -.  0.170218 *.  ( -.  2. +.  y6) ) ]
 ;;


let box_7819193535 y1 y2 y3 y4 y5 y6   = dart_std3_lw y1 y2 y3 y4 y5 y6 ;;
let obj_7819193535 y1 y2 y3 y4 y5 y6   = [ ( dih2_y y1 y2 y3 y4 y5 y6 +.  0.0011  , 
          1.16613 +. 
           -.  0.296776 *.  ( -.  2. +.  y1) +. 
          0.208935 *.  ( -.  2. +.  y2) +. 
           -.  0.243302 *.  ( -.  2. +.  y3) +. 
           -.  0.360575 *.  ( -.  2.25 +.  y4) +. 
          0.636205 *.  ( -.  2. +.  y5) +. 
           -.  0.295156 *.  ( -.  2. +.  y6) ) ]
 ;;


let box_6987934000 y1 y2 y3 y4 y5 y6   = dart_mll_w y1 y2 y3 y4 y5 y6 ;;
let obj_6987934000 y1 y2 y3 y4 y5 y6   = [ ( dih2_y y1 y2 y3 y4 y5 y6 +.  0.0042  , 
          0.952682 +. 
           -.  0.268837 *.  ( -.  2.36 +.  y1) +. 
          0.130607 *.  ( -.  2. +.  y2) +. 
           -.  0.168729 *.  ( -.  2. +.  y3) +. 
           -.  0.0831764 *.  ( -.  2.52 +.  y4) +. 
          0.580152 *.  ( -.  2. +.  y5) +. 
          0.0656612 *.  ( -.  2.25 +.  y6) ) ]
 ;;


let box_7291663656 y1 y2 y3 y4 y5 y6   = apex_flat y1 y2 y3 y4 y5 y6 ;;
let obj_7291663656 y1 y2 y3 y4 y5 y6   = [ ( dih2_y y1 y2 y3 y4 y5 y6 +.  0.0009  , 
          0.947391 +. 
           -.  0.637397 *.  ( -.  2. +.  y1) +. 
          0.120003 *.  ( -.  2. +.  y2) +. 
           -.  0.100814 *.  ( -.  2.3 +.  y3) +. 
           -.  0.302956 *.  ( -.  2.65 +.  y4) +. 
          0.547359 *.  ( -.  2. +.  y5) +. 
           -.  0.157745 *.  ( -.  2.2 +.  y6) ) ]
 ;;


let box_2390583444 y1 y2 y3 y4 y5 y6   = dart_std3_mini y1 y2 y3 y4 y5 y6 ;;
let obj_2390583444 y1 y2 y3 y4 y5 y6   = [ ( dih_y y1 y2 y3 y4 y5 y6 +.  0.0012  , 
          1.08627 +. 
          0.159149 *.  ( -.  2. +.  y1) +. 
           -.  0.198496 *.  ( -.  2.1 +.  y2) +. 
           -.  0.199306 *.  ( -.  2.1 +.  y3) +. 
          0.590083 *.  ( -.  2. +.  y4) +. 
           -.  0.0888111 *.  ( -.  2.25 +.  y5) +. 
           -.  0.0881846 *.  ( -.  2.25 +.  y6) ) ]
 ;;


let apex_flat_l y1 y2 y3 y4 y5 y6  = [ (  2.  , 2.18 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 2.52 , sqrt8 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let apex_flat_h y1 y2 y3 y4 y5 y6  = [ ( 2.18 , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 2.52 , sqrt8 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let box_9641946727 y1 y2 y3 y4 y5 y6   = apex_flat_l y1 y2 y3 y4 y5 y6 ;;
let obj_9641946727 y1 y2 y3 y4 y5 y6   = [ ( dih2_y y1 y2 y3 y4 y5 y6 +.  0.0071  , 
          0.98362 +. 
           -.  0.264094 *.  ( -.  2.18 +.  y1) +. 
          0.149308 *.  ( -.  2.18 +.  y2) +. 
           -.  0.312683 *.  ( -.  2. +.  y3) +. 
           -.  0.282792 *.  ( -.  2.65 +.  y4) +. 
          0.581552 *.  ( -.  2. +.  y5) +. 
          0.143669 *.  ( -.  2.3 +.  y6) ) ]
 ;;

let apex_std3_lll_xww y1 y2 y3 y4 y5 y6  = [ ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2. , 2.52 ) ; ( 2.25 , 2.52 ) ; ( 2.25 , 2.52 ) ]
 ;;

let box_4222324842 y1 y2 y3 y4 y5 y6   = apex_std3_lll_xww y1 y2 y3 y4 y5 y6 ;;
let obj_4222324842 y1 y2 y3 y4 y5 y6   = [ ( dih_y y1 y2 y3 y4 y5 y6 +.  0.0071  , 
          1.09969 +. 
          0.146345 *.  ( -.  2. +.  y1) +. 
           -.  0.160538 *.  ( -.  2. +.  y2) +. 
           -.  0.151698 *.  ( -.  2.14 +.  y3) +. 
          0.61314 *.  ( -.  2. +.  y4) +. 
           -.  0.236149 *.  ( -.  2.25 +.  y5) +. 
           -.  0.242043 *.  ( -.  2.25 +.  y6) ) ]
 ;;

let apex_std3_lll_wxx y1 y2 y3 y4 y5 y6  = [ ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2. , 2.18 ) ; ( 2.25 , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let box_5756588587 y1 y2 y3 y4 y5 y6   = apex_std3_lll_wxx y1 y2 y3 y4 y5 y6 ;;
let obj_5756588587 y1 y2 y3 y4 y5 y6   = [ ( dih2_y y1 y2 y3 y4 y5 y6 +.  0.0025  , 
          1.16613 +. 
           -.  0.296776 *.  ( -.  2. +.  y1) +. 
          0.208935 *.  ( -.  2. +.  y2) +. 
           -.  0.196313 *.  ( -.  2. +.  y3) +. 
           -.  0.360575 *.  ( -.  2.25 +.  y4) +. 
          0.652861 *.  ( -.  2. +.  y5) +. 
           -.  0.218063 *.  ( -.  2. +.  y6) ) ]
 ;;

let box_3425739813 y1 y2 y3 y4 y5 y6   = apex_flat y1 y2 y3 y4 y5 y6 ;;
let obj_3425739813 y1 y2 y3 y4 y5 y6   = [ (  -. dih_y y1 y2 y3 y4 y5 y6 +.  0.0011  , 
           -.  1.67609 +. 
           -.  0.506322 *.  ( -.  2.18 +.  y1) +. 
          0.212075 *.  ( -.  2.1 +.  y2) +. 
          0.230669 *.  ( -.  2.1 +.  y3) +. 
           -.  1.28579 *.  ( -.  2.52 +.  y4) +. 
          0.249199 *.  ( -.  2. +.  y5) +. 
          0.193545 *.  ( -.  2. +.  y6) ) ]
 ;;

let box_7316455966 y1 y2 y3 y4 y5 y6   = apex_std3_lll_wxx y1 y2 y3 y4 y5 y6 ;;
let obj_7316455966 y1 y2 y3 y4 y5 y6   = [ ( dih2_y y1 y2 y3 y4 y5 y6 +.  0.0050  , 
          1.02005 +. 
           -.  0.256494 *.  ( -.  2.18 +.  y1) +. 
          0.121497 *.  ( -.  2. +.  y2) +. 
           -.  0.256494 *.  ( -.  2. +.  y3) +. 
           -.  0.0116869 *.  ( -.  2.52 +.  y4) +. 
          0.598233 *.  ( -.  2. +.  y5) +. 
          0.0187672 *.  ( -.  2.25 +.  y6) ) ]
 ;;

let box_6410081357 y1 y2 y3 y4 y5 y6   = apex_std3_lll_wxx y1 y2 y3 y4 y5 y6 ;;
let obj_6410081357 y1 y2 y3 y4 y5 y6   = [ (  -. dih3_y y1 y2 y3 y4 y5 y6 +.  0.0087  , 
           -.  1.18616 +. 
          0.436647 *.  ( -.  2.18 +.  y1) +. 
          0.032258 *.  ( -.  2. +.  y2) +. 
           -.  0.289629 *.  ( -.  2. +.  y3) +. 
          0.397053 *.  ( -.  2.52 +.  y4) +. 
           -.  0.0210289 *.  ( -.  2. +.  y5) +. 
           -.  0.683341 *.  ( -.  2.25 +.  y6) ) ]
 ;;

let box_2923748598 y1 y2 y3 y4 y5 y6   = dart_mll_n y1 y2 y3 y4 y5 y6 ;;
let obj_2923748598 y1 y2 y3 y4 y5 y6   = [ (  -. dih_y y1 y2 y3 y4 y5 y6 +.  0.0083  , 
           -.  1.29912 +. 
           -.  0.284457 *.  ( -.  2.18 +.  y1) +. 
          0.337354 *.  ( -.  2. +.  y2) +. 
          0.186287 *.  ( -.  2. +.  y3) +. 
           -.  0.645382 *.  ( -.  2.25 +.  y4) +. 
          0.367671 *.  ( -.  2.52 +.  y5) +. 
          0.0536051 *.  ( -.  2. +.  y6) ) ]
 ;;

let box_4306175952 y1 y2 y3 y4 y5 y6   = dart_mll_n y1 y2 y3 y4 y5 y6 ;;
let obj_4306175952 y1 y2 y3 y4 y5 y6   = [ ( dih2_y y1 y2 y3 y4 y5 y6 +.  0.0035  , 
          1.05036 +. 
           -.  0.222178 *.  ( -.  2.18 +.  y1) +. 
          0.132628 *.  ( -.  2. +.  y2) +. 
           -.  0.219284 *.  ( -.  2. +.  y3) +. 
          0.00563427 *.  ( -.  2.25 +.  y4) +. 
          0.59096 *.  ( -.  2. +.  y5) +. 
           -.  0.0771574 *.  ( -.  2.52 +.  y6) ) ]
 ;;

let box_2763799127 y1 y2 y3 y4 y5 y6   = apex_sup_flat y1 y2 y3 y4 y5 y6 ;;
let obj_2763799127 y1 y2 y3 y4 y5 y6   = [ (  -. dih3_y y1 y2 y3 y4 y5 y6 +.  0.0076  , 
           -.  0.956317 +. 
          0.419124 *.  ( -.  2. +.  y1) +. 
           -.  0.0753922 *.  ( -.  2. +.  y2) +. 
           -.  0.252307 *.  ( -.  2. +.  y3) +. 
          0.5 *.  ( -.  2.82843 +.  y4) +. 
           -.  0.246082 *.  ( -.  2. +.  y5) +. 
           -.  0.788717 *.  ( -.  2. +.  y6) ) ]
 ;;

let box_5943578801 y1 y2 y3 y4 y5 y6   = apex_sup_flat y1 y2 y3 y4 y5 y6 ;;
let obj_5943578801 y1 y2 y3 y4 y5 y6   = [ ( dih2_y y1 y2 y3 y4 y5 y6 +.  0.0047  , 
          0.936544 +. 
           -.  0.636113 *.  ( -.  2.1 +.  y1) +. 
          0.140759 *.  ( -.  2.1 +.  y2) +. 
           -.  0.0771734 *.  ( -.  2.3 +.  y3) +. 
           -.  1.29068 *.  ( -.  2.82843 +.  y4) +. 
          0.591328 *.  ( -.  2.1 +.  y5) +. 
           -.  0.0521775 *.  ( -.  2.1 +.  y6) ) ]
 ;;

let apex_std3_lhh y1 y2 y3 y4 y5 y6  = [ ( 2. , 2.18 ) ; ( 2.18 , 2.52 ) ; ( 2.18 , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ; ( 2. , 2.52 ) ]
 ;;

let box_1836408787 y1 y2 y3 y4 y5 y6   = apex_std3_lhh y1 y2 y3 y4 y5 y6 ;;
let obj_1836408787 y1 y2 y3 y4 y5 y6   = [ ( dih_y y1 y2 y3 y4 y5 y6 +.  0.0012  , 
          1.01332 +. 
          0.148615 *.  ( -.  2. +.  y1) +. 
           -.  0.379006 *.  ( -.  2.18 +.  y2) +. 
           -.  0.379441 *.  ( -.  2.18 +.  y3) +. 
          0.583676 *.  ( -.  2. +.  y4) +. 
           -.  0.184708 *.  ( -.  2.25 +.  y5) +. 
           -.  0.18471 *.  ( -.  2.25 +.  y6) ) ]
 ;;

let box_1248932983 y1 y2 y3 y4 y5 y6   = apex_std3_lhh y1 y2 y3 y4 y5 y6 ;;
let obj_1248932983 y1 y2 y3 y4 y5 y6   = [ (  -. dih2_y y1 y2 y3 y4 y5 y6 +.  0.0059  , 
           -.  1.33909 +. 
          0.0724529 *.  ( -.  2. +.  y1) +. 
           -.  0.486824 *.  ( -.  2.18 +.  y2) +. 
          0.317329 *.  ( -.  2.18 +.  y3) +. 
           -.  0.00479451 *.  ( -.  2. +.  y4) +. 
           -.  0.751179 *.  ( -.  2.25 +.  y5) +. 
          0.350857 *.  ( -.  2.25 +.  y6) ) ]
 ;;

let box_6725783616 y1 y2 y3 y4 y5 y6   = apex_flat y1 y2 y3 y4 y5 y6 ;;
let obj_6725783616 y1 y2 y3 y4 y5 y6   = [ ( dih3_y y1 y2 y3 y4 y5 y6 +.  0.0046  , 
          0.88473 +. 
           -.  0.443946 *.  ( -.  2.36 +.  y1) +. 
           -.  0.244711 *.  ( -.  2.1 +.  y2) +. 
          0.205592 *.  ( -.  2.1 +.  y3) +. 
           -.  0.739126 *.  ( -.  2.55 +.  y4) +. 
           -.  0.127198 *.  ( -.  2.1 +.  y5) +. 
          0.61582 *.  ( -.  2. +.  y6) ) ]
 ;;

let box_9185711902 y1 y2 y3 y4 y5 y6   = apex_std3_hll y1 y2 y3 y4 y5 y6 ;;
let obj_9185711902 y1 y2 y3 y4 y5 y6   = [ (  -. dih3_y y1 y2 y3 y4 y5 y6 +.  0.0116  , 
           -.  1.30119 +. 
          0.392915 *.  ( -.  2.36 +.  y1) +. 
          0.142563 *.  ( -.  2.1 +.  y2) +. 
           -.  0.258747 *.  ( -.  2.1 +.  y3) +. 
          0.417088 *.  ( -.  2.45 +.  y4) +. 
           -.  0.0606764 *.  ( -.  2. +.  y5) +. 
           -.  0.637966 *.  ( -.  2.45 +.  y6) ) ]
 ;;

let box_6284721194 y1 y2 y3 y4 y5 y6   = apex_std3_hll y1 y2 y3 y4 y5 y6 ;;
let obj_6284721194 y1 y2 y3 y4 y5 y6   = [ ( dih2_y y1 y2 y3 y4 y5 y6 +.  0.0011  , 
          0.957661 +. 
           -.  0.250506 *.  ( -.  2.36 +.  y1) +. 
          0.145114 *.  ( -.  2.1 +.  y2) +. 
           -.  0.0549376 *.  ( -.  2.1 +.  y3) +. 
           -.  0.0384445 *.  ( -.  2.45 +.  y4) +. 
          0.5275 *.  ( -.  2. +.  y5) +. 
          0.118819 *.  ( -.  2.45 +.  y6) ) ]
 ;;

let box_3137600529 y1 y2 y3 y4 y5 y6   = apex_flat_h y1 y2 y3 y4 y5 y6 ;;
let obj_3137600529 y1 y2 y3 y4 y5 y6   = [ ( dih2_y y1 y2 y3 y4 y5 y6 +.  0.0042  , 
          0.868174 +. 
           -.  0.701906 *.  ( -.  2.25 +.  y1) +. 
          0.136514 *.  ( -.  2. +.  y2) +. 
           -.  0.209239 *.  ( -.  2.18 +.  y3) +. 
           -.  0.493373 *.  ( -.  2.65 +.  y4) +. 
          0.537385 *.  ( -.  2. +.  y5) +. 
          0.0187672 *.  ( -.  2.2 +.  y6) ) ]
 ;;


let box_ZTGIJCF4_0_0_0_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_ZTGIJCF4_0_0_0_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   1.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_0_0_0_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF4_0_0_0_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   2.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_0_0_1_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_ZTGIJCF4_0_0_1_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   2.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_0_0_1_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF4_0_0_1_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   3.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_0_1_0_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_ZTGIJCF4_0_1_0_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   2.  +.   1.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_0_1_0_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF4_0_1_0_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   3.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_0_1_1_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_ZTGIJCF4_0_1_1_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   3.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_0_1_1_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF4_0_1_1_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   4.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_1_0_0_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_ZTGIJCF4_1_0_0_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   2.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_1_0_0_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF4_1_0_0_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   3.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_1_0_1_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_ZTGIJCF4_1_0_1_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   3.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_1_0_1_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF4_1_0_1_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   4.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_1_1_0_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_ZTGIJCF4_1_1_0_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   3.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_1_1_0_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF4_1_1_0_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   4.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_1_1_1_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_ZTGIJCF4_1_1_1_0_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   4.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF4_1_1_1_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF4_1_1_1_1_1821661595  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   5.  +.   0.  *. beta_bump_lb   , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,   2.  ) ]
 ;;

let box_ZTGIJCF23_0_0_0_7907792228_b  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2.  ,  sqrt8  ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_ZTGIJCF23_0_0_0_7907792228_b  y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; (  0.14 , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; ( gamma23f_n y1 y2 y3 y4 y5 y6  1.  1. sqrt2 lmfun     , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ]
 ;;

let box_ZTGIJCF23_0_0_1_7907792228_b  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2.  ,  sqrt8  ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF23_0_0_1_7907792228_b  y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; (  0.14 , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; ( gamma23f_n y1 y2 y3 y4 y5 y6  2.  1. sqrt2 lmfun     , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ]
 ;;

let box_ZTGIJCF23_1_0_1_7907792228_b  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2.  ,  sqrt8  ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF23_1_0_1_7907792228_b  y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; (  0.14 , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; ( gamma23f_n y1 y2 y3 y4 y5 y6  2.  2. sqrt2 lmfun     , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ]
 ;;

let box_ZTGIJCF23_0_1_1_7907792228_b  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2.  ,  sqrt8  ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF23_0_1_1_7907792228_b  y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; (  0.14 , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; ( gamma23f_n y1 y2 y3 y4 y5 y6  2.  2. sqrt2 lmfun     , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ]
 ;;

let box_ZTGIJCF23_0_0_0_7907792228_b2  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2.  ,  2.  ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_ZTGIJCF23_0_0_0_7907792228_b2  y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; (  0.14 , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; ( gamma23f_n y1 y2 y3 y4 y5 y6  1.  1. sqrt2 lmfun     , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ]
 ;;

let box_ZTGIJCF23_0_0_1_7907792228_b2  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2.  ,  2.  ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF23_0_0_1_7907792228_b2  y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; (  0.14 , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; ( gamma23f_n y1 y2 y3 y4 y5 y6  2.  1. sqrt2 lmfun     , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ]
 ;;

let box_ZTGIJCF23_1_0_1_7907792228_b2  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2.  ,  2.  ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF23_1_0_1_7907792228_b2  y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; (  0.14 , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; ( gamma23f_n y1 y2 y3 y4 y5 y6  2.  2. sqrt2 lmfun     , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ]
 ;;

let box_ZTGIJCF23_0_1_1_7907792228_b2  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2.  ,  2.  ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF23_0_1_1_7907792228_b2  y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; (  0.14 , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; ( gamma23f_n y1 y2 y3 y4 y5 y6  2.  2. sqrt2 lmfun     , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ]
 ;;

let box_ZTGIJCF23_0_0_0_7907792228_c  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2.  ,  2.  ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_ZTGIJCF23_0_0_0_7907792228_c  y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; ( delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ,  0.14 ) ; (  0. , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; ( gamma23f_126_03_n y1 y2 y3 y4 y5 y6  1.  sqrt2 lmfun     , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ]
 ;;

let box_ZTGIJCF23_0_0_1_7907792228_c  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2.  ,  2.  ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF23_0_0_1_7907792228_c  y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; ( delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ,  0.14 ) ; (  0. , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; ( gamma23f_126_03_n y1 y2 y3 y4 y5 y6  2.  sqrt2 lmfun     , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ]
 ;;

let box_ZTGIJCF23_1_0_1_7907792228_c  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2.  ,  2.  ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF23_1_0_1_7907792228_c  y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; ( delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ,  0.14 ) ; (  0. , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; ( gamma23f_126_03_n y1 y2 y3 y4 y5 y6  2.  sqrt2 lmfun     , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ]
 ;;

let box_ZTGIJCF23_0_1_1_7907792228_c  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2.  ,  2.  ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF23_0_1_1_7907792228_c  y1 y2 y3 y4 y5 y6  = [ (  0.14  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; ( delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ,  0.14 ) ; (  0. , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ; ( gamma23f_126_03_n y1 y2 y3 y4 y5 y6  2.  sqrt2 lmfun     , 
       a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ]
 ;;

let box_ZTGIJCF23_0_0_0_7907792228_d  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2.  ,  sqrt8  ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_ZTGIJCF23_0_0_0_7907792228_d  y1 y2 y3 y4 y5 y6  = [ ( gamma23f_red_03 y1 y2 y3 y4 y5 y6 sqrt2 lmfun     , 
    a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; ( delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ,  0.14  ) ; (  0.  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; ( delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ,  0.14 ) ; (  0. , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ]
 ;;

let box_ZTGIJCF23_0_0_1_7907792228_d  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2.  ,  sqrt8  ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF23_0_0_1_7907792228_d  y1 y2 y3 y4 y5 y6  = [ ( gamma23f_red_03 y1 y2 y3 y4 y5 y6 sqrt2 lmfun     , 
    a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; ( delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ,  0.14  ) ; (  0.  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; ( delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ,  0.14 ) ; (  0. , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ]
 ;;

let box_ZTGIJCF23_1_0_1_7907792228_d  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2.  ,  sqrt8  ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF23_1_0_1_7907792228_d  y1 y2 y3 y4 y5 y6  = [ ( gamma23f_red_03 y1 y2 y3 y4 y5 y6 sqrt2 lmfun     , 
    a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; ( delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ,  0.14  ) ; (  0.  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; ( delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ,  0.14 ) ; (  0. , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ]
 ;;

let box_ZTGIJCF23_0_1_1_7907792228_d  y1 y2 y3 y4 y5 y6  = [ ( 2. *.   hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2.  ,  sqrt8  ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_ZTGIJCF23_0_1_1_7907792228_d  y1 y2 y3 y4 y5 y6  = [ ( gamma23f_red_03 y1 y2 y3 y4 y5 y6 sqrt2 lmfun     , 
    a_spine5 +.  b_spine5 *.  dih_y y1 y2 y3 y4 y5 y6 ) ; (  2. , y_of_x rad2_x y1 y2 y3 y4 y5 y6  ) ; ( delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ,  0.14  ) ; (  0.  , delta_y y1 y2 sqrt2 sqrt2 sqrt2 y6  ) ; ( delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ,  0.14 ) ; (  0. , delta_y y1 sqrt2 y3 sqrt2 y5 sqrt2  ) ]
 ;;


let box_QITNPEA4_0_0_0_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_QITNPEA4_0_0_0_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   2.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_0_0_1_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA4_0_0_1_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   2.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_0_0_1_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_QITNPEA4_0_0_1_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   3.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_0_1_0_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA4_0_1_0_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   2.  +.   1.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_0_1_0_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_QITNPEA4_0_1_0_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   3.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_0_1_1_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA4_0_1_1_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   3.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_0_1_1_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_QITNPEA4_0_1_1_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   4.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_1_0_0_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA4_1_0_0_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   2.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_1_0_0_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_QITNPEA4_1_0_0_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   3.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_1_0_1_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA4_1_0_1_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   3.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_1_0_1_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_QITNPEA4_1_0_1_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   4.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_1_1_0_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA4_1_1_0_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   3.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_1_1_0_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_QITNPEA4_1_1_0_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   4.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_1_1_1_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA4_1_1_1_0_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   4.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA4_1_1_1_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ; ( 2. *.  hminus , sqrt8 ) ]
 ;;
let obj_QITNPEA4_1_1_1_1_3803737830  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   5.  +.   0.  *.  beta_bump_force_y y1 y2 y3 y4 y5 y6
         -.  0.0105256 +.   0.00522841*. dih_y y1 y2 y3 y4 y5 y6  ,  0.0 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;




let box_QITNPEA1_1_0_9063653052  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2.  , 2. *. hminus ) ; ( 2.  , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA1_1_0_9063653052  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   2.  +.   0.  *. beta_bump_lb
          ,  0.0057 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA1_1_1_9063653052  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , 2. *.  hplus ) ; ( 2. *.  hminus , 2. *.  hplus ) ; ( 2.  , 2. *. hminus ) ; ( 2.  , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA1_1_1_9063653052  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   3.  +.   0.  *. beta_bump_lb
          ,  0.0057 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA1_1_2_9063653052  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hminus , 2. *.  hplus ) ; ( 2. *.  hplus , sqrt8 ) ; ( 2.  , 2. *. hminus ) ; ( 2.  , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA1_1_2_9063653052  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   2.  +.   0.  *. beta_bump_lb
          ,  0.0057 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA1_2_0_9063653052  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hplus , sqrt8 ) ; ( 2. , 2. *.  hminus ) ; ( 2.  , 2. *. hminus ) ; ( 2.  , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA1_2_0_9063653052  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   1.  +.   0.  *. beta_bump_lb
          ,  0.0057 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA1_2_1_9063653052  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hplus , sqrt8 ) ; ( 2. *.  hminus , 2. *.  hplus ) ; ( 2.  , 2. *. hminus ) ; ( 2.  , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA1_2_1_9063653052  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   2.  +.   1.  *. beta_bump_lb
          ,  0.0057 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_QITNPEA1_2_2_9063653052  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  hplus ) ; ( 2.  ,  2. *. hminus ) ; ( 2. *.  hplus , sqrt8 ) ; ( 2. *.  hplus , sqrt8 ) ; ( 2.  , 2. *. hminus ) ; ( 2.  , 2. *.  hminus ) ]
 ;;
let obj_QITNPEA1_2_2_9063653052  y1 y2 y3 y4 y5 y6  = [ ( gamma4f y1 y2 y3 y4 y5 y6 lmfun  /.   1.  +.   0.  *. beta_bump_lb
          ,  0.0057 ) ; ( y_of_x rad2_x y1 y2 y3 y4 y5 y6  ,  2. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_0  y1 y12 y23 y34 y41  = [ ( 2. *.  hminus ,   2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_0  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.129913) +.  (( -. 0.060416)+. (0.01764)+. (0.045166)+. (0.021777))*.  y1 
       +.  2. *.  ((0.002372)+. ( -. 0.002372)) *.  y12 +.  2. *. (( -. 0.002372) +.  (0.002372)) *.  y23 +.  2. *. ((0.002372) +.  ( -. 0.002372)) *.  y34 +.  2. *. 
        (( -. 0.002372)+. (0.002372))*.  y41
      +.  ( -. 0.113134) +.  ( -. 0.198777) +.  ( -. 0.306092) +.  ( -. 0.259166)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_0  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_0  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.060416)*.  y1 
     +. (0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.113134) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_0  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_0  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.01764)*.  y1 
     +. ( -. 0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.198777) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_0  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_0  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.045166)*.  y1 
     +. (0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.306092) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_1  y1 y12 y23 y34 y41  = [ ( 2. *.  hminus ,   2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_1  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.129699) +.  (( -. 0.060316)+. (0.019214)+. (0.021887)+. (0.019214))*.  y1 
       +.  2. *.  ((0.002264)+. ( -. 0.002264)) *.  y12 +.  2. *. (( -. 0.002264) +.  (0.002264)) *.  y23 +.  2. *. ((0.002264) +.  ( -. 0.002264)) *.  y34 +.  2. *. 
        (( -. 0.002264)+. (0.002264))*.  y41
      +.  ( -. 0.112116) +.  ( -. 0.203309) +.  ( -. 0.29619) +.  ( -. 0.203309)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_1  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_1  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129699)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.060316)*.  y1 
     +. (0.002264)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.112116) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_1  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_1  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129699)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.019214)*.  y1 
     +. ( -. 0.002264)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.203309) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_1  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. 2. *.  hminus) /.  2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_1  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129699)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.021887)*.  y1 
     +. (0.002264)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.29619) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_2  y1 y12 y23 y34 y41  = [ ( 2. *.  hminus ,   2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_2  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.129913) +.  (( -. 0.060416)+. (0.021777)+. (0.045166)+. (0.01764))*.  y1 
       +.  2. *.  ((0.002372)+. ( -. 0.002372)) *.  y12 +.  2. *. (( -. 0.002372) +.  (0.002372)) *.  y23 +.  2. *. ((0.002372) +.  ( -. 0.002372)) *.  y34 +.  2. *. 
        (( -. 0.002372)+. (0.002372))*.  y41
      +.  ( -. 0.113134) +.  ( -. 0.259166) +.  ( -. 0.306092) +.  ( -. 0.198777)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_2  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_2  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.060416)*.  y1 
     +. (0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.113134) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_2  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. 2. *.  hminus) /.  2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_2  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.021777)*.  y1 
     +. ( -. 0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.259166) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_2  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_2  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.045166)*.  y1 
     +. (0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.306092) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_3  y1 y12 y23 y34 y41  = [ ( 2. *.  hminus ,   2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_3  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.114872) +.  ((0.133539)+. (0.148605)+. (0.08743)+. (0.148605))*.  y1 
       +.  2. *.  (( -. 0.080919)+. (0.080919)) *.  y12 +.  2. *. ((0.080919) +.  ( -. 0.080919)) *.  y23 +.  2. *. (( -. 0.080919) +.  (0.080919)) *.  y34 +.  2. *. 
        ((0.080919)+. ( -. 0.080919))*.  y41
      +.  (0.532524) +.  ( -. 0.855148) +.  (0.593722) +.  ( -. 0.855148)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_3  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_3  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.114872)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.133539)*.  y1 
     +. ( -. 0.080919)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.532524) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_3  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_3  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.114872)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.148605)*.  y1 
     +. (0.080919)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.855148) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_3  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_3  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.114872)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.08743)*.  y1 
     +. ( -. 0.080919)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.593722) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_4  y1 y12 y23 y34 y41  = [ ( 2. *.  hminus ,   2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_4  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.065103) +.  (( -. 0.008732)+. (0.072591)+. (0.042651)+. (0.055356))*.  y1 
       +.  2. *.  (( -. 0.024884)+. (0.024884)) *.  y12 +.  2. *. ((0.024884) +.  ( -. 0.024884)) *.  y23 +.  2. *. (( -. 0.024884) +.  (0.024884)) *.  y34 +.  2. *. 
        ((0.024884)+. ( -. 0.024884))*.  y41
      +.  (0.097156) +.  ( -. 0.464803) +.  (0.008797) +.  ( -. 0.458108)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_4  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_4  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.008732)*.  y1 
     +. ( -. 0.024884)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.097156) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_4  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_4  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.072591)*.  y1 
     +. (0.024884)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.464803) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_4  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_4  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.042651)*.  y1 
     +. ( -. 0.024884)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.008797) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_5  y1 y12 y23 y34 y41  = [ ( 2. *.  hminus ,   2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_5  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.065103) +.  (( -. 0.029778)+. (0.072591)+. (0.055356)+. (0.072591))*.  y1 
       +.  2. *.  (( -. 0.027449)+. (0.027449)) *.  y12 +.  2. *. ((0.027449) +.  ( -. 0.027449)) *.  y23 +.  2. *. (( -. 0.027449) +.  (0.027449)) *.  y34 +.  2. *. 
        ((0.027449)+. ( -. 0.027449))*.  y41
      +.  (0.170713) +.  ( -. 0.485323) +.  ( -. 0.039438) +.  ( -. 0.485323)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_5  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_5  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.029778)*.  y1 
     +. ( -. 0.027449)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.170713) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_5  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_5  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.072591)*.  y1 
     +. (0.027449)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.485323) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_5  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. 2. *.  hminus) /.  2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_5  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.055356)*.  y1 
     +. ( -. 0.027449)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.039438) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_6  y1 y12 y23 y34 y41  = [ ( 2. *.  hminus ,   2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_6  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.065103) +.  (( -. 0.008732)+. (0.055356)+. (0.072591)+. (0.037947))*.  y1 
       +.  2. *.  ((0.025458)+. ( -. 0.025458)) *.  y12 +.  2. *. (( -. 0.025458) +.  (0.025458)) *.  y23 +.  2. *. ((0.025458) +.  ( -. 0.025458)) *.  y34 +.  2. *. 
        (( -. 0.025458)+. (0.025458))*.  y41
      +.  ( -. 0.30558) +.  ( -. 0.055371) +.  ( -. 0.469389) +.  (0.025236)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_6  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_6  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.008732)*.  y1 
     +. (0.025458)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.30558) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_6  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. 2. *.  hminus) /.  2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_6  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.055356)*.  y1 
     +. ( -. 0.025458)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.055371) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_6  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_6  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.072591)*.  y1 
     +. (0.025458)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.469389) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_7  y1 y12 y23 y34 y41  = [ ( 2. *.  hminus ,   2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_7  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.114872) +.  ((0.116669)+. (0.08743)+. (0.148605)+. (0.08743))*.  y1 
       +.  2. *.  ((0.080919)+. ( -. 0.080919)) *.  y12 +.  2. *. (( -. 0.080919) +.  (0.080919)) *.  y23 +.  2. *. ((0.080919) +.  ( -. 0.080919)) *.  y34 +.  2. *. 
        (( -. 0.080919)+. (0.080919))*.  y41
      +.  ( -. 0.725145) +.  (0.595546) +.  ( -. 0.853324) +.  (0.595546)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_7  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_7  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.114872)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.116669)*.  y1 
     +. (0.080919)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.725145) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_7  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_7  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.114872)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.08743)*.  y1 
     +. ( -. 0.080919)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.595546) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_7  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  hminus ,  2. *.  h0 ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_7  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.114872)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.148605)*.  y1 
     +. (0.080919)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.853324) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_8  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_8  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.129913) +.  (( -. 0.09152)+. (0.347659)+. ( -. 0.105208)+. ( -. 0.150931))*.  y1 
       +.  2. *.  ((0.002372)+. ( -. 0.002372)) *.  y12 +.  2. *. (( -. 0.002372) +.  (0.002372)) *.  y23 +.  2. *. ((0.002372) +.  ( -. 0.002372)) *.  y34 +.  2. *. 
        (( -. 0.002372)+. (0.002372))*.  y41
      +.  ( -. 0.034749) +.  ( -. 1.030425) +.  (0.072849) +.  (0.176057)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_8  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_8  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.09152)*.  y1 
     +. (0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.034749) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_8  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_8  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.347659)*.  y1 
     +. ( -. 0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 1.030425) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_8  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_8  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.105208)*.  y1 
     +. (0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.072849) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_9  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_9  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.129913) +.  ((0.340765)+. ( -. 0.094917)+. ( -. 0.150931)+. ( -. 0.094917))*.  y1 
       +.  2. *.  ((0.002372)+. ( -. 0.002372)) *.  y12 +.  2. *. (( -. 0.002372) +.  (0.002372)) *.  y23 +.  2. *. ((0.002372) +.  ( -. 0.002372)) *.  y34 +.  2. *. 
        (( -. 0.002372)+. (0.002372))*.  y41
      +.  ( -. 1.124108) +.  (0.084866) +.  (0.138108) +.  (0.084866)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_9  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_9  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.340765)*.  y1 
     +. (0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 1.124108) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_9  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_9  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.094917)*.  y1 
     +. ( -. 0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.084866) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_9  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. 2. *.  hminus) /.  2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_9  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.150931)*.  y1 
     +. (0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.138108) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_10  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_10  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.129913) +.  (( -. 0.09152)+. (0.291645)+. ( -. 0.105208)+. ( -. 0.094917))*.  y1 
       +.  2. *.  ((0.002372)+. ( -. 0.002372)) *.  y12 +.  2. *. (( -. 0.002372) +.  (0.002372)) *.  y23 +.  2. *. ((0.002372) +.  ( -. 0.002372)) *.  y34 +.  2. *. 
        (( -. 0.002372)+. (0.002372))*.  y41
      +.  ( -. 0.034749) +.  ( -. 0.939234) +.  (0.072849) +.  (0.084866)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_10  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_10  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.09152)*.  y1 
     +. (0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.034749) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_10  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. 2. *.  hminus) /.  2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_10  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.291645)*.  y1 
     +. ( -. 0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.939234) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_10  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_10  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.129913)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.105208)*.  y1 
     +. (0.002372)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.072849) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_11  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_11  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.128506) +.  ((0.290371)+. ( -. 0.070878)+. ( -. 0.097658)+. ( -. 0.121835))*.  y1 
       +.  2. *.  ((0.003287)+. ( -. 0.003287)) *.  y12 +.  2. *. (( -. 0.003287) +.  (0.003287)) *.  y23 +.  2. *. ((0.003287) +.  ( -. 0.003287)) *.  y34 +.  2. *. 
        (( -. 0.003287)+. (0.003287))*.  y41
      +.  ( -. 1.026581) +.  (0.033394) +.  (0.050047) +.  (0.13571)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_11  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_11  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.128506)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.290371)*.  y1 
     +. (0.003287)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 1.026581) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_11  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_11  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.128506)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.070878)*.  y1 
     +. ( -. 0.003287)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.033394) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_11  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_11  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.128506)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.097658)*.  y1 
     +. (0.003287)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.050047) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_12  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_12  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.128506) +.  ((0.263591)+. ( -. 0.070878)+. ( -. 0.121835)+. ( -. 0.070878))*.  y1 
       +.  2. *.  ((0.003287)+. ( -. 0.003287)) *.  y12 +.  2. *. (( -. 0.003287) +.  (0.003287)) *.  y23 +.  2. *. ((0.003287) +.  ( -. 0.003287)) *.  y34 +.  2. *. 
        (( -. 0.003287)+. (0.003287))*.  y41
      +.  ( -. 0.957343) +.  (0.033394) +.  (0.083125) +.  (0.033394)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_12  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_12  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.128506)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.263591)*.  y1 
     +. (0.003287)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.957343) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_12  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_12  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.128506)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.070878)*.  y1 
     +. ( -. 0.003287)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.033394) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_12  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_12  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.128506)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.121835)*.  y1 
     +. (0.003287)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.083125) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_13  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_13  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.128506) +.  (( -. 0.066254)+. (0.234791)+. ( -. 0.097658)+. ( -. 0.070878))*.  y1 
       +.  2. *.  ((0.003287)+. ( -. 0.003287)) *.  y12 +.  2. *. (( -. 0.003287) +.  (0.003287)) *.  y23 +.  2. *. ((0.003287) +.  ( -. 0.003287)) *.  y34 +.  2. *. 
        (( -. 0.003287)+. (0.003287))*.  y41
      +.  ( -. 0.104563) +.  ( -. 0.786309) +.  (0.050047) +.  (0.033394)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_13  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_13  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.128506)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.066254)*.  y1 
     +. (0.003287)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.104563) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_13  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_13  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.128506)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.234791)*.  y1 
     +. ( -. 0.003287)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.786309) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_13  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_13  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.128506)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.097658)*.  y1 
     +. (0.003287)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.050047) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_14  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_14  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.127166) +.  (( -. 0.07331)+. (0.23984)+. ( -. 0.096981)+. ( -. 0.069548))*.  y1 
       +.  2. *.  ((0.003788)+. ( -. 0.003788)) *.  y12 +.  2. *. (( -. 0.003788) +.  (0.003788)) *.  y23 +.  2. *. ((0.003788) +.  ( -. 0.003788)) *.  y34 +.  2. *. 
        (( -. 0.003788)+. (0.003788))*.  y41
      +.  ( -. 0.105909) +.  ( -. 0.767737) +.  (0.04248) +.  (0.032155)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_14  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2. *.  h0+. 2. *.  hplus) /.  2. , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_14  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.127166)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.07331)*.  y1 
     +. (0.003788)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.105909) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_14  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_14  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.127166)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.23984)*.  y1 
     +. ( -. 0.003788)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.767737) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_14  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_14  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.127166)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.096981)*.  y1 
     +. (0.003788)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.04248) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_15  y1 y12 y23 y34 y41  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_15  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.126777) +.  (( -. 0.053069)+. (0.196466)+. ( -. 0.093532)+. ( -. 0.049865))*.  y1 
       +.  2. *.  ((0.003525)+. ( -. 0.003525)) *.  y12 +.  2. *. (( -. 0.003525) +.  (0.003525)) *.  y23 +.  2. *. ((0.003525) +.  ( -. 0.003525)) *.  y34 +.  2. *. 
        (( -. 0.003525)+. (0.003525))*.  y41
      +.  ( -. 0.142652) +.  ( -. 0.667227) +.  (0.035622) +.  ( -. 0.022307)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_15  y1 y2 y3 y4 y5 y6  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_15  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.126777)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.053069)*.  y1 
     +. (0.003525)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.142652) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_15  y1 y2 y3 y4 y5 y6  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_15  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.126777)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.196466)*.  y1 
     +. ( -. 0.003525)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.667227) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_15  y1 y2 y3 y4 y5 y6  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_15  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.126777)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.093532)*.  y1 
     +. (0.003525)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.035622) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_16  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_16  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.0469) +.  ((0.051237)+. ( -. 0.014413)+. ( -. 0.014413)+. ( -. 0.02241))*.  y1 
       +.  2. *.  ((0.060747)+. ( -. 0.060747)) *.  y12 +.  2. *. (( -. 0.060747) +.  (0.060747)) *.  y23 +.  2. *. ((0.060747) +.  ( -. 0.060747)) *.  y34 +.  2. *. 
        (( -. 0.060747)+. (0.060747))*.  y41
      +.  ( -. 0.530637) +.  (0.594377) +.  ( -. 0.377571) +.  (0.608509)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_16  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_16  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.051237)*.  y1 
     +. (0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.530637) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_16  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_16  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.014413)*.  y1 
     +. ( -. 0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.594377) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_16  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_16  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.014413)*.  y1 
     +. (0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.377571) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_17  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_17  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.0469) +.  ((0.051237)+. ( -. 0.014413)+. ( -. 0.02241)+. ( -. 0.014413))*.  y1 
       +.  2. *.  ((0.060747)+. ( -. 0.060747)) *.  y12 +.  2. *. (( -. 0.060747) +.  (0.060747)) *.  y23 +.  2. *. ((0.060747) +.  ( -. 0.060747)) *.  y34 +.  2. *. 
        (( -. 0.060747)+. (0.060747))*.  y41
      +.  ( -. 0.530636) +.  (0.594377) +.  ( -. 0.36344) +.  (0.594377)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_17  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_17  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.051237)*.  y1 
     +. (0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.530636) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_17  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_17  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.014413)*.  y1 
     +. ( -. 0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.594377) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_17  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_17  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.02241)*.  y1 
     +. (0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.36344) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_18  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_18  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.0469) +.  ((0.051237)+. ( -. 0.02241)+. ( -. 0.014413)+. ( -. 0.014413))*.  y1 
       +.  2. *.  ((0.060747)+. ( -. 0.060747)) *.  y12 +.  2. *. (( -. 0.060747) +.  (0.060747)) *.  y23 +.  2. *. ((0.060747) +.  ( -. 0.060747)) *.  y34 +.  2. *. 
        (( -. 0.060747)+. (0.060747))*.  y41
      +.  ( -. 0.530637) +.  (0.608509) +.  ( -. 0.377571) +.  (0.594377)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_18  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_18  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.051237)*.  y1 
     +. (0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.530637) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_18  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_18  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.02241)*.  y1 
     +. ( -. 0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.608509) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_18  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_18  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.014413)*.  y1 
     +. (0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.377571) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_19  y1 y12 y23 y34 y41  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ,   ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_19  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.036939) +.  ((0.050064)+. ( -. 0.016688)+. ( -. 0.016688)+. ( -. 0.016688))*.  y1 
       +.  2. *.  (( -. 0.057593)+. (0.057593)) *.  y12 +.  2. *. ((0.057593) +.  ( -. 0.057593)) *.  y23 +.  2. *. (( -. 0.057593) +.  ( -. 0.057593)) *.  y34 +.  2. *. 
        (( -. 0.057593)+. ( -. 0.057593))*.  y41
      +.  (0.397884) +.  ( -. 0.362427) +.  (0.559062) +.  (0.559062)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_19  y1 y2 y3 y4 y5 y6  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_19  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.036939)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.050064)*.  y1 
     +. ( -. 0.057593)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.397884) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_19  y1 y2 y3 y4 y5 y6  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_19  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.036939)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.016688)*.  y1 
     +. (0.057593)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.362427) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_19  y1 y2 y3 y4 y5 y6  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_19  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.036939)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.016688)*.  y1 
     +. ( -. 0.057593)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.559062) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_20  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_20  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.049823) +.  ((0.047052)+. ( -. 0.015684)+. ( -. 0.015684)+. ( -. 0.015684))*.  y1 
       +.  2. *.  (( -. 0.061687)+. (0.061687)) *.  y12 +.  2. *. ((0.061687) +.  ( -. 0.061687)) *.  y23 +.  2. *. (( -. 0.061687) +.  (0.061687)) *.  y34 +.  2. *. 
        ((0.061687)+. ( -. 0.061687))*.  y41
      +.  (0.463622) +.  ( -. 0.379191) +.  (0.607807) +.  ( -. 0.379191)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_20  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. , (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_20  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.049823)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.047052)*.  y1 
     +. ( -. 0.061687)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.463622) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_20  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_20  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.049823)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.015684)*.  y1 
     +. (0.061687)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.379191) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_20  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_20  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.049823)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.015684)*.  y1 
     +. ( -. 0.061687)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.607807) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_21  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_21  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.053582) +.  ((0.049452)+. ( -. 0.013853)+. ( -. 0.020791)+. ( -. 0.013853))*.  y1 
       +.  2. *.  (( -. 0.06302)+. (0.06302)) *.  y12 +.  2. *. ((0.06302) +.  ( -. 0.06302)) *.  y23 +.  2. *. (( -. 0.06302) +.  ( -. 0.062897)) *.  y34 +.  2. *. 
        (( -. 0.062897)+. ( -. 0.06302))*.  y41
      +.  (0.475514) +.  ( -. 0.389234) +.  (0.637132) +.  (0.618101)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_21  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_21  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.053582)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.049452)*.  y1 
     +. ( -. 0.06302)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.475514) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_21  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_21  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.053582)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.013853)*.  y1 
     +. (0.06302)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.389234) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_21  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_21  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.053582)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.020791)*.  y1 
     +. ( -. 0.06302)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.637132) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_22  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_22  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.066935) +.  ((0.079693)+. ( -. 0.021495)+. ( -. 0.021495)+. ( -. 0.036704))*.  y1 
       +.  2. *.  ((0.066241)+. ( -. 0.066241)) *.  y12 +.  2. *. (( -. 0.066241) +.  (0.066241)) *.  y23 +.  2. *. ((0.066241) +.  ( -. 0.066241)) *.  y34 +.  2. *. 
        (( -. 0.066241)+. (0.066241))*.  y41
      +.  ( -. 0.605497) +.  (0.685308) +.  ( -. 0.374549) +.  (0.715304)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_22  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_22  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.066935)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.079693)*.  y1 
     +. (0.066241)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.605497) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_22  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_22  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.066935)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.021495)*.  y1 
     +. ( -. 0.066241)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.685308) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_22  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_22  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.066935)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.021495)*.  y1 
     +. (0.066241)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.374549) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_23  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_23  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.066935) +.  ((0.028887)+. ( -. 0.021495)+. (0.014102)+. ( -. 0.021495))*.  y1 
       +.  2. *.  ((0.066241)+. ( -. 0.066241)) *.  y12 +.  2. *. (( -. 0.066241) +.  (0.066241)) *.  y23 +.  2. *. ((0.066241) +.  ( -. 0.066241)) *.  y34 +.  2. *. 
        (( -. 0.066241)+. (0.066241))*.  y41
      +.  ( -. 0.477466) +.  (0.685308) +.  ( -. 0.472584) +.  (0.685308)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_23  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_23  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.066935)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.028887)*.  y1 
     +. (0.066241)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.477466) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_23  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_23  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.066935)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.021495)*.  y1 
     +. ( -. 0.066241)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.685308) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_23  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_23  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.066935)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.014102)*.  y1 
     +. (0.066241)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.472584) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_24  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_24  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.066935) +.  ((0.028887)+. (0.014102)+. ( -. 0.021495)+. ( -. 0.021495))*.  y1 
       +.  2. *.  (( -. 0.066241)+. (0.066241)) *.  y12 +.  2. *. ((0.066241) +.  ( -. 0.066241)) *.  y23 +.  2. *. (( -. 0.066241) +.  (0.066241)) *.  y34 +.  2. *. 
        ((0.066241)+. ( -. 0.066241))*.  y41
      +.  (0.582391) +.  ( -. 0.472584) +.  (0.685308) +.  ( -. 0.374549)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_24  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_24  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.066935)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.028887)*.  y1 
     +. ( -. 0.066241)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.582391) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_24  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_24  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.066935)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.014102)*.  y1 
     +. (0.066241)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.472584) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_24  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_24  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.066935)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.021495)*.  y1 
     +. ( -. 0.066241)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.685308) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_25  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ,   (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_25  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.070081) +.  ((0.043025)+. ( -. 0.014342)+. ( -. 0.014342)+. ( -. 0.014342))*.  y1 
       +.  2. *.  ((0.06775)+. ( -. 0.06775)) *.  y12 +.  2. *. (( -. 0.06775) +.  (0.06775)) *.  y23 +.  2. *. ((0.06775) +.  ( -. 0.06775)) *.  y34 +.  2. *. 
        (( -. 0.06775)+. (0.06775))*.  y41
      +.  ( -. 0.520998) +.  (0.681778) +.  ( -. 0.402228) +.  (0.681778)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_25  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2. *.  h0+. 2. *.  hplus) /.  2. , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_25  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.070081)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.043025)*.  y1 
     +. (0.06775)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.520998) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_25  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_25  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.070081)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.014342)*.  y1 
     +. ( -. 0.06775)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.681778) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_25  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_25  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.070081)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.014342)*.  y1 
     +. (0.06775)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.402228) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_26  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_26  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.074623) +.  ((0.079355)+. ( -. 0.023711)+. ( -. 0.023711)+. ( -. 0.031932))*.  y1 
       +.  2. *.  ((0.068595)+. ( -. 0.068595)) *.  y12 +.  2. *. (( -. 0.068595) +.  (0.068595)) *.  y23 +.  2. *. ((0.068595) +.  ( -. 0.068595)) *.  y34 +.  2. *. 
        (( -. 0.068595)+. (0.068595))*.  y41
      +.  ( -. 0.608613) +.  (0.719631) +.  ( -. 0.37789) +.  (0.735738)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_26  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2. *.  h0+. 2. *.  hplus) /.  2. , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_26  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.074623)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.079355)*.  y1 
     +. (0.068595)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.608613) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_26  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_26  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.074623)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.023711)*.  y1 
     +. ( -. 0.068595)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.719631) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_26  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_26  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.074623)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.023711)*.  y1 
     +. (0.068595)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.37789) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_27  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_27  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.074623) +.  ((0.019702)+. ( -. 0.023711)+. ( -. 0.031932)+. (0.035942))*.  y1 
       +.  2. *.  (( -. 0.081204)+. (0.081204)) *.  y12 +.  2. *. ((0.081204) +.  ( -. 0.081204)) *.  y23 +.  2. *. (( -. 0.081204) +.  (0.081204)) *.  y34 +.  2. *. 
        ((0.081204)+. ( -. 0.081204))*.  y41
      +.  (0.740105) +.  ( -. 0.47876) +.  (0.836608) +.  ( -. 0.629086)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_27  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2. *.  h0+. 2. *.  hplus) /.  2. , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_27  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.074623)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.019702)*.  y1 
     +. ( -. 0.081204)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.740105) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_27  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_27  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.074623)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.023711)*.  y1 
     +. (0.081204)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.47876) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_27  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_27  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.074623)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.031932)*.  y1 
     +. ( -. 0.081204)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.836608) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_28  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_28  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.074623) +.  ((0.019702)+. ( -. 0.031932)+. ( -. 0.023711)+. (0.035942))*.  y1 
       +.  2. *.  (( -. 0.068595)+. (0.068595)) *.  y12 +.  2. *. ((0.068595) +.  ( -. 0.068595)) *.  y23 +.  2. *. (( -. 0.068595) +.  (0.068595)) *.  y34 +.  2. *. 
        ((0.068595)+. ( -. 0.068595))*.  y41
      +.  (0.639237) +.  ( -. 0.361784) +.  (0.719631) +.  ( -. 0.528217)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_28  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2. *.  h0+. 2. *.  hplus) /.  2. , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_28  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.074623)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.019702)*.  y1 
     +. ( -. 0.068595)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.639237) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_28  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_28  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.074623)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.031932)*.  y1 
     +. (0.068595)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.361784) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_28  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_28  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.074623)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.023711)*.  y1 
     +. ( -. 0.068595)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.719631) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_29  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2.) /.  2. ,   (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_29  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.090009) +.  ((0.04151)+. ( -. 0.013837)+. ( -. 0.013837)+. ( -. 0.013837))*.  y1 
       +.  2. *.  ((0.073665)+. ( -. 0.073665)) *.  y12 +.  2. *. (( -. 0.073665) +.  (0.073665)) *.  y23 +.  2. *. ((0.073665) +.  ( -. 0.073665)) *.  y34 +.  2. *. 
        (( -. 0.073665)+. (0.073665))*.  y41
      +.  ( -. 0.523458) +.  (0.755879) +.  ( -. 0.422755) +.  (0.755879)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_29  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2.) /.  2. ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_29  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.090009)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.04151)*.  y1 
     +. (0.073665)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.523458) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_29  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2.) /.  2. ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_29  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.090009)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.013837)*.  y1 
     +. ( -. 0.073665)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.755879) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_29  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2.) /.  2. ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_29  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.090009)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.013837)*.  y1 
     +. (0.073665)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.422755) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_30  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   (2. *.  h0+. (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_30  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.17025) +.  ((0.094709)+. ( -. 0.021455)+. (0.009749)+. ( -. 0.021455))*.  y1 
       +.  2. *.  ((0.098535)+. ( -. 0.098535)) *.  y12 +.  2. *. (( -. 0.098535) +.  (0.098535)) *.  y23 +.  2. *. ((0.098535) +.  ( -. 0.098535)) *.  y34 +.  2. *. 
        (( -. 0.098535)+. (0.098535))*.  y41
      +.  ( -. 0.692034) +.  (1.087114) +.  ( -. 0.568591) +.  (1.087114)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_30  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. , 2. *.  hplus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_30  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.17025)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.094709)*.  y1 
     +. (0.098535)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.692034) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_30  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_30  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.17025)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.021455)*.  y1 
     +. ( -. 0.098535)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (1.087114) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_30  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_30  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.17025)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.009749)*.  y1 
     +. (0.098535)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.568591) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_31  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_31  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.172166) +.  ((0.09973)+. (0.014169)+. ( -. 0.017353)+. (0.014169))*.  y1 
       +.  2. *.  (( -. 0.099785)+. (0.099785)) *.  y12 +.  2. *. ((0.099785) +.  ( -. 0.099785)) *.  y23 +.  2. *. (( -. 0.099785) +.  (0.099785)) *.  y34 +.  2. *. 
        ((0.099785)+. ( -. 0.099785))*.  y41
      +.  (0.882284) +.  ( -. 0.586728) +.  (1.0903) +.  ( -. 0.586728)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_31  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2. *.  h0+. 2. *.  hplus) /.  2. , ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_31  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.172166)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.09973)*.  y1 
     +. ( -. 0.099785)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.882284) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_31  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_31  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.172166)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.014169)*.  y1 
     +. (0.099785)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.586728) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_31  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. (2. *.  h0+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_31  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.172166)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.017353)*.  y1 
     +. ( -. 0.099785)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (1.0903) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_32  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_32  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.084789) +.  ((0.039845)+. ( -. 0.013282)+. ( -. 0.013282)+. ( -. 0.013282))*.  y1 
       +.  2. *.  (( -. 0.071708)+. ( -. 0.071708)) *.  y12 +.  2. *. (( -. 0.071708) +.  ( -. 0.071708)) *.  y23 +.  2. *. (( -. 0.071708) +.  (0.071708)) *.  y34 +.  2. *. 
        ((0.071708)+. ( -. 0.071708))*.  y41
      +.  (0.632521) +.  (0.731624) +.  (0.731624) +.  ( -. 0.415701)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_32  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  h0 , (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_32  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.084789)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.039845)*.  y1 
     +. ( -. 0.071708)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.632521) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_32  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_32  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.084789)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.013282)*.  y1 
     +. ( -. 0.071708)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.731624) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_32  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  (2. *.  h0+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_32  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.084789)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.013282)*.  y1 
     +. ( -. 0.071708)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.731624) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_33  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_33  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.065103) +.  (( -. 0.052337)+. (0.23854)+. ( -. 0.073933)+. ( -. 0.11227))*.  y1 
       +.  2. *.  (( -. 0.02292)+. (0.02292)) *.  y12 +.  2. *. ((0.02292) +.  ( -. 0.02292)) *.  y23 +.  2. *. (( -. 0.02292) +.  (0.02292)) *.  y34 +.  2. *. 
        ((0.02292)+. ( -. 0.02292))*.  y41
      +.  (0.191326) +.  ( -. 0.867278) +.  (0.286871) +.  ( -. 0.019974)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_33  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_33  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.052337)*.  y1 
     +. ( -. 0.02292)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.191326) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_33  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_33  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.23854)*.  y1 
     +. (0.02292)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.867278) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_33  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_33  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.073933)*.  y1 
     +. ( -. 0.02292)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.286871) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_34  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_34  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.065103) +.  (( -. 0.052337)+. (0.23854)+. ( -. 0.11227)+. ( -. 0.073933))*.  y1 
       +.  2. *.  ((0.02292)+. ( -. 0.02292)) *.  y12 +.  2. *. (( -. 0.02292) +.  (0.02292)) *.  y23 +.  2. *. ((0.02292) +.  ( -. 0.02292)) *.  y34 +.  2. *. 
        (( -. 0.02292)+. (0.02292))*.  y41
      +.  ( -. 0.17539) +.  ( -. 0.500562) +.  ( -. 0.019974) +.  (0.286871)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_34  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_34  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.052337)*.  y1 
     +. (0.02292)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.17539) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_34  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_34  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.23854)*.  y1 
     +. ( -. 0.02292)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.500562) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_34  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. 2. *.  hminus) /.  2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_34  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.11227)*.  y1 
     +. (0.02292)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.019974) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_35  y1 y12 y23 y34 y41  = [ ( 2. *.  h0 ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_35  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.065103) +.  (( -. 0.052337)+. ( -. 0.11227)+. (0.23854)+. ( -. 0.073933))*.  y1 
       +.  2. *.  ((0.02292)+. ( -. 0.02292)) *.  y12 +.  2. *. (( -. 0.02292) +.  (0.02292)) *.  y23 +.  2. *. ((0.02292) +.  ( -. 0.02292)) *.  y34 +.  2. *. 
        (( -. 0.02292)+. (0.02292))*.  y41
      +.  ( -. 0.175391) +.  (0.346743) +.  ( -. 0.867278) +.  (0.286871)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_35  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_35  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.052337)*.  y1 
     +. (0.02292)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.175391) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_35  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. 2. *.  hminus) /.  2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_35  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.11227)*.  y1 
     +. ( -. 0.02292)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.346743) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_35  y1 y2 y3 y4 y5 y6  = [ ( 2. *.  h0 ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_35  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.065103)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.23854)*.  y1 
     +. (0.02292)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.867278) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_36  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_36  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.062681) +.  (( -. 0.026929)+. ( -. 0.06441)+. (0.176245)+. ( -. 0.084906))*.  y1 
       +.  2. *.  ((0.023742)+. ( -. 0.023742)) *.  y12 +.  2. *. (( -. 0.023742) +.  (0.023742)) *.  y23 +.  2. *. ((0.023742) +.  ( -. 0.023742)) *.  y34 +.  2. *. 
        (( -. 0.023742)+. (0.023742))*.  y41
      +.  ( -. 0.242815) +.  (0.273568) +.  ( -. 0.72849) +.  (0.3039)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_36  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_36  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.062681)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.026929)*.  y1 
     +. (0.023742)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.242815) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_36  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_36  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.062681)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.06441)*.  y1 
     +. ( -. 0.023742)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.273568) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_36  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_36  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.062681)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.176245)*.  y1 
     +. (0.023742)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.72849) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_37  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_37  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.062681) +.  (( -. 0.026929)+. (0.176245)+. ( -. 0.084906)+. ( -. 0.06441))*.  y1 
       +.  2. *.  ((0.023742)+. ( -. 0.023742)) *.  y12 +.  2. *. (( -. 0.023742) +.  (0.023742)) *.  y23 +.  2. *. ((0.023742) +.  ( -. 0.023742)) *.  y34 +.  2. *. 
        (( -. 0.023742)+. (0.023742))*.  y41
      +.  ( -. 0.242815) +.  ( -. 0.348621) +.  ( -. 0.075969) +.  (0.273568)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_37  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_37  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.062681)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.026929)*.  y1 
     +. (0.023742)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.242815) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_37  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_37  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.062681)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.176245)*.  y1 
     +. ( -. 0.023742)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.348621) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_37  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_37  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.062681)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.084906)*.  y1 
     +. (0.023742)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.075969) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_38  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_38  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.062681) +.  (( -. 0.026929)+. ( -. 0.084906)+. (0.176245)+. ( -. 0.06441))*.  y1 
       +.  2. *.  ((0.023742)+. ( -. 0.023742)) *.  y12 +.  2. *. (( -. 0.023742) +.  (0.023742)) *.  y23 +.  2. *. ((0.023742) +.  ( -. 0.023742)) *.  y34 +.  2. *. 
        (( -. 0.023742)+. (0.023742))*.  y41
      +.  ( -. 0.242815) +.  (0.3039) +.  ( -. 0.72849) +.  (0.273568)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_38  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_38  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.062681)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.026929)*.  y1 
     +. (0.023742)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.242815) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_38  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. , (2.+. 2. *.  hminus) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_38  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.062681)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.084906)*.  y1 
     +. ( -. 0.023742)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.3039) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_38  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_38  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.062681)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.176245)*.  y1 
     +. (0.023742)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.72849) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_39  y1 y12 y23 y34 y41  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ,   2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_39  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  (0.061714) +.  (( -. 0.014502)+. (0.134266)+. ( -. 0.059882)+. ( -. 0.059882))*.  y1 
       +.  2. *.  (( -. 0.02407)+. (0.02407)) *.  y12 +.  2. *. ((0.02407) +.  ( -. 0.02407)) *.  y23 +.  2. *. (( -. 0.02407) +.  ( -. 0.02407)) *.  y34 +.  2. *. 
        (( -. 0.02407)+. ( -. 0.02407))*.  y41
      +.  (0.104941) +.  ( -. 0.631477) +.  (0.261947) +.  (0.261947)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_39  y1 y2 y3 y4 y5 y6  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_39  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.061714)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.014502)*.  y1 
     +. ( -. 0.02407)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.104941) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_39  y1 y2 y3 y4 y5 y6  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_39  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.061714)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.134266)*.  y1 
     +. (0.02407)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.631477) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_39  y1 y2 y3 y4 y5 y6  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ,  2. *.  hplus ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_39  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. (0.061714)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.059882)*.  y1 
     +. ( -. 0.02407)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.261947) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_40  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_40  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.0469) +.  ((0.051237)+. ( -. 0.014413)+. ( -. 0.014413)+. ( -. 0.02241))*.  y1 
       +.  2. *.  ((0.060747)+. ( -. 0.060747)) *.  y12 +.  2. *. (( -. 0.060747) +.  (0.060747)) *.  y23 +.  2. *. ((0.060747) +.  ( -. 0.060747)) *.  y34 +.  2. *. 
        (( -. 0.060747)+. (0.060747))*.  y41
      +.  ( -. 0.530637) +.  (0.594377) +.  ( -. 0.377571) +.  (0.608509)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_40  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_40  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.051237)*.  y1 
     +. (0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.530637) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_40  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_40  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.014413)*.  y1 
     +. ( -. 0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.594377) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_40  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_40  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.014413)*.  y1 
     +. (0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.377571) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_41  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_41  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.0469) +.  ((0.051237)+. ( -. 0.014413)+. ( -. 0.02241)+. ( -. 0.014413))*.  y1 
       +.  2. *.  (( -. 0.073427)+. (0.073427)) *.  y12 +.  2. *. ((0.073427) +.  ( -. 0.073427)) *.  y23 +.  2. *. (( -. 0.073427) +.  (0.073427)) *.  y34 +.  2. *. 
        ((0.073427)+. ( -. 0.073427))*.  y41
      +.  (0.542756) +.  ( -. 0.479016) +.  (0.709954) +.  ( -. 0.479016)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_41  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_41  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.051237)*.  y1 
     +. ( -. 0.073427)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.542756) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_41  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_41  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.014413)*.  y1 
     +. (0.073427)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.479016) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_41  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_41  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.02241)*.  y1 
     +. ( -. 0.073427)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.709954) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_42  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_42  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.0469) +.  ((0.051237)+. ( -. 0.02241)+. ( -. 0.014413)+. ( -. 0.014413))*.  y1 
       +.  2. *.  (( -. 0.060747)+. (0.060747)) *.  y12 +.  2. *. ((0.060747) +.  ( -. 0.060747)) *.  y23 +.  2. *. (( -. 0.060747) +.  (0.060747)) *.  y34 +.  2. *. 
        ((0.060747)+. ( -. 0.060747))*.  y41
      +.  (0.441312) +.  ( -. 0.36344) +.  (0.594377) +.  ( -. 0.377571)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_42  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_42  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.051237)*.  y1 
     +. ( -. 0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.441312) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_42  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. , (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_42  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.02241)*.  y1 
     +. (0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.36344) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_42  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_42  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.0469)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.014413)*.  y1 
     +. ( -. 0.060747)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.594377) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_43  y1 y12 y23 y34 y41  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ,   ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_43  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.036939) +.  ((0.050064)+. ( -. 0.016688)+. ( -. 0.016688)+. ( -. 0.016688))*.  y1 
       +.  2. *.  ((0.057593)+. ( -. 0.057593)) *.  y12 +.  2. *. (( -. 0.057593) +.  (0.057593)) *.  y23 +.  2. *. ((0.057593) +.  ( -. 0.057593)) *.  y34 +.  2. *. 
        (( -. 0.057593)+. (0.057593))*.  y41
      +.  ( -. 0.523604) +.  (0.559062) +.  ( -. 0.362427) +.  (0.559062)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_43  y1 y2 y3 y4 y5 y6  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_43  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.036939)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.050064)*.  y1 
     +. (0.057593)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.523604) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_43  y1 y2 y3 y4 y5 y6  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_43  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.036939)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.016688)*.  y1 
     +. ( -. 0.057593)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.559062) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_43  y1 y2 y3 y4 y5 y6  = [ ( ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_43  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.036939)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. ( -. 0.016688)*.  y1 
     +. (0.057593)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.362427) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_0_44  y1 y12 y23 y34 y41  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,   ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ; ( 2. ,  2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_0_44  y1 y12 y23 y34 y41  = [ (  0. , 2. *.  pi *.  ( -. 0.177145) +.  ((0.151334)+. (0.041584)+. (0.00995)+. (0.041584))*.  y1 
       +.  2. *.  (( -. 0.103308)+. (0.103308)) *.  y12 +.  2. *. ((0.103308) +.  ( -. 0.103308)) *.  y23 +.  2. *. (( -. 0.103308) +.  (0.103308)) *.  y34 +.  2. *. 
        ((0.103308)+. ( -. 0.103308))*.  y41
      +.  (0.774954) +.  ( -. 0.677721) +.  (1.057518) +.  ( -. 0.677721)   ) ]
 ;;

let box_OXLZLEZ_6346351218_1_44  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. *.  hminus , 2. *.  h0 ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_1_44  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  2. +.  1. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.177145)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.151334)*.  y1 
     +. ( -. 0.103308)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (0.774954) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_2_44  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_2_44  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.177145)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.041584)*.  y1 
     +. (0.103308)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. ( -. 0.677721) ,  0. ) ]
 ;;

let box_OXLZLEZ_6346351218_3_44  y1 y2 y3 y4 y5 y6  = [ ( (2. *.  h0+. 2. *.  hplus) /.  2. ,  ((2. *.  h0+. 2. *.  hplus) /.  2.+. ((2. *.  h0+. 2. *.  hplus) /.  2.+. 2. *.  hplus) /.  2.) /.  2. ) ; ( 2.  ,  2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ; ( 2. , (2.+. (2.+. (2.+. 2. *.  hminus) /.  2.) /.  2.) /.  2. ) ; ( 2. , 2. *.  hminus ) ; ( 2. , 2. *.  hminus ) ]
 ;;
let obj_OXLZLEZ_6346351218_3_44  y1 y2 y3 y4 y5 y6  = [ ( gamma4fgcy y1 y2 y3 y4 y5 y6 lmfun  /.  1. +.  0. *. beta_bump_force_y y1 y2 y3 y4 y5 y6 
     +. ( -. 0.177145)*.  dih_y y1 y2 y3 y4 y5 y6  
     +. (0.00995)*.  y1 
     +. ( -. 0.103308)*.  (y2 +.  y3 +.  y5 +.  y6)
     +. (1.057518) ,  0. ) ]
 ;;

let box_181212899_0  y1  y2  y3  y4  y5  y6  = [ ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.52 ,  sqrt8 ) ; ( 2.0 ,  2.52 ) ; ( 2.52 ,  sqrt8 ) ]
 ;;
let obj_181212899_0  y1  y2  y3  y4  y5  y6  = [ ( dih_y y1 y2 y3 y4 y5 y6  -.  1.448  -.  
(0.266 *.  (y1  -.  2.0)) +.  
(0.295 *.  (y2  -.  2.0)) +.  
(0.57 *.  (y3  -.  2.0))  -.  
(0.745 *.  (y4  -.  2.52)) +.  
(0.268 *.  (y5  -.  2.0)) +.  
(0.385 *.  (y6  -.  2.52))  ,  0.0 ) ]
 ;;

let box_181212899_1  y1  y2  y3  y4  y5  y6  = [ ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.52 ,  sqrt8 ) ; ( 2.52 ,  sqrt8 ) ; ( 2.0 ,  2.52 ) ]
 ;;
let obj_181212899_1  y1  y2  y3  y4  y5  y6  = [ ( dih_y y1 y2 y3 y4 y5 y6  -.  1.448  -.  
(0.266 *.  (y1  -.  2.0)) +.  
(0.295 *.  (y3  -.  2.0)) +.  
(0.57 *.  (y2  -.  2.0))  -.  
(0.745 *.  (y4  -.  2.52)) +.  
(0.268 *.  (y6  -.  2.0)) +.  
(0.385 *.  (y5  -.  2.52))  ,  0.0 ) ]
 ;;

let box_181212899_2  y1  y2  y3  y4  y5  y6  = [ ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( sqrt8 ,  sqrt8 ) ; ( 2.0 ,  2.52 ) ; ( 2.52 ,  sqrt8 ) ]
 ;;
let obj_181212899_2  y1  y2  y3  y4  y5  y6  = [ ( dih_y y1 y2 y3 y4 y5 y6  -.  1.448  -.  
(0.266 *.  (y1  -.  2.0)) +.  
(0.295 *.  (y2  -.  2.0)) +.  
(0.57 *.  (y3  -.  2.0))  -.  
(0.745 *.  (sqrt8  -.  2.52)) +.  
(0.268 *.  (y5  -.  2.0)) +.  
(0.385 *.  (y6  -.  2.52))  ,  0.0 ) ]
 ;;

let box_181212899_3  y1  y2  y3  y4  y5  y6  = [ ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( sqrt8 ,  sqrt8 ) ; ( 2.52 ,  sqrt8 ) ; ( 2.0 ,  2.52 ) ]
 ;;
let obj_181212899_3  y1  y2  y3  y4  y5  y6  = [ ( dih_y y1 y2 y3 y4 y5 y6  -.  1.448  -.  
(0.266 *.  (y1  -.  2.0)) +.  
(0.295 *.  (y3  -.  2.0)) +.  
(0.57 *.  (y2  -.  2.0))  -.  
(0.745 *.  (sqrt8  -.  2.52)) +.  
(0.268 *.  (y6  -.  2.0)) +.  
(0.385 *.  (y5  -.  2.52))  ,  0.0 ) ]
 ;;

let box_181212899_4  y1  y2  y3  y4  y5  y6  = [ ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.52 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.52 ,  sqrt8 ) ]
 ;;
let obj_181212899_4  y1  y2  y3  y4  y5  y6  = [ ( dih_y y1 y2 y3 y4 y5 y6  -.  1.448  -.  
(0.266 *.  (y1  -.  2.0)) +.  
(0.295 *.  (y2  -.  2.0)) +.  
(0.57 *.  (y3  -.  2.0))  -.  
(0.745 *.  (2.52  -.  2.52)) +.  
(0.268 *.  (y5  -.  2.0)) +.  
(0.385 *.  (y6  -.  2.52))  ,  0.0 ) ]
 ;;

let box_181212899_5  y1  y2  y3  y4  y5  y6  = [ ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.0 ,  2.52 ) ; ( 2.52 ,  2.52 ) ; ( 2.52 ,  sqrt8 ) ; ( 2.0 ,  2.52 ) ]
 ;;
let obj_181212899_5  y1  y2  y3  y4  y5  y6  = [ ( dih_y y1 y2 y3 y4 y5 y6  -.  1.448  -.  
(0.266 *.  (y1  -.  2.0)) +.  
(0.295 *.  (y3  -.  2.0)) +.  
(0.57 *.  (y2  -.  2.0))  -.  
(0.745 *.  (2.52  -.  2.52)) +.  
(0.268 *.  (y6  -.  2.0)) +.  
(0.385 *.  (y5  -.  2.52))  ,  0.0 ) ]
 ;;

let box_2151506422 y1 y2 y3 y4 y5 y6   = apex_std3_hll y1 y2 y3 y4 y5 y6  ;;
let obj_2151506422 y1 y2 y3 y4 y5 y6   = [ (  1. *.  dih_y y1 y2 y3 y4 y5 y6  ,  1.2777
      +.  0.281 *.  (y1  -.  2.18) +.   -.  0.278364 *. (y2 -.  2.) +.   -.  0.278364 *.  (y3  -.  2.) +. 
          0.7117 *.  (y4  -.  2.) +.   -.  0.34336 *. (y5 -.  2.) +.   -.  0.34336 *.  (y6  -.  2.) ) ]
 ;;

let box_6836427086 y1 y2 y3 y4 y5 y6   = apex_std3_hll y1 y2 y3 y4 y5 y6  ;;
let obj_6836427086 y1 y2 y3 y4 y5 y6   = [ (   -.  1. *.  dih_y y1 y2 y3 y4 y5 y6  ,   -.  1.27799
      +.   -.  0.356217 *.  (y1  -.  2.18) +.  0.229466 *. (y2 -.  2.) +.  0.229466 *.  (y3  -.  2.) +. 
           -.  0.949067 *.  (y4  -.  2.) +.  0.172726 *. (y5 -.  2.) +.  0.172726 *.  (y6  -.  2.) ) ]
 ;;

let box_3636849632 y1 y2 y3 y4 y5 y6   = apex_std3_hll y1 y2 y3 y4 y5 y6  ;;
let obj_3636849632 y1 y2 y3 y4 y5 y6   = [ (  1. *.  taum y1 y2 y3 y4 y5 y6  ,  0.0345
      +.  0.185545 *.  (y1  -.  2.18) +.  0.193139 *. (y2 -.  2.) +.  0.193139 *.  (y3  -.  2.) +. 
          0.170148 *.  (y4  -.  2.) +.  0.13195 *. (y5 -.  2.) +.  0.13195 *.  (y6  -.  2.) ) ]
 ;;

let box_5298513205 y1 y2 y3 y4 y5 y6   = apex_std3_hll y1 y2 y3 y4 y5 y6  ;;
let obj_5298513205 y1 y2 y3 y4 y5 y6   = [ (  1. *.  dih2_y y1 y2 y3 y4 y5 y6  ,  1.185
      +.   -.  0.302913 *.  (y1  -.  2.18) +.  0.214849 *. (y2 -.  2.) +.   -.  0.163775 *.  (y3  -.  2.) +. 
           -.  0.443449 *.  (y4  -.  2.) +.  0.67364 *. (y5 -.  2.) +.   -.  0.314532 *.  (y6  -.  2.) ) ]
 ;;

let box_7743522046 y1 y2 y3 y4 y5 y6   = apex_std3_hll y1 y2 y3 y4 y5 y6  ;;
let obj_7743522046 y1 y2 y3 y4 y5 y6   = [ (   -.  1. *.  dih2_y y1 y2 y3 y4 y5 y6  ,   -.  1.1865
      +.  0.20758 *.  (y1  -.  2.18) +.   -.  0.236153 *. (y2 -.  2.) +.  0.14172 *.  (y3  -.  2.) +. 
          0.263834 *.  (y4  -.  2.) +.   -.  0.771203 *. (y5 -.  2.) +.  0.0457292 *.  (y6  -.  2.) ) ]
 ;;

let box_8657368829 y1 y2 y3 y4 y5 y6   = apex_std3_small_hll y1 y2 y3 y4 y5 y6  ;;
let obj_8657368829 y1 y2 y3 y4 y5 y6   = [ (  1. *.  dih_y y1 y2 y3 y4 y5 y6  ,  1.277
      +.  0.273298 *.  (y1  -.  2.18) +.   -.  0.273853 *. (y2 -.  2.) +.   -.  0.273853 *.  (y3  -.  2.) +. 
          0.708818 *.  (y4  -.  2.) +.   -.  0.313988 *. (y5 -.  2.) +.   -.  0.313988 *.  (y6  -.  2.) ) ]
 ;;

let box_6619134733 y1 y2 y3 y4 y5 y6   = apex_std3_small_hll y1 y2 y3 y4 y5 y6  ;;
let obj_6619134733 y1 y2 y3 y4 y5 y6   = [ (   -.  1. *.  dih_y y1 y2 y3 y4 y5 y6  ,   -.  1.27799
      +.   -.  0.439002 *.  (y1  -.  2.18) +.  0.229466 *. (y2 -.  2.) +.  0.229466 *.  (y3  -.  2.) +. 
           -.  0.771733 *.  (y4  -.  2.) +.  0.208429 *. (y5 -.  2.) +.  0.208429 *.  (y6  -.  2.) ) ]
 ;;

let box_1284543870 y1 y2 y3 y4 y5 y6   = apex_std3_small_hll y1 y2 y3 y4 y5 y6  ;;
let obj_1284543870 y1 y2 y3 y4 y5 y6   = [ (  1. *.  dih2_y y1 y2 y3 y4 y5 y6  ,  1.185
      +.   -.  0.372262 *.  (y1  -.  2.18) +.  0.214849 *. (y2 -.  2.) +.   -.  0.163775 *.  (y3  -.  2.) +. 
           -.  0.293508 *.  (y4  -.  2.) +.  0.656172 *. (y5 -.  2.) +.   -.  0.267157 *.  (y6  -.  2.) ) ]
 ;;

let box_4041673283 y1 y2 y3 y4 y5 y6   = apex_std3_small_hll y1 y2 y3 y4 y5 y6  ;;
let obj_4041673283 y1 y2 y3 y4 y5 y6   = [ (   -.  1. *.  dih2_y y1 y2 y3 y4 y5 y6  ,   -.  1.1864
      +.  0.20758 *.  (y1  -.  2.18) +.   -.  0.236153 *. (y2 -.  2.) +.  0.14172 *.  (y3  -.  2.) +. 
          0.263109 *.  (y4  -.  2.) +.   -.  0.737003 *. (y5 -.  2.) +.  0.12047 *.  (y6  -.  2.) ) ]
 ;;

let box_3872614111 y1 y2 y3 y4 y5 y6   = dart_mll_w y1 y2 y3 y4 y5 y6  ;;
let obj_3872614111 y1 y2 y3 y4 y5 y6   = [ (   -.  1. *.  dih_y y1 y2 y3 y4 y5 y6  ,   -.  1.542
      +.   -.  0.362519 *.  (y1  -.  2.36) +.  0.298691 *. (y2 -.  2.) +.  0.287065 *.  (y3  -.  2.) +. 
           -.  0.920785 *.  (y4  -.  2.25) +.  0.190917 *. (y5 -.  2.) +.  0.219132 *.  (y6  -.  2.) ) ]
 ;;

let box_3139693500 y1 y2 y3 y4 y5 y6   = dart_mll_n y1 y2 y3 y4 y5 y6  ;;
let obj_3139693500 y1 y2 y3 y4 y5 y6   = [ (   -.  1. *.  dih_y y1 y2 y3 y4 y5 y6  ,   -.  1.542
      +.   -.  0.346773 *.  (y1  -.  2.36) +.  0.300751 *. (y2 -.  2.) +.  0.300751 *.  (y3  -.  2.) +. 
           -.  0.702567 *.  (y4  -.  2.25) +.  0.172726 *. (y5 -.  2.) +.  0.172727 *.  (y6  -.  2.) ) ]
 ;;

let box_4841020453 y1 y2 y3 y4 y5 y6   = dart_Hll_n y1 y2 y3 y4 y5 y6  ;;
let obj_4841020453 y1 y2 y3 y4 y5 y6   = [ (   -.  1. *.  dih_y y1 y2 y3 y4 y5 y6  ,   -.  1.542
      +.   -.  0.490439 *.  (y1  -.  2.36) +.  0.318125 *. (y2 -.  2.) +.  0.32468 *.  (y3  -.  2.) +. 
           -.  0.740079 *.  (y4  -.  2.25) +.  0.178868 *. (y5 -.  2.) +.  0.205819 *.  (y6  -.  2.) ) ]
 ;;

let box_9925287433 y1 y2 y3 y4 y5 y6   = dart_Hll_w y1 y2 y3 y4 y5 y6  ;;
let obj_9925287433 y1 y2 y3 y4 y5 y6   = [ (   -.  1. *.  dih_y y1 y2 y3 y4 y5 y6  ,   -.  1.542
      +.   -.  0.490439 *.  (y1  -.  2.36) +.  0.321849 *. (y2 -.  2.) +.  0.320956 *.  (y3  -.  2.) +. 
           -.  1.00902 *.  (y4  -.  2.25) +.  0.240709 *. (y5 -.  2.) +.  0.218081 *.  (y6  -.  2.) ) ]
 ;;

let box_7409690040 y1 y2 y3 y4 y5 y6   = dart_mll_w y1 y2 y3 y4 y5 y6  ;;
let obj_7409690040 y1 y2 y3 y4 y5 y6   = [ (  1. *.  dih2_y y1 y2 y3 y4 y5 y6  ,  1.0494
      +.   -.  0.297823 *.  (y1  -.  2.36) +.  0.215328 *. (y2 -.  2.) +.   -.  0.0792439 *.  (y3  -.  2.) +. 
           -.  0.422674 *.  (y4  -.  2.25) +.  0.647416 *. (y5 -.  2.) +.   -.  0.207561 *.  (y6  -.  2.) ) ]
 ;;

let box_4002562507 y1 y2 y3 y4 y5 y6   = dart_mll_n y1 y2 y3 y4 y5 y6  ;;
let obj_4002562507 y1 y2 y3 y4 y5 y6   = [ (  1. *.  dih2_y y1 y2 y3 y4 y5 y6  ,  1.0494
      +.   -.  0.29013 *.  (y1  -.  2.36) +.  0.215328 *. (y2 -.  2.) +.   -.  0.0715511 *.  (y3  -.  2.) +. 
           -.  0.267157 *.  (y4  -.  2.25) +.  0.650269 *. (y5 -.  2.) +.   -.  0.295198 *.  (y6  -.  2.) ) ]
 ;;

let box_5835568093 y1 y2 y3 y4 y5 y6   = dart_Hll_n y1 y2 y3 y4 y5 y6  ;;
let obj_5835568093 y1 y2 y3 y4 y5 y6   = [ (  1. *.  dih2_y y1 y2 y3 y4 y5 y6  ,  1.0494
      +.   -.  0.404131 *.  (y1  -.  2.36) +.  0.212119 *. (y2 -.  2.) +.   -.  0.0402827 *.  (y3  -.  2.) +. 
           -.  0.299046 *.  (y4  -.  2.25) +.  0.643273 *. (y5 -.  2.) +.   -.  0.266118 *.  (y6  -.  2.) ) ]
 ;;

let box_1894886027 y1 y2 y3 y4 y5 y6   = dart_Hll_w y1 y2 y3 y4 y5 y6  ;;
let obj_1894886027 y1 y2 y3 y4 y5 y6   = [ (  1. *.  dih2_y y1 y2 y3 y4 y5 y6  ,  1.0494
      +.   -.  0.401543 *.  (y1  -.  2.36) +.  0.207551 *. (y2 -.  2.) +.   -.  0.0294227 *.  (y3  -.  2.) +. 
           -.  0.494954 *.  (y4  -.  2.25) +.  0.605453 *. (y5 -.  2.) +.   -.  0.156385 *.  (y6  -.  2.) ) ]
 ;;

