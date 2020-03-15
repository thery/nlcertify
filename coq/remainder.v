Require Import ssreflect ssrbool eqtype ssrfun.
Require Import NArith.
Require Import Relation_Definitions.
Require Import Setoid.
(*****)
Require Import Env.
Require Import sos_horner.
(*****)
Require Import List.
Require Import Bool.
Require Import OrderedRing.
Require Import Refl.
Require Import Iqr Realslemmas.

Set Implicit Arguments.

Import OrderedRingSyntax.
(*
Require Import Reals.
Variable req: R -> R -> Prop.
Variable Reqe : (ring_eq_ext Rplus Rmult Ropp req).
*)
(*
Require Import BigQ.
(*Require Import BigQ.QMake.*)
Definition C := bigQ.
Definition cO:=0%bigQ.
Definition cI := 1%bigQ.
Definition cplus := BigQ.add.
Definition ctimes := BigQ.mul.
Definition cminus := BigQ.sub.
Definition copp := BigQ.opp.
Definition ceq := BigQ.eq.
Definition ceqb := BigQ.eqb.
Definition csquare := BigQ.square.
Definition clt := BigQ.lt.
Definition cle := BigQ.le.
Definition cmin := BigQ.min.
Definition bigQleq_bool n m :=
  match BigQ.compare n m with Gt => false | _ => true end.
Definition bigQlt_bool n m :=
  match BigQ.compare n m with Lt => true | _ => false end.
Definition cleb := bigQleq_bool.
Notation "x [=] y" := (ceqb x y).
Notation "x [<=] y" := (cleb x y).

Definition cneqb (x y : C) := negb (ceqb x y).
(*Definition cltb := bigQlt_bool.*)
Definition cltb (x y : C) := (cleb x y) && (cneqb x y).

Notation "x [~=] y" := (cneqb x y).
Notation "x [<] y" := (cltb x y).
*)
Require Import seq.
Definition seqpos := seq positive.

Lemma eqpositiveP : Equality.axiom Pos.eqb.
Proof.
move=> p1 p2.
apply: (equivP idP). by apply Pos.eqb_eq.
Qed.

Canonical positive_eqMixin := EqMixin eqpositiveP.
Canonical positive_eqType := Eval hnf in EqType positive positive_eqMixin.
Section Lowerbound.

Variable R : Type.
Variables rO rI : R.
Variables rplus rtimes rminus: R -> R -> R.
Variable ropp : R -> R.
Variables req rle rlt : R -> R -> Prop.
Variable sor : SOR rO rI rplus rtimes rminus ropp req rle rlt.
(*About SOR.
Check ring_theory.
Check  SORtimes_pos_pos sor.
*)
Notation "0" := rO.
Notation "1" := rI.
Notation "x + y" := (rplus x y).
Notation "x * y " := (rtimes x y).
Notation "x - y " := (rminus x y).
Notation "- x" := (ropp x).
Notation "x == y" := (req x y).
Notation "x ~= y" := (~ req x y).
Notation "x <= y" := (rle x y).
Notation "x < y" := (rlt x y).
Infix "^" := (pow_pos rtimes).
(*Check  SORtimes_pos_pos sor.*)

(* Assume we have a type of coefficients C and a morphism from C to R *)

(*
Variable C : Type.
Variables cO cI : C.
Variables cplus ctimes cminus: C -> C -> C.
Variable copp : C -> C.
Variables ceqb cleb : C -> C -> bool.
Variable phi : C -> R.
hNotation "[ x ]" := (phi x).
Notation "x [=] y" := (ceqb x y).
Notation "x [<=] y" := (cleb x y).
*)

Variable phi : C -> R.

(* Power coefficients *)
Variable E : Set. (* the type of exponents *)
Variable pow_phi : N -> E.
Variable rpow : R -> E -> R.

Notation "[ x ]" := (phi x).
(* Let's collect all hypotheses in addition to the ordered ring axioms into
one structure *)

Record SORaddon := mk_SOR_addon {
  SORrm : ring_morph 0 1 rplus rtimes rminus ropp req cO cI cplus ctimes cminus copp ceqb phi;
  SORpower : power_theory rI rtimes req pow_phi rpow;
  SORcneqb_morph : forall x y : C, x [=] y = false -> [x] ~= [y];
  SORcleb_morph : forall x y : C, x [<=] y = true -> [x] <= [y]
}.
(*About ring_morph.*)

Variable addon : SORaddon.
(*Check (morph0 (SORrm addon)).*)
Add Relation R req
  reflexivity proved by sor.(SORsetoid).(@Equivalence_Reflexive _ _ )
  symmetry proved by sor.(SORsetoid).(@Equivalence_Symmetric _ _ )
  transitivity proved by sor.(SORsetoid).(@Equivalence_Transitive _ _ )
 as micromega_sor_setoid.
Add Morphism rplus with signature req ==> req ==> req as rplus_morph.
Proof.
exact sor.(SORplus_wd).
Qed.
Add Morphism rtimes with signature req ==> req ==> req as rtimes_morph.
Proof.
exact sor.(SORtimes_wd).
Qed.
Add Morphism ropp with signature req ==> req as ropp_morph.
Proof.
exact sor.(SORopp_wd).
Qed.
Add Morphism rle with signature req ==> req ==> iff as rle_morph.
Proof.
  exact sor.(SORle_wd).
Qed.
Add Morphism rlt with signature req ==> req ==> iff as rlt_morph.
Proof.
  exact sor.(SORlt_wd).
Qed.

Add Morphism rminus with signature req ==> req ==> req as rminus_morph.
Proof.
  exact (rminus_morph sor). (* We already proved that minus is a morphism in OrderedRing.v *)
Qed.

Add Ring SOR : sor.(SORrt).


Ltac le_less := rewrite (Rle_lt_eq sor); left; try assumption.
Ltac le_equal := rewrite (Rle_lt_eq sor); right; try reflexivity; try assumption.
Ltac le_elim H := rewrite (Rle_lt_eq sor) in H; destruct H as [H | H].

Lemma cleb_sound : forall x y : C, x [<=] y = true -> [x] <= [y].
Proof.
  exact addon.(SORcleb_morph).
Qed.

Lemma cleqb_sound x y : x [=] y = true -> [x] == [y].
Proof. apply (morph_eq (SORrm addon)). Qed.


Definition PolC := Pol C. (* polynomials in generalized Horner form, defined in sos_horner *)
Definition P0 := Pc cO.
Definition P1 := Pc cI.
Definition PolEnv := Env R. (* For interpreting PolC *)
(*
Definition mkXi i := PX P1 i P0.
Definition mkX := mkXi 1.
*)
Definition paddC := PaddC cplus.
Definition psubC := PsubC cminus.

Definition eval_pol (env : PolEnv) (p:PolC) : R :=
   Pphi rplus rtimes phi env p.

Infix "+!" := cplus.
Fixpoint lower_bound_0_1 p := match p with
  | Pc c => cmin c cO
  | Pinj _ p => lower_bound_0_1 p
  | PX p _ q => lower_bound_0_1 p +! lower_bound_0_1 q
end.

Require Import ssrnat.
Local Open Scope nat.


Fixpoint varmax_aux (p : PolC) idx := match p with
  | Pc c => idx
  | Pinj j p => maxn (varmax_aux p 0 + (nat_of_pos j)) idx
  | PX p j q => maxn idx (max (varmax_aux q 0 + 1) (varmax_aux p 0))
end.

Fixpoint varmax_aux2 (p : PolC) := match p with
  | Pc c => 0
  | Pinj j p => varmax_aux2 p + (nat_of_pos j)
  | PX p j q => maxn (varmax_aux2 q + 1) (varmax_aux2 p)
end.

(*Require Import BinNums.
Fixpoint varmax_aux3 (p : PolC) : N := match p with
  | Pc c => N0
  | Pinj j p => (varmax_aux3 p + Npos j)%N
  | PX p j q => Nmax (varmax_aux3 q + 1) (varmax_aux3 p)
end.
*)

Fixpoint varmax_aux4 (p : PolC) : nat%coq_nat := match p with
  | Pc c => 0%coq_nat
  | Pinj j p => (varmax_aux4 p + Pos.to_nat j)
  | PX p j q => maxn (varmax_aux4 q + 1) (varmax_aux4 p)
end.

Definition varmax := varmax_aux4.

Definition Peq a b := Peq ceqb a b.
Infix "?==" := Peq.
Definition padd := Padd cO cplus ceqb.
Definition psub := Psub cO cplus cminus copp ceqb.
Infix "--" := psub.


Definition pmulC_aux := PmulC_aux cO ctimes ceqb.
Definition pmulC := PmulC cO cI ctimes ceqb.
Definition pmul := Pmul cO cI cplus ctimes ceqb.
Definition psquare := Psquare cO cI cplus ctimes ceqb.
Infix "**" := pmul.

Definition Rops_wd := mk_reqe (*rplus rtimes ropp req*)
                       sor.(SORplus_wd)
                       sor.(SORtimes_wd)
                       sor.(SORopp_wd).


Close Scope nat_scope.

Lemma eval_pol_add : forall env lhs rhs, eval_pol env (padd lhs rhs) == eval_pol env lhs + eval_pol env rhs.
Proof.
  intros.
  apply (Padd_ok  sor.(SORsetoid) Rops_wd
    (Rth_ARth (SORsetoid sor) Rops_wd sor.(SORrt)) addon.(SORrm)  ).
Qed.

Lemma eval_pol_sub : forall env lhs rhs, eval_pol env (psub  lhs rhs) == eval_pol env lhs - eval_pol env rhs.
Proof.
  intros.
  apply (Psub_ok  sor.(SORsetoid) Rops_wd
    (Rth_ARth (SORsetoid sor) Rops_wd sor.(SORrt)) addon.(SORrm)).
Qed.


Lemma eval_pol_mul : forall env lhs rhs, eval_pol env (pmul lhs rhs) == eval_pol env lhs * eval_pol env rhs.
Proof.
  intros.
  apply (Pmul_ok  sor.(SORsetoid) Rops_wd
    (Rth_ARth (SORsetoid sor) Rops_wd sor.(SORrt)) addon.(SORrm) lhs rhs env).
Qed.

Lemma eval_pol_square : forall env lhs, eval_pol env (psquare lhs) == (eval_pol env lhs) * (eval_pol env lhs).
Proof.
  intros.
  apply (Psquare_ok  sor.(SORsetoid) Rops_wd
    (Rth_ARth (SORsetoid sor) Rops_wd sor.(SORrt)) addon.(SORrm) lhs env).
Qed.


Definition  eval_pexpr :=  PEeval rplus rtimes rminus ropp phi pow_phi rpow .

Definition norm := norm_aux cO cI cplus ctimes cminus copp ceqb.
Lemma norm_eval_pexpr_correct env p1 p2 : norm p1 ?== norm p2 -> eval_pexpr env p1 == eval_pexpr env p2.
Proof.
  intros.
  by apply (norm_eval_spec sor.(SORsetoid) Rops_wd
    (Rth_ARth (SORsetoid sor) Rops_wd sor.(SORrt)) addon.(SORrm)  addon.(SORpower)  ).
Qed.

Lemma eval_pol_norm : forall env lhs, eval_pexpr env lhs == eval_pol env  (norm lhs).
Proof.
  intros.
  apply  (norm_aux_spec sor.(SORsetoid) Rops_wd   (Rth_ARth (SORsetoid sor) Rops_wd sor.(SORrt)) addon.(SORrm) addon.(SORpower) ).
Qed.

Lemma eval_pol_norm_aux env lhs rhs : norm lhs ?== rhs -> eval_pexpr env lhs ==  eval_pol env rhs.
Proof.
rewrite eval_pol_norm.
move => h.
move : (Peq_ok micromega_sor_setoid Rops_wd (SORrm addon) (norm lhs) rhs h).
by [].
Qed.

Lemma prop_aux (A B C : Prop) : (A -> C) /\ (B -> C) -> (A \/ B -> C).
Proof. move => [ac bc] ab.
destruct ab.
apply (ac H). apply (bc H).
Qed.

Lemma c_aux c : [cO] <= [cminus c (cmin c cO)].
Proof.
apply cleb_sound. 
apply cleq_aux2.
move : lt_total => T.
move : (T c cO).
apply prop_aux.
- split.
  move => Hlt.
  have : (ceq (cmin c cO) c). apply cmin_l. 
  corder.
  move => Hmin. rewrite Hmin  cminus0_aux. apply cleq_aux.
apply prop_aux.
- split.
  move => Heq. rewrite Heq //=.
- 
  move => Hgt. 
  have : (ceq (cmin c cO) cO). apply cmin_r.
  corder.
  move => Hmin. rewrite Hmin cminus0_aux2. corder.
Qed.

Definition PsubC_ok : forall c P env, eval_pol env (psubC  P c) == eval_pol env P - [c] :=
  let Rops_wd := mk_reqe (*rplus rtimes ropp req*)
                       sor.(SORplus_wd)
                       sor.(SORtimes_wd)
                       sor.(SORopp_wd) in
                       PsubC_ok sor.(SORsetoid) Rops_wd (Rth_ARth (SORsetoid sor) Rops_wd sor.(SORrt))
                addon.(SORrm).


Definition PmulC_ok : forall c P env, eval_pol env (pmulC P c) == eval_pol env P * [c] :=
  let Rops_wd := mk_reqe (*rplus rtimes ropp req*)
                       sor.(SORplus_wd)
                       sor.(SORtimes_wd)
                       sor.(SORopp_wd) in
                       PmulC_ok sor.(SORsetoid) Rops_wd (Rth_ARth (SORsetoid sor) Rops_wd sor.(SORrt))
                addon.(SORrm).




Lemma r_cplus x y : [cplus x y] == [x] + [y].
Proof. apply (morph_add (SORrm addon)). Qed.

Lemma r_cminus x y : [cminus x y] == [x] - [y].
Proof. apply (morph_sub (SORrm addon)). Qed.


Lemma cOrO : [cO] == rO.
Proof. apply (morph0 (SORrm addon)). Qed.

Lemma cIrI : [cI] == rI.
Proof. apply (morph1 (SORrm addon)). Qed.

Lemma rone r : 1 * r == r.
Proof. ring. Qed.
Lemma rone_r r : r * 1 == r.
Proof. ring. Qed.

Lemma rzero r : r + 0 == r.
Proof. ring. Qed.

Lemma raux1 r1 r2 r3 r4 : r1 + (r2 - (r3 + r4)) == (r1 - r3) + (r2 - r4).
Proof. ring. Qed.

Lemma raux0 r1 r2 r3 r4 : r1 + r2 - (r3 + r4) == (r1 - r3) + (r2 - r4).
Proof. ring. Qed.

Lemma raux2 r r1 r2 : r * (r1 - r2 ) == r * r1 - r * r2.
Proof. ring. Qed.

Lemma rmult_distr_add r r1 r2 : (r1 + r2) * r == r1 * r + r2 * r.
Proof. ring. Qed.

Lemma rmult_assoc r r1 r2 : r * r1 * r2 == r * (r1 * r2).
Proof. ring. Qed.

Lemma raux3 r : r - 1 == - (1 - r).
Proof. ring. Qed.

Lemma rO_opp : 0 == -0.
Proof. ring. Qed.

Lemma rO_add : 0 + 0 == 0.
Proof. ring. Qed.


Lemma raux4 r1 r2 : 1 - r1 * r2 == (1 - r1) * r2 + (1 - r2).
Proof. ring. Qed.

Lemma raux5 r r1 r2 : r * r1 - r2 == (r - r2)*r1 + ((-r2) * (1 - r1)).
Proof. ring. Qed.

Lemma c_aux2 c : [cmin c cO] <= 0.
Proof. 
rewrite <- cOrO.
apply cleb_sound.
apply cleq_aux2.
move : lt_total => T.
move : (T c cO).
apply prop_aux.
- split.
  move => Hlt.
  have : (ceq (cmin c cO) c). apply cmin_l. 
  corder.
  move => Hmin. rewrite Hmin. corder.
apply prop_aux.
- split.
  move => Heq. rewrite Heq //=.
- 
  move => Hgt. 
  have : (ceq (cmin c cO) cO). apply cmin_r.
  corder.
  move => Hmin. rewrite Hmin. by [].
Qed.


Definition ceqb_specC := (ceqb_spec (SORrm addon)).
(*Variable Reqe : ring_eq_ext rplus rtimes ropp req.
   Peq_ok micromega_sor_setoid Reqe (SORrm addon).*)

Lemma jump_aux p (l : PolEnv) : forall i, Env.nth (i + p) l = Env.nth i (jump p l).
Proof. move => i. trivial. Qed.

Lemma lower_bound_negative p : [lower_bound_0_1 p] <= 0.
Proof.
induction p.
- simpl. by apply c_aux2.
- by [].
- simpl. rewrite r_cplus. (*Locate Rtimes_neg_neg.*) rewrite <- rO_add. by apply (Rplus_le_mono sor).
Qed.



Lemma Rtimes_aux r r1 r2 : 0 <= r -> 0 <= r1 - r2 -> r2 * r <= r1 * r.
Proof. 
  move => in1 in2. rewrite (Rle_le_minus sor).
  have <- : r * (r1 - r2) == r1 * r - r2 * r by ring. by apply (Rtimes_nonneg_nonneg sor).
Qed.

Definition Rle_trans := Rle_trans sor.

Lemma r_trans r1 r2 : 0 <= r1 -> r1 <= r2 -> 0 <= r2.
Proof.
 move => in1 in2.
 by apply (Rle_trans (m:=r1)).
 Qed.


Lemma rminus_aux2 r1 r2 : 0 <= r2 - r1 <-> r1 <= r2.
Proof. move => *. split; by apply (Rle_le_minus sor). Qed.


Lemma ropp_aux r1 r2 : r1 <= r2 -> -r2 <= -r1.
Proof.
  move => ineq.
  rewrite -rminus_aux2. have -> : - r1 - - r2 == r2 - r1 by ring. by rewrite rminus_aux2.
Qed.

Lemma Rtimes_aux2 r r1 r2 : 0 <= r -> 0 <= 1 - r -> r1 <= r2 -> r1 <= 0 -> r1 <= r2 * r.
Proof. 
 move => inr_0 inr_1 inr1r2 inr1.
 rewrite -rminus_aux2. have -> : r2 * r - r1 == (r2 - r1) * r + (1 - r) * (-r1) by ring.
 apply (Rplus_nonneg_nonneg sor).
 - apply (Rtimes_nonneg_nonneg sor). by rewrite rminus_aux2. by [].
 - apply (Rtimes_nonneg_nonneg sor). by []. have -> : 0 == -0 by ring. by apply ropp_aux.
Qed.


Lemma rpow_0 r : 0 <= r -> forall i, 0 <= r^i.
Proof. 
 move => h.
 elim.
 move => p hp. simpl. by repeat apply (Rtimes_nonneg_nonneg sor). 
 move => p hp. simpl. by repeat apply (Rtimes_nonneg_nonneg sor).
 by [].
Qed.

Lemma rpow_1 r : 0 <= r -> 0 <= 1 - r -> forall i, 0 <= 1 - r^i.
Proof. 
 move => hr0 hr1.
 elim.
 - move => p hp. simpl. 
   have -> :  1 - r * (r ^ p * r ^ p) == (1 - r ^ p) * r * r^p + ((1 - r ^ p) * r + (1 - r)) by ring.
   repeat apply (Rplus_nonneg_nonneg sor); repeat apply (Rtimes_nonneg_nonneg sor). by []. by []. by apply rpow_0. by []. by []. by [].
 - move => p hp. simpl.
   have -> :  1 - (r ^ p * r ^ p) == (1 - r ^ p) * r^p + (1 - r^p) by ring. apply (Rplus_nonneg_nonneg sor). apply (Rtimes_nonneg_nonneg sor). by [].  by apply rpow_0. by []. 
 - by [].
Qed.

Lemma Rtimes_nonpos_nonpos r1 r2 : r1 <= 0 -> r2 <= 0 -> 0 <= r1 * r2.
Proof.
 move => in1 in2.
 apply ropp_aux in in1. apply ropp_aux in in2. move : in1 in2. rewrite -rO_opp. 
 have -> : r1 * r2 == (-r1) * (-r2) by ring.
 by apply (Rtimes_nonneg_nonneg sor).
Qed.

(*
Lemma remainder_lemma p : forall l, ((forall i, 0 <= Env.nth i l /\ 0 <= 1 - Env.nth i l) ->  [lower_bound_0_1 p] <= eval_pol l p).
Proof.
induction p; move => l h.
- simpl. apply rminus_aux2. simpl. rewrite <- cOrO. rewrite <- r_cminus. by apply c_aux.
- simpl. apply IHp. move => i; apply h.
- simpl. rewrite r_cplus. apply (Rplus_le_mono sor).  apply (Rtimes_aux2).
  + apply rpow_0; apply h. apply rpow_1; apply h. 
  + apply IHp1; exact h. apply lower_bound_negative.
  + apply IHp2. unfold Env.tail. move => i. rewrite <- jump_aux. apply h.
Qed.
*)
(*Local Open Scope nat_scope.*)
(*
Require Import BinNat BinNums BinPos NArith PArith Pnat.
*)
Lemma varmax_nonneg p : (0 <= varmax p)%N.
Proof.
by destruct (varmax p).
(*by induction p; move => //=.*)
Qed.


Lemma remainder_lemma p : forall l, ((forall i, (Pos.to_nat i <= varmax p)%nat -> 0 <= Env.nth i l /\ 0 <= 1 - Env.nth i l) ->  [lower_bound_0_1 p] <= eval_pol l p).
Proof.
induction p; move => l h //=.
- apply rminus_aux2. rewrite <- cOrO. rewrite <- r_cminus. by apply c_aux.
- simpl in h. apply IHp. move => i hp.
  + have newh : (Pos.to_nat (i + p) <= varmax p0 + Pos.to_nat p)%N. rewrite Pnat.Pos2Nat.inj_add. by rewrite leq_add2r.
  + by apply h.
- 
  + have varmax123 : (nat_of_pos 1 <= varmax (PX p1 p2 p3))%N. rewrite leq_max. apply/orP. left. move : (varmax_nonneg p3). by rewrite -ltnS addn1.
  + have hd0 : 0 <= Env.hd l. by apply h. 
  + have hd1 : 0 <= 1 - Env.hd l. by apply h.
- rewrite r_cplus. apply (Rplus_le_mono sor). apply Rtimes_aux2.
  + by apply rpow_0, hd0. 
  + by [apply rpow_1 | apply hd0 | apply hd1].
  + apply IHp1. move => i hp. apply h. by rewrite leq_max ; apply/orP; right.
  + by apply lower_bound_negative.
  + apply IHp2. move => i hp. apply h. simpl. rewrite leq_max. apply/orP; left. rewrite Pnat.Pos2Nat.inj_add. by rewrite leq_add2r.
Qed.


(*
Lemma remainder_lemma p : forall l, ((forall i, (Pos.to_nat i <= varmax p)%coq_nat -> 0 <= Env.nth i l /\ 0 <= 1 - Env.nth i l) ->  [lower_bound_0_1 p] <= eval_pol l p).
induction p; move => l h //=.
- apply rminus_aux2. rewrite <- cOrO. rewrite <- r_cminus. by apply c_aux.
- simpl in h. apply IHp. move => i hp. 
  + have newh : (Pos.to_nat (i + p) <= varmax p0 + Pos.to_nat p)%N. rewrite Pnat.Pos2Nat.inj_add. 
Search Pos.to_nat.
by apply N.add_le_mono; last by apply N.le_refl.
  + by apply h.
- 
  + have varmax123 : (1 <= varmax (PX p1 p2 p3))%N. simpl. rewrite N.max_le_iff. left. move : (varmax_nonneg p3). move => hle. have : (0 + 1 <=  varmax p3 + 1)%N by apply N.add_le_mono; last by apply N.le_refl. by [].
  + have hd0 : 0 <= Env.hd l. by apply h. 
  + have hd1 : 0 <= 1 - Env.hd l. by apply h.
- rewrite r_cplus. apply (Rplus_le_mono sor). apply Rtimes_aux2.
  + by apply rpow_0, hd0. 
  + by [apply rpow_1 | apply hd0 | apply hd1].
  + apply IHp1. move => i hp. apply h. simpl. by rewrite N.max_le_iff; right.
  + by apply lower_bound_negative.
  + apply IHp2. move => i hp. apply h. simpl. rewrite N.max_le_iff; left. rewrite Npos_add. by apply N.add_le_mono; last by apply N.le_refl.
Qed.
*)

End Lowerbound.

Require Import Reals Raxioms RIneq Rpow_def DiscrR.

Definition Rsrt : ring_theory R0 R1 Rplus Rmult Rminus Ropp (@eq R).
Proof.
  constructor.
  exact Rplus_0_l.
  exact Rplus_comm.
  intros. rewrite Rplus_assoc. auto.
  exact Rmult_1_l.
  exact Rmult_comm.
  intros ; rewrite Rmult_assoc ; auto.
  intros. rewrite Rmult_comm. rewrite Rmult_plus_distr_l.
   rewrite (Rmult_comm z). rewrite (Rmult_comm z). auto.
  reflexivity.
  exact Rplus_opp_r.
Qed.

Add Ring Rring : Rsrt.
Local Open Scope R_scope.



Lemma Rsor : SOR R0 R1 Rplus Rmult Rminus Ropp (@eq R)  Rle Rlt.
Proof.
  constructor; intros ; subst ; try (intuition (subst; try ring ; auto with real)).
  constructor.
  constructor.
  unfold RelationClasses.Symmetric. auto.
  unfold RelationClasses.Transitive. intros. subst. reflexivity.
  apply Rsrt.
  eapply Rle_trans ; eauto.
  apply (Rlt_irrefl m) ; auto.
  apply Rnot_le_lt. auto with real.
  destruct (total_order_T n m) as [ [H1 | H1] | H1] ; auto.
  intros.
  rewrite <- (Rmult_neutral m).
  apply (Rmult_lt_compat_r) ; auto.
Qed.


(*
match (BigQ.to_Q q) with n # d => IZR n / IZR (Zpos d) end.
*)

Definition eval_expr := eval_pexpr  Rplus Rmult Rminus Ropp IQR N.to_nat pow.
Definition PExpr_nonneg l ineq : Prop :=  eval_expr l ineq >= 0.

Fixpoint conj_PExpr_nonneg l hyps := 
  match hyps with 
  | [::]  => True
(*  | [::x]   => PExpr_nonneg l x*)
  | x::tl => PExpr_nonneg l x /\ conj_PExpr_nonneg l tl
  end.


(*p Definition Eig := positive.  *)
Definition Eig := nat.
             (* i est l'indice de la valeur propre lambda_i dans eigPos i *)
(*Definition Sqr := R.*)

Definition Ineq := nat.
             (* indice de l'element positif sos_i * g_i *)
             (*  g_i = ineq_pos i *) 
Definition Sos_block :=  (Eig * PolC)%type.
              (* lambda_i * sqr_i  *)
Definition Sos := seq Sos_block.
              (* sos_blck1 + sos_blck2 + ...  *)
Definition Putinar_summand := (Sos * Ineq)%type.
              (* sos * g *)
Definition Putinar_psatz := seq Putinar_summand.
              (* sos1 * g1  +  sos2 * g2  +   ..  *)

Section FoldRightPsatz.
Variables (A Rt: Type) (e : Rt) (plus : Rt -> Rt -> Rt) (interp : A -> Rt).

Fixpoint foldr_psatz l := match l with
    [::] => e
  | [::hd] => interp hd
  | x::tl => plus (interp x) (foldr_psatz tl) end.

Lemma foldr_psatz_nil : foldr_psatz [::] = e.
Proof. done. Qed.

Lemma foldr_psatz_singl x : foldr_psatz [:: x] = interp x.
Proof. done. Qed.

Lemma foldr_psatz_cons x y tl : 
  foldr_psatz [:: x, y & tl] =  plus (interp x) (foldr_psatz (y :: tl)).
Proof. done. Qed.

End FoldRightPsatz.

(*About foldr_psatz.*)

Lemma Rmult_le_0_compat: forall r1 r2, 0 <= r1 -> 0 <= r2 -> 0 <= r2 * r1.
intros.
rewrite <- (Rmult_0_l (r1)).
apply Rmult_le_compat_r;auto.
Qed.

Definition rpow :=  (pow_pos Rmult).
Infix "^" := rpow.

Lemma Rsqr_pow (r : R) : r^2 = (Rsqr r).
simpl. unfold Rsqr. by []. Qed.


Definition eval_pol_R := eval_pol Rplus Rmult IQR.
Definition seqC := seq Iqr.C.
Definition Nth := seq.nth cO.

(*Definition NthpolC := seq.nth P0.*)
Definition Nthpol := seq.nth (PEc cO).
(*
Definition seqpols : seq (PExpr Iqr.C * PolC).
Definition Nthpols := seq.nth (PEc cO, P0).
*)
Definition seqpol := seq (PExpr Iqr.C).
Definition cnneg q := 0 [<=] q.
Definition sizeC := @size (PExpr Iqr.C).

Infix "?==" := Peq.
(*
Definition norm_pol_eq (pol_tuple : (PExpr Iqr.C * PolC)) := let (s, t) := pol_tuple in norm s ?== t.
*)
Definition interp_Sos_block env (eig_pos : seqC) (sos_block : Sos_block) := 
  let (eig, sqr) := sos_block in 
   Rmult (IQR (Nth eig_pos eig))  (Rsqr (eval_pol_R env sqr)).

Definition interp_Sos env eig_pos (sos: Sos) := foldr_psatz 0 Rplus (interp_Sos_block env eig_pos) sos.
Definition interp_Putinar_summand env hyps eig_pos (putinar_summand: Putinar_summand) := 
let (sos, ineq) := putinar_summand in 
(*
let pols := zip hyps ineq_pos in
let ineq_pol := (Nthpols pols ineq).2 in
*)
 Rmult (interp_Sos env eig_pos sos) (eval_pol_R env (norm (Nthpol hyps ineq))).

Definition interp_Psatz env hyps eig_pos summands := foldr_psatz 0 Rplus (interp_Putinar_summand env hyps eig_pos) summands.

Definition Sos_block_toPolC eig_pos (sos_block : Sos_block) := 
   let (eig, sqr) := sos_block in 
    pmulC  (psquare sqr) (Nth eig_pos eig).

Definition Sos_toPolC eig_pos (sos: Sos) := foldr_psatz P0 padd (Sos_block_toPolC eig_pos) sos.

Definition Putinar_summand_toPolC hyps eig_pos (putinar_summand: Putinar_summand) := 
  let (sos, ineq) := putinar_summand in
(*
  let pols := zip hyps ineq_pos in
  let ineq_pol := (Nthpols pols ineq).2 in
*)
   pmul (Sos_toPolC eig_pos sos) (norm (Nthpol hyps ineq)).

Definition Psatz_toPolC hyps eig_pos summands := foldr_psatz P0 padd (Putinar_summand_toPolC hyps eig_pos) summands.


Notation to_nat := N.to_nat.



Lemma QSORaddon :
  @SORaddon Rdefinitions.R
  R0 R1 Rplus Rmult Rminus Ropp  (@eq R)  Rle (* ring elements *)
(*  IQR 0%bigQ 1%bigQ cplus ctimes cminus copp (* coefficients *)
  BigQ.eq_bool Qle_bool*)
  IQR nat to_nat pow.
Proof.
  constructor.
  constructor ; intros ; try reflexivity.
  apply IQR_0.
  apply IQR_1.
  apply IQR_plus.
  apply IQR_minus.
  apply IQR_mult.
  apply IQR_opp.
  by apply IQR_eq.
  apply R_power_theory.
  move => x y h; apply IQR_neq. apply (negbT h).
  apply IQR_le.
Qed.

Lemma eval_interp_Sos_block env eig_pos sos_block : interp_Sos_block env eig_pos sos_block = eval_pol_R env (Sos_block_toPolC eig_pos sos_block).
Proof.
move : sos_block => [eig sqr].
rewrite /interp_Sos_block /Sos_block_toPolC. unfold eval_pol_R. rewrite (PmulC_ok Rsor QSORaddon). rewrite (eval_pol_square Rsor QSORaddon).  rewrite <- Rsqr_pow. unfold eval_pol. unfold rpow, pow_pos. by ring. Qed.

Lemma eval_interp_Sos env eig_pos sos :  interp_Sos env eig_pos sos = eval_pol_R env (Sos_toPolC eig_pos sos).
Proof.
rewrite /interp_Sos. rewrite /Sos_toPolC.
elim : sos => [ | a [ | b tl] ih].
- simpl; by rewrite IQR_0. 
- by apply eval_interp_Sos_block.
- unfold interp_Sos in ih. rewrite (foldr_psatz_cons 0 Rplus) (foldr_psatz_cons P0 padd) eval_interp_Sos_block ih. unfold eval_pol_R. rewrite (eval_pol_add Rsor QSORaddon). by []. 
Qed.

Lemma eval_interp_Putinar_summand env hyps eig_pos summand : interp_Putinar_summand env hyps eig_pos summand = eval_pol_R env (Putinar_summand_toPolC hyps eig_pos summand).
move : summand => [sos ineq].
unfold  interp_Putinar_summand, eval_pol_R.
rewrite (eval_pol_mul Rsor QSORaddon) eval_interp_Sos.
by unfold eval_pol_R.
Qed.

Lemma eval_interp_Psatz env hyps eig_pos summands : interp_Psatz env hyps eig_pos summands = eval_pol_R env (Psatz_toPolC hyps eig_pos summands). 
rewrite /interp_Psatz. rewrite /Psatz_toPolC.
elim : summands => [ | a [ | b tl] ih].
- simpl;  by rewrite IQR_0.
- by apply eval_interp_Putinar_summand.
- unfold interp_Putinar_summand in ih. rewrite (foldr_psatz_cons 0 Rplus) (foldr_psatz_cons P0 padd) eval_interp_Putinar_summand ih. unfold eval_pol_R. rewrite (eval_pol_add Rsor QSORaddon). by []. 
Qed.



(*
Fixpoint all2 a (s : seq (PExpr Iqr.C) ) (t : seq PolC) : bool := if size s == size t then (if (s, t) is (x :: s', y::t') then a x y && all2 a s' t' else true) else false.
*)

Local Open Scope nat_scope.
Lemma lt_total n m : (n < m) || (m <= n).
rewrite ltnNge.
by rewrite orNb.
Qed.

Lemma order_ssrnat n m : ssrnat.leq (S n) m \/ ssrnat.leq m n.
Proof.
apply /orP.
by apply lt_total.
Qed.

Lemma all_nth : forall s, all cnneg s -> forall n, cnneg (Nth s n).
Proof.
move => s h n.
have : ssrnat.leq (S n) (size s) \/ ssrnat.leq (size s) n by apply order_ssrnat.
case.
move => hle.
unfold Nth.
move/(all_nthP cO) : h.
move => allh. by apply allh.
move => hle.
have : Nth s n = cO.
by apply (nth_default cO).
move => h0. by rewrite h0.
Qed. 

Local Open Scope R_scope.

Lemma nthpol env hyps : conj_PExpr_nonneg env hyps -> (forall n : nat, 0 <= eval_pol_R env (norm (Nthpol hyps n))).
Proof.
elim : hyps => //=.
- move => h n.
  have -> :  Nthpol [::] n = PEc cO by apply nth_nil. simpl; rewrite IQR_0; by apply Rle_refl.
- move => p tl h.
move => [ha htl] n.
 + case n => //=.
   have <- : eval_expr env p = eval_pol_R env (norm p) by apply (eval_pol_norm Rsor  QSORaddon).
   by unfold PExpr_nonneg in ha; apply Rge_le.
 + by apply h.
Qed.


Lemma thm_Sos_block env eig_pos sos_block : (all cnneg eig_pos) -> 0 <= interp_Sos_block env eig_pos sos_block.
Proof.
move : sos_block => [eig sqr] H; rewrite /interp_Sos_block.
 - apply Rmult_le_0_compat. rewrite <- Rsqr_pow. by apply Rle_0_sqr.  
 - rewrite <- IQR_0. apply IQR_le. by apply all_nth. (* [rewrite Rsqr_pow; apply Rle_0_sqr |  ].*)
Qed.

Lemma thm_Sos env eig_pos sos: all cnneg eig_pos -> 0 <= interp_Sos env eig_pos sos.
Proof.
move => H; elim: sos => [ | a [ | b tl] ih].
by apply: Rle_refl.
- rewrite /interp_Sos.
by apply thm_Sos_block.
- rewrite /interp_Sos.
unfold interp_Sos in ih.
rewrite (foldr_psatz_cons 0 Rplus (interp_Sos_block env eig_pos) a).
apply Rplus_le_le_0_compat.
by apply : thm_Sos_block. done.
Qed.

Lemma thm_Putinar_summand env hyps eig_pos summand : conj_PExpr_nonneg env hyps -> all cnneg eig_pos -> 0 <= interp_Putinar_summand env hyps eig_pos summand.
Proof.
move : summand => [sos ineq] Hyps Heig.
apply Rmult_le_0_compat. 
- apply (nthpol env hyps Hyps).
- apply thm_Sos, Heig.
Qed.

Lemma thm_Putinar_Psatz env hyps eig_pos summands : conj_PExpr_nonneg env hyps -> all cnneg eig_pos -> 0 <= interp_Psatz env hyps eig_pos summands.
Proof.
move => Hyps Heig. elim: summands => [ | a [ | b tl] ih].
by apply: Rle_refl.
- rewrite /interp_Psatz.
by apply thm_Putinar_summand.
- rewrite /interp_Psatz.
unfold interp_Psatz in ih.
rewrite foldr_psatz_cons.
apply Rplus_le_le_0_compat.
by apply thm_Putinar_summand.
by done.
Qed.

(* Certificate: the tuple (summands, r, eig_pos) *)
(*
obj: initial objective polynomial of the POP
env: mapping positive to variables of the POP 
1 -> x1, 2 -> x2, 3 -> x3
*)


Lemma conj_PExpr_nonneg_cons l x tl : conj_PExpr_nonneg l (x::tl) =  (PExpr_nonneg l x /\ conj_PExpr_nonneg l tl).
Proof. by []. Qed.

Lemma conj_PExpr_nonneg_concat l h1 h2 :conj_PExpr_nonneg l h1 -> conj_PExpr_nonneg l h2 -> conj_PExpr_nonneg l (h1 ++ h2).
Proof.
elim h1.
by [].
move =>  a ? H H1 ?.
rewrite cat_cons.
rewrite conj_PExpr_nonneg_cons. 
rewrite conj_PExpr_nonneg_cons in H1.
move : H1 => [h ?].
split.
  apply h.  
  by apply H.
Qed.


Lemma conj_PExpr_nonneg_concat2 l h1 h2 : conj_PExpr_nonneg l (h1 ++ h2) -> (conj_PExpr_nonneg l h1 /\ conj_PExpr_nonneg l h2).
Proof.
elim h1 => //=.
split. split; [apply H0 | by apply H; by apply H0].
by apply H, H0.
Qed.

Lemma conj_PExpr_nonneg_1 env hyps :  conj_PExpr_nonneg env hyps -> conj_PExpr_nonneg env ((PEc cI)::hyps).
Proof.
move => h.
simpl. split => //=.
unfold PExpr_nonneg => //=. rewrite IQR_1. by apply Rle_ge, Rle_0_1.
Qed.

Lemma conj_PExpr_nonneg_n env hyps n :  conj_PExpr_nonneg env hyps -> conj_PExpr_nonneg env (nseq n(PEc cI)++ hyps).
Proof.
move => h.
simpl. unfold nseq.
induction n.
  by [].
  simpl.
  unfold PExpr_nonneg => //=. rewrite IQR_1. split. apply Rle_ge, Rle_0_1. by [].
Qed.

Definition PEX := PEX Iqr.C.

Definition var_0_1 hyps n := (norm (PEX (Pos.of_nat n)) ?== norm (Nthpol hyps (2 * n -2 ))) && (norm (PEsub (PEc cI) (PEX (Pos.of_nat n))) ?== norm (Nthpol hyps (2 * n - 1))).


Lemma all_vars_0_1_aux bnds p : all (var_0_1 bnds) (iota 1 (varmax p)) -> forall n, ((0 < n)%N && (n <= varmax p)%nat) -> var_0_1 bnds n. 
Proof.
move => h n.
have :  (S (n.-1) <= (size (iota 1 (varmax p))))%N  \/  ((size (iota 1 (varmax p)) ) <= (n.-1))%N by apply order_ssrnat.
case.
- move => hle.
  move/(all_nthP 0%N) : h.
  move => allh.  have : var_0_1 bnds (nth 0%N (iota 1 (varmax p)) (n - 1)). rewrite -subn1 in hle. by move : (allh (n -1)%N hle).
  + rewrite nth_iota.  rewrite add1n. move => h1. move/andP => [b1 b2]. by rewrite subn1 prednK in h1.
  + by rewrite size_iota -subn1 in hle.
- rewrite size_iota. move => h1. move/andP => [b1 b2].
  have : (varmax p < (n.-1).+1)%nat by rewrite ltnS. rewrite prednK; last by apply b1. rewrite ltnNge negbF; by [].
Qed.

(*
Lemma  var_0_1_0 hyps : var_0_1 hyps 0%N = false.
Proof. by []. Qed.
*)

Definition sqr_bnd n := PEsub (PEc cI) (PEmul (PEX (Pos.of_nat n)) (PEX (Pos.of_nat n))).
Definition sqr_bnds varmax := map sqr_bnd (iota 1 varmax).


Lemma all_vars_0_1 l bnds p : conj_PExpr_nonneg l bnds ->  all (var_0_1 bnds) (iota 1 (varmax p)%nat) -> (forall i, (Pos.to_nat i <= varmax p)%nat -> 0 <= Env.nth i l /\ 0 <= 1 - Env.nth i l).
Proof.
move => Hyps hall.
move : (all_vars_0_1_aux bnds p hall). move => h i hpos.
- have : var_0_1 bnds (Pos.to_nat i).
  + apply h. apply/andP. split; last by done.
  + induction i => //=. rewrite Pos2Nat.inj_xO. rewrite multE. rewrite mul2n. rewrite double_gt0.  apply IHi. rewrite Pos2Nat.inj_xO multE mul2n in hpos.  apply leq_trans with (n:= (Pos.to_nat i).*2); last by done. rewrite -addnn. by apply leq_addr.
- unfold var_0_1. move/andP => [h1 h2]. (*move/andP : h1 => [h0 h1].*) rewrite Pos2Nat.id in h1, h2. split.
  apply (norm_eval_pexpr_correct Rsor QSORaddon l) in h1. simpl in h1. rewrite h1. move : (nthpol l bnds Hyps (2 * Pos.to_nat i -2) ). rewrite eval_pol_norm. by unfold eval_pol_R, eval_pol. apply Rsor. by apply QSORaddon.
- apply (norm_eval_pexpr_correct Rsor QSORaddon l) in h2.  simpl in h2. rewrite IQR_1 in h2. rewrite h2. move : (nthpol l bnds Hyps (2 * Pos.to_nat i - 1) ). rewrite eval_pol_norm. by unfold eval_pol_R, eval_pol. apply Rsor. by apply QSORaddon.
Qed.



Lemma var_0_1_sqr_0_1 l i :  0 <= Env.nth i l ->  0 <= 1 - Env.nth i l->
eval_expr l (PEc cI) - eval_expr l (PEmul (PEX i) (PEX i)) >= 0.
Proof.
 move => h0 h1.
 simpl. rewrite IQR_1. apply Rle_ge.
 have -> : 1 - Env.nth i l * Env.nth i l= (1 - Env.nth i l) * (1 + Env.nth i l) by ring.
 apply Rmult_le_0_compat; last by done.  apply Rplus_le_le_0_compat; by [apply Rle_0_1 | done].
Qed.

Lemma sqr_bnds_correct l bnds p : conj_PExpr_nonneg l bnds -> all (var_0_1 bnds) (iota 1 (varmax p)%nat) ->  conj_PExpr_nonneg l (sqr_bnds (varmax p)).
Proof.
 move => Hyps hall.
 pose n := varmax p.
 have : conj_PExpr_nonneg l (sqr_bnds n); last by done.
 have : (forall i, (Pos.to_nat i <= n)%nat -> 0 <= Env.nth i l /\ 0 <= 1 - Env.nth i l) by apply all_vars_0_1 with (bnds:=bnds).
 unfold sqr_bnds. move => H.
 induction n => //.
replace (n.+1) with (n + 1)%nat; last  by rewrite  addn1.
have -> : [seq sqr_bnd i | i <- iota 1 (n+1)] = [seq sqr_bnd i | i <- iota 1 n]++[::(sqr_bnd n.+1)].
have iotan : [:: n.+1] =  iota (1 + n) 1 by done.
have :  iota 1 (n + 1) =  iota 1 n ++ [::n.+1]. rewrite iotan.
by apply (iota_add 1 n 1).  move => hn. rewrite hn. by rewrite map_cat.
apply conj_PExpr_nonneg_concat => //=. apply IHn. move => i. move => P. apply H.
 apply leq_trans with (n:=n); first by []; last by apply leqnSn.
 split; last by done.
have [h0 h1] : 0 <= Env.nth (Pos.of_nat (n.+1)) l /\ 0 <= 1 - Env.nth (Pos.of_nat (n.+1)) l.
apply H. rewrite Nat2Pos.id; [by apply ltnSn | done].
unfold PExpr_nonneg, sqr_bnd. by apply  var_0_1_sqr_0_1.
 Qed.


Lemma Putinar_Psatz_correct bnds hyps env obj r eig_pos summands :
let n:= (size summands - size ((bnds ++ sqr_bnds (varmax r)) ++ hyps))%nat in
conj_PExpr_nonneg env (bnds ++ hyps) -> all (var_0_1 bnds) (iota 1 (varmax r)) && all cnneg eig_pos && ((norm obj) ?== padd (Psatz_toPolC (nseq n (PEc cI) ++ ((bnds ++ (sqr_bnds (varmax r))) ++ hyps)) eig_pos summands) (psubC r (lower_bound_0_1 r))) -> 0 <= eval_expr env obj.
Proof.
move =>  n Hyps B. move/andP : B => [b1 NORM]. move/andP : b1 => [ENV EIG].
 apply conj_PExpr_nonneg_concat2 with (h1:=bnds) in Hyps. destruct Hyps as [Bnds Hyps].
- have Bndsqr : conj_PExpr_nonneg env (sqr_bnds (varmax r)) by apply sqr_bnds_correct with (bnds := bnds). 
- move  : (conj_PExpr_nonneg_concat env bnds (sqr_bnds (varmax r)) Bnds Bndsqr ) => Bnds_Bndsqr. 
- move  : (conj_PExpr_nonneg_concat env (bnds ++ sqr_bnds (varmax r)) hyps Bnds_Bndsqr Hyps) => allhyps.
unfold eval_expr.
rewrite (eval_pol_norm_aux Rsor QSORaddon env _ (padd (Psatz_toPolC (nseq n (PEc cI) ++ (
((bnds ++ sqr_bnds (varmax r)) ++ hyps)
))  eig_pos summands)(psubC r (lower_bound_0_1 r))) ).
- rewrite (eval_pol_add  Rsor QSORaddon).
apply Rplus_le_le_0_compat.
 + rewrite <- eval_interp_Psatz. apply thm_Putinar_Psatz. by apply conj_PExpr_nonneg_n. by [].
 + rewrite  (PsubC_ok Rsor  QSORaddon) rminus_aux2. apply (remainder_lemma Rsor QSORaddon). move => i h.
apply all_vars_0_1 with (bnds:=(bnds)) (p:=r). by []. by []. by []. by apply Rsor.
- by [].
Qed.
