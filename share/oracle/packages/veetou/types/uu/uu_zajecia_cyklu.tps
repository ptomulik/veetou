CREATE OR REPLACE TYPE V2u_Uu_Zajecia_Cyklu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Zajecia_Cyklu_B_t
    ( job_uuid RAW(16)
    , pk_subject VARCHAR2(32 CHAR)
    , pk_semester VARCHAR2(20 CHAR)
    , pk_classes VARCHAR2(20 CHAR)
    -- DBG
    , dbg_subj_codes NUMBER(5)
    , dbg_map_subj_codes NUMBER(5)
    , dbg_map_classes_types NUMBER(5)
    , dbg_map_proto_types NUMBER(5)
    , dbg_subj_credit_kinds NUMBER(5)
    , dbg_prz_kody NUMBER(5)
    , dbg_cdyd_kody NUMBER(5)
    , dbg_tzaj_kody NUMBER(5)
    , dbg_classes_hours NUMBER(5)
    , dbg_map_classes_hours NUMBER(5)
    , dbg_ids NUMBER(5)
    , dbg_unique_match NUMBER(1)
    , dbg_values_ok NUMBER(1)
    , dbg_matched NUMBER(5)
    , dbg_missing NUMBER(5)
    , dbg_subject_mapped NUMBER(5)
    , dbg_classes_mapped NUMBER(5)
    -- CTL
    , change_type VARCHAR2(1)
    , safe_to_change NUMBER(1)

    , CONSTRUCTOR FUNCTION V2u_Uu_Zajecia_Cyklu_t(
              SELF IN OUT NOCOPY V2u_Uu_Zajecia_Cyklu_t
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
            -- KEY
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , pk_semester IN VARCHAR2
            , pk_classes IN VARCHAR2
            -- DBG
            , dbg_subj_codes IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_map_classes_types IN NUMBER
            , dbg_map_proto_types IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_cdyd_kody IN NUMBER
            , dbg_tzaj_kody IN NUMBER
            , dbg_classes_hours IN NUMBER
            , dbg_map_classes_hours IN NUMBER
            , dbg_ids IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_subject_mapped IN NUMBER
            , dbg_classes_mapped IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Zajecia_Cyklu_t
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
            -- KEY
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , pk_semester IN VARCHAR2
            , pk_classes IN VARCHAR2
            -- DBG
            , dbg_subj_codes IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_map_classes_types IN NUMBER
            , dbg_map_proto_types IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_cdyd_kody IN NUMBER
            , dbg_tzaj_kody IN NUMBER
            , dbg_classes_hours IN NUMBER
            , dbg_map_classes_hours IN NUMBER
            , dbg_ids IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_subject_mapped IN NUMBER
            , dbg_classes_mapped IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            )
    )
;

-- vim: set ft=sql ts=4 sw=4 et:
