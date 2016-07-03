*** be_zeit1.wfm

Skal_datum = kartei->pb_datum

DO WHILE .t.

 DO CASE
  CASE MONTH(Skal_datum)=1
   IF p_zeit > 0
    Smin_jan=Smin_jan+p_zeit
    Spm1_jan=Spm1_jan+1
   ELSE
    Spm2_jan=Spm2_jan+1
   ENDIF
  CASE MONTH(Skal_datum)=2
   IF p_zeit > 0
    Smin_febr=Smin_febr+p_zeit
    Spm1_febr=Spm1_febr+1
   ELSE
    Spm2_febr=Spm2_febr+1
   ENDIF
  CASE MONTH(Skal_datum)=3
   IF p_zeit > 0
    Smin_m„rz=Smin_m„rz+p_zeit
    Spm1_m„rz=Spm1_m„rz+1
   ELSE
    Spm2_m„rz=Spm2_m„rz+1
   ENDIF
  CASE MONTH(Skal_datum)=4
   IF p_zeit > 0
    Smin_april=Smin_april+p_zeit
    Spm1_april=Spm1_april+1
   ELSE
    Spm2_april=Spm2_april+1
   ENDIF
  CASE MONTH(Skal_datum)=5
   IF p_zeit > 0
    Smin_mai=Smin_mai+p_zeit
    Spm1_mai=Spm1_mai+1
   ELSE
    Spm2_mai=Spm2_mai+1
   ENDIF
  CASE MONTH(Skal_datum)=6
   IF p_zeit > 0
    Smin_juni=Smin_juni+p_zeit
    Spm1_juni=Spm1_juni+1
   ELSE
    Spm2_juni=Spm2_juni+1
   ENDIF
  CASE MONTH(Skal_datum)=7
   IF p_zeit > 0
    Smin_juli=Smin_juli+p_zeit
    Spm1_juli=Spm1_juli+1
   ELSE
    Spm2_juli=Spm2_juli+1
   ENDIF
  CASE MONTH(Skal_datum)=8
   IF p_zeit > 0
    Smin_aug=Smin_aug+p_zeit
    Spm1_aug=Spm1_aug+1
   ELSE
    Spm2_aug=Spm2_aug+1
   ENDIF
  CASE MONTH(Skal_datum)=9
   IF p_zeit > 0
    Smin_sept=Smin_sept+p_zeit
    Spm1_sept=Spm1_sept+1
   ELSE
    Spm2_sept=Spm2_sept+1
   ENDIF
  CASE MONTH(Skal_datum)=10
   IF p_zeit > 0
    Smin_okt=Smin_okt+p_zeit
    Spm1_okt=Spm1_okt+1
   ELSE
    Spm2_okt=Spm2_okt+1
   ENDIF
  CASE MONTH(Skal_datum)=11
   IF p_zeit > 0
    Smin_nov=Smin_nov+p_zeit
    Spm1_nov=Spm1_nov+1
   ELSE
    Spm2_nov=Spm2_nov+1
   ENDIF
  CASE MONTH(Skal_datum)=12
   IF p_zeit > 0
    Smin_dez=Smin_dez+p_zeit
    Spm1_dez=Spm1_dez+1
   ELSE
    Spm2_dez=Spm2_dez+1
   ENDIF
 ENDCASE

 IF Skal_datum+kfr <= Stermin_bis  .AND.  kfr > 0
  Skal_datum=Skal_datum+kfr
 ELSE
  EXIT
 ENDIF

ENDDO