CREATE OR REPLACE TYPE V2u_Uu_Etap_Osoby_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Etap_Osoby_B_t
    ( job_uuid RAW(16)
    , pk_student VARCHAR2(32 CHAR)
    , pk_etap_osoby VARCHAR2(128 CHAR)
    -- DBG
    , dbg_unique_match NUMBER(1)
    , dbg_values_ok NUMBER(1)
    , dbg_map_program_codes NUMBER(5)
    , dbg_ids NUMBER(5)
    , dbg_eo_prgos_ids NUMBER(5)
    , dbg_po_prgos_ids NUMBER(5)
    , dbg_eo_etp_kody NUMBER(5)
    , dbg_ek_etp_kody NUMBER(5)
    , dbg_eo_prg_kody NUMBER(5)
    , dbg_po_prg_kody NUMBER(5)
    , dbg_semester_codes NUMBER(5)
    , dbg_ects_attained NUMBER(5)
    , dbg_skipped_prg_kody NUMBER(5)
    , dbg_matched NUMBER(5)
    , dbg_missing NUMBER(5)
    , dbg_mapped NUMBER(5)
    -- CTL
    , change_type VARCHAR2(1)
    , safe_to_change NUMBER(1)


    , CONSTRUCTOR FUNCTION V2u_Uu_Etap_Osoby_t(
              SELF IN OUT NOCOPY V2u_Uu_Etap_Osoby_t
            , id IN NUMBER
            , data_zakon IN DATE
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , status_zaliczenia IN VARCHAR2
            , etp_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , prgos_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , status_zal_komentarz IN VARCHAR2
            , liczba_war IN NUMBER
            , wym_cdyd_kod IN VARCHAR2
            , czy_platny_na_2_kier IN VARCHAR2
            , ects_uzyskane IN NUMBER
            , czy_przedluzenie IN VARCHAR2
            , urlop_kod IN VARCHAR2
            , ects_efekty_uczenia IN NUMBER
            , ects_przepisane IN NUMBER
            , kolejnosc IN NUMBER
            , czy_erasmus IN VARCHAR2
            , jedn_dyplomujaca IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_student IN VARCHAR2
            , pk_etap_osoby IN VARCHAR2
            -- DBG
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_map_program_codes IN NUMBER
            , dbg_ids IN NUMBER
            , dbg_eo_prgos_ids IN NUMBER
            , dbg_po_prgos_ids IN NUMBER
            , dbg_eo_etp_kody IN NUMBER
            , dbg_ek_etp_kody IN NUMBER
            , dbg_eo_prg_kody IN NUMBER
            , dbg_po_prg_kody IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_ects_attained IN NUMBER
            , dbg_skipped_prg_kody IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_mapped IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Etap_Osoby_t
            , id IN NUMBER
            , data_zakon IN DATE
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , status_zaliczenia IN VARCHAR2
            , etp_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , prgos_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , status_zal_komentarz IN VARCHAR2
            , liczba_war IN NUMBER
            , wym_cdyd_kod IN VARCHAR2
            , czy_platny_na_2_kier IN VARCHAR2
            , ects_uzyskane IN NUMBER
            , czy_przedluzenie IN VARCHAR2
            , urlop_kod IN VARCHAR2
            , ects_efekty_uczenia IN NUMBER
            , ects_przepisane IN NUMBER
            , kolejnosc IN NUMBER
            , czy_erasmus IN VARCHAR2
            , jedn_dyplomujaca IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_student IN VARCHAR2
            , pk_etap_osoby IN VARCHAR2
            -- DBG
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_map_program_codes IN NUMBER
            , dbg_ids IN NUMBER
            , dbg_eo_prgos_ids IN NUMBER
            , dbg_po_prgos_ids IN NUMBER
            , dbg_eo_etp_kody IN NUMBER
            , dbg_ek_etp_kody IN NUMBER
            , dbg_eo_prg_kody IN NUMBER
            , dbg_po_prg_kody IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_ects_attained IN NUMBER
            , dbg_skipped_prg_kody IN NUMBER
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
