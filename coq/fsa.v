Require Import ssreflect ssrbool eqtype ssrfun.
Require Import NArith.
Require Import Relation_Definitions.
Require Export Setoid.
(*****)
Require Import Env.
(*****)
(*Require Import List.*)
Require Import Bool.
Require Import OrderedRing.
Require Import Refl.
Require Import Iqr Realslemmas sos_horner remainder.
Require Import Reals Raxioms RIneq Rpow_def DiscrR.

Set Implicit Arguments.


Import OrderedRingSyntax.
Definition C := Iqr.C.
Definition PExpr := PExpr C.
(* Intervals for fsa functions *)
Inductive itv : Type := | Itv : C -> C -> itv.
Definition itv01 := Itv cO cI.

(** 
itv_arith: obtained with certified interval arithmetic
itv_sos : obtained with SOS certificate
itv_arith is mandatory to scale POP systems and bound the remainder eps_pop
**)

Require Import seq.
Record cert_pop := mk_cert_pop {
 remainder : PolC;
 eigs : seq Iqr.C;
 sos : seq Putinar_summand
}.



Definition cert_itv := (cert_pop * cert_pop)%type.
Definition certif_null := (mk_cert_pop P0 [::] [::], mk_cert_pop P0 [::] [::]).

Inductive Fsa : Type :=
  | Poly  : PExpr -> itv -> cert_itv -> Fsa
(*  | Fdivp : PExpr -> Fsa -> itv -> itv -> Fsa*)
  | Fdiv  : Fsa -> Fsa -> itv -> itv -> cert_itv -> Fsa
  | Fmul  : Fsa -> Fsa -> itv -> itv -> cert_itv -> Fsa
  | Fsub  : Fsa -> Fsa -> itv -> itv -> cert_itv -> Fsa
  | Fopp  : Fsa -> itv -> Fsa
  | Fadd  : Fsa -> Fsa -> itv -> itv -> cert_itv -> Fsa
  | Fsqrt : Fsa -> itv -> Fsa.


(* get the interval computed by interval arithmetics *)
Fixpoint get_itv (f : Fsa) := 
  match f with
  | Poly _ itv _ (*| Fdivp _ _ itv _*) | Fdiv _ _ itv _  _ | Fmul _ _ itv _ _ | Fsub _ _ itv _ _ | Fopp _ itv | Fadd _ _ itv _ _ | Fsqrt _ itv => itv end.

(* get the interval computed by SOS relaxations *)
Fixpoint get_itv_sos f := 
  match f with
  | Poly _ itv _ (*| Fdivp _ _ _ itv *)| Fdiv _ _ _ itv _ | Fmul _ _ _ itv _ | Fsub _ _ _ itv _ | Fopp _ itv | Fadd _  _ _ itv _ | Fsqrt _ itv => itv end.


Local Open Scope R_scope.

Set Implicit Arguments.

Lemma PEeval_sub l pe1 pe2 : eval_expr l (PEsub pe1 pe2) = (eval_expr l pe1) - (eval_expr l pe2).
Proof. by []. Qed.
Lemma PEeval_mul l pe1 pe2 : eval_expr l (PEmul pe1 pe2) = (eval_expr l pe1) * (eval_expr l pe2).
Proof. by []. Qed.

Definition rsqrt := sqrt.

Fixpoint Feval (l:Env R) (fsa:Fsa) : R := 
  match fsa with
  | Poly pe _ _ => eval_expr l pe
(*  | Fdivp pe f _ _ => (eval_expr l pe) / (Feval l f)*)
  | Fdiv f1 f2 _ _ _ => (Feval l f1) / (Feval l f2)
  | Fmul f1 f2 _ _ _ => (Feval l f1) * (Feval l f2)
  | Fsub f1 f2 _ _ _ => (Feval l f1) - (Feval l f2)
  | Fopp f1 _ => - (Feval l f1)
  | Fadd f1 f2 _ _ _ => (Feval l f1) + (Feval l f2)
  | Fsqrt f1 _ => rsqrt (Feval l f1)
  end.

Lemma Feval_sqrt f l i : Feval l (Fsqrt f i) = rsqrt (Feval l f).
Proof. by []. Qed.

Lemma r_div_mult r r1 r2 : r2 <> 0 -> (r * r2 = r1 <-> r =  r1 / r2).
Proof. 
move => hneq.
split.
have : r = (r * r2) / r2 by field.
move => feq meq.
by rewrite feq meq.
move => h. rewrite h. by field.
Qed.

Lemma r_div_mult2 r r1 r2 r'1 r'2 : r2 <> 0 -> r'1 = r1 -> r'2 = r2 ->  r'1 / r'2 = r -> r2 * r = r1.
Proof. 
move => hneq eq1 eq2 feq.
rewrite -eq2 -eq1 -feq. field. by rewrite eq2.
Qed.

Lemma r_sqrt f r f' r' : f >= 0 -> f' = f -> r' = r -> rsqrt f' = r -> r * r = f.
Proof.
move => fge eqf eqr eqsqrt.
rewrite -eqsqrt eqf.
apply sqrt_sqrt; by apply Rge_le.
Qed.


Lemma rneq_neq (r1 r2 : R) : r1 <> r2 -> r2 <> r1.
Proof.
move => h.
apply Rminus_not_eq.
have -> : r2 - r1 = -(r1 - r2) by ring.
apply Ropp_neq_0_compat.
by apply Rminus_eq_contra.
Qed.

Lemma r_lemma1 r1 r2 : r1 >= 0 -> r1 = r2 -> r2 >= 0.
Proof. 
 move => hge heq. by rewrite -heq.
Qed.

Lemma r_lemma2 r1 r2 : r1 - r2 >= 0 /\ r2 - r1 >= 0 <-> r1 = r2.
Proof.
 split.
 move => [h1 h2].
 apply Rge_ge_eq. split; by apply Rminus_ge.
 move => heq.
 split; apply Req_ge; rewrite heq; by ring.
Qed.

Lemma r_lemma_sub1 r1 r2 : r1 - r2 >= 0 <-> r1 >= r2.
Proof. split; [by apply Rminus_ge | by apply Rge_minus]. Qed.

Lemma r_lemma_sub2 r1 r2 r : r1 >= r2 -> r = r1 -> r >= r2.
Proof. move => hge eq. by rewrite eq. Qed.

Lemma r_lemma_sub3 r1 r2 r : r1 >= r2 -> r = r2 -> r1 >= r.
Proof. move => hge eq. by rewrite eq. Qed.

Lemma r_lemma_add r1 r'1 r2 r'2 : r1 = r'1 -> r2 = r'2 -> r1 + r2 = r'1 + r'2.
Proof. move => eq1 eq2. by rewrite eq1 eq2. Qed.

Lemma r_lemma_mul r1 r'1 r2 r'2 : r1 = r'1 -> r2 = r'2 -> r1 * r2 = r'1 * r'2.
Proof. move => eq1 eq2. by rewrite eq1 eq2. Qed.

Lemma r_lemma_sub r1 r'1 r2 r'2 : r1 = r'1 -> r2 = r'2 -> r1 - r2 =r'1 - r'2.
Proof. move => eq1 eq2. by rewrite eq1 eq2. Qed.
Lemma r_lemma_opp r r' : r = r' -> - r = -r'.
Proof. move => eq. by rewrite eq. Qed.

Definition fst_itv (itv : itv) : C := match itv with | Itv c1   => c1 end.
Definition snd_itv (itv : itv) : C := match itv with | Itv    c2 => c2 end.
Definition PEX := sos_horner.PEX C.
Definition lift_in_itv_fst j (itv : itv) : PExpr := PEsub (PEX j) (PEc (fst_itv itv)).
Definition lift_in_itv_snd j (itv : itv) : PExpr := PEsub (PEc (snd_itv itv)) (PEX j).
Definition pol_in_itv_fst p (itv : itv) : PExpr := PEsub p (PEc (fst_itv itv)).
Definition pol_in_itv_snd p (itv : itv) : PExpr := PEsub (PEc (snd_itv itv)) p.


(*Definition PExpr_nonneg l ineq : Prop :=  eval_expr l ineq >= 0.*)
Definition Fsa_nonneg l ineq : Prop := Feval l ineq >= 0.

Definition pol_in_itv l pj itv :=  PExpr_nonneg l (PEsub (pj) (PEc (fst_itv itv))) /\ PExpr_nonneg l (PEsub (PEc (snd_itv itv)) (pj)).
Definition fsa_in_itv l f itv := Feval l f >= IQR (fst_itv itv) /\ IQR (snd_itv itv) >= Feval l f.

 

Lemma PExpr_nonneg_sub l p1 p2 : PExpr_nonneg l (PEsub p1 p2) -> eval_expr l p1 >= eval_expr l p2.
Proof.
unfold PExpr_nonneg.
rewrite PEeval_sub.
apply r_lemma_sub1.
Qed.

Lemma pol_in_itv_left l p i : pol_in_itv l p i -> IQR(fst_itv i) <= eval_expr l p.
Proof. move => [h1 h]. apply Rge_le.
have -> : IQR (fst_itv i) = eval_expr l (PEc (fst_itv i)) by []. by apply PExpr_nonneg_sub.
Qed.

Lemma pol_in_itv_right l p i : pol_in_itv l p i -> eval_expr l p <= IQR(snd_itv i).
Proof. move => [h h2]. apply Rge_le.
have -> : IQR (snd_itv i) = eval_expr l (PEc (snd_itv i)) by []. by apply PExpr_nonneg_sub.
Qed.
Lemma fsa_in_itv_left l p i : fsa_in_itv l p i -> IQR(fst_itv i) <= Feval l p.
Proof. move => [h1 h]; by apply Rge_le. Qed.
Lemma fsa_in_itv_right l p i : fsa_in_itv l p i -> Feval l p <= IQR (snd_itv i).
Proof. move => [h1 h]; by apply Rge_le. Qed.


Definition gen_cstr_itv pe itv := [:: pol_in_itv_fst pe itv; pol_in_itv_snd pe itv].

Definition Ctype := (R * R * R)%type.
Definition triple : Ctype := (0, 0, 0).
Definition double := (0, 0).
Record pop := mk_pop {
 bndsvs : seq PExpr;
 cstr : seq PExpr;
 obj : PExpr;
 vf : positive;
 envfsa : seq Prop
}.


Fixpoint conj_envfsa envfsa := 
  match envfsa with 
  | [::]  => True
  | x::tl => x /\ conj_envfsa tl
  end.

Definition cstrnull := mk_pop [::] [::] (PEc cO) xH [::].
Definition fsa_pol_eq l f p := Feval l f = eval_expr l p.

Definition scale_obj obj itv :=    
  let (m, M)  := (fst_itv itv, snd_itv itv) in
   PEadd  (PEmul obj (PEc (cminus M m))) (PEc m).

Definition fmul0 f1 f2:= Fmul f1 f2 itv01 itv01 certif_null.
Definition fsub0 f1 f2:= Fsub f1 f2 itv01 itv01 certif_null.

Definition descale_fsa f itv :=    
  let (m, M)  := (fst_itv itv, snd_itv itv) in
  let pc := PEc (cinv (cminus M m)) in
  let pc2 := PEc (ctimes m (cinv (cminus M m))) in
   fsub0 (fmul0 (Poly pc itv01 certif_null) f) (Poly pc2 itv01 certif_null).


Fixpoint sa_lift l (bnds hyps : seq PExpr) f v : pop := 
  match f with
  | Poly pe itv _ => mk_pop bnds hyps pe v [::]
  | Fopp f1 _ => 
    let pop1 := sa_lift l bnds hyps f1 v in
    let obj1 := obj pop1 in
    let cstr1:= cstr pop1 in
    let bnds1 := bndsvs pop1 in
     mk_pop bnds1 cstr1 (PEopp obj1) (vf pop1) (envfsa pop1)
  | Fadd f1 f2 _ _ _ => 
    let pop1 := sa_lift l bnds hyps f1 v in
    let pop2 := sa_lift l bnds hyps f2 (vf pop1) in
    let (obj1, obj2)  := (obj pop1, obj pop2) in
    let (cstr1, cstr2):= (cstr pop1, cstr pop2) in
    let (envfsa1, envfsa2) := (envfsa pop1, envfsa pop2) in
     mk_pop bnds (cstr1 ++ cstr2)  (PEadd obj1 obj2) (vf pop2) (envfsa1 ++ envfsa2)
  | Fmul f1 f2 _ _ _ => 
    let pop1 := sa_lift l bnds hyps f1 v in
    let pop2 := sa_lift l bnds hyps f2 (vf pop1) in
    let (obj1, obj2)  := (obj pop1, obj pop2) in
    let (cstr1, cstr2):= (cstr pop1, cstr pop2) in
    let (envfsa1, envfsa2) := (envfsa pop1, envfsa pop2) in
     mk_pop bnds (cstr1 ++ cstr2) (PEmul obj1 obj2) (vf pop2) (envfsa1 ++ envfsa2)
  | Fsub f1 f2 _ _ _ => 
    let pop1 := sa_lift l bnds hyps f1 v in
    let pop2 := sa_lift l bnds hyps f2 (vf pop1) in
    let (obj1, obj2)  := (obj pop1, obj pop2) in
    let (cstr1, cstr2):= (cstr pop1, cstr pop2) in
    let (envfsa1, envfsa2) := (envfsa pop1, envfsa pop2) in
     mk_pop bnds (cstr1 ++ cstr2) (PEsub obj1 obj2) (vf pop2) (envfsa1 ++ envfsa2)
(*
  | Fdivp pe f2 _ =>
    let pop2          := sa_lift hyps f2 v in
    let obj2          := obj pop2 in
    let cstr2         := cstr pop2 in
    let obj_div       := PEX (vf pop2 + 1) in
    let cstr_div      := PEsub (PEmul obj2 obj_div) pe :: PEsub pe (PEmul obj2 obj_div) :: cstr2 ++ gen_cstr_itv obj2 (get_itv f2)  in
     mk_pop cstr_div obj_div (vf pop2 + 1)
*)
  | Fdiv f1 f2 itv itv_sos _ =>
    let (itv1, itv2)  := (get_itv_sos f1, get_itv_sos f2) in
    let pop1          := sa_lift l bnds hyps f1 v in
    let pop2          := sa_lift l bnds hyps f2 (vf pop1) in
    let (obj1, obj2)  := (pop1.(obj), pop2.(obj)) in
    let (cstr1, cstr2):= (pop1.(cstr), pop2.(cstr)) in
    let (envfsa1, envfsa2) := (envfsa pop1, envfsa pop2) in
    let obj_div_tmp   := PEX (vf pop2 + 1) in (* obj_div_tmp lies in itv *)
    let obj_div       := scale_obj obj_div_tmp itv in
    let cstr_div      := cstr1 ++ cstr2 ++ [::PEsub (PEmul obj2 obj_div) obj1; PEsub obj1 (PEmul obj2 obj_div)] (*++ gen_cstr_itv obj1 itv1 ++ gen_cstr_itv obj2 itv2*) in
    let bnds_div      := bnds ++ gen_cstr_itv obj_div_tmp itv01 in
     mk_pop bnds_div cstr_div obj_div (vf pop2 + 1) (envfsa1 ++ envfsa2 ++ [::fsa_pol_eq l (descale_fsa f itv) obj_div_tmp])
  | Fsqrt a itv => 
    let r := sa_lift l bnds hyps a v in 
    let itva := get_itv_sos a in
    let obja := obj r in
    let v_arg := vf r in
    let v_sqrt := (v_arg + 1)%positive in
    let obj_tmp := PEX v_sqrt in
    let obj := scale_obj obj_tmp itv in
    let cstr := cstr r ++ [::PEsub (PEmul obj obj) obja ; PEsub obja (PEmul obj obj)] in (*gen_cstr_itv obja itva*)
    let bnds := bndsvs r ++ gen_cstr_itv obj_tmp itv01 in
     mk_pop bnds cstr obj v_sqrt (envfsa r ++ [::fsa_pol_eq l (descale_fsa f itv) obj_tmp])
(*
    let res_one := gen_cstr hyps f1 v in
    let v_one := res_one.2 in
    let res_two := gen_cstr hyps f2 v_one in
    let v_two := res_two.2 in
    let v_three := (v_two + 1)%positive in
    let obj := PEX v_three in
    ( PEsub (PEmul res_two.1.2 obj) res_one.1.2 :: PEsub res_one.1.2 (PEmul res_two.1.2 obj) :: gen_cstr_itv res_one.1.2 (get_itv f1) ++  gen_cstr_itv res_two.1.2 (get_itv f2) ++ res_one.1.1 ++ res_two.1.1, obj, v_three)
*)
 end.

Definition peadd p1 p2 : PExpr := PEadd p1 p2.
Notation "x + y" := (peadd x y).
Definition pesub p1 p2 : PExpr := PEsub p1 p2.
Notation "x - y" := (pesub x y).
Definition pemul p1 p2 : PExpr := PEmul p1 p2.
Notation "x * y" := (pemul x y).
(* Infix "-" := rsub.*) Notation "- x" := (PEopp x).

Local Open Scope positive.
Fixpoint var (f : Fsa) v  : positive :=
  match f with
   | Poly pe itv _ => v
   | Fopp a _ => var a v
   | Fadd f1 f2 _ _ _ | Fsub f1 f2 _ _ _ | Fmul f1 f2 _ _ _ => var f2 (var f1 v)
   | Fdiv f1 f2 _ _ _ => (var f2 (var f1 v) + 1)
   | Fsqrt a _ =>  (var a v + 1)
  end.
Local Close Scope positive.
Fixpoint get_obj (f : Fsa) v : PExpr := 
  match f with
   | Poly pe itv _ => pe
   | Fopp f1 _ => - (get_obj f1 v)
   | Fadd f1 f2 _ _ _ => (get_obj f1 v) + (get_obj f2 (var f1 v))
   | Fmul f1 f2 _ _ _ => (get_obj f1 v) * (get_obj f2 (var f1 v))
   | Fsub f1 f2 _ _ _ => (get_obj f1 v) - (get_obj f2 (var f1 v))
   | Fdiv f1 f2 itv _ _ => scale_obj (PEX (var f2 (var f1 v) + 1)) itv
   | Fsqrt a itv => scale_obj (PEX (var a v + 1)) itv
  end.

Fixpoint get_envfsa l f v : (seq Prop) := 
  match f with 
   | Poly pe itv _ => [::]
   | Fopp a _ => get_envfsa l a v
   | Fadd f1 f2 _ _ _ | Fsub f1 f2 _ _ _ | Fmul f1 f2 _ _ _ => get_envfsa l f1 v ++ get_envfsa l f2 (var f1 v)
   | Fdiv f1 f2 itv _ _ => get_envfsa l f1 v ++ get_envfsa l f2 (var f1 v) ++ [::fsa_pol_eq l (descale_fsa f itv)  (PEX (var f2 (var f1 v) + 1))]
   | Fsqrt a itv =>  get_envfsa l a v ++ [::fsa_pol_eq l (descale_fsa f itv)  (PEX (var a v + 1))]
  end.

Fixpoint get_bnds f v : seq PExpr :=
  match f with 
   | Poly pe itv _ => [::]
   | Fopp a _ => get_bnds a v
   | Fadd f1 f2 _ _ _ | Fsub f1 f2 _ _ _ | Fmul f1 f2 _ _ _ => get_bnds f1 v ++ get_bnds f2 (var f1 v)
   | Fdiv f1 f2 itv _ _ => get_bnds f1 v ++ get_bnds f2 (var f1 v) ++ gen_cstr_itv (PEX (var f2 (var f1 v) + 1)) itv01
   | Fsqrt a itv => get_bnds a v ++ gen_cstr_itv (PEX (var a v + 1)) itv01
  end.

Fixpoint get_cstr f v : seq PExpr := 
  match f with 
   | Poly pe itv _ => [::]
   | Fopp a _ => get_cstr a v
   | Fadd f1 f2 _ _ _ | Fsub f1 f2 _ _ _ | Fmul f1 f2 _ _ _ => get_cstr f1 v ++ get_cstr f2 (var f1 v)
   | Fdiv f1 f2 itv _ _ => get_cstr f1 v ++ get_cstr f2 (var f1 v) ++ [::PEsub (PEmul (get_obj f2 (var f1 v)) (get_obj f v)) (get_obj f1 v); PEsub (get_obj f1 v) (PEmul (get_obj f2 (var f1 v)) (get_obj f v))]
   | Fsqrt a itv => get_cstr a v ++ [::PEsub (PEmul (get_obj f v) (get_obj f v)) (get_obj a v) ; PEsub (get_obj a v) (PEmul (get_obj f v) (get_obj f v))]
  end.

Definition checker_pop bnds hyps obj cert := 
let n:= (size (sos cert) - size ((bnds ++ sqr_bnds (varmax (remainder cert))) ++ hyps))%nat in
all (var_0_1 (bnds)) (iota 1 (varmax (remainder cert))) &&  all cnneg (eigs cert) && ((norm (obj)) ?== padd (Psatz_toPolC (nseq n (PEc cI)++((bnds ++ (sqr_bnds (varmax (remainder cert)) )) ++ hyps)) (eigs cert) (sos cert)) (psubC (remainder cert) (lower_bound_0_1 (remainder cert)))).


Definition checker_pop_itv bnds hyps p cert_itv itv :=  (checker_pop bnds hyps (PEsub p (PEc (fst_itv itv))) cert_itv.1 && checker_pop bnds hyps  (PEsub (PEc (snd_itv itv)) p) cert_itv.2).

Lemma Putinar_Psatz_correct_itv l bnds hyps p cert_itv itv : conj_PExpr_nonneg l (bnds ++ hyps) -> checker_pop_itv bnds hyps p cert_itv itv -> pol_in_itv l p itv.
Proof.
  move => Hyps. move/andP => [C1 C2]. split;  unfold PExpr_nonneg; apply Rle_ge.
- by apply (Putinar_Psatz_correct bnds hyps l (PEsub p (PEc (fst_itv itv))) (remainder cert_itv.1) (eigs cert_itv.1) (sos cert_itv.1)).
- by apply (Putinar_Psatz_correct bnds hyps l (PEsub (PEc (snd_itv itv)) p) (remainder cert_itv.2) (eigs cert_itv.2) (sos cert_itv.2)).
Qed.



(*
Definition pop_valid l hyps p itv := conj_PExpr_nonneg l hyps -> pol_in_itv l p itv.
*)

Definition itv_eq i1 i2 := (fst_itv i1[=] fst_itv i2) && (snd_itv i1[=] snd_itv i2).
Definition itv_opp i := Itv (copp (snd_itv i)) (copp (fst_itv i)).
Definition itv_add i1 i2 := Itv (cplus (fst_itv i1) (fst_itv i2))  (cplus (snd_itv i1) (snd_itv i2)).
Definition itv_sub i1 i2 := itv_add i1 (itv_opp i2).

Notation "x [<] y" := (cltb x y). Notation "x [=] y" := (ceqb x y). Notation "x [<=] y" := (cleb x y).

Definition itv_without_0 itv := (cO  [<] fst_itv itv) || (snd_itv itv [<] cO).
Definition itv_pos itv := (cO [<] fst_itv itv) &&  (cO [<] snd_itv itv).
Definition is_opp_itv i1 i2 := (fst_itv i1 [=] copp (snd_itv i2)) && (snd_itv i1 [=] copp (fst_itv i2)).
(* sqrt i1 belongs to i2 *)
Definition belongs i1 i2 := (fst_itv i2 [<=] fst_itv i1) &&  (snd_itv i1 [<=] snd_itv i2).
Definition itv_sqr i := Itv (csquare (fst_itv i)) (csquare (snd_itv i)).
Definition itv_correct i := fst_itv i [<=] snd_itv i.
Definition itv_strict_correct i := fst_itv i [<] snd_itv i.

Definition itv_inv i := Itv (cinv (snd_itv i)) (cinv (fst_itv i)).
Definition belongs_inv_itv i1 i2 := belongs i1 (itv_inv i2).

Definition itv_mult i1 i2 := match i1, i2 with
 | Itv a b, Itv c d => Itv (cmin (cmin (cmin (ctimes a d) (ctimes a c)) (ctimes b c)) (ctimes b d)) (cmax (cmax (cmax (ctimes a d) (ctimes a c)) (ctimes b c)) (ctimes b d))
 end.

Definition itv_div i1 i2 := itv_mult i1 (itv_inv i2).
Definition belongs_sqrt_itv i1 i2 := itv_pos i1 && itv_pos i2 && belongs i2 (itv_sqr i1).
Definition belongs_div_itv i i1 i2 := itv_without_0 i2 && itv_correct i2 && belongs (itv_div i1 i2) i.
Definition belongs_add_itv i i1 i2 := belongs (itv_add i1 i2) i.
Lemma pol_in_itv_belongs l p i1 i2 : belongs i1 i2 -> pol_in_itv l p i1 -> pol_in_itv l p i2.
Proof. split; move/andP : H => [h1 h2].
- apply pol_in_itv_left in H0. unfold PExpr_nonneg; simpl; apply r_lemma_sub1, Rle_ge. by apply Rle_trans with (r2:=IQR (fst_itv i1)); [apply IQR_le | done].
- apply pol_in_itv_right in H0. unfold PExpr_nonneg; simpl; apply r_lemma_sub1, Rle_ge. by apply Rle_trans with (r2:=IQR (snd_itv i1)); [done | apply IQR_le].
Qed.

Local Open Scope R_scope.
Lemma raux11 (r r1 r2 : R) : r + r1 - r2 = r + (r1 - r2). 
Proof. by ring. Qed.

Lemma scale_obj_itv l obj itv : itv_strict_correct itv -> pol_in_itv l (scale_obj obj itv) itv -> pol_in_itv l obj itv01.
Proof. 
unfold itv_strict_correct, pol_in_itv, PExpr_nonneg, scale_obj => //. do 3 rewrite PEeval_sub. simpl.
move => Itv [hlo hup]. pose m := fst_itv itv. pose M := snd_itv itv. rewrite IQR_0 IQR_1 Rminus_0_r.

rewrite raux11 in hlo. rewrite Rminus_diag_eq   in hlo; last by []. rewrite Rplus_0_r Rmult_comm in hlo.
move : hup. rewrite Rmult_comm raux9 -IQR_minus raux10. move => hup. 
split; apply Rle_ge; apply (r6 (IQR (cminus M m))).
- rewrite IQR_minus; apply Rgt_lt, Rgt_minus; by apply Rlt_gt, IQR_lt. by apply Rge_le.
- rewrite IQR_minus. apply Rgt_lt, Rgt_minus. by apply Rlt_gt, IQR_lt. by apply Rge_le.
Qed.



(*
Require Import BigQ.
Local Open Scope bigQ.
Definition i1 := Itv 2 3.
Definition i2 := Itv 4 7.
Eval compute in itv_div i1 i2.
Definition i := Itv (9#28) (15#28).
Eval compute in belongs_div_itv (itv_opp i) i1 i2.
*)

(*
Definition belongs_itv_inv i1 i2 := itv_without_0 i1 &&  itv_without_0 i2 && 1 [=] ctimes (snd_itv i2) (fst_itv i1) && ctimes (fst_itv i2) (snd_itv i1).
*)

(*OLD
Definition get_obj l bnds hyps f v := obj (sa_lift l bnds hyps f v).
Definition var l bnds hyps f v := vf (sa_lift l bnds hyps f v).
Definition get_cstr l bnds hyps f v := cstr (sa_lift l bnds hyps f v).
Definition get_bnds l bnds hyps f v := bndsvs (sa_lift l bnds hyps f v).
Definition get_envfsa l bnds hyps f v := envfsa (sa_lift l bnds hyps f v).


Lemma get_obj_add l bnds hyps f1 f2 itv i v cert : get_obj l bnds hyps (Fadd f1 f2 itv i cert) v = PEadd (get_obj l bnds hyps f1 v) (get_obj l bnds hyps f2 (var l bnds hyps f1 v)).
Proof. unfold get_obj. unfold obj. simpl. trivial. Qed.

Lemma get_obj_div l bnds hyps f1 f2 itv itv_sos v cert : get_obj l bnds hyps (Fdiv f1 f2 itv itv_sos cert) v = scale_obj (PEX ((var l bnds hyps f2 (var l bnds hyps f1 v)) + 1)) itv.
Proof. by []. Qed.

Lemma get_obj_sqrt l bnds hyps f itv v : get_obj l bnds hyps (Fsqrt f itv) v = scale_obj( PEX (
(var l bnds hyps f v) + 1)) itv.
Proof. by []. Qed.

Lemma get_obj_pol l bnds hyps p v itv cert: get_obj l bnds hyps (Poly p itv cert) v = p.
Proof. by []. Qed.

Lemma get_obj_opp l bnds hyps f itv v : get_obj l bnds hyps (Fopp f itv) v = PEopp (get_obj l bnds hyps f v).
Proof. by []. Qed.


Lemma get_cstr_pol l bnds hyps p itv v cert:  get_cstr l bnds hyps (Poly p itv cert) v = hyps.
Proof. by []. Qed.
*)


Lemma scale_fsa_obj_impl l f obj itv : itv_strict_correct itv -> fsa_pol_eq l (descale_fsa f itv) obj -> fsa_pol_eq l f (scale_obj obj itv).
Proof.
 move => I. unfold fsa_pol_eq, descale_fsa. simpl. move => h. rewrite -h. by apply IQR_scale.
Qed.



Fixpoint checker_fsa_itv bnds hyps f v is_root :=
  match f with 
  | Poly p itv cert => checker_pop_itv bnds hyps p cert itv
(*
  | Fdivp _ f2 itv => checker_fsa_itv l hyps f2 v /\ fsa_pol_eq l f obj /\ itv_without_0 (get_itv f2) /\ pop_valid l cstr obj itv
*)
  | Fdiv f1 f2 itv itv_sos cert => checker_fsa_itv bnds hyps f1 v is_root && checker_fsa_itv bnds hyps f2 (var f1 v) is_root &&  belongs_div_itv itv (get_itv_sos f1) (get_itv_sos f2) && itv_strict_correct itv  && checker_pop_itv (bnds ++ (get_bnds f v)) (hyps ++ (get_cstr f v)) (get_obj f v) cert itv_sos
  | Fadd f1 f2 itv itv_sos cert | Fmul f1 f2 itv itv_sos cert | Fsub f1 f2 itv itv_sos cert => checker_fsa_itv bnds hyps f1 v false && checker_fsa_itv bnds hyps f2 (var f1 v) false && (*if is_root then*) checker_pop_itv (bnds ++ (get_bnds f v)) (hyps ++ (get_cstr f v)) (get_obj f v) cert itv_sos (*else (itv_eq itv itv_sos &&  belongs_add_itv itv (get_itv_sos f1) (get_itv_sos f2))*)
  | Fsqrt a itv => checker_fsa_itv bnds hyps a v is_root &&  itv_pos (get_itv_sos a) && itv_strict_correct itv && belongs_sqrt_itv itv (get_itv_sos a)   
  | Fopp a itv => checker_fsa_itv bnds hyps a v is_root && is_opp_itv itv (get_itv_sos a)
  end.

Lemma checker_fsa_itv_pol l bnds hyps p itv v cert is_root : conj_PExpr_nonneg l (bnds ++ hyps) -> checker_fsa_itv bnds hyps (Poly p itv cert) v is_root -> pol_in_itv l p itv.
Proof. by apply Putinar_Psatz_correct_itv. Qed.

Definition pol_non_null l pe := 0 <> eval_expr l pe.
Definition fsa_non_null l pe := 0 <> Feval l pe.

Lemma eqs_div_aux2 l p itv : itv_without_0 itv -> pol_in_itv l p itv -> pol_non_null l p.
Proof.
 unfold itv_without_0, pol_in_itv, pol_non_null, PExpr_nonneg; simpl. move => hb [h1 h2].
 move/orP : hb.
 case; move => hb; apply IQR_lt in hb; rewrite IQR_0 in hb.
 - apply Rlt_not_eq; apply Rlt_le_trans with (r2:=IQR (fst_itv itv)); [done | apply Rminus_ge in h1; by apply Rge_le].
 - apply Rgt_not_eq; apply Rgt_ge_trans with (r2:=IQR (snd_itv itv)); [by apply Rgt_lt | by apply Rminus_ge in h2].
Qed.

Lemma fsa_non_null_aux  l p itv : itv_without_0 itv -> fsa_in_itv l p itv -> fsa_non_null l p.
Proof.
 unfold itv_without_0, fsa_in_itv, fsa_non_null; simpl. move => hb [h1 h2].
 move/orP : hb.
 case; move => hb; apply IQR_lt in hb; rewrite IQR_0 in hb.
 - by apply Rlt_not_eq; apply Rlt_le_trans with (r2:=IQR (fst_itv itv)); [done | apply Rge_le].
 - by apply Rgt_not_eq; apply Rgt_ge_trans with (r2:=IQR (snd_itv itv)); [apply Rgt_lt | done].
Qed.

Lemma fsa_pol_in_itv l p f i : fsa_pol_eq l f p -> pol_in_itv l p i -> fsa_in_itv l f i.
Proof. unfold fsa_pol_eq, pol_in_itv, PExpr_nonneg, fsa_in_itv. simpl.
move => heq [h1 h2]. rewrite heq. split; by apply Rminus_ge.
Qed.
Lemma pol_fsa_in_itv l p f i : fsa_pol_eq l f p -> fsa_in_itv l f i -> pol_in_itv l p i.
Proof.  unfold fsa_pol_eq, pol_in_itv, PExpr_nonneg, fsa_in_itv. simpl.
move => heq [h1 h2]. rewrite -heq. split; by apply Rge_minus.
Qed.


Lemma eqs_sqrt_aux l p itv :  itv_pos itv -> pol_in_itv l p itv -> eval_expr l p > 0.
Proof.  
 unfold itv_pos, pol_in_itv, PExpr_nonneg => /andP [hb1 hb2] [h1 h2]. simpl in h1; apply IQR_lt in hb1; rewrite IQR_0 in hb1. apply Rlt_le_trans with (r2:=IQR (fst_itv itv)); [by [] | apply Rminus_ge in h1; by apply Rge_le].
Qed.

Lemma pol_in_itv_opp l p i1 i2 : is_opp_itv i1 i2 -> pol_in_itv l p i2 -> pol_in_itv l (PEopp p) i1.
Proof. 
 unfold is_opp_itv, pol_in_itv, PExpr_nonneg. move/andP => [hb1 hb2] [h1 h2].
 split; simpl. 
 - have -> : IQR (fst_itv i1) = IQR (copp (snd_itv i2)) by apply IQR_eq.
   rewrite IQR_opp. simpl in h2. have <- : IQR (snd_itv i2) - eval_expr l p = - eval_expr l p - - IQR (snd_itv i2) by ring. by [].
 - have -> : IQR (snd_itv i1) = IQR (copp (fst_itv i2)) by apply IQR_eq.
   rewrite IQR_opp. simpl in h1. have <- : eval_expr l p - IQR (fst_itv i2) = - IQR (fst_itv i2) - - eval_expr l p by ring. by [].
Qed.

 
Lemma pol_in_itv_sqrt l p1 p2 i1 i2 : belongs_sqrt_itv i1 i2 -> PExpr_nonneg l p1 -> pol_in_itv l p2 i2 -> eval_expr l (PEmul p1 p1) = eval_expr l p2 -> pol_in_itv l p1 i1.
Proof. 
 unfold belongs_sqrt_itv. move/andP => [hb1 hb3] h hnneg heq. simpl in heq. move/andP : hb1 => [hb1 hb2]. 
   (*move : hb1 => /andP [hb1fst hb1snd]. move : hb2 => /andP [hb2fst hb2snd]. *)
 - have hnneg2 : 0 <= eval_expr l p2  by apply Rge_le, Rgt_ge, eqs_sqrt_aux with (itv := i2). 
 - have hsqrt : rsqrt (eval_expr l p2) = eval_expr l p1.
   apply sqrt_lem_1. by []. by apply Rge_le. by []. 
 - have sqr1 : IQR (csquare (fst_itv i1)) = IQR (fst_itv i1) * IQR (fst_itv i1). rewrite -IQR_mult. apply IQR_eq. rewrite csquare_aux. unfold ctimes. by apply ceq_eqb.
 - have sqrt1 : rsqrt (IQR (csquare (fst_itv i1))) =  IQR (fst_itv i1). apply sqrt_lem_1. apply IQR_le0_square. apply Rlt_le. rewrite -IQR_0. move : hb1 => /andP [hb1fst hb1snd]. by apply IQR_lt. by [].
 - have sqr2 : IQR (csquare (snd_itv i1)) = IQR (snd_itv i1) * IQR (snd_itv i1). rewrite -IQR_mult. apply IQR_eq. rewrite csquare_aux. unfold ctimes. by apply ceq_eqb.
 - have sqrt2 : rsqrt (IQR (csquare (snd_itv i1))) =  IQR (snd_itv i1). apply sqrt_lem_1. apply IQR_le0_square. apply Rlt_le. rewrite -IQR_0. move : hb1 => /andP [hb1fst hb1snd]. by apply IQR_lt. by [].
- 
 unfold itv_sqr, belongs in hb3. simpl in hb3. move/andP : hb3 => [hb12 hb21].
 have lo : IQR (csquare (fst_itv i1))  <= eval_expr l p1 * eval_expr l p1. rewrite heq. apply Rle_trans with (r2:= IQR(fst_itv i2)). by apply IQR_le. by apply pol_in_itv_left.
 have up : eval_expr l p1 * eval_expr l p1 <= IQR (csquare (snd_itv i1)). rewrite heq. apply Rle_trans with (r2:= IQR(snd_itv i2)). by apply pol_in_itv_right. by apply IQR_le.
 have lo1 : IQR (fst_itv i1) <=  eval_expr l p1.
 rewrite -hsqrt -sqrt1. apply sqrt_le_1. apply IQR_le0_square. by []. by rewrite -heq.
 have up1 : eval_expr l p1 <= IQR (snd_itv i1).
 rewrite -hsqrt -sqrt2. apply sqrt_le_1. by []. apply IQR_le0_square. by rewrite -heq.
-split; unfold PExpr_nonneg; simpl; apply r_lemma_sub1; by apply Rle_ge.
Qed. 

Lemma Rinv1 r : 1 / r = / r.
Proof. unfold Rdiv. by ring. Qed.


Lemma itv_pos_without_0_left i :  itv_without_0 i -> itv_correct i -> cO [~=] fst_itv i.
Proof. unfold itv_without_0, itv_correct. move/ orP. case => hpos h.
- unfold cltb in hpos. move /andP : hpos => [] //=.
- rewrite cneq_neqb. apply cleq_aux2 in h. unfold cltb in hpos. move/andP : hpos => [h1 h2]. move : h h1 h2. rewrite cleq_aux2 cneq_neqb. corder. Qed.


Lemma itv_pos_without_0_right i :  itv_without_0 i -> itv_correct i -> cO [~=] snd_itv i.
Proof. unfold itv_without_0, itv_correct. move/ orP. case; unfold cltb; move/andP => [h1 h2]; move : h1 h2; rewrite cneq_neqb cleq_aux2; rewrite cneq_neqb cleq_aux2; corder.
Qed.


Lemma cinv_lt0 q : clt cO q -> clt cO (cinv q).
Proof. unfold clt, cO, cinv. BigQ.BigQ.qify. apply QArith_base.Qinv_lt_0_compat. Qed.

Lemma cinv_ltb0 q : cO [<] q -> cO [<] (cinv q).
Proof. do 2 rewrite cltb_lt. by apply cinv_lt0. Qed.

Lemma rlt_false x y : x < y -> y < x -> False.
Proof. move => ineq. apply Rle_not_lt. by apply Rlt_le. Qed.

(*
Lemma clt_minus q : clt q cO -> clt cO (copp q).
Proof. unfold clt, cO, copp. have  BigQ.BigQ.qify. move => h. apply QArith_base.Qopp_le_compat. BigQ.bigQ_order.
*)

Require Import QArith BigQ.
Lemma compat_inv_opp q : q < 0 -> - / q == / - q. 
Proof. move => h. field. by apply Qlt_not_eq. Qed.

Local Open Scope bigQ.
Lemma cinv_gt0 q : clt q cO -> clt (cinv q) cO.
Proof. unfold clt, cO, cinv.  BigQ.BigQ.qify. move => h. 
 - have ineq : (0 < - [q])%Q. move : h. rewrite QArith_base.Qlt_minus_iff. by rewrite  QArith_base.Qplus_0_l.
 - rewrite QArith_base.Qlt_minus_iff. rewrite QArith_base.Qplus_0_l. rewrite compat_inv_opp. by apply QArith_base.Qinv_lt_0_compat. by done. 
Qed.

Lemma itv_inv_without_0 i : itv_without_0 i -> itv_correct i -> itv_without_0 (itv_inv i).
Proof. unfold itv_without_0, itv_correct. simpl. move /orP => h0. case h0 => h1 h2; apply /orP.
- left. have h : cO[<]snd_itv i. move : h1 h2. do 2 rewrite cltb_lt. rewrite cleq_aux2. corder. by apply cinv_ltb0.
- right. rewrite cltb_lt. apply  cinv_gt0. move : h1 h2. rewrite cltb_lt cleq_aux2. corder.
Qed.

(*
Lemma itv_inv_correct i : itv_without_0 i -> itv_correct i ->  itv_correct (itv_inv i).
Proof. unfold itv_without_0, itv_correct.  simpl. move /orP => h0. do 2 rewrite cleq_aux2. unfold cle, cinv. case h0 => h1 h2.
- BigQ.qify. 
*)

Open Local Scope R_scope.
Lemma Rge_Rinv x y : x < 0 -> y < 0 -> x <= y -> / y <= / x.
Proof.
 move => xlt ylt xyle.
 apply Ropp_le_contravar in xyle.
 apply Ropp_le_cancel.
 have -> : - / x = / - x. field; by apply Rlt_not_eq.  have -> : - / y = / - y. field; by apply Rlt_not_eq.
 apply Rle_Rinv; last by done. apply Ropp_lt_cancel. have -> : - - y  = y by ring. by have -> : - 0 = 0 by ring. apply Ropp_lt_cancel. have -> : - - x  = x by ring. by have -> : - 0 = 0 by ring. 
Qed.


Local Open Scope R_scope.
Lemma fsa_in_itv_inv l p i invp : itv_without_0 i -> itv_correct i -> fsa_in_itv l p i -> Feval l invp  = 1 / Feval l p -> fsa_in_itv l invp (itv_inv i).
Proof. 
move => hneq hcorr hinv hmult. 
 - have hnnull : fsa_non_null l p by apply fsa_non_null_aux with (itv:=i). 
 - have iqr : IQR (fst_itv i) <= IQR (snd_itv i). by apply IQR_le.
split; simpl; unfold PExpr_nonneg; simpl; rewrite hmult; move: (fsa_in_itv_left hinv) => hleft;  move: (fsa_in_itv_right hinv) => hright; unfold pol_non_null in hnnull; apply Rdichotomy in hnnull; case hnnull => h.
  - have sndinv : 1 / Feval l p >= IQR (cinv (snd_itv i)).
  + apply Rle_Rinv in hright. apply Rle_ge. rewrite IQR_inv. by rewrite Rinv1.
    unfold itv_without_0 in hneq. by apply itv_pos_without_0_right. by []. by apply Rlt_le_trans with (r2:= Feval l p). by [].
  - have sndinv : 1 / Feval l p >= IQR (cinv (snd_itv i)).
  + apply Rge_Rinv in hright. apply Rle_ge. rewrite IQR_inv. by rewrite Rinv1.
    unfold itv_without_0 in hneq. by apply itv_pos_without_0_right. by apply Rgt_lt.
    unfold itv_without_0 in hneq. move/orP : hneq. case => hneq.
    + have hcontr1 : IQR (fst_itv i) < 0. apply Rle_lt_trans with (r2:=  Feval l p); [by done | by apply Rgt_lt].
    + have hcontr2 : 0 < IQR (fst_itv i). rewrite -IQR_0. by apply IQR_lt. 
    + by move : (rlt_false hcontr1 hcontr2).
  + rewrite -IQR_0. apply IQR_lt.  by []. by [].
- apply Rle_Rinv in hleft. rewrite IQR_inv. rewrite Rinv1.  unfold itv_without_0 in hneq. by apply Rle_ge. apply itv_pos_without_0_left.  unfold itv_without_0 in hneq. move/orP : hneq. case => hneq. unfold itv_without_0. apply/orP. by left. unfold itv_without_0. apply/orP. by right. by [].
    + rewrite -IQR_0. apply IQR_lt. 
    + have hcontr1 : 0 < IQR (snd_itv i). apply Rlt_le_trans with (r2:=  Feval l p); by []. 
     unfold itv_without_0 in hneq. move/orP : hneq. case => hneq. by [].
    + have hcontr2 : IQR (snd_itv i) < 0. rewrite -IQR_0. by apply IQR_lt.
    + move : (rlt_false hcontr1 hcontr2). by []. by [].
  + have hfstneg :IQR (fst_itv i) < 0  by apply Rle_lt_trans with (r2:= Feval l p).
  apply Rle_ge. rewrite IQR_inv. rewrite Rinv1; first by apply Rge_Rinv. rewrite -IQR_0 in hfstneg.
  by apply itv_pos_without_0_left.
Qed.

Lemma Rle_le_dec r1 r2 : r1 <= r2 \/ r2 <= r1.
Proof. 
move : (Rlt_or_le r1 r2). case.
- left; by apply Rlt_le.
- right; by done.
Qed.

Lemma cle_le_dec q1 q2 : q1 [<=] q2 \/ q2 [<=] q1.
Proof. do 2 rewrite cleq_aux2. unfold cle. BigQ.qify. move : (Qlt_le_dec [q1] [q2]). case.
- left; by apply Qlt_le_weak.
- right; by done.
Qed.

(*
Lemma Rmult_le_compat_neg r1 r2 r3 r4 : r1 <= 0 -> 0 <= r3 -> r1 <= r2 -> r3 <= r4 -> r1 * r3 <= r2 * r4.
*)

Lemma Rmult_le_compat_l_minus r r1 r2 : r <= 0 -> r1 <= r2 -> r * r2 <= r * r1.
Proof. move => h0 h1. have -> : r * r1 = - ((-r) * r1) by ring. have -> : r * r2 = - ((-r) * r2) by ring. apply Ropp_le_contravar. apply Ropp_le_contravar in h0. have h00 : 0 = -0 by ring. rewrite -h00 in h0. by apply Rmult_le_compat_l.
Qed.

Lemma Rmult_le_compat_r_minus r r1 r2 : r <= 0 -> r1 <= r2 -> r2 * r <= r1 * r.
Proof. have -> : r1 * r = r * r1 by ring. have -> : r2 * r = r * r2 by ring. by apply Rmult_le_compat_l_minus.
Qed.

Lemma mult_aux1 p1 p2 a b c d : 0 <= p1 -> a <= p1 -> p1 <= b -> c <= p2 -> p2 <= d -> p1 * p2 <= a * d \/ p1 * p2 <= b * d.
Proof.
move : (Rle_le_dec 0 p2). case.
- right; by apply Rmult_le_compat.
- move : (Rle_le_dec 0 d). case.
  + right. have : p1 * d <= b * d by apply Rmult_le_compat_r. apply Rle_trans.  by apply Rmult_le_compat_l.
  + left. apply Rle_trans with (r2:= p1 * d). by apply Rmult_le_compat_l. by apply Rmult_le_compat_r_minus.
Qed.

Lemma mult_aux2 p1 p2 a b c d :  p1 <= 0 -> a <= p1 -> p1 <= b -> c <= p2 -> p2 <= d ->  p1 * p2 <= a * c \/ p1 * p2 <= b * c \/ p1 * p2 <= b * d.
Proof. 
move : (Rle_le_dec 0 p2). case.
- move => h2 h1 ha hb hc hd. move : (mult_aux1 h2 hc hd ha hb). have -> : b * c = c * b by ring.  have -> : d * b = b * d by ring. have -> : p2 * p1 = p1 * p2 by ring. right. by [].
- left. have -> : p1 * p2 = (-p1) * (-p2) by ring. have -> : a * c = (- a) * (- c) by ring. 
  apply Rmult_le_compat. have -> : 0 = -0 by ring. by apply Ropp_le_contravar. have -> : 0 = -0 by ring. by apply Ropp_le_contravar. by apply Ropp_le_contravar. by apply Ropp_le_contravar. 
Qed.

Lemma mult_aux_max  p1 p2 a b c d : a <= p1 -> p1 <= b -> c <= p2 -> p2 <= d -> p1 * p2 <= a * d \/ p1 * p2 <= a * c \/ p1 * p2 <= b * c \/ p1 * p2 <= b * d.
Proof.
move : (Rle_le_dec 0 p1). case. 
move => h1 ha hb hc hd.
move : (mult_aux1 h1 ha hb hc hd). case.
left; by done.
right. right. right; by done.
right; by apply mult_aux2.
Qed.


Lemma Ropp_le a b c d : - a * b <= - c * d <->  c * d <= a * b.
Proof. have -> : - a * b = - (a * b) by ring.  have -> : - c * d = - (c * d) by ring.  split. by apply Ropp_le_cancel.  by apply Ropp_le_contravar. Qed.

Lemma disj_iff A B : A \/ B <-> B \/ A.
Proof. split. case; [by right | by left]. case; [by right | by left]. Qed.

Lemma disj_trans A B C : A \/ B \/ C <-> (A \/ B) \/ C.
Proof. split.
- case. by left; left. case. by left; right. by right. 
- case. case. by left. by right; left. by right; right.
Qed.

Lemma disj_trans4 A B C D : A \/ B \/ C \/ D -> (A \/ B \/ C) \/ D.
Proof. case. by left; left. rewrite <- disj_trans. by right; apply disj_trans. Qed.

Lemma mult_aux_min  p1 p2 a b c d : a <= p1 -> p1 <= b -> c <= p2 -> p2 <= d -> a * d <= p1 * p2 \/ a * c <= p1 * p2 \/ b * c <= p1 * p2 \/ b * d <= p1 * p2.
Proof.
 move => ha hb hc hd.
 apply Ropp_le_contravar in ha. apply Ropp_le_contravar in hb. 
 move : (mult_aux_max hb ha hc hd).
 do 4 rewrite Ropp_le. 
 - case. by right; right; right.
 - case. by right; right; left.
 - case. by right; left.
 - by left.
Qed.

Lemma IQR_max p c1 c2 : p <= IQR c1 \/ p <= IQR c2 -> p <= IQR (cmax c1 c2).
Proof. 
move : (BigQ.le_max_l c1 c2) (BigQ.le_max_r c1 c2) => h1 h2.
rewrite <- cleq_aux2 in h1, h2.
move : (cle_le_dec c1 c2). do 2 rewrite cleq_aux2. 
case => h; case => iqr; apply (Rle_trans _ _  _ iqr); by apply IQR_le.
Qed.

Lemma IQR_max2 p c1 c2 c3 : p <= IQR c1 \/ p <= IQR c2 \/ p <= IQR c3 -> p <= IQR (cmax (cmax c1 c2) c3).
Proof.
rewrite disj_trans. move => disj. apply IQR_max. case disj. left; by apply IQR_max. by right. 
Qed.


Lemma IQR_max3 p c1 c2 c3 c4 : p <= IQR c1 \/ p <= IQR c2 \/ p <= IQR c3 \/ p <= IQR c4 -> p <= IQR (cmax (cmax (cmax c1 c2) c3) c4).
Proof.
move => disj. 
apply disj_trans4 in disj.
apply IQR_max. case disj. left; by apply IQR_max2. by right.
Qed.

Lemma IQR_min p c1 c2 : IQR c1 <= p \/ IQR c2 <= p -> IQR (cmin c1 c2) <= p.
Proof. 
move : (BigQ.le_min_l c1 c2) (BigQ.le_min_r c1 c2) => h1 h2.
rewrite <- cleq_aux2 in h1, h2.
move : (cle_le_dec c1 c2). do 2 rewrite cleq_aux2.
case => h; case => iqr; apply (Rle_trans _  _ _ (IQR_le _ _ h1) iqr) || apply (Rle_trans _  _ _ (IQR_le _ _ h2) iqr).
Qed.


Lemma IQR_min2 p c1 c2 c3 : IQR c1 <= p \/ IQR c2 <= p \/ IQR c3 <= p -> IQR (cmin (cmin c1 c2) c3) <= p.
Proof.
rewrite disj_trans. move => disj. apply IQR_min. case disj. left; by apply IQR_min. by right. 
Qed.


Lemma IQR_min3 p c1 c2 c3 c4 : IQR c1 <= p \/ IQR c2 <= p \/ IQR c3 <= p \/ IQR c4 <= p -> IQR (cmin (cmin (cmin c1 c2) c3) c4) <= p.
Proof.
move => disj. 
apply disj_trans4 in disj.
apply IQR_min. case disj. left; by apply IQR_min2. by right.
Qed.

Lemma fsa_in_itv_mult l p1 p2 i1 i2 p : fsa_in_itv l p1 i1 -> fsa_in_itv l p2 i2 -> Feval l p = Feval l p1 * Feval l p2 -> fsa_in_itv l p (itv_mult i1 i2).
Proof. 
move => h1 h2 h. 
move: (fsa_in_itv_left h1) (fsa_in_itv_right h1) (fsa_in_itv_left h2) (fsa_in_itv_right h2) => h1left h1right h2left h2right.
pose a := fst_itv i1. pose b := snd_itv i1. pose c := fst_itv i2. pose d := snd_itv i2.
- have ha : IQR a <= Feval l p1 by []. have hb :  Feval l p1 <= IQR b by [].
- have hc : IQR c <= Feval l p2 by []. have hd :  Feval l p2 <= IQR d by [].
split;  rewrite h; apply Rle_ge. 
- have <- : (cmin (cmin (cmin (ctimes a d) (ctimes a c)) (ctimes b c)) (ctimes b d)) = fst_itv (itv_mult i1 i2). unfold fst_itv, itv_mult. by case i1, i2. apply IQR_min3. do 4 rewrite IQR_mult. by apply mult_aux_min.
-  have <- : (cmax (cmax (cmax (ctimes a d) (ctimes a c)) (ctimes b c)) (ctimes b d)) = snd_itv (itv_mult i1 i2). unfold fst_itv, itv_mult. by case i1, i2. apply IQR_max3. do 4 rewrite IQR_mult. by apply mult_aux_max.
Qed.

Lemma fsa_in_itv_div l p1 p2 i1 i2 p inv2: itv_without_0 i2 -> itv_correct i2 -> fsa_in_itv l p1 i1 -> fsa_in_itv l p2 i2 -> Feval l inv2 = 1 / Feval l p2 -> Feval l p = Feval l p1 * Feval l inv2 -> fsa_in_itv l p (itv_div i1 i2).
Proof.
move => hi1 hi2 h1 h2 hdiv hmult.
unfold itv_div.
apply fsa_in_itv_mult with (p1:=p1) (p2:=inv2).
 +by [].
 +by apply fsa_in_itv_inv with (p:=p2). by [].
Qed. 


(*
Lemma fsa_in_itv_div l p1 p2 i1 i2 p i i0: itv_without_0 i2 -> itv_correct i2 -> fsa_in_itv l p1 i1 -> fsa_in_itv l p2 i2 -> Feval l p = Feval l p1 * Feval l inv2 -> fsa_in_itv l (Fdiv p1 p2 i i0) (itv_div i1 i2).
*)
(*
Lemma pol_in_itv_div l p p1 p2 i1 i2 i i0 : itv_without_0 i2 -> pol_in_itv l p1 i1 -> pol_in_itv l p2 i2 ->  pol_in_itv l p (itv_div i1 i2).
Proof. move => hneq hdiv. 
*)

(*
Lemma pol_in_itv_div l p p1 p2 i i1 i2 : itv_without_0 i2 -> belongs_div_itv i i1 i2 -> pol_in_itv l p1 i1 -> pol_in_itv l p2 i2 -> pol_in_itv l p i.
Proof. move => hneq hdiv h1 h2. split.
- unfold 
*)

Lemma conj_envfsa_cons x tl : conj_envfsa (x::tl) =  (x /\ conj_envfsa tl).
Proof. by []. Qed.

Lemma conj_envfsa_concat h1 h2 : conj_envfsa (h1 ++ h2) -> (conj_envfsa h1 /\ conj_envfsa h2).
Proof.
elim h1 => //=.
split. split; [apply H0 | by apply H; by apply H0].
by apply H, H0.
Qed.



Lemma conj_envfsa_concat_prop h1 h2 h : conj_envfsa (h1 ++ h2++ [::h]) -> (conj_envfsa h1 /\ conj_envfsa h2 /\ h).
Proof.
move => H.
move : (conj_envfsa_concat h1 (h2 ++ [::h]) H ) => [Hyp1 H2].
move : (conj_envfsa_concat h2 [::h] H2) => [Hyp2 H0]. 
split. by apply Hyp1. split. by apply Hyp2. by apply H0.
Qed.


Lemma correct_lifting_aux l f v : pol_in_itv l (get_obj f v) (get_itv_sos f) /\ fsa_pol_eq l f (get_obj f v) -> fsa_in_itv l f (get_itv_sos f).
Proof.
unfold fsa_in_itv, pol_in_itv, fsa_pol_eq.
move => [[Hfst Hsnd] Heq].
split.
(* exact car c'est directement la preuve du but, pas besoin de () car un seul terme après : *)
  exact : r_lemma_sub2 (PExpr_nonneg_sub Hfst) Heq.
  exact : r_lemma_sub3 (PExpr_nonneg_sub Hsnd) Heq.
Qed.


Lemma correct_lifting l bnds hyps f : conj_PExpr_nonneg l (bnds ++ hyps) ->  (forall (is_root : bool) v, conj_envfsa (get_envfsa l f v) -> checker_fsa_itv bnds hyps f v is_root -> pol_in_itv l (get_obj f v) (get_itv_sos f) /\ fsa_pol_eq l f (get_obj f v) /\ conj_PExpr_nonneg l ( (get_bnds f v) ++  (get_cstr f v) )).
Proof.
move => HNN.
induction f.
move => is_root v T POP. simpl.
split. by apply (checker_fsa_itv_pol l bnds hyps p i v c is_root).
split. by unfold fsa_pol_eq, get_cstr, get_bnds. by [].
(*
(* Fdivp *)
move => /= v [POP [ENV [ITV FSA]]].
rewrite get_obj_divp in ENV.
assert (eq : fsa_pol_eq l f (get_obj hyps f v)).
by apply IHf. unfold fsa_pol_eq, var in ENV. 
pose pop2:= sa_lift hyps f v. pose obj2 := obj pop2. pose cstr2 := cstr pop2. pose obj_div := PEX (vf pop2 + 1). 
have POL_ITV : pol_in_itv l (get_obj hyps f v) (get_itv f) by apply IHf.
have POL_ITV2 : pol_in_itv l obj2 (get_itv f) by []. 
have ENV2 : Feval l (Fdivp p f i) = eval_expr l obj_div. by []. clear ENV.
have eq2 : fsa_pol_eq l f obj2  by []. clear eq.
have eqmul : eval_expr l obj_div * eval_expr l obj2 = eval_expr l p. apply r_div_mult. apply rneq_neq. apply eqs_div_aux2 with (itv := (get_itv f)); by []. unfold fsa_pol_eq in eq2.
by rewrite -ENV2 -eq2. 
have [hpexpr1 hpexpr2] : PExpr_nonneg l (PEsub (PEmul obj2 obj_div) p) /\ PExpr_nonneg l (PEsub p (PEmul obj2 obj_div)). unfold PExpr_nonneg. rewrite PEeval_sub PEeval_mul. rewrite PEeval_sub PEeval_mul. apply r_lemma2. rewrite -eqmul. by ring.
have CONJ : conj_PExpr_nonneg l (get_cstr hyps (Fdivp p f i) v).
simpl. split. by []. split. by []. apply conj_PExpr_nonneg_concat. by apply IHf. simpl. split. apply POL_ITV. split; [by apply POL_ITV| by done].
split. apply FSA. simpl. split. by []. split. by []. by apply CONJ. split. by []. split. by []. split. by []. by apply CONJ.
*)
(* Fdiv *)
move => is_root v ENVconj Checker_Fsa_Itv. 
pose itv1 := get_itv f1. pose itv2 := get_itv f2.
(*pose pop1:= sa_lift l bnds hyps f1 v. pose pop2:= sa_lift l bnds hyps f2 (vf pop1). *)
pose obj1 := get_obj f1 v. pose obj2 := get_obj f2 (var f1 v). 
pose cstr1:= get_cstr f1 v. pose cstr2 := get_cstr f2 (var f1 v).
pose bnds1:= get_bnds f1 v. pose bnds2 := get_bnds f2 (var f1 v).
(*pose cstr1:= cstr pop1. pose cstr2 := cstr pop2. *)
pose obj_div_tmp := PEX (var f2 (var f1 v) + 1). 
pose obj_div := scale_obj obj_div_tmp i.
pose envfsa1 := get_envfsa l f1 v. pose envfsa2 := get_envfsa l f2 (var f1 v).
(*pose envfsa1 := envfsa pop1. pose envfsa2 := envfsa pop2.*)
pose cstr := hyps ++ cstr1 ++ cstr2 ++ [::PEsub (PEmul obj2 obj_div) obj1; PEsub obj1 (PEmul obj2 obj_div)].
pose bounds := bnds1 ++ bnds2 ++ gen_cstr_itv obj_div_tmp itv01.
(*simpl in Checker_Fsa_Itv.*)

- have Checker_Fsa_Itv' : checker_fsa_itv bnds hyps (Fdiv f1 f2 i i0 c) v is_root = checker_fsa_itv  bnds hyps f1 v is_root && checker_fsa_itv bnds hyps f2 (var f1 v) is_root &&  belongs_div_itv i (get_itv_sos f1) (get_itv_sos f2) && itv_strict_correct i  && checker_pop_itv (bnds++ bounds) cstr obj_div c i0. done. rewrite Checker_Fsa_Itv' in Checker_Fsa_Itv. clear Checker_Fsa_Itv'. 

simpl in Checker_Fsa_Itv.
move/andP : Checker_Fsa_Itv => [Hb FSA]. move/andP : Hb => [Hb ITVstrict]. move/andP : Hb => [Hb ITV]. move/andP : Hb => [POP1 POP2]. move/andP : ITV => [ITV1 ITV2]. move/andP : ITV1 => [ITV0 ITV1].

- have Envfsa : get_envfsa l (Fdiv f1 f2 i i0 c) v = envfsa1 ++ envfsa2 ++ [::  fsa_pol_eq l (descale_fsa (Fdiv f1 f2 i i0 c) i) (*(get_obj l hyps (Fdiv f1 f2 i i0 c) v)*) obj_div_tmp ] by []. rewrite Envfsa in ENVconj. 
move : (conj_envfsa_concat_prop envfsa1 envfsa2 (*(fsa_pol_eq l (Fdiv f1 f2 i i0 c) (get_obj l hyps (Fdiv f1 f2 i i0 c) v))*) (fsa_pol_eq l (descale_fsa (Fdiv f1 f2 i i0 c) i) obj_div_tmp)  ENVconj) => ENVFSA. 
- have Envfsa1 : conj_envfsa (get_envfsa l  f1 v) by apply ENVFSA.
- have Envfsa2 : conj_envfsa (get_envfsa l f2 (var f1 v)) by apply ENVFSA.
- have ENV : fsa_pol_eq l (Fdiv f1 f2 i i0 c) (get_obj (Fdiv f1 f2 i i0 c) v). apply scale_fsa_obj_impl. by []. by apply ENVFSA.
- move : (IHf1 is_root) => IHf1'. clear IHf1. rename IHf1' into IHf1. move : (IHf2 is_root) => IHf2'. clear IHf2. rename IHf2' into IHf2.
- have eq1 : fsa_pol_eq l f1 (get_obj f1 v) by apply IHf1.
  have eq2 : fsa_pol_eq l f2 (get_obj f2 ( var f1 v )) by apply IHf2.
- have POL_ITV1 : pol_in_itv l obj1 (get_itv_sos f1) by apply IHf1.
  have POL_ITV2 : pol_in_itv l obj2 (get_itv_sos f2) by apply IHf2.
  have POL_ITVf1 : pol_in_itv l (get_obj f1 v) (get_itv_sos f1) by apply IHf1.
  have POL_ITVf2 : pol_in_itv l (get_obj f2 (var f1 v) ) (get_itv_sos f2) by apply IHf2.

- have Env : Feval l (Fdiv f1 f2 i i0 c) = eval_expr l obj_div by apply ENV. clear ENV.
  have Eq1 : fsa_pol_eq l f1 obj1  by apply eq1; clear eq1.
  have Eq2 : fsa_pol_eq l f2 obj2  by apply eq2; clear eq2.
  have obj2nnull : eval_expr l obj2 <> 0 by apply rneq_neq; apply eqs_div_aux2 with (itv := (get_itv_sos f2)).
  have eqmul : eval_expr l obj_div * eval_expr l obj2 = eval_expr l obj1. apply r_div_mult. by unfold fsa_pol_eq in eq2, eq1.
by rewrite -Env -eq1 -eq2. 

- have [hpexpr1 hpexpr2] : PExpr_nonneg l (PEsub (PEmul obj2 obj_div) obj1) /\ PExpr_nonneg l (PEsub obj1 (PEmul obj2 obj_div)). unfold PExpr_nonneg. rewrite PEeval_sub PEeval_mul. rewrite PEeval_sub PEeval_mul. apply r_lemma2. rewrite -eqmul. by ring.

  - have CONJ : conj_PExpr_nonneg l (bnds ++ (bounds ++ cstr)).
apply conj_PExpr_nonneg_concat.  by apply  (conj_PExpr_nonneg_concat2 l bnds hyps). apply conj_PExpr_nonneg_concat.  apply conj_PExpr_nonneg_concat. apply (conj_PExpr_nonneg_concat2 l bnds1 cstr1). by apply IHf1. apply conj_PExpr_nonneg_concat. apply (conj_PExpr_nonneg_concat2 l bnds2 cstr2). by apply IHf2.
  + have hdiv : pol_in_itv l obj_div_tmp itv01. apply scale_obj_itv with (itv:= i). by [].
    apply (pol_in_itv_belongs i ITV2).
    apply pol_fsa_in_itv with (f:= Fdiv f1 f2 i i0 c). by [].
    apply fsa_in_itv_div with (p1:=f1) (p2:=f2) (inv2:=Fdiv (Poly (PEc cI) i0 c) f2 i i0 c).
    by []. by []. by apply fsa_pol_in_itv with (p:=obj1).  by apply fsa_pol_in_itv with (p:=obj2). simpl; by rewrite IQR_1. simpl. rewrite IQR_1. field. by rewrite Eq2. by destruct hdiv.
apply conj_PExpr_nonneg_concat. by apply (conj_PExpr_nonneg_concat2 l bnds hyps). apply conj_PExpr_nonneg_concat. 
apply (conj_PExpr_nonneg_concat2 l bnds1 cstr1). by apply IHf1.
apply conj_PExpr_nonneg_concat.  apply (conj_PExpr_nonneg_concat2 l bnds2 cstr2). by apply IHf2.
by [].
(*
    apply conj_PExpr_nonneg_concat. unfold bounds. apply conj_PExpr_nonneg_concat. 
 apply IHf1. by apply conj_PExpr_nonneg_concat2 in HNN; apply HNN.

  + apply conj_PExpr_nonneg_concat.  apply (conj_PExpr_nonneg_concat2 l (get_bnds l bnds hyps f1 v) cstr1).  by apply IHf1. 
    apply conj_PExpr_nonneg_concat. apply (conj_PExpr_nonneg_concat2 l (get_bnds l bnds hyps f2 (vf pop1))  cstr2). by apply IHf2. by [].
*)

- have FSA' : pol_in_itv l obj_div i0. apply (checker_fsa_itv_pol l (bnds++ bounds) cstr obj_div i0 v c is_root). by rewrite catA in CONJ. by apply FSA.
split. by []. split. by []. apply conj_PExpr_nonneg_concat2 in CONJ. destruct CONJ. apply conj_PExpr_nonneg_concat2 in H0. destruct H0. apply conj_PExpr_nonneg_concat2 in H1. destruct H1. apply conj_PExpr_nonneg_concat. by []. by [].
(* Fmul *)
 move : (IHf1 false) => IHf1'; clear IHf1; rename IHf1' into IHf1; move : (IHf2 false) => IHf2'; clear IHf2; rename IHf2' into IHf2. move => is_root v ENVconj Checker_Fsa_Itv. 
pose cstr1:= get_cstr f1 v. pose cstr2 := get_cstr f2 (var f1 v).
pose envfsa1 := get_envfsa l f1 v. pose envfsa2 := get_envfsa l f2 (var f1 v).
pose bnds1:= get_bnds f1 v. pose bnds2 := get_bnds f2 (var f1 v).
pose obj := (get_obj (Fmul f1 f2 i i0 c) v).
- have Envfsa : get_envfsa l  (Fmul f1 f2 i i0 c) v = envfsa1 ++ envfsa2 by []. rewrite Envfsa in ENVconj. apply conj_envfsa_concat in ENVconj. move : ENVconj => [ENVconj1 ENVconj2].
- have FSA' : checker_fsa_itv bnds hyps (Fmul f1 f2 i i0 c) v is_root = checker_fsa_itv bnds hyps f1 v false && checker_fsa_itv bnds hyps f2 (var f1 v) false && checker_pop_itv (bnds ++ (bnds1 ++ bnds2)) (hyps ++ cstr1 ++ cstr2) obj c i0.
by [].
rewrite FSA' in Checker_Fsa_Itv. move/andP : Checker_Fsa_Itv => [hb FSA]. move/andP : hb => [POP1 POP2].
- have CONJ : conj_PExpr_nonneg l ((bnds ++ bnds1 ++ bnds2) ++ hyps ++ cstr1 ++ cstr2). apply conj_PExpr_nonneg_concat. apply conj_PExpr_nonneg_concat. 
 + by apply conj_PExpr_nonneg_concat2 in HNN; apply HNN.  apply conj_PExpr_nonneg_concat.
 + apply (conj_PExpr_nonneg_concat2 l bnds1 cstr1). apply IHf1.  by []. by []. 
 + by apply (conj_PExpr_nonneg_concat2 l bnds2 cstr2); apply IHf2. apply conj_PExpr_nonneg_concat. 
 + by apply conj_PExpr_nonneg_concat2 in HNN; apply HNN. apply conj_PExpr_nonneg_concat.
 + by apply (conj_PExpr_nonneg_concat2 l bnds1 cstr1); apply IHf1.
 + by apply (conj_PExpr_nonneg_concat2 l bnds2 cstr2); apply IHf2.
split.
- by apply (checker_fsa_itv_pol l (bnds++bnds1 ++ bnds2) (hyps++cstr1++cstr2)   _ _ (var (Fmul f1 f2 i i0 c) v)  c is_root).
split.
- unfold fsa_pol_eq => //=. apply r_lemma_mul. by apply IHf1. by apply IHf2.
apply conj_PExpr_nonneg_concat2 in CONJ. destruct CONJ as [CONJ1 CONJ2]. apply conj_PExpr_nonneg_concat2 in CONJ1. apply conj_PExpr_nonneg_concat2 in CONJ2. 
- apply conj_PExpr_nonneg_concat. by apply CONJ1. by apply CONJ2.
(* Fsub *)
 move : (IHf1 false) => IHf1'; clear IHf1; rename IHf1' into IHf1; move : (IHf2 false) => IHf2'; clear IHf2; rename IHf2' into IHf2. move => is_root v ENVconj Checker_Fsa_Itv. 
pose cstr1:= get_cstr f1 v. pose cstr2 := get_cstr f2 (var f1 v).
pose envfsa1 := get_envfsa l f1 v. pose envfsa2 := get_envfsa l f2 (var f1 v).
pose bnds1:= get_bnds f1 v. pose bnds2 := get_bnds f2 (var f1 v).
pose obj := (get_obj (Fsub f1 f2 i i0 c) v).
- have Envfsa : get_envfsa l  (Fsub f1 f2 i i0 c) v = envfsa1 ++ envfsa2 by []. rewrite Envfsa in ENVconj. apply conj_envfsa_concat in ENVconj. move : ENVconj => [ENVconj1 ENVconj2].
- have FSA' : checker_fsa_itv bnds hyps (Fsub f1 f2 i i0 c) v is_root = checker_fsa_itv bnds hyps f1 v false && checker_fsa_itv bnds hyps f2 (var f1 v) false && checker_pop_itv (bnds ++ (bnds1 ++ bnds2)) (hyps ++ cstr1 ++ cstr2) obj c i0
by [].
rewrite FSA' in Checker_Fsa_Itv. move/andP : Checker_Fsa_Itv => [hb FSA]. move/andP : hb => [POP1 POP2].

- have CONJ : conj_PExpr_nonneg l ((bnds ++ bnds1 ++ bnds2) ++ hyps ++ cstr1 ++ cstr2). apply conj_PExpr_nonneg_concat. apply conj_PExpr_nonneg_concat. 
 + by apply conj_PExpr_nonneg_concat2 in HNN; apply HNN.  apply conj_PExpr_nonneg_concat. 
 + by apply (conj_PExpr_nonneg_concat2 l bnds1 cstr1); apply IHf1. 
 + by apply (conj_PExpr_nonneg_concat2 l bnds2 cstr2); apply IHf2. apply conj_PExpr_nonneg_concat. 
 + by apply conj_PExpr_nonneg_concat2 in HNN; apply HNN. apply conj_PExpr_nonneg_concat.
 + by apply (conj_PExpr_nonneg_concat2 l bnds1 cstr1); apply IHf1.
 + by apply (conj_PExpr_nonneg_concat2 l bnds2 cstr2); apply IHf2.
split.
- by apply (checker_fsa_itv_pol l (bnds++bnds1 ++ bnds2) (hyps++cstr1++cstr2)   _ _ (var (Fmul f1 f2 i i0 c) v)  c is_root). split.
- unfold fsa_pol_eq => //=.  apply r_lemma_sub. by apply IHf1. by apply IHf2.
apply conj_PExpr_nonneg_concat2 in CONJ. destruct CONJ as [CONJ1 CONJ2]. apply conj_PExpr_nonneg_concat2 in CONJ1. apply conj_PExpr_nonneg_concat2 in CONJ2. 
- apply conj_PExpr_nonneg_concat. by apply CONJ1. by apply CONJ2.
(* Fopp *)
move => /= is_root v conj. move/andP => [POP Opp]. move : (IHf is_root) => IHf'. clear IHf. rename IHf' into IHf.
split.
  apply (@pol_in_itv_opp l _ _ (get_itv_sos f)) => //=. by apply IHf.
split.
  unfold fsa_pol_eq.
  apply r_lemma_opp. by apply IHf.
    unfold get_cstr. by apply IHf.
(* Fadd *)
 move : (IHf1 false) => IHf1'; clear IHf1; rename IHf1' into IHf1; move : (IHf2 false) => IHf2'; clear IHf2; rename IHf2' into IHf2. move => is_root v ENVconj Checker_Fsa_Itv. 
pose cstr1:= get_cstr f1 v. pose cstr2 := get_cstr f2 (var f1 v).
pose envfsa1 := get_envfsa l f1 v. pose envfsa2 := get_envfsa l f2 (var f1 v).
pose bnds1:= get_bnds f1 v. pose bnds2 := get_bnds f2 (var f1 v).
pose obj := (get_obj (Fadd f1 f2 i i0 c) v).
- have Envfsa : get_envfsa l  (Fadd f1 f2 i i0 c) v = envfsa1 ++ envfsa2 by []. rewrite Envfsa in ENVconj. apply conj_envfsa_concat in ENVconj. move : ENVconj => [ENVconj1 ENVconj2].
- have FSA' : checker_fsa_itv bnds hyps (Fadd f1 f2 i i0 c) v is_root = checker_fsa_itv bnds hyps f1 v false && checker_fsa_itv bnds hyps f2 (var f1 v) false && checker_pop_itv (bnds ++ (bnds1 ++ bnds2)) (hyps ++ cstr1 ++ cstr2) obj c i0
by [].
rewrite FSA' in Checker_Fsa_Itv. move/andP : Checker_Fsa_Itv => [hb FSA]. move/andP : hb => [POP1 POP2].

- have CONJ : conj_PExpr_nonneg l ((bnds ++ bnds1 ++ bnds2) ++ hyps ++ cstr1 ++ cstr2). apply conj_PExpr_nonneg_concat. apply conj_PExpr_nonneg_concat. 
 + by apply conj_PExpr_nonneg_concat2 in HNN; apply HNN.  apply conj_PExpr_nonneg_concat. 
 + by apply (conj_PExpr_nonneg_concat2 l bnds1 cstr1); apply IHf1. 
 + by apply (conj_PExpr_nonneg_concat2 l bnds2 cstr2); apply IHf2. apply conj_PExpr_nonneg_concat. 
 + by apply conj_PExpr_nonneg_concat2 in HNN; apply HNN. apply conj_PExpr_nonneg_concat.
 + by apply (conj_PExpr_nonneg_concat2 l bnds1 cstr1); apply IHf1.
 + by apply (conj_PExpr_nonneg_concat2 l bnds2 cstr2); apply IHf2.
split.
- by apply (checker_fsa_itv_pol l (bnds++bnds1 ++ bnds2) (hyps++cstr1++cstr2)   _ _ (var (Fmul f1 f2 i i0 c) v)  c is_root). split.
- unfold fsa_pol_eq => //=.  apply r_lemma_add. by apply IHf1. by apply IHf2.
apply conj_PExpr_nonneg_concat2 in CONJ. destruct CONJ as [CONJ1 CONJ2]. apply conj_PExpr_nonneg_concat2 in CONJ1. apply conj_PExpr_nonneg_concat2 in CONJ2. 
- apply conj_PExpr_nonneg_concat. by apply CONJ1. by apply CONJ2.
(* Fsqrt *)
move => is_root v ENVconj. move/andP => [hb FSA]. move /andP : hb => [hb ITVstrict]. move/andP : hb => [POP ITV]. move : (IHf is_root) => IHf'. clear IHf. rename IHf' into IHf.
pose objr := get_obj f v.
pose envfsar := get_envfsa l f v.
pose v_sqrt := (var f v + 1)%positive.
pose obj_sqrt_tmp := PEX v_sqrt.
pose obj_sqrt := scale_obj obj_sqrt_tmp i.
- have Envfsa : get_envfsa l (Fsqrt f i) v = envfsar ++ [::fsa_pol_eq l (descale_fsa (Fsqrt f i) i) obj_sqrt_tmp] by []. rewrite Envfsa in ENVconj. apply conj_envfsa_concat in ENVconj. move : ENVconj => [ENVconj ENV]. destruct ENV as [ENV _].
- have eq_arg : fsa_pol_eq l f (get_obj f v)  by apply IHf. apply scale_fsa_obj_impl in ENV.
- have POL_ITV : pol_in_itv l (get_obj f v) (get_itv_sos f) by apply IHf.
- have POL_ITVr : pol_in_itv l objr (get_itv_sos f) by []. 
- have Env : Feval l (Fsqrt f i) = eval_expr l obj_sqrt by []. clear ENV.
- have eqr : fsa_pol_eq l f objr  by apply eq_arg. clear eq_arg.
- have eqmul : eval_expr l obj_sqrt * eval_expr l obj_sqrt = Feval l f. 
   apply r_sqrt with (f':= eval_expr l objr) (r':= Feval l (Fsqrt f i)).
   apply Rgt_ge. rewrite eqr. by apply eqs_sqrt_aux with (itv:=get_itv_sos f). by []. by []. by rewrite Feval_sqrt eqr in Env.

- have [hpexpr1 hpexpr2] : PExpr_nonneg l (PEsub (PEmul obj_sqrt obj_sqrt) objr) /\ PExpr_nonneg l (PEsub objr (PEmul obj_sqrt obj_sqrt)). unfold PExpr_nonneg. rewrite PEeval_sub PEeval_mul. rewrite PEeval_sub PEeval_mul. apply r_lemma2. by rewrite eqmul.

- have hsqrt : pol_in_itv l obj_sqrt i. apply pol_in_itv_sqrt with (p2 := objr) (i2:= get_itv_sos f). by []. unfold PExpr_nonneg. rewrite -Env. apply Rle_ge. rewrite Feval_sqrt. apply sqrt_positivity. apply Rge_le. apply Rgt_ge. rewrite eqr. by apply eqs_sqrt_aux with (itv:=get_itv_sos f).  by []. rewrite PEeval_mul. by rewrite -Env -eqr Env.
- have htmp : pol_in_itv l obj_sqrt_tmp itv01. apply scale_obj_itv with (itv:= i). by []. by [].
simpl. split. by []. split. by []. apply conj_PExpr_nonneg_concat. apply conj_PExpr_nonneg_concat.
- apply (conj_PExpr_nonneg_concat2 l (get_bnds f v) (get_cstr f v)). by apply IHf.
- by destruct htmp. apply conj_PExpr_nonneg_concat.
- apply (conj_PExpr_nonneg_concat2 l (get_bnds f v) (get_cstr f v)). by apply IHf.
- by [].
- by [].
Qed.

Lemma correct_fsa l bnds hyps f v : conj_PExpr_nonneg l (bnds ++ hyps) -> conj_envfsa (get_envfsa l  f v) -> 
checker_fsa_itv bnds hyps f v true = true -> fsa_in_itv l f (get_itv_sos f).
Proof.
move => Hyps Env checker_fsa_itv.
apply (correct_lifting_aux v).
move : ( correct_lifting l bnds hyps f Hyps true v Env checker_fsa_itv). move => [? h2]. by split; last by apply h2.
Qed.


Lemma fsa_in_itv_reif l fexpr fe isos: fexpr = Feval l fe -> fsa_in_itv l fe isos -> IQR (fst_itv isos) <= fexpr <= IQR (snd_itv isos).
Proof.
 move => Eq Itv. rewrite Eq. unfold fsa_in_itv in Itv. move : Itv => [Itv1 Itv2]. apply Rge_le in Itv1. apply Rge_le in Itv2. by done.
Qed.

Lemma descale_reif l i fsa : Feval l (descale_fsa fsa i) = (IQR (cinv ( snd_itv i - fst_itv i )) ) * Feval l fsa - (IQR (fst_itv i / ( snd_itv i - fst_itv i ))).
Proof. by done. Qed. 

Lemma xge0_reif x l j : 0 <= x -> Env.nth j l = x -> PExpr_nonneg l (PEadd (PEX j) (PEc (0 # 1))).
Proof.
  move => xgeq env. unfold PExpr_nonneg. simpl. rewrite env. rewrite IQR_0_1. rewrite Rplus_0_r. by apply Rle_ge.
Qed.

Lemma xle1_reif x l j : x <= 1 -> Env.nth j l = x -> PExpr_nonneg l (PEadd (PEmul (PEc (-1 # 1)) (PEX j)) (PEc (1 # 1))).
Proof.
  move => xgeq env. unfold PExpr_nonneg. simpl. rewrite env. rewrite IQR_1_1 IQR_minus1_1. rewrite Rplus_comm. rewrite r7. apply Rge_minus. by apply Rle_ge. 
Qed.
