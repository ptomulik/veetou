CREATE OR REPLACE TYPE BODY V2u_Dz_Program_Osoby_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Program_Osoby_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Program_Osoby_B_t
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
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Program_Osoby_B_t
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
            )
    IS
    BEGIN
        SELF.os_id := os_id;
        SELF.prg_kod := prg_kod;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.st_id := st_id;
        SELF.czy_glowny := czy_glowny;
        SELF.id := id;
        SELF.data_nast_zal := data_nast_zal;
        SELF.uprawnienia_zawodowe := uprawnienia_zawodowe;
        SELF.uprawnienia_zawodowe_ang := uprawnienia_zawodowe_ang;
        SELF.jed_org_kod := jed_org_kod;
        SELF.dok_upr_id := dok_upr_id;
        SELF.data_przyjecia := data_przyjecia;
        SELF.plan_data_ukon := plan_data_ukon;
        SELF.czy_zgloszony := czy_zgloszony;
        SELF.status := status;
        SELF.data_rozpoczecia := data_rozpoczecia;
        SELF.numer_s := numer_s;
        SELF.numer_swiadectwa := numer_swiadectwa;
        SELF.tecz_id := tecz_id;
        SELF.data_arch := data_arch;
        SELF.warunki_przyjec_na_prog := warunki_przyjec_na_prog;
        SELF.warunki_przyjec_na_prog_ang := warunki_przyjec_na_prog_ang;
        SELF.numer_do_banku := numer_do_banku;
        SELF.numer_do_banku_sygn := numer_do_banku_sygn;
        SELF.numer_5_proc := numer_5_proc;
        SELF.numer_5_proc_sygn := numer_5_proc_sygn;
        SELF.status_arch := status_arch;
        SELF.osiagniecia := osiagniecia;
        SELF.osiagniecia_ang := osiagniecia_ang;
        SELF.nr_kierunku_ustawa := nr_kierunku_ustawa;
        SELF.limit_ects := limit_ects;
        SELF.dodatkowe_ects_uczelnia := dodatkowe_ects_uczelnia;
        SELF.wykorzystane_ects_obce := wykorzystane_ects_obce;
        SELF.limit_ects_podpiecia := limit_ects_podpiecia;
        SELF.prgos_id := prgos_id;
        SELF.osiagniecia_programu := osiagniecia_programu;
        SELF.osiagniecia_programu_ang := osiagniecia_programu_ang;
        SELF.wynik_studiow := wynik_studiow;
        SELF.wynik_studiow_ang := wynik_studiow_ang;
        SELF.umowa_data_przeczytania := umowa_data_przeczytania;
        SELF.umowa_data_podpisania := umowa_data_podpisania;
        SELF.umowa_sygnatura := umowa_sygnatura;
        SELF.kod_isced := kod_isced;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
