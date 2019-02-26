CREATE OR REPLACE TYPE V2u_Uu_Przedmiot_Cyklu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Przedmiot_Cyklu_B_t
    ( job_uuid RAW(16)
    , pk_subject VARCHAR2(32 CHAR)
    , pk_semester_code VARCHAR2(32 CHAR)
    , dbg_subj_codes NUMBER(5)
    , dbg_map_subj_codes NUMBER(5)
    , dbg_subj_credit_kinds NUMBER(5)
    , dbg_matched NUMBER(5)
    , dbg_missing NUMBER(5)
    , dbg_mapped NUMBER(5)
    , safe_to_add NUMBER(1)


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
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , pk_semester_code IN VARCHAR2
            , dbg_map_subj_codes IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_mapped IN NUMBER
            , safe_to_add IN NUMBER
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
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , pk_semester_code IN VARCHAR2
            , dbg_map_subj_codes IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_mapped IN NUMBER
            , safe_to_add IN NUMBER
            )
    )
;

-- vim: set ft=sql ts=4 sw=4 et:
