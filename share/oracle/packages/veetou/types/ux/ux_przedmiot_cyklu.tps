CREATE OR REPLACE TYPE V2u_Ux_Przedmiot_Cyklu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Przedmiot_Cyklu_B_t
    ( job_uuid RAW(16)
    , dbg_subj_codes INTEGER
    , dbg_map_subj_codes INTEGER
    , dbg_subj_credit_kinds INTEGER
    , dbg_matched INTEGER
    , dbg_missing INTEGER
    , dbg_mapped INTEGER
    , safe_to_add INTEGER


    , CONSTRUCTOR FUNCTION V2u_Ux_Przedmiot_Cyklu_t(
              SELF IN OUT NOCOPY V2u_Ux_Przedmiot_Cyklu_t
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
            , dbg_map_subj_codes IN INTEGER
            , dbg_subj_credit_kinds IN INTEGER
            , dbg_matched IN INTEGER
            , dbg_missing IN INTEGER
            , dbg_mapped IN INTEGER
            , safe_to_add IN INTEGER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ux_Przedmiot_Cyklu_t
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
            , dbg_map_subj_codes IN INTEGER
            , dbg_subj_credit_kinds IN INTEGER
            , dbg_matched IN INTEGER
            , dbg_missing IN INTEGER
            , dbg_mapped IN INTEGER
            , safe_to_add INTEGER
            )
    )
;

-- vim: set ft=sql ts=4 sw=4 et:
