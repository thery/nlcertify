Require Import sos_horner.
From Bignums Require Import BigQ.
Require Import QArith.
(*****)
Require Import OrderedRing Bool Reals. 
Require Import ssreflect ssrbool.
Import OrderedRingSyntax.
(*
Require Import Reals.
Variable req: R -> R -> Prop.
Variable Reqe : (ring_eq_ext Rplus Rmult Ropp req).
*)


Definition C := bigQ.
Definition cO:=0%bigQ.
Definition cI := 1%bigQ.
Definition cplus := BigQ.add.
Definition ctimes := BigQ.mul.
Definition cminus := BigQ.sub.
Definition copp := BigQ.opp.
Definition ceq := BigQ.eq.
Definition ceqb := BigQ.eqb.
Definition csquare a := BigQ.power a 2.
Definition clt := BigQ.lt.
Definition cle := BigQ.le.
Definition cmin := BigQ.min.
Definition cmax := BigQ.max.
Definition cinv := BigQ.inv.
Definition cdiv := BigQ.div.
Definition bigQleq_bool n m :=
  match BigQ.compare n m with Gt => false | _ => true end.
Definition bigQlt_bool n m :=
  match BigQ.compare n m with Lt => true | _ => false end.
Definition cleb := bigQleq_bool.
Notation "x [=] y" := (ceqb x y).
Notation "x [<=] y" := (cleb x y).

Definition cneqb (x y : C) := negb (ceqb x y).
Definition cltb (x y : C) := (cleb x y) && (cneqb x y).

Notation "x [~=] y" := (cneqb x y).
Notation "x [<] y" := (cltb x y).
Definition lt_total := BigQ.lt_total.
Definition cmin_l := BigQ.min_l. Definition cmin_r := BigQ.min_r. 
Ltac corder := bigQ_order.

Local Open Scope bigQ.
Lemma csquare_aux i : csquare i == ctimes i  i.
Proof. by rewrite /csquare /ctimes; ring. Qed.

Lemma cring c1 c2 : c1 == c2 + cminus c1 c2.
Proof. by rewrite /cminus; ring. Qed.

Local Open Scope R_scope.

Definition IQR  := 
  fun x : bigQ => (IZR (Qnum (BigQ.to_Q x)) * / 
                     IPR (Qden (BigQ.to_Q x)))%R.

Lemma IPR_neq0 a : IPR a <> 0.
Proof.
by rewrite -INR_IPR; have := pos_INR_nat_of_P a; auto with real.
Qed.

Lemma mult_IPR a b : IPR (a * b) = IPR a * IPR b.
Proof.
by repeat rewrite -INR_IPR; rewrite Pos2Nat.inj_mul; rewrite mult_INR.
Qed.

Require Import Realslemmas.

(*Require Import QArith.*)

Lemma cminus0_aux (c : C) :  ceq (cminus c c) 0.
Proof. unfold cminus, ceq, cO. ring. Qed.

Lemma cminus0_aux2 c : ceq (cminus c cO) c.
Proof. unfold cminus, ceq, cO; ring. Qed.

Lemma cplus0_aux c : c + cO == c.
Proof. unfold cplus, ceq, cO; ring. Qed.

Lemma cleq_aux c : cle c c.
Proof. bigQ_order. Qed.

Lemma cleq_aux2 c1 c2 : c1 [<=] c2 <-> cle c1 c2.
Proof.
unfold cleb, cle.
unfold bigQleq_bool.
rewrite BigQ.spec_compare.
apply QArith_base.Qle_bool_iff.
Qed.


Lemma ceq_eqb c1 c2 : c1 [=] c2 <-> (c1 == c2)%bigQ.
Proof. apply BigQ.eqb_eq. Qed.

Lemma cneq_neqb c1 c2 : c1 [~=] c2 <-> c1 != c2.
Proof.
unfold cneqb.
split => H.
- unfold ceqb, BigQ.eqb in H. rewrite BigQ.spec_eq_bool in H.
- apply Qeq_bool_neq; by apply negbTE.
- apply introN with (P:= (c1[=]c2)). by apply idP. by rewrite ceq_eqb. 
Qed.

Lemma cneqb_symm c1 c2 : c1 [~=] c2 -> c2 [~=] c1.
Proof. rewrite cneq_neqb. rewrite cneq_neqb. by apply Qnot_eq_sym. Qed.

Lemma cneqb_trans (c1 c2 : C) : c1 [~=] c2 -> cO [~=] (cminus c1 c2).
Proof. 
  do 2 rewrite cneq_neqb. move => b1 b2. 
  apply b1. 
  rewrite (cring c1 c2). 
  by rewrite -b2 cplus0_aux. 
Qed.

Lemma IQR_plus : forall x y, IQR (x + y) = IQR x + IQR y.
Proof.
  move => x y.
  have  /IZR_eq := BigQ.spec_add x y.
  repeat (rewrite (mult_IZR, plus_IZR)).
  repeat rewrite [IZR (Z.pos _)]/IZR /= /IQR.
  rewrite mult_IPR => H.
  by field [H]; repeat split; apply: IPR_neq0.
  Qed.

Lemma IQR_opp : forall x, IQR (- x) = - IQR x.
Proof.
  move => x.
  have  /IZR_eq := BigQ.spec_opp x.
  repeat (rewrite (mult_IZR, plus_IZR)).
  repeat rewrite [IZR (Z.pos _)]/IZR.
  rewrite /= /IQR /= opp_IZR => H.
  by field [H]; repeat split; apply: IPR_neq0.
Qed.

Lemma IQR_minus : forall x y, IQR (x - y) = IQR x - IQR y.
Proof.
  intros.
  unfold Qminus.
  rewrite IQR_plus.
  rewrite IQR_opp.
  ring.
Qed.

Lemma IQR_mult : forall x y, IQR (x * y) = IQR x * IQR y.
Proof.
  move => x y.
  have  /IZR_eq := BigQ.spec_mul x y.
  repeat rewrite mult_IZR.
  repeat rewrite [IZR (Z.pos _)]/IZR /= /IQR.
  rewrite mult_IPR => H.
  by field [H]; repeat split; apply: IPR_neq0.
Qed.

Lemma IQR_le : forall (x y : bigQ), (x [<=] y) -> IQR x <= IQR y.
Proof.
  move => x y H.
  have -> : IQR x = IZR (Qnum [x]) * IPR (Qden [y]) * 
                  (/ IPR (Qden [x]) * / IPR (Qden [y])).
    by rewrite /IQR; field; split; apply: IPR_neq0.
  have -> : IQR y = IZR (Qnum [y]) * IPR (Qden [x]) * 
                  (/ IPR (Qden [x]) * / IPR (Qden [y])).
    by rewrite /IQR; field; split; apply: IPR_neq0.
  apply: Rmult_le_compat_r.
    by apply Rmult_le_pos; apply: Rlt_le; apply: Rinv_0_lt_compat;
       rewrite -INR_IPR; apply: pos_INR_nat_of_P.
  have /IZR_le : ([x] <= [y])%Q.
    apply/Qle_alt.
    move: H; rewrite /cleb /bigQleq_bool /IQR.
    by have -> := BigQ.spec_compare x y;  case: (_ ?= _)%Q.
  by repeat rewrite mult_IZR; rewrite [IZR (Z.pos _)]/IZR.
Qed.

Lemma spec_eqb_toQ (x y : bigQ) : x [=] y -> Qeq_bool [x]%bigQ [y]%bigQ.
Proof. 
 move => H.
 apply ceq_eqb in H.
 apply Qeq_bool_iff.
 by [].
Qed.

Lemma spec_neqb_toQ (x y : bigQ) : 
  x [~=] y -> Qeq_bool [x]%bigQ [y]%bigQ = false.
Proof. 
 move => H.
 unfold cneqb, ceqb, BigQ.eqb in H.
 rewrite -BigQ.spec_eq_bool. by apply negbTE.
Qed.

Lemma Qeq_true : forall x y,  Qeq_bool [x] [y] ->  IQR x = IQR y.
Proof.
  move=> x y /Qeq_bool_eq /IZR_eq.
  rewrite !mult_IZR ![IZR (Z.pos _)]/IZR => H.
  by rewrite /IQR; field [H]; split; apply: IPR_neq0.
Qed.

Lemma IQR_eq : forall (x y : bigQ), (x [=] y) -> IQR x = IQR y.
Proof.
 move => x y H. apply spec_eqb_toQ in H.
 by apply Qeq_true.
Qed.

Lemma IQR_le0_square i : 0 <= IQR (csquare i).
Proof.
 have -> : IQR (csquare i) = IQR(ctimes i i).
   apply IQR_eq.
   by rewrite csquare_aux /ctimes /ceqb /BigQ.eqb /BigQ.eq_bool ceq_eqb.
 rewrite IQR_mult.
 by apply Rle_0_sqr.
Qed.

Lemma cltb_lt c1 c2 : c1 [<] c2 <-> clt c1 c2.
Proof.
split.
- unfold cltb. move/andP => [h1 h2]. move : h1 h2. 
  rewrite cleq_aux2 cneq_neqb; by bigQ_order.
- unfold cltb. move => h; apply /andP. split; move : h.
  + by rewrite cleq_aux2; bigQ_order.
  + by rewrite cneq_neqb; bigQ_order.
Qed.

Lemma Qeq_false :
  forall x y, Qeq_bool[x]%bigQ [y]%bigQ  = false -> IQR x <> IQR y.
Proof.
  move=> x y /Qeq_bool_neq H H1.
  case: H.
  apply: eq_IZR.
  rewrite !mult_IZR ![IZR (Z.pos _)]/IZR.
  have ->: IZR (Qnum [x]) = (IZR (Qnum [x]) / IPR (Qden [x])) * IPR (Qden [x]).
    by field; apply: IPR_neq0.
  by rewrite [_ / _]H1 /IQR; field; apply: IPR_neq0.
Qed.

Lemma IQR_neq (x y : bigQ) : (x [~=] y) -> IQR x <> IQR y.
Proof.
 move => H. apply spec_neqb_toQ in H.
 by apply Qeq_false.
Qed.

Lemma IQR_lt (x y : bigQ) : x [<] y -> IQR x < IQR y.
Proof. 
 move/andP => [h1 h2].
 have : IQR x <> IQR y by apply IQR_neq.
 have : IQR x <= IQR y by apply IQR_le.
 apply rorder.
Qed.

(*
Lemma IQR_inv (x : BigQ) : 
*)


Lemma IQR_0 : IQR 0 = 0.
Proof. by apply: Rinv_1. Qed.

Lemma IQR_1 : IQR 1 = 1.
Proof. by apply Rinv_1. Qed.

Lemma IQR_0_1 : IQR (0 # 1) = 0.
Proof. by apply Rinv_1. Qed.

Lemma IQR_1_1 : IQR (1 # 1) = 1.
Proof. by apply Rinv_1. Qed.

Lemma IQR_minus1_1 : IQR (- 1 # 1) = -1.
Proof. by apply Rinv_1. Qed.

Lemma IQR_inv x : (cO [~=] x) -> IQR (cinv x) =  / IQR x.
Proof.
  move => hlt.
  have neq : IQR x <> 0.
    by rewrite -IQR_0; apply/IQR_neq/cneqb_symm.
  suff /Rinv_elim<- // : IQR (cinv x) * IQR x = 1 => //; first by ring.
  rewrite -IQR_mult /cinv.
  have : cinv x *  x == 1%bigQ.
    rewrite /cinv; field.
    by apply/cneq_neqb/cneqb_symm.
  rewrite /cinv => H. 
  rewrite -IQR_1.
  apply IQR_eq.
  by rewrite ceq_eqb.
Qed.

Lemma IQR_div x y : (cO [~=] y) ->  IQR (cdiv x y) = IQR x / IQR y.
Proof. by move => h; rewrite IQR_mult IQR_inv. Qed.

Lemma ring_aux1 q1 r q2  q:  (q1 * r - q * q1) * q2 = (r - q) * (q1 * q2).
Proof. by ring. Qed.

Lemma IQR_scale r m M : m [<] M -> r =
   (IQR (cinv (cminus M m)) * r - IQR (ctimes m (cinv (cminus M m)))) *
   IQR (cminus M m) + IQR m.
Proof. 
  move/andP => [_ hneq].
  rewrite /cinv /cminus IQR_mult ring_aux1 IQR_inv.
    field.
    by rewrite -IQR_0; apply /IQR_neq/cneqb_symm; apply/cneqb_trans/cneqb_symm.
  by apply/cneqb_trans/cneqb_symm.
Qed.

Lemma r6 r r1 : 0 < r -> 0 <= r * r1 -> 0 <= r1.
Proof.
move=> gtr0 gep0.
have -> : r1 = /r * (r * r1) by field; auto with real.
apply: Rmult_le_pos => //.
by apply/Rlt_le/Rinv_0_lt_compat.
Qed.

Lemma r7 x : 1 + -1 * x = 1 - x.
Proof. by ring. Qed.

Module Type IQRSig.
  Parameter opaque_IQR : bigQ -> R.
  Axiom opaque_IQREdef : opaque_IQR = IQR.
End IQRSig.

Module IQRDef : IQRSig.
  Definition opaque_IQR : bigQ -> R := IQR.
  Definition opaque_IQREdef := refl_equal IQR.
End IQRDef.

Export IQRDef.

Lemma opaque_IQR_1 : opaque_IQR 1 = 1%R.
Proof. now rewrite opaque_IQREdef IQR_1. Qed.

Lemma opaque_IQR_0 : opaque_IQR 0 = 0%R.
Proof. now rewrite opaque_IQREdef IQR_0. Qed.


Lemma R_morph_bigQ :
  ring_morph
    R0 R1 Rplus Rmult Rminus Ropp (@eq R)
    0%bigQ 1%bigQ BigQ.add BigQ.mul BigQ.sub BigQ.opp BigQ.eq_bool 
    opaque_IQR.
Proof.  
 rewrite opaque_IQREdef.
 constructor.
 by apply IQR_0.
 by apply IQR_1.
 by apply IQR_plus.
 by apply IQR_minus.
 by apply IQR_mult.
 by apply IQR_opp.
 by apply IQR_eq.
Qed.

Add Field RField : Rfield
   (morphism  R_morph_bigQ,
     constants [Qcst]).

Lemma var_scale (m M : bigQ) (x y : R) : 
  (cO [<] (M - m)%bigQ) -> 
  0 <= y - opaque_IQR(m) -> 0 <= opaque_IQR(M) - y ->  
  y = (opaque_IQR(M) - opaque_IQR(m))*x + opaque_IQR(m) -> 
  x + IQR (0 # 1) >= 0 /\ IQR (-1 # 1) * x + IQR (1 # 1) >= 0.
(* (0 <= x /\ 0 <= 1 - x).*)
Proof.
  rewrite opaque_IQREdef IQR_0_1 Rplus_0_r => bnd ylo yup h.
  rewrite h in ylo, yup.
  have Mn_gt0 : 0 < IQR (M - m) by rewrite <- IQR_0; apply/(IQR_lt)/bnd.
  split; apply Rle_ge.
    apply: (@r6 (IQR (M - m))) => //.
    suff -> : IQR (M - m) * x = (IQR M - IQR m) * x + IQR m - IQR m by [].
    by rewrite IQR_minus; ring.
  rewrite IQR_minus1_1 IQR_1_1 Rplus_comm r7.
  apply (r6 (IQR (M - m))) => //.
  suff -> : IQR (M - m) * (1 - x) = IQR M - ((IQR M - IQR m) * x + IQR m) by [].
  by rewrite IQR_minus; ring.
Qed.
