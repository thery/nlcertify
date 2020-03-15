Require Import Reals.
Lemma pi4 : PI = (4 * (PI / 4))%R. 
Proof. field. Qed.

Set Implicit Arguments.
 Require Import Interval_tactic.
Require Export BigQ.
Notation "n # d" := (n # d)%bigQ.
Require Import sos_horner remainder fsa.
Definition PEX := sos_horner.PEX bigQ.
Require Import seq.
Require Import Iqr.
Require Import ssreflect ssrbool.

Ltac simpl_Q2R :=
  unfold IQR;
  rewrite <- ?Fcore_Raux.Z2R_IZR ;
  simpl Fcore_Raux.Z2R.

Definition bnds : seq PExpr := [::PEadd (((PEX 1))) (PEc ((0#1)));PEadd (PEmul (PEc ((-1#1))) ((PEX 1))) (PEc ((1#1)));PEadd (((PEX 2))) (PEc ((0#1)));PEadd (PEmul (PEc ((-1#1))) ((PEX 2))) (PEc ((1#1)))].
Definition hyps : seq PExpr := [::].
Definition obj := PEadd (PEmul (PEadd (PEmul (PEc ((8705940511106311#9007199254740992))) ((PEX 1))) (PEadd (PEmul (PEc ((-6914326819331745#2251799813685248))) ((PEX 2))) (PEc ((362767612577757073577#186773283746309210112))))) ((PEX 1))) (PEadd (PEmul (PEadd (PEmul (PEc ((647549294214519#2251799813685248))) ((PEX 2))) (PEc ((-13714447065872114021#31128880624384868352)))) ((PEX 2))) (PEc ((322246888176995669468400719#387293081176346778088243200)))).
Definition obj_bound := (5046503236798422810312333956220704517805624127#14427791579676672000000000000000000000000000000).
Definition obj0 := PEsub obj (PEc obj_bound).
Definition cert := mk_cert_pop (PX (PX (PX (Pc ((-10481767546517574162321#1000000000000000000000000000000))) 1 (PX (Pc ((-1628608119937960037833#200000000000000000000000000000))) 1 (Pc ((-340487312567017032110889569633#8388608000000000000000000000000000000))))) 1 (PX (PX (Pc ((-47439440506970800139779#1000000000000000000000000000000))) 1 (Pc ((115100710933041907601952239799#2097152000000000000000000000000000000)))) 1 (Pc ((5284728182471662178293827504426641#173946175488000000000000000000000000000000))))) 1 (PX (PX (PX (Pc ((-5372087402725645600293#1000000000000000000000000000000))) 1 (Pc ((79463581368943182502024668303#2097152000000000000000000000000000000)))) 1 (Pc ((103918532374745672787768642466679#5798205849600000000000000000000000000000)))) 1 (Pc ((353370695863673468267016556771#16777216000000000000000000000000000000))))) ([::(0#1);(1623487593#10000000000);(3597675013#10000000000);(0#1);(4118314531#10000000000);(845112117#200000000);(0#1);(197277049#1000000000);(1721369073#2000000000);(0#1);(669104497#2500000000);(12545958019#5000000000);(978483559#10000000000);(474958073#400000000);(3946530063#2000000000)]) ([::([::(0, PX (Pc ((95372633#250000000))) 1 (PX (Pc ((6536377783#10000000000))) 1 (Pc ((81702837#125000000))))) ;(1, PX (Pc ((-3710080857#5000000000))) 1 (PX (Pc ((-128211157#625000000))) 1 (Pc ((797780577#1250000000))))) ;(2, PX (Pc ((-1102500749#2000000000))) 1 (PX (Pc ((3642375999#5000000000))) 1 (Pc ((-2033758269#5000000000)))))], 0) ;([::(3, PX (Pc ((-3815046139#10000000000))) 1 (PX (Pc ((-6536277879#10000000000))) 1 (Pc ((-261449787#400000000))))) ;(4, PX (Pc ((9069900349#10000000000))) 1 (PX (Pc ((-501445099#1250000000))) 1 (Pc ((-320574453#2500000000))))) ;(5, PX (Pc ((445977201#2500000000))) 1 (PX (Pc ((6417511317#10000000000))) 1 (Pc ((-1864691963#2500000000)))))], 1) ;([::(6, PX (Pc ((23843383#62500000))) 1 (PX (Pc ((6536304943#10000000000))) 1 (Pc ((6536278813#10000000000))))) ;(7, PX (Pc ((-1257268007#2000000000))) 1 (PX (Pc ((-3349614077#10000000000))) 1 (Pc ((7018690369#10000000000))))) ;(8, PX (Pc ((-847128901#1250000000))) 1 (PX (Pc ((6786516281#10000000000))) 1 (Pc ((-2831085443#10000000000)))))], 2) ;([::(9, PX (Pc ((238443947#625000000))) 1 (PX (Pc ((6536262739#10000000000))) 1 (Pc ((3268113269#5000000000))))) ;(10, PX (Pc ((-9083174249#10000000000))) 1 (PX (Pc ((334753383#2500000000))) 1 (Pc ((31701597#80000000))))) ;(11, PX (Pc ((-428728753#2500000000))) 1 (PX (Pc ((186219481#250000000))) 1 (Pc ((-3223924407#5000000000)))))], 3) ;([::(12, PX (Pc ((24619317#312500000))) 1 (PX (Pc ((2245904271#10000000000))) 1 (Pc ((1214079233#1250000000))))) ;(13, PX (Pc ((760089893#1250000000))) 1 (PX (Pc ((-3914402077#5000000000))) 1 (Pc ((329268147#2500000000))))) ;(14, PX (Pc ((7899632729#10000000000))) 1 (PX (Pc ((11604437#20000000))) 1 (Pc ((-396487741#2000000000)))))], 4)]).

Variable x1 x2 : R.
Definition env (n: positive) := match n with | 1%positive => x1 | 2%positive => x2 | _ => 0%R end.



Lemma R_morph_bigQ :
  ring_morph
    R0 R1 Rplus Rmult Rminus Ropp (@eq R)
    0%bigQ 1%bigQ BigQ.add BigQ.mul BigQ.sub BigQ.opp BigQ.eq_bool 
    IQR.
Proof.  
 constructor.
 by apply IQR_0.
 by apply IQR_1.
 by apply IQR_plus.
 by apply IQR_minus.
 by apply IQR_mult.
 by apply IQR_opp.
 by apply IQR_eq.
Qed.

Ltac Qcst t :=
  match t with
  | IQR ?u => constr:u
  | _ => constr:InitialRing.NotConstant
  end.

Add Field RField : Rfield
   (morphism  R_morph_bigQ,
     constants [Qcst]).

Open Local Scope R_scope.
Lemma correctobj: conj_PExpr_nonneg env (bnds ++ hyps) ->  0 <= eval_expr env obj0.
move => Conj. apply Putinar_Psatz_correct with (hyps:=hyps) (bnds:=bnds) (eig_pos := eigs cert) (r:=remainder cert) (summands:=sos cert). by done. by vm_compute. Qed.


Lemma pexpr_reif : - IQR (68787566775937 # 140737488355328) *
   (IQR (11 # 8) * x1 - IQR (3 # 2) + IQR (3 # 4) * x2 - IQR (3 # 1)) *
   (IQR (11 # 8) * x1 - IQR (3 # 2) + IQR (3 # 4) * x2 - IQR (3 # 1)) -
   IQR (104740403727667521893 # 23346660468288651264) *
   (IQR (11 # 8) * x1 - IQR (3 # 2) + IQR (3 # 4) * x2 - IQR (3 # 1)) -
   IQR (145294742556168586619925337 # 15491723247053871123529728) +
   ((IQR (11 # 8) * x1 - IQR (3 # 2) - IQR (3 # 4) * x2 + IQR (3 # 1)) *
    (IQR (11 # 8) * x1 - IQR (3 # 2) - IQR (3 # 4) * x2 + IQR (3 # 1)) -
    IQR (3 # 2) * (IQR (11 # 8) * x1 - IQR (3 # 2)) +
    IQR (5 # 2) * (IQR (3 # 4) * x2 - IQR (3 # 1)) + 
    IQR (1 # 1) + IQR (192 # 100)) - IQR (obj_bound)

 = eval_expr env obj0.
simpl. unfold Env.nth, env, obj. by ring. Qed.


Lemma mc_proof x : IQR(-9#2) <= x <= IQR(-19#8) ->
- IQR(68787566775937#140737488355328) * x * x - IQR(104740403727667521893#23346660468288651264) * x - IQR(145294742556168586619925337#15491723247053871123529728)
 <= sin x.
simpl_Q2R.
intros H.
destruct (Rle_or_lt (-2) x).
- assert (H1 := conj H0 (proj2 H)).
  clear -H1.
  Time by interval with (i_bisect x).
- rewrite <- (Ropp_involutive (sin x)), <- neg_sin.
  rewrite pi4.
  rewrite <- atan_1.
Time interval with (i_bisect_taylor x 2, i_prec 50).
Qed.

Lemma mc_correct : 0 <= x1 <= 1 -> 0 <= x2 <= 1 -> 0 <= sin( IQR(11#8)* x1 -IQR(3#2) + IQR(3#4)* x2 -IQR(3#1)  ) + ((IQR(11#8) * x1 -IQR(3#2) - IQR(3#4)* x2 +IQR(3#1))*(IQR(11#8)* x1 -IQR(3#2) - IQR(3#4)* x2 +IQR(3#1))   -IQR(3#2) * (IQR(11#8)*x1 -IQR(3#2))+ IQR(5#2) * (IQR(3#4)*x2 -IQR(3#1)) + IQR(1#1) + IQR(192#100)) - IQR (obj_bound).
Proof.
move => H1 H2.
pose z :=  IQR(11#8)* x1 -IQR(3#2) + IQR(3#4)* x2 -IQR(3#1) . 
have : IQR(-9#2) <= z <= IQR(-19#8).
- unfold z. simpl_Q2R. split; interval. move => Hz.
move : (mc_proof Hz) => Hmaxplus.
apply RIneq.Rle_trans with (r2:=  - IQR (68787566775937 # 140737488355328) * z * z -
             IQR (104740403727667521893 # 23346660468288651264) * z -
             IQR (145294742556168586619925337 # 15491723247053871123529728) + ((IQR (11 # 8) * x1 - IQR (3 # 2) - IQR (3 # 4) * x2 + IQR (3 # 1)) *
    (IQR (11 # 8) * x1 - IQR (3 # 2) - IQR (3 # 4) * x2 + IQR (3 # 1)) -
    IQR (3 # 2) * (IQR (11 # 8) * x1 - IQR (3 # 2)) +
    IQR (5 # 2) * (IQR (3 # 4) * x2 - IQR (3 # 1)) + 
    IQR (1 # 1) + IQR (192 # 100)) - IQR(obj_bound) ). rewrite pexpr_reif. apply correctobj. move : H1 H2 => [C1le C1ge] [C2le C2ge]. + split. by apply xge0_reif with (x:=x1). + split. by apply xle1_reif with (x:=x1). + split. by apply xge0_reif with (x:=x2). + split. by apply xle1_reif with (x:=x2). by done.
-  apply Rplus_le_compat_r.  by apply Rplus_le_compat_r.
Qed.

Lemma mc_ok : 0 <= x1 <= 1 -> 0 <= x2 <= 1 -> 0 <=  sin (11 * / 8 * x1 - 3 * / 2 + 3 * / 4 * x2 - 3 * / 1) +
   ((11 * / 8 * x1 - 3 * / 2 - 3 * / 4 * x2 + 3 * / 1) *
    (11 * / 8 * x1 - 3 * / 2 - 3 * / 4 * x2 + 3 * / 1) -
    3 * / 2 * (11 * / 8 * x1 - 3 * / 2) + 5 * / 2 * (3 * / 4 * x2 - 3 * / 1) +
    1 * / 1 + 192 * / 100).
Proof.
move => H1 H2.
- apply RIneq.Rle_trans with (r2 := IQR(obj_bound)). rewrite -IQR_0. by apply IQR_le. 
- apply Rge_le. apply Rminus_ge. apply Rle_ge. 
have <- :  sin( IQR(11#8)* x1 -IQR(3#2) + IQR(3#4)* x2 -IQR(3#1)  ) + ((IQR(11#8) * x1 -IQR(3#2) - IQR(3#4)* x2 +IQR(3#1))*(IQR(11#8)* x1 -IQR(3#2) - IQR(3#4)* x2 +IQR(3#1))   -IQR(3#2) * (IQR(11#8)*x1 -IQR(3#2))+ IQR(5#2) * (IQR(3#4)*x2 -IQR(3#1)) + IQR(1#1) + IQR(192#100)) =  sin (11 * / 8 * x1 - 3 * / 2 + 3 * / 4 * x2 - 3 * / 1) +
   ((11 * / 8 * x1 - 3 * / 2 - 3 * / 4 * x2 + 3 * / 1) *
    (11 * / 8 * x1 - 3 * / 2 - 3 * / 4 * x2 + 3 * / 1) -
    3 * / 2 * (11 * / 8 * x1 - 3 * / 2) + 5 * / 2 * (3 * / 4 * x2 - 3 * / 1) +
    1 * / 1 + 192 * / 100).
by simpl_Q2R. by apply mc_correct.
Qed.