CREATE OR REPLACE TYPE V2u_Uu_Atrybut_Przedmiotu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Atrybut_Przedmiotu_B_t
    ( job_uuid RAW(16)
    , pk_subject VARCHAR2(32 CHAR)
    , pk_attribute VARCHAR2(20 CHAR)
    -- DBG
    , dbg_mapped NUMBER(5)
    , dbg_map_subj_codes NUMBER(5)
    , dbg_subj_codes NUMBER(5)
    , dbg_subj_codes_tab V2u_Subj_20Codes_t
    , dbg_rev_subj_codes NUMBER(5)
    , dbg_rev_subj_codes_tab V2u_Subj_20Codes_t
    , dbg_ids NUMBER(5)
    , dbg_unique_match NUMBER(1)
    -- CTL
    , change_type CHAR(1)
    , safe_to_change NUMBER(1)

    , CONSTRUCTOR FUNCTION V2u_Uu_Atrybut_Przedmiotu_t(
              SELF IN OUT NOCOPY V2u_Uu_Atrybut_Przedmiotu_t
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
            -- KEY
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , pk_attribute IN VARCHAR2
            -- DBG
            , dbg_mapped IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_subj_codes IN NUMBER
            , dbg_subj_codes_tab IN V2u_Subj_20Codes_t
            , dbg_rev_subj_codes IN NUMBER
            , dbg_rev_subj_codes_tab IN V2u_Subj_20Codes_t
            , dbg_ids IN NUMBER
            , dbg_unique_match IN NUMBER
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Atrybut_Przedmiotu_t
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
            -- KEY
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , pk_attribute IN VARCHAR2
            -- DBG
            , dbg_mapped IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_subj_codes IN NUMBER
            , dbg_subj_codes_tab IN V2u_Subj_20Codes_t
            , dbg_rev_subj_codes IN NUMBER
            , dbg_rev_subj_codes_tab IN V2u_Subj_20Codes_t
            , dbg_ids IN NUMBER
            , dbg_unique_match IN NUMBER
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            )
    );
/
CREATE OR REPLACE TYPE V2u_Uu_Atrybuty_Przedmiotow_t
    AS TABLE OF V2u_Uu_Atrybut_Przedmiotu_t;

-- vim: set ft=sql ts=4 sw=4 et:
