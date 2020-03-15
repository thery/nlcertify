Require Import sos_horner.
Require Import BigQ QArith.
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
Proof. unfold csquare, ctimes. by ring. Qed.
Lemma cring c1 c2 : c1 == c2 + cminus c1 c2.
Proof. unfold cminus. ring. Qed.

Local Open Scope R_scope.
Definition IQR  := fun x : bigQ => (IZR (Qnum (BigQ.to_Q x)) * / IZR (' Qden (BigQ.to_Q x)))%R.

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
Proof. do 2 rewrite cneq_neqb. move => b1 b2. apply b1. rewrite (cring c1 c2). by rewrite -b2 cplus0_aux. 
Qed.

Lemma IQR_plus : forall x y, IQR (x + y) = IQR x + IQR y.
Proof.
  move => x y.
  unfold IQR.
  have h : IZR (Qnum [x + y]%bigQ) * IZR (' Qden ( ([x]%bigQ + [y]%bigQ)%Q ))  = IZR (Qnum ( ([x]%bigQ + [y]%bigQ)%Q )) * IZR (' Qden [x + y]%bigQ).
  repeat rewrite -mult_IZR. apply IZR_eq. by apply BigQ.spec_add.
  have -> :  IZR (Qnum [x + y]%bigQ) * / IZR (' Qden [x + y]%bigQ) = IZR (Qnum ([x]%bigQ + [y]%bigQ)%Q   ) * / IZR (' Qden ([x]%bigQ + [y]%bigQ)%Q). apply raux6impl.
  simpl; repeat INR_nat_of_P; by apply Rlt_neq.
  simpl; repeat INR_nat_of_P; by apply Rlt_neq. by [].
  simpl in *.
  rewrite plus_IZR. rewrite mult_IZR.
  simpl.  
  rewrite Pos2Nat.inj_mul.
  rewrite mult_INR.
  rewrite mult_IZR.
  simpl.
  repeat INR_nat_of_P.
  intros. field.
  split ; apply Rlt_neq; auto.
  Qed.

Lemma IQR_opp : forall x, IQR (- x) = - IQR x.
Proof.
move => x.
unfold IQR. 
have -> : ([-x]%bigQ = -[x]%bigQ)%Q by rewrite BigQ.strong_spec_opp.
rewrite opp_IZR /=; ring.
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
  unfold IQR ; intros.
  simpl.
  repeat rewrite mult_IZR.
  simpl.
  have h : IZR (Qnum [x * y]%bigQ) * IZR (' Qden ( ([x]%bigQ * [y]%bigQ)%Q ))  = IZR (Qnum ( ([x]%bigQ * [y]%bigQ)%Q )) * IZR (' Qden [x * y]%bigQ).
  repeat rewrite -mult_IZR. apply IZR_eq. by apply  BigQ.spec_mul.
  have -> :  IZR (Qnum [x * y]%bigQ) * / IZR (' Qden [x * y]%bigQ) = IZR (Qnum ([x]%bigQ * [y]%bigQ)%Q   ) * / IZR (' Qden ([x]%bigQ * [y]%bigQ)%Q). apply raux6impl.
  simpl; repeat INR_nat_of_P; by apply Rlt_neq.
  simpl; repeat INR_nat_of_P; by apply Rlt_neq. by [].
  simpl in *.
  repeat rewrite mult_IZR.
  rewrite Pos2Nat.inj_mul.
  rewrite mult_INR.
  repeat INR_nat_of_P.
  intros. field ; split ; apply Rlt_neq; auto.
Qed.



Lemma IQR_le : forall (x y : bigQ), (x [<=] y) -> IQR x <= IQR y.
Proof.
  move => x y H.
  apply cleq_aux2 in H. 
  unfold cle in H.
  unfold IQR.
  simpl in *.
  apply IZR_le in H.
  repeat rewrite mult_IZR in H.
  simpl in H.
  repeat INR_nat_of_P; intros.
  assert (Hr := Rlt_neq r H).
  assert (Hr0 := Rlt_neq r0 H0).
  replace (IZR (Qnum [x]%bigQ) * / r) with ((IZR (Qnum [x]%bigQ) * r0) * (/r * /r0)).
  replace (IZR (Qnum [y]%bigQ ) * / r0) with ((IZR (Qnum [y]%bigQ) * r) * (/r * /r0)).
  apply Rmult_le_compat_r ; auto.
  apply Rmult_le_pos.
  unfold Rle. left. apply Rinv_0_lt_compat ; auto.
  unfold Rle. left. apply Rinv_0_lt_compat ; auto.
  field ; intuition.
  field ; intuition.
Qed.


Lemma spec_eqb_toQ (x y : bigQ) : x [=] y -> Qeq_bool [x]%bigQ [y]%bigQ.
Proof. 
 move => H.
 apply ceq_eqb in H.
 apply Qeq_bool_iff.
 by [].
Qed.

Lemma spec_neqb_toQ (x y : bigQ) : x [~=] y -> Qeq_bool [x]%bigQ [y]%bigQ = false.
Proof. 
 move => H.
 unfold cneqb, ceqb, BigQ.eqb in H.
 rewrite -BigQ.spec_eq_bool. by apply negbTE.
Qed.


Lemma Qeq_true : forall x y,  
    Qeq_bool [x]%bigQ [y]%bigQ -> 
   IQR x = IQR y.
Proof.
  unfold IQR.
  simpl.
  intros.
  apply Qeq_bool_eq in H.
  unfold Qeq in H.
  assert (IZR (Qnum [x]%bigQ * ' Qden [y]%bigQ ) = IZR (Qnum [y]%bigQ * ' Qden [x]%bigQ ))%Z.
     rewrite H. reflexivity.
  repeat rewrite mult_IZR in H0.
  simpl in H0.
  revert H0.
  repeat INR_nat_of_P.
  intros.
  apply Rinv_elim in H2 ; [| apply Rlt_neq ; auto].
  rewrite <- H2.
  field.
  split ; apply Rlt_neq ; auto.
Qed.

Lemma IQR_eq : forall (x y : bigQ), (x [=] y) -> IQR x = IQR y.
Proof.
 move => x y H. apply spec_eqb_toQ in H.
 by apply Qeq_true.
Qed.

Lemma IQR_le0_square i : 0 <= IQR (csquare i).
Proof. have -> : IQR (csquare i) = IQR(ctimes i i). apply IQR_eq. rewrite csquare_aux. unfold ctimes. unfold ceqb, BigQ.eqb, BigQ.eq_bool. rewrite ceq_eqb. by []. rewrite IQR_mult. by apply Rle_0_sqr. Qed.



Lemma cltb_lt c1 c2 : c1 [<] c2 <-> clt c1 c2.
Proof.
split.
- unfold cltb. move/andP => [h1 h2]. move : h1 h2. 
  rewrite cleq_aux2 cneq_neqb; by bigQ_order.
- unfold cltb. move => h; apply /andP. split; move : h.
  + rewrite cleq_aux2; by bigQ_order.
  + rewrite cneq_neqb; by bigQ_order.
Qed.


Lemma Qeq_false : forall x y, Qeq_bool[x]%bigQ [y]%bigQ  = false -> IQR x <> IQR y.
Proof.
  intros.
  apply Qeq_bool_neq in H.
  intro. apply H. clear H.
  unfold Qeq,IQR in *.
  simpl in *.
  revert H0.
  repeat Rinv_elim.
  intros.
  subst.
  assert (IZR (Qnum [x]%bigQ * ' Qden [y]%bigQ)%Z = IZR (Qnum [y]%bigQ * ' Qden [x]%bigQ)%Z).
  repeat rewrite mult_IZR.
  apply raux6.
  simpl; repeat INR_nat_of_P; intros; by apply Rlt_neq.
  simpl; repeat INR_nat_of_P; intros; by apply Rlt_neq. rewrite -H -H0. simpl. field.
  simpl; repeat INR_nat_of_P; intros. split; by apply Rlt_neq.
  apply eq_IZR; auto.
  simpl; repeat INR_nat_of_P; intros; by apply Rlt_neq.
  simpl; repeat INR_nat_of_P; intros; by apply Rlt_neq.
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
Proof.
  vm_compute. apply Rinv_1.
Qed.

Lemma IQR_1 : IQR 1 = 1.
Proof.
  vm_compute. apply Rinv_1.
Qed.

Lemma IQR_0_1 : IQR (0 # 1) = 0.
Proof.
  vm_compute. apply Rinv_1.
Qed.

Lemma IQR_1_1 : IQR (1 # 1) = 1.
Proof.
  vm_compute. apply Rinv_1.
Qed.

Lemma IQR_minus1_1 : IQR (- 1 # 1) = -1.
Proof.
  vm_compute. apply Rinv_1.
Qed.


Lemma IQR_inv x : (cO [~=] x) -> 
  IQR (cinv x) =  / IQR x.
Proof.
  move => hlt.
  - have neq : IQR x <> 0. rewrite -IQR_0. apply IQR_neq; by apply cneqb_symm.
  - have : IQR (cinv x) * IQR x = 1.
  rewrite -IQR_mult. unfold cinv. have : cinv x *  x == 1%bigQ. unfold cinv. field. apply cneq_neqb. by apply cneqb_symm. unfold cinv.  move => H. rewrite -IQR_1. apply IQR_eq. by rewrite ceq_eqb. move => h. 
apply Rinv_elim in h; [rewrite -h; by ring | by []].
Qed.

Lemma IQR_div x y : (cO [~=] y) -> 
  IQR (cdiv x y) = IQR x / IQR y.
Proof. move => h. rewrite IQR_mult IQR_inv; by done. Qed.

Lemma ring_aux1 q1 r q2  q:  (q1 * r - q * q1) * q2 = (r - q) * (q1 * q2).
Proof. by ring. Qed.

Lemma IQR_scale r m M : m [<] M -> r =
   (IQR (cinv (cminus M m)) * r -
    IQR (ctimes m (cinv (cminus M m)))) *
   IQR (cminus M m) + IQR m.
Proof. 
move/andP => [_ hneq].
unfold cinv, cminus. rewrite IQR_mult. rewrite ring_aux1. rewrite IQR_inv; last by apply cneqb_trans, cneqb_symm. field. rewrite -IQR_0. apply IQR_neq.  apply cneqb_symm. apply cneqb_trans. by apply cneqb_symm.
Qed.

Lemma r6 r r1 : 0 < r -> 0 <= r * r1 -> 0 <= r1.
Proof.
move=> gtr0 gep0.
have -> : r1 = /r * (r * r1).
field.
apply  Rlt_neq. exact gtr0.
have -> : 0 = /r * 0 by field; apply: Rlt_neq.
have -> : 0 = /r * 0 by rewrite Rmult_0_r.
apply: Rmult_le_compat_l => //.
by apply: Rlt_le; apply: Rinv_0_lt_compat.
by rewrite Rmult_0_r.
Qed.

Lemma r7 x : 1 + -1 * x = 1 - x.
Proof. by ring. Qed.

Module Type IQRSig.
Parameter opaque_IQR : bigQ -> R. Axiom opaque_IQREdef : opaque_IQR = IQR.
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

Lemma var_scale (m M : bigQ) (x y : R) : (cO [<] (M - m)%bigQ) -> 0 <= y - opaque_IQR(m) -> 0 <= opaque_IQR(M) - y ->  y = (opaque_IQR(M) - opaque_IQR(m))*x + opaque_IQR(m) -> x + IQR (0 # 1) >= 0 /\ IQR (-1 # 1) * x + IQR (1 # 1) >= 0.
(* (0 <= x /\ 0 <= 1 - x).*)
intros bnd ylo yup h.
rewrite h in ylo, yup.
split; apply Rle_ge.
- rewrite IQR_0_1 Rplus_0_r.
  apply (@r6 (IQR (M - m))). rewrite <- IQR_0.
  apply (IQR_lt). exact bnd. 
  have eq : (opaque_IQR M - opaque_IQR m) * x = (opaque_IQR M - opaque_IQR m) * x + opaque_IQR m - opaque_IQR m by ring.
 rewrite -eq in ylo. by rewrite opaque_IQREdef -IQR_minus in ylo.
rewrite <- raux7, raux8 in ylo.
- rewrite  raux9 in yup. rewrite opaque_IQREdef -IQR_minus in yup. rewrite  raux10 in yup.
  rewrite IQR_minus1_1 IQR_1_1 Rplus_comm r7.
  apply (r6 (IQR (M - m))). rewrite <- IQR_0. apply IQR_lt. exact bnd. exact yup.
Qed.



