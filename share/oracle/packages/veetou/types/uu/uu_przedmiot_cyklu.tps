CREATE OR REPLACE TYPE V2u_Uu_Przedmiot_Cyklu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Przedmiot_Cyklu_B_t
    ( job_uuid RAW(16)
    , pk_subject VARCHAR2(32 CHAR)
    , pk_semester VARCHAR2(32 CHAR)
    -- DBG
    , dbg_subj_codes NUMBER(5)
    , dbg_map_subj_codes NUMBER(5)
    , dbg_map_proto_types NUMBER(5)
    , dbg_subj_credit_kinds NUMBER(5)
    , dbg_prz_kody NUMBER(5)
    , dbg_cdyd_kody NUMBER(5)
    , dbg_values_ok NUMBER(1)
    , dbg_unique_match NUMBER(1)
    , dbg_matched NUMBER(5)
    , dbg_missing NUMBER(5)
    , dbg_mapped NUMBER(5)
    -- CTL
    , change_type VARCHAR2(1)
    , safe_to_change NUMBER(1)


    , CONSTRUCTOR FUNCTION V2u_Uu_Przedmiot_Cyklu_t(
              SELF IN OUT NOCOPY V2u_Uu_Przedmiot_Cyklu_t
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , uczestnicy IN VARCHAR2
            , url IN VARCHAR2
            , uwagi IN CLOB
            , notes IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , opis IN CLOB
            , opis_ang IN CLOB
            , skrocony_opis IN VARCHAR2
            , skrocony_opis_ang IN VARCHAR2
            , status_sylabusu IN VARCHAR2
            , guid IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , pk_semester IN VARCHAR2
            -- DBG
            , dbg_subj_codes IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_map_proto_types IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_cdyd_kody IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_mapped IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Przedmiot_Cyklu_t
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , uczestnicy IN VARCHAR2
            , url IN VARCHAR2
            , uwagi IN CLOB
            , notes IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , opis IN CLOB
            , opis_ang IN CLOB
            , skrocony_opis IN VARCHAR2
            , skrocony_opis_ang IN VARCHAR2
            , status_sylabusu IN VARCHAR2
            , guid IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , pk_semester IN VARCHAR2
            -- DBG
            , dbg_subj_codes IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_map_proto_types IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_cdyd_kody IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_mapped IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            )
    )
;

-- vim: set ft=sql ts=4 sw=4 et:
