CREATE OR REPLACE TYPE V2u_Uu_Program_Osoby_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Program_Osoby_B_t
    ( job_uuid RAW(16)
    , pk_student_index VARCHAR2(32 CHAR)
    , pk_program_osoby VARCHAR2(128 CHAR)
    , dbg_unique_match NUMBER(1)
    , dbg_map_program_codes NUMBER(5)
    , dbg_faculty_codes NUMBER(5)
    , dbg_matched_ids NUMBER(5)
    , dbg_matched_prg_kody NUMBER(5)
    , dbg_matched_st_ids NUMBER(5)
    , dbg_matched_os_ids NUMBER(5)
    , dbg_skipped_prg_kody NUMBER(5)
    , dbg_matched NUMBER(5)
    , dbg_missing NUMBER(5)
    , dbg_mapped NUMBER(5)
    , safe_to_add NUMBER(1)

    , CONSTRUCTOR FUNCTION V2u_Uu_Program_Osoby_t(
              SELF IN OUT NOCOPY V2u_Uu_Program_Osoby_t
            , os_id IN NUMBER
            , prg_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , st_id IN NUMBER
            , czy_glowny IN VARCHAR2
            , id IN NUMBER
            , data_nast_zal IN DATE
            , uprawnienia_zawodowe IN VARCHAR2
            , uprawnienia_zawodowe_ang IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , dok_upr_id IN NUMBER
            , data_przyjecia IN DATE
            , plan_data_ukon IN DATE
            , czy_zgloszony IN VARCHAR2
            , status IN VARCHAR2
            , data_rozpoczecia IN DATE
            , numer_s IN NUMBER
            , numer_swiadectwa IN VARCHAR2
            , tecz_id IN NUMBER
            , data_arch IN DATE
            , warunki_przyjec_na_prog IN VARCHAR2
            , warunki_przyjec_na_prog_ang IN VARCHAR2
            , numer_do_banku IN NUMBER
            , numer_do_banku_sygn IN VARCHAR2
            , numer_5_proc IN NUMBER
            , numer_5_proc_sygn IN VARCHAR2
            , status_arch IN VARCHAR2
            , osiagniecia IN CLOB
            , osiagniecia_ang IN CLOB
            , nr_kierunku_ustawa IN VARCHAR2
            , limit_ects IN NUMBER
            , dodatkowe_ects_uczelnia IN NUMBER
            , wykorzystane_ects_obce IN NUMBER
            , limit_ects_podpiecia IN NUMBER
            , prgos_id IN NUMBER
            , osiagniecia_programu IN VARCHAR2
            , osiagniecia_programu_ang IN VARCHAR2
            , wynik_studiow IN VARCHAR2
            , wynik_studiow_ang IN VARCHAR2
            , umowa_data_przeczytania IN DATE
            , umowa_data_podpisania IN DATE
            , umowa_sygnatura IN VARCHAR2
            , kod_isced IN VARCHAR2
            , job_uuid IN RAW
            , pk_student_index IN VARCHAR2
            , pk_program_osoby IN VARCHAR2
            , dbg_unique_match IN NUMBER
            , dbg_map_program_codes IN NUMBER
            , dbg_faculty_codes IN NUMBER
            , dbg_matched_ids IN NUMBER
            , dbg_matched_prg_kody IN NUMBER
            , dbg_matched_st_ids IN NUMBER
            , dbg_matched_os_ids IN NUMBER
            , dbg_skipped_prg_kody IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_mapped IN NUMBER
            , safe_to_add IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Program_Osoby_t
            , os_id IN NUMBER
            , prg_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , st_id IN NUMBER
            , czy_glowny IN VARCHAR2
            , id IN NUMBER
            , data_nast_zal IN DATE
            , uprawnienia_zawodowe IN VARCHAR2
            , uprawnienia_zawodowe_ang IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , dok_upr_id IN NUMBER
            , data_przyjecia IN DATE
            , plan_data_ukon IN DATE
            , czy_zgloszony IN VARCHAR2
            , status IN VARCHAR2
            , data_rozpoczecia IN DATE
            , numer_s IN NUMBER
            , numer_swiadectwa IN VARCHAR2
            , tecz_id IN NUMBER
            , data_arch IN DATE
            , warunki_przyjec_na_prog IN VARCHAR2
            , warunki_przyjec_na_prog_ang IN VARCHAR2
            , numer_do_banku IN NUMBER
            , numer_do_banku_sygn IN VARCHAR2
            , numer_5_proc IN NUMBER
            , numer_5_proc_sygn IN VARCHAR2
            , status_arch IN VARCHAR2
            , osiagniecia IN CLOB
            , osiagniecia_ang IN CLOB
            , nr_kierunku_ustawa IN VARCHAR2
            , limit_ects IN NUMBER
            , dodatkowe_ects_uczelnia IN NUMBER
            , wykorzystane_ects_obce IN NUMBER
            , limit_ects_podpiecia IN NUMBER
            , prgos_id IN NUMBER
            , osiagniecia_programu IN VARCHAR2
            , osiagniecia_programu_ang IN VARCHAR2
            , wynik_studiow IN VARCHAR2
            , wynik_studiow_ang IN VARCHAR2
            , umowa_data_przeczytania IN DATE
            , umowa_data_podpisania IN DATE
            , umowa_sygnatura IN VARCHAR2
            , kod_isced IN VARCHAR2
            , job_uuid IN RAW
            , pk_student_index IN VARCHAR2
            , pk_program_osoby IN VARCHAR2
            , dbg_unique_match IN NUMBER
            , dbg_map_program_codes IN NUMBER
            , dbg_faculty_codes IN NUMBER
            , dbg_matched_ids IN NUMBER
            , dbg_matched_prg_kody IN NUMBER
            , dbg_matched_st_ids IN NUMBER
            , dbg_matched_os_ids IN NUMBER
            , dbg_skipped_prg_kody IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_mapped IN NUMBER
            , safe_to_add IN NUMBER
            )
    )
;

-- vim: set ft=sql ts=4 sw=4 et:
