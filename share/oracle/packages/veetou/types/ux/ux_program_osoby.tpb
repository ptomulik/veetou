CREATE OR REPLACE TYPE BODY V2u_Ux_Program_Osoby_t AS
    CONSTRUCTOR FUNCTION V2u_Ux_Program_Osoby_t(
              SELF IN OUT NOCOPY V2u_Ux_Program_Osoby_t
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
            , safe_to_add INTEGER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              os_id => os_id
            , prg_kod => prg_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , st_id => st_id
            , czy_glowny => czy_glowny
            , id => id
            , data_nast_zal => data_nast_zal
            , uprawnienia_zawodowe => uprawnienia_zawodowe
            , uprawnienia_zawodowe_ang => uprawnienia_zawodowe_ang
            , jed_org_kod => jed_org_kod
            , dok_upr_id => dok_upr_id
            , data_przyjecia => data_przyjecia
            , plan_data_ukon => plan_data_ukon
            , czy_zgloszony => czy_zgloszony
            , status => status
            , data_rozpoczecia => data_rozpoczecia
            , numer_s => numer_s
            , numer_swiadectwa => numer_swiadectwa
            , tecz_id => tecz_id
            , data_arch => data_arch
            , warunki_przyjec_na_prog => warunki_przyjec_na_prog
            , warunki_przyjec_na_prog_ang => warunki_przyjec_na_prog_ang
            , numer_do_banku => numer_do_banku
            , numer_do_banku_sygn => numer_do_banku_sygn
            , numer_5_proc => numer_5_proc
            , numer_5_proc_sygn => numer_5_proc_sygn
            , status_arch => status_arch
            , osiagniecia => osiagniecia
            , osiagniecia_ang => osiagniecia_ang
            , nr_kierunku_ustawa => nr_kierunku_ustawa
            , limit_ects => limit_ects
            , dodatkowe_ects_uczelnia => dodatkowe_ects_uczelnia
            , wykorzystane_ects_obce => wykorzystane_ects_obce
            , limit_ects_podpiecia => limit_ects_podpiecia
            , prgos_id => prgos_id
            , osiagniecia_programu => osiagniecia_programu
            , osiagniecia_programu_ang => osiagniecia_programu_ang
            , wynik_studiow => wynik_studiow
            , wynik_studiow_ang => wynik_studiow_ang
            , umowa_data_przeczytania => umowa_data_przeczytania
            , umowa_data_podpisania => umowa_data_podpisania
            , umowa_sygnatura => umowa_sygnatura
            , kod_isced => kod_isced
            , job_uuid => job_uuid
            , safe_to_add => safe_to_add
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ux_Program_Osoby_t
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
            , safe_to_add INTEGER
            )
    IS
    BEGIN
        SELF.init(
              os_id => os_id
            , prg_kod => prg_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , st_id => st_id
            , czy_glowny => czy_glowny
            , id => id
            , data_nast_zal => data_nast_zal
            , uprawnienia_zawodowe => uprawnienia_zawodowe
            , uprawnienia_zawodowe_ang => uprawnienia_zawodowe_ang
            , jed_org_kod => jed_org_kod
            , dok_upr_id => dok_upr_id
            , data_przyjecia => data_przyjecia
            , plan_data_ukon => plan_data_ukon
            , czy_zgloszony => czy_zgloszony
            , status => status
            , data_rozpoczecia => data_rozpoczecia
            , numer_s => numer_s
            , numer_swiadectwa => numer_swiadectwa
            , tecz_id => tecz_id
            , data_arch => data_arch
            , warunki_przyjec_na_prog => warunki_przyjec_na_prog
            , warunki_przyjec_na_prog_ang => warunki_przyjec_na_prog_ang
            , numer_do_banku => numer_do_banku
            , numer_do_banku_sygn => numer_do_banku_sygn
            , numer_5_proc => numer_5_proc
            , numer_5_proc_sygn => numer_5_proc_sygn
            , status_arch => status_arch
            , osiagniecia => osiagniecia
            , osiagniecia_ang => osiagniecia_ang
            , nr_kierunku_ustawa => nr_kierunku_ustawa
            , limit_ects => limit_ects
            , dodatkowe_ects_uczelnia => dodatkowe_ects_uczelnia
            , wykorzystane_ects_obce => wykorzystane_ects_obce
            , limit_ects_podpiecia => limit_ects_podpiecia
            , prgos_id => prgos_id
            , osiagniecia_programu => osiagniecia_programu
            , osiagniecia_programu_ang => osiagniecia_programu_ang
            , wynik_studiow => wynik_studiow
            , wynik_studiow_ang => wynik_studiow_ang
            , umowa_data_przeczytania => umowa_data_przeczytania
            , umowa_data_podpisania => umowa_data_podpisania
            , umowa_sygnatura => umowa_sygnatura
            , kod_isced => kod_isced
            );
        SELF.job_uuid := job_uuid;
        SELF.safe_to_add := safe_to_add;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
