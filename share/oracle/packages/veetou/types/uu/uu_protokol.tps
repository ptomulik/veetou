CREATE OR REPLACE TYPE V2u_Uu_Protokol_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Protokol_B_t
    ( job_uuid RAW(16)
    , pk_protokol VARCHAR2(128 CHAR)
      -- DBG
    , dbg_subj_codes NUMBER(5)
    , dbg_classes_types NUMBER(5)
    , dbg_map_subj_codes NUMBER(5)
    , dbg_map_proto_types NUMBER(5)
    , dbg_map_classes_types NUMBER(5)
    , dbg_subj_credit_kinds NUMBER(5)
    , dbg_prot_ids NUMBER(5)
    , dbg_opisy NUMBER(5)
    , dbg_czy_do_sredniej NUMBER(5)
    , dbg_edycje NUMBER(5)
    , dbg_opisy_ang NUMBER(5)
    , dbg_zaj_cyk_ids NUMBER(5)
    , dbg_subj_grades NUMBER(5)
    , dbg_values_ok NUMBER(1)
    , dbg_unique_match NUMBER(1)
    , dbg_matched NUMBER(5)
    , dbg_missing NUMBER(5)
    , dbg_subject_mapped NUMBER(5)
    , dbg_classes_mapped NUMBER(5)
      -- CTL
    , change_type CHAR(1)
    , safe_to_change NUMBER(1)
    , CONSTRUCTOR FUNCTION V2u_Uu_Protokol_t(
              SELF IN OUT NOCOPY V2u_Uu_Protokol_t
            , zaj_cyk_id IN NUMBER
            , opis IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , czy_do_sredniej IN VARCHAR2
            , edycja IN VARCHAR2
            , opis_ang IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_protokol IN VARCHAR2
            -- DBG
            , dbg_subj_codes IN NUMBER
            , dbg_classes_types IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_map_proto_types IN NUMBER
            , dbg_map_classes_types IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_prot_ids IN NUMBER
            , dbg_opisy IN NUMBER
            , dbg_czy_do_sredniej IN NUMBER
            , dbg_edycje IN NUMBER
            , dbg_opisy_ang IN NUMBER
            , dbg_zaj_cyk_ids IN NUMBER
            , dbg_subj_grades IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_subject_mapped IN NUMBER
            , dbg_classes_mapped IN NUMBER
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT
    );
/
-- vim: set ft=sql ts=4 sw=4 et:
