CREATE OR REPLACE TYPE V2u_Uu_Punkty_Przedmiotu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Punkty_Przedmiotu_B_t
    ( job_uuid RAW(16)
    , pk_punkty_przedmiotu VARCHAR2(128 CHAR)
    -- DBG
    , dbg_pktprz_ids NUMBER(5)
    , dbg_prz_kody NUMBER(5)
    , dbg_prg_kody NUMBER(5)
    , dbg_cdyd_pocz NUMBER(5)
    , dbg_cdyd_kon NUMBER(5)
    , dbg_map_subj_codes NUMBER(5)
    , dbg_coalesced_subj_codes NUMBER(5)
    , dbg_coalesced_subj_ectses NUMBER(5)
    , dbg_map_program_codes NUMBER(5)
    , dbg_semester_codes NUMBER(5)
    , dbg_ectses_per_id NUMBER(5)
    , dbg_ectses_per_non_id NUMBER(5)
    , dbg_unique_match NUMBER(1)
    , dbg_values_ok NUMBER(1)
    , dbg_matched NUMBER(5)
    , dbg_missing NUMBER(5)
    , dbg_subject_mapped NUMBER(5)
    , dbg_specialty_mapped NUMBER(5)
    -- CTL
    , change_type CHAR(1)
    , safe_to_change NUMBER(1)

    , CONSTRUCTOR FUNCTION V2u_Uu_Punkty_Przedmiotu_t(
              SELF IN OUT NOCOPY V2u_Uu_Punkty_Przedmiotu_t
            , prz_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , tpkt_kod IN VARCHAR2
            , ilosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , id IN NUMBER
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_punkty_przedmiotu IN VARCHAR2
            -- DBG
            , dbg_pktprz_ids IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_prg_kody IN NUMBER
            , dbg_cdyd_pocz IN NUMBER
            , dbg_cdyd_kon IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_coalesced_subj_codes IN NUMBER
            , dbg_coalesced_subj_ectses IN NUMBER
            , dbg_map_program_codes IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_ectses_per_id IN NUMBER
            , dbg_ectses_per_non_id IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_subject_mapped IN NUMBER
            , dbg_specialty_mapped IN NUMBER
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Punkty_Przedmiotu_t
            , prz_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , tpkt_kod IN VARCHAR2
            , ilosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , id IN NUMBER
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_punkty_przedmiotu IN VARCHAR2
            -- DBG
            , dbg_pktprz_ids IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_prg_kody IN NUMBER
            , dbg_cdyd_pocz IN NUMBER
            , dbg_cdyd_kon IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_coalesced_subj_codes IN NUMBER
            , dbg_coalesced_subj_ectses IN NUMBER
            , dbg_map_program_codes IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_ectses_per_id IN NUMBER
            , dbg_ectses_per_non_id IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_subject_mapped IN NUMBER
            , dbg_specialty_mapped IN NUMBER
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            )
    )
;
/
-- vim: set ft=sql ts=4 sw=4 et:
