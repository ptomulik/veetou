CREATE OR REPLACE TYPE V2u_Ux_Atrybut_Przedmiotu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Atrybut_Przedmiotu_B_t
    ( job_uuid RAW(16)
    , pk_subj_code VARCHAR2(32 CHAR)
    , subj_codes V2u_Subj_20Codes_t
    , all_subj_codes V2u_Subj_20Codes_t
    -- DBG
    , dbg_map_subj_codes INTEGER
    , dbg_subj_codes INTEGER
    , dbg_all_subj_codes INTEGER
    , dbg_ids INTEGER
    , safe_to_add INTEGER

    , CONSTRUCTOR FUNCTION V2u_Ux_Atrybut_Przedmiotu_t(
              SELF IN OUT NOCOPY V2u_Ux_Atrybut_Przedmiotu_t
            , tatr_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , wart_lst_id IN NUMBER
            , prz_kod_rel IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , wartosc IN CLOB
            , wartosc_ang IN CLOB
            , id IN VARCHAR2
            , job_uuid IN RAW
            , subj_codes IN V2u_Subj_20Codes_t
            , all_subj_codes IN V2u_Subj_20Codes_t
            , pk_subj_code IN VARCHAR2
            -- DBG
            , dbg_map_subj_codes IN INTEGER
            , dbg_subj_codes IN INTEGER
            , dbg_all_subj_codes IN INTEGER
            , dbg_ids IN INTEGER
            , safe_to_add IN INTEGER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ux_Atrybut_Przedmiotu_t
            , tatr_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , wart_lst_id IN NUMBER
            , prz_kod_rel IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , wartosc IN CLOB
            , wartosc_ang IN CLOB
            , id IN VARCHAR2
            , job_uuid IN RAW
            , subj_codes IN V2u_Subj_20Codes_t
            , all_subj_codes IN V2u_Subj_20Codes_t
            , pk_subj_code IN VARCHAR2
            -- DBG
            , dbg_map_subj_codes IN INTEGER
            , dbg_subj_codes IN INTEGER
            , dbg_all_subj_codes IN INTEGER
            , dbg_ids IN INTEGER
            , safe_to_add IN INTEGER
            )
    );
/
CREATE OR REPLACE TYPE V2u_Ux_Atrybuty_Przedmiotow_t
    AS TABLE OF V2u_Ux_Atrybut_Przedmiotu_t;

-- vim: set ft=sql ts=4 sw=4 et:
