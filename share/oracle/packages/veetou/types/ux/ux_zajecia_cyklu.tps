CREATE OR REPLACE TYPE V2u_Ux_Zajecia_Cyklu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Zajecia_Cyklu_B_t
    ( job_uuid RAW(16)
    , dbg_subj_codes INTEGER
    , dbg_map_subj_codes INTEGER
    , dbg_classes_hours INTEGER
    , dbg_subj_credit_kinds INTEGER
    , dbg_matched INTEGER
    , dbg_missing INTEGER
    , dbg_subject_mapped INTEGER
    , dbg_classes_mapped INTEGER
    , safe_to_add INTEGER

    , CONSTRUCTOR FUNCTION V2u_Ux_Zajecia_Cyklu_t(
              SELF IN OUT NOCOPY V2u_Ux_Zajecia_Cyklu_t
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tzaj_kod IN VARCHAR2
            , liczba_godz IN NUMBER
            , limit_miejsc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , waga_pensum IN NUMBER
            , tpro_kod IN VARCHAR2
            , efekty_uczenia IN CLOB
            , efekty_uczenia_ang IN CLOB
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            , url IN VARCHAR2
            , zakres_tematow IN CLOB
            , zakres_tematow_ang IN CLOB
            , metody_dyd IN CLOB
            , metody_dyd_ang IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , czy_pokazywac_termin IN VARCHAR2
            , job_uuid IN RAW
            , dbg_subj_codes IN INTEGER
            , dbg_map_subj_codes IN INTEGER
            , dbg_classes_hours IN INTEGER
            , dbg_subj_credit_kinds IN INTEGER
            , dbg_matched IN INTEGER
            , dbg_missing IN INTEGER
            , dbg_subject_mapped IN INTEGER
            , dbg_classes_mapped IN INTEGER
            , safe_to_add INTEGER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ux_Zajecia_Cyklu_t
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tzaj_kod IN VARCHAR2
            , liczba_godz IN NUMBER
            , limit_miejsc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , waga_pensum IN NUMBER
            , tpro_kod IN VARCHAR2
            , efekty_uczenia IN CLOB
            , efekty_uczenia_ang IN CLOB
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            , url IN VARCHAR2
            , zakres_tematow IN CLOB
            , zakres_tematow_ang IN CLOB
            , metody_dyd IN CLOB
            , metody_dyd_ang IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , czy_pokazywac_termin IN VARCHAR2
            , job_uuid IN RAW
            , dbg_subj_codes IN INTEGER
            , dbg_map_subj_codes IN INTEGER
            , dbg_classes_hours IN INTEGER
            , dbg_subj_credit_kinds IN INTEGER
            , dbg_matched IN INTEGER
            , dbg_missing IN INTEGER
            , dbg_subject_mapped IN INTEGER
            , dbg_classes_mapped IN INTEGER
            , safe_to_add INTEGER
            )
    )
;

-- vim: set ft=sql ts=4 sw=4 et:
