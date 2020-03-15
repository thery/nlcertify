Require Import Raxioms RIneq Rpow_def DiscrR.
Require Import Reals.
Open Local Scope R_scope.
Require Import ssreflect.

Lemma Rmult_neutral : forall x:R , 0 * x = 0.
Proof.
  intro ; ring.
Qed.


Lemma Ropp_0 : forall r , - r = 0 -> r = 0.
Proof.
  intros.
  rewrite <- (Ropp_involutive r).
  apply Ropp_eq_0_compat ; auto.
Qed.


Lemma raux6impl (a b c d : R) : b <> 0 -> d <> 0 -> a * d = c * b -> a * /  b = c */ d.
Proof. 
move => bneq0 dneq0. 
- move => prod.  
 + have div : a * d */ b = c. rewrite prod. by field.
 + rewrite -div. by field.
Qed.

Lemma raux6 (a b c d : R) : b <> 0 -> d <> 0 -> a * /  b = c */ d ->  a * d = c * b.
Proof.
move => bneq0 dneq0. 
- move => div.
 + have div2 : (a */ b) * d = c. rewrite div. by field.
 + rewrite -div2. by field.
Qed.

Lemma Rlt_neq : forall r , 0 < r -> r <> 0.
Proof.
  red. intros.
  subst.
  apply (Rlt_irrefl 0 H).  
Qed.

Lemma Rinv_elim : forall x y z, 
  y <> 0 -> (z * y = x <->   x * / y = z).
Proof.
  intros.
  split ; intros.
  subst.
  rewrite Rmult_assoc.
  rewrite Rinv_r; auto.
  ring.
  subst.
  rewrite Rmult_assoc.
  rewrite (Rmult_comm (/ y)).
  rewrite Rinv_r ; auto.
  ring.
Qed.
Lemma raux7  r r1 r2 : r + (r1 - r2) = r + r1 - r2.
Proof. ring. Qed.
Lemma raux8 r  : r - r = 0.
Proof. apply Rplus_opp_r. Qed.
Lemma raux9 r r1 r2 : r - (r1 + r2) = r - r2 - r1.
Proof. ring. Qed.
Lemma raux10 r r1: r - r * r1 = r * (1 - r1).
Proof. ring. Qed.



Ltac INR_nat_of_P :=
  match goal with
    | H : context[INR (Pos.to_nat ?X)] |- _ =>
      revert H ; 
      let HH := fresh in
        assert (HH := pos_INR_nat_of_P X) ; revert HH ; generalize (INR (Pos.to_nat X))
    | |- context[INR (Pos.to_nat ?X)] =>
      let HH := fresh in
        assert (HH := pos_INR_nat_of_P X) ; revert HH ; generalize (INR (Pos.to_nat X))
  end.


Ltac add_eq expr val := set (temp := expr) ; 
  generalize (eq_refl temp) ;
    unfold temp at 1 ; generalize temp ; intro val ; clear temp.



Ltac Rinv_elim :=
  match goal with
    | |- context[?x * / ?y] => 
      let z := fresh "v" in 
      add_eq (x * / y) z  ;
      let H := fresh in intro H ; rewrite <- Rinv_elim in H
  end.





Lemma rorder (r1 r2 : R) : r1 <= r2 -> r1 <> r2 -> r1 < r2.
Proof.
 move => ineq eq.
 move : (Rdichotomy r1 r2) => dich.
 move : (dich eq) => dich2. elim dich2. by []. move => abs. exfalso. have :( ~ r1 > r2).
 by apply (Rle_not_lt).
 move => abs2. by elim abs2.
Qed.


Lemma Rinv_1 : forall x, x * / 1 = x.
Proof.
  intro.
  rewrite <- Rinv_elim. ring.
  apply R1_neq_R0.
Qed.
