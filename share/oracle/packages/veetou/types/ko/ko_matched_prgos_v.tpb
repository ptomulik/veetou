CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Prgos_V_t AS
--    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Prgos_V_t(
--              SELF IN OUT NOCOPY V2u_Ko_Matched_Prgos_V_t
--            , job_uuid IN RAW
--            , student_id IN NUMBER
--            , specialty_id IN NUMBER
--            , semester_id IN NUMBER
--            , student_index VARCHAR2
--            , student_name VARCHAR2
--            , first_name VARCHAR2
--            , last_name VARCHAR2
--            , university IN VARCHAR2
--            , faculty IN VARCHAR2
--            , studies_modetier IN VARCHAR2
--            , studies_field IN VARCHAR2
--            , studies_specialty IN VARCHAR2
--            , semester_number IN NUMBER
--            , semester_code IN VARCHAR2
--            , ects_mandatory IN NUMBER
--            , ects_other IN NUMBER
--            , ects_total IN NUMBER
--            , ects_attained IN NUMBER
--            , prgos_id IN NUMBER
--            , os_id IN NUMBER
--            , prg_kod IN VARCHAR2
--            , utw_id IN VARCHAR2
--            , utw_data IN DATE
--            , mod_id IN VARCHAR2
--            , mod_data IN DATE
--            , st_id IN NUMBER
--            , czy_glowny IN VARCHAR2
--            , data_nast_zal IN DATE
--            , uprawnienia_zawodowe IN VARCHAR2
--            , uprawnienia_zawodowe_ang IN VARCHAR2
--            , jed_org_kod IN VARCHAR2
--            , dok_upr_id IN NUMBER
--            , data_przyjecia IN DATE
--            , plan_data_ukon IN DATE
--            , czy_zgloszony IN VARCHAR2
--            , status IN VARCHAR2
--            , data_rozpoczecia IN DATE
--            , numer_s IN NUMBER
--            , numer_swiadectwa IN VARCHAR2
--            , tecz_id IN NUMBER
--            , data_arch IN DATE
--            , warunki_przyjec_na_prog IN VARCHAR2
--            , warunki_przyjec_na_prog_ang IN VARCHAR2
--            , numer_do_banku IN NUMBER
--            , numer_do_banku_sygn IN VARCHAR2
--            , numer_5_proc IN NUMBER
--            , numer_5_proc_sygn IN VARCHAR2
--            , status_arch IN VARCHAR2
--            , osiagniecia IN CLOB
--            , osiagniecia_ang IN CLOB
--            , nr_kierunku_ustawa IN VARCHAR2
--            , limit_ects IN NUMBER
--            , dodatkowe_ects_uczelnia IN NUMBER
--            , wykorzystane_ects_obce IN NUMBER
--            , limit_ects_podpiecia IN NUMBER
--            , prgos_prgos_id IN NUMBER
--            , osiagniecia_programu IN VARCHAR2
--            , osiagniecia_programu_ang IN VARCHAR2
--            , wynik_studiow IN VARCHAR2
--            , wynik_studiow_ang IN VARCHAR2
--            , umowa_data_przeczytania IN DATE
--            , umowa_data_podpisania IN DATE
--            , umowa_sygnatura IN VARCHAR2
--            , kod_isced IN VARCHAR2
--            ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.init(
--              job_uuid => job_uuid
--            , student_id => student_id
--            , specialty_id => specialty_id
--            , semester_id => semester_id
--            , student_index => student_index
--            , student_name => student_name
--            , first_name => first_name
--            , last_name => last_name
--            , university => university
--            , faculty => faculty
--            , studies_modetier => studies_modetier
--            , studies_field => studies_field
--            , studies_specialty => studies_specialty
--            , semester_number => semester_number
--            , semester_code => semester_code
--            , ects_mandatory => ects_mandatory
--            , ects_other => ects_other
--            , ects_total => ects_total
--            , ects_attained => ects_attained
--            , prgos_id => prgos_id
--            , os_id => os_id
--            , prg_kod => prg_kod
--            , utw_id => utw_id
--            , utw_data => utw_data
--            , mod_id => mod_id
--            , mod_data => mod_data
--            , st_id => st_id
--            , czy_glowny => czy_glowny
--            , data_nast_zal => data_nast_zal
--            , uprawnienia_zawodowe => uprawnienia_zawodowe
--            , uprawnienia_zawodowe_ang => uprawnienia_zawodowe_ang
--            , jed_org_kod => jed_org_kod
--            , dok_upr_id => dok_upr_id
--            , data_przyjecia => data_przyjecia
--            , plan_data_ukon => plan_data_ukon
--            , czy_zgloszony => czy_zgloszony
--            , status => status
--            , data_rozpoczecia => data_rozpoczecia
--            , numer_s => numer_s
--            , numer_swiadectwa => numer_swiadectwa
--            , tecz_id => tecz_id
--            , data_arch => data_arch
--            , warunki_przyjec_na_prog => warunki_przyjec_na_prog
--            , warunki_przyjec_na_prog_ang => warunki_przyjec_na_prog_ang
--            , numer_do_banku => numer_do_banku
--            , numer_do_banku_sygn => numer_do_banku_sygn
--            , numer_5_proc => numer_5_proc
--            , numer_5_proc_sygn => numer_5_proc_sygn
--            , status_arch => status_arch
--            , osiagniecia => osiagniecia
--            , osiagniecia_ang => osiagniecia_ang
--            , nr_kierunku_ustawa => nr_kierunku_ustawa
--            , limit_ects => limit_ects
--            , dodatkowe_ects_uczelnia => dodatkowe_ects_uczelnia
--            , wykorzystane_ects_obce => wykorzystane_ects_obce
--            , limit_ects_podpiecia => limit_ects_podpiecia
--            , prgos_prgos_id => prgos_prgos_id
--            , osiagniecia_programu => osiagniecia_programu
--            , osiagniecia_programu_ang => osiagniecia_programu_ang
--            , wynik_studiow => wynik_studiow
--            , wynik_studiow_ang => wynik_studiow_ang
--            , umowa_data_przeczytania => umowa_data_przeczytania
--            , umowa_data_podpisania => umowa_data_podpisania
--            , umowa_sygnatura => umowa_sygnatura
--            , kod_isced => kod_isced
--            );
--        RETURN;
--    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Prgos_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Prgos_V_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , program_osoby IN V2u_Dz_Program_Osoby_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              semester => semester
            , specialty => specialty
            , student => student
            , ects_attained => ects_attained
            , program_osoby => program_osoby
            );
        RETURN;
    END;

--    MEMBER PROCEDURE init(
--              SELF IN OUT NOCOPY V2u_Ko_Matched_Prgos_V_t
--            , job_uuid IN RAW
--            , student_id IN NUMBER
--            , specialty_id IN NUMBER
--            , semester_id IN NUMBER
--            , student_index VARCHAR2
--            , student_name VARCHAR2
--            , first_name VARCHAR2
--            , last_name VARCHAR2
--            , university IN VARCHAR2
--            , faculty IN VARCHAR2
--            , studies_modetier IN VARCHAR2
--            , studies_field IN VARCHAR2
--            , studies_specialty IN VARCHAR2
--            , semester_number IN NUMBER
--            , semester_code IN VARCHAR2
--            , ects_mandatory IN NUMBER
--            , ects_other IN NUMBER
--            , ects_total IN NUMBER
--            , ects_attained IN NUMBER
--            , prgos_id IN NUMBER
--            , os_id IN NUMBER
--            , prg_kod IN VARCHAR2
--            , utw_id IN VARCHAR2
--            , utw_data IN DATE
--            , mod_id IN VARCHAR2
--            , mod_data IN DATE
--            , st_id IN NUMBER
--            , czy_glowny IN VARCHAR2
--            , data_nast_zal IN DATE
--            , uprawnienia_zawodowe IN VARCHAR2
--            , uprawnienia_zawodowe_ang IN VARCHAR2
--            , jed_org_kod IN VARCHAR2
--            , dok_upr_id IN NUMBER
--            , data_przyjecia IN DATE
--            , plan_data_ukon IN DATE
--            , czy_zgloszony IN VARCHAR2
--            , status IN VARCHAR2
--            , data_rozpoczecia IN DATE
--            , numer_s IN NUMBER
--            , numer_swiadectwa IN VARCHAR2
--            , tecz_id IN NUMBER
--            , data_arch IN DATE
--            , warunki_przyjec_na_prog IN VARCHAR2
--            , warunki_przyjec_na_prog_ang IN VARCHAR2
--            , numer_do_banku IN NUMBER
--            , numer_do_banku_sygn IN VARCHAR2
--            , numer_5_proc IN NUMBER
--            , numer_5_proc_sygn IN VARCHAR2
--            , status_arch IN VARCHAR2
--            , osiagniecia IN CLOB
--            , osiagniecia_ang IN CLOB
--            , nr_kierunku_ustawa IN VARCHAR2
--            , limit_ects IN NUMBER
--            , dodatkowe_ects_uczelnia IN NUMBER
--            , wykorzystane_ects_obce IN NUMBER
--            , limit_ects_podpiecia IN NUMBER
--            , prgos_prgos_id IN NUMBER
--            , osiagniecia_programu IN VARCHAR2
--            , osiagniecia_programu_ang IN VARCHAR2
--            , wynik_studiow IN VARCHAR2
--            , wynik_studiow_ang IN VARCHAR2
--            , umowa_data_przeczytania IN DATE
--            , umowa_data_podpisania IN DATE
--            , umowa_sygnatura IN VARCHAR2
--            , kod_isced IN VARCHAR2
--            )
--    IS
--    BEGIN
--        SELF.init(
--              job_uuid => job_uuid
--            , student_id => student_id
--            , specialty_id => specialty_id
--            , semester_id => semester_id
--            , student_index => student_index
--            , student_name => student_name
--            , first_name => first_name
--            , last_name => last_name
--            , university => university
--            , faculty => faculty
--            , studies_modetier => studies_modetier
--            , studies_field => studies_field
--            , studies_specialty => studies_specialty
--            , semester_number => semester_number
--            , semester_code => semester_code
--            , ects_mandatory => ects_mandatory
--            , ects_other => ects_other
--            , ects_total => ects_total
--            , ects_attained => ects_attained
--            );
--        SELF.prgos_id := prgos_id;
--        SELF.os_id := os_id;
--        SELF.prg_kod := prg_kod;
--        SELF.utw_id := utw_id;
--        SELF.utw_data := utw_data;
--        SELF.mod_id := mod_id;
--        SELF.mod_data := mod_data;
--        SELF.st_id := st_id;
--        SELF.czy_glowny := czy_glowny;
--        SELF.data_nast_zal := data_nast_zal;
--        SELF.uprawnienia_zawodowe := uprawnienia_zawodowe;
--        SELF.uprawnienia_zawodowe_ang := uprawnienia_zawodowe_ang;
--        SELF.jed_org_kod := jed_org_kod;
--        SELF.dok_upr_id := dok_upr_id;
--        SELF.data_przyjecia := data_przyjecia;
--        SELF.plan_data_ukon := plan_data_ukon;
--        SELF.czy_zgloszony := czy_zgloszony;
--        SELF.status := status;
--        SELF.data_rozpoczecia := data_rozpoczecia;
--        SELF.numer_s := numer_s;
--        SELF.numer_swiadectwa := numer_swiadectwa;
--        SELF.tecz_id := tecz_id;
--        SELF.data_arch := data_arch;
--        SELF.warunki_przyjec_na_prog := warunki_przyjec_na_prog;
--        SELF.warunki_przyjec_na_prog_ang := warunki_przyjec_na_prog_ang;
--        SELF.numer_do_banku := numer_do_banku;
--        SELF.numer_do_banku_sygn := numer_do_banku_sygn;
--        SELF.numer_5_proc := numer_5_proc;
--        SELF.numer_5_proc_sygn := numer_5_proc_sygn;
--        SELF.status_arch := status_arch;
--        SELF.osiagniecia := osiagniecia;
--        SELF.osiagniecia_ang := osiagniecia_ang;
--        SELF.nr_kierunku_ustawa := nr_kierunku_ustawa;
--        SELF.limit_ects := limit_ects;
--        SELF.dodatkowe_ects_uczelnia := dodatkowe_ects_uczelnia;
--        SELF.wykorzystane_ects_obce := wykorzystane_ects_obce;
--        SELF.limit_ects_podpiecia := limit_ects_podpiecia;
--        SELF.prgos_prgos_id := prgos_prgos_id;
--        SELF.osiagniecia_programu := osiagniecia_programu;
--        SELF.osiagniecia_programu_ang := osiagniecia_programu_ang;
--        SELF.wynik_studiow := wynik_studiow;
--        SELF.wynik_studiow_ang := wynik_studiow_ang;
--        SELF.umowa_data_przeczytania := umowa_data_przeczytania;
--        SELF.umowa_data_podpisania := umowa_data_podpisania;
--        SELF.umowa_sygnatura := umowa_sygnatura;
--        SELF.kod_isced := kod_isced;
--    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Prgos_V_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , program_osoby IN V2u_Dz_Program_Osoby_t
            )
    IS
    BEGIN
        SELF.init(
              student => student
            , specialty => specialty
            , semester => semester
            , ects_attained => ects_attained
            );
        SELF.prgos_id := program_osoby.id;
        SELF.os_id := program_osoby.os_id;
        SELF.prg_kod := program_osoby.prg_kod;
        SELF.utw_id := program_osoby.utw_id;
        SELF.utw_data := program_osoby.utw_data;
        SELF.mod_id := program_osoby.mod_id;
        SELF.mod_data := program_osoby.mod_data;
        SELF.st_id := program_osoby.st_id;
        SELF.czy_glowny := program_osoby.czy_glowny;
        SELF.data_nast_zal := program_osoby.data_nast_zal;
        SELF.uprawnienia_zawodowe := program_osoby.uprawnienia_zawodowe;
        SELF.uprawnienia_zawodowe_ang := program_osoby.uprawnienia_zawodowe_ang;
        SELF.jed_org_kod := program_osoby.jed_org_kod;
        SELF.dok_upr_id := program_osoby.dok_upr_id;
        SELF.data_przyjecia := program_osoby.data_przyjecia;
        SELF.plan_data_ukon := program_osoby.plan_data_ukon;
        SELF.czy_zgloszony := program_osoby.czy_zgloszony;
        SELF.status := program_osoby.status;
        SELF.data_rozpoczecia := program_osoby.data_rozpoczecia;
        SELF.numer_s := program_osoby.numer_s;
        SELF.numer_swiadectwa := program_osoby.numer_swiadectwa;
        SELF.tecz_id := program_osoby.tecz_id;
        SELF.data_arch := program_osoby.data_arch;
        SELF.warunki_przyjec_na_prog := program_osoby.warunki_przyjec_na_prog;
        SELF.warunki_przyjec_na_prog_ang := program_osoby.warunki_przyjec_na_prog_ang;
        SELF.numer_do_banku := program_osoby.numer_do_banku;
        SELF.numer_do_banku_sygn := program_osoby.numer_do_banku_sygn;
        SELF.numer_5_proc := program_osoby.numer_5_proc;
        SELF.numer_5_proc_sygn := program_osoby.numer_5_proc_sygn;
        SELF.status_arch := program_osoby.status_arch;
        SELF.osiagniecia := program_osoby.osiagniecia;
        SELF.osiagniecia_ang := program_osoby.osiagniecia_ang;
        SELF.nr_kierunku_ustawa := program_osoby.nr_kierunku_ustawa;
        SELF.limit_ects := program_osoby.limit_ects;
        SELF.dodatkowe_ects_uczelnia := program_osoby.dodatkowe_ects_uczelnia;
        SELF.wykorzystane_ects_obce := program_osoby.wykorzystane_ects_obce;
        SELF.limit_ects_podpiecia := program_osoby.limit_ects_podpiecia;
        SELF.prgos_prgos_id := program_osoby.prgos_id;
        SELF.osiagniecia_programu := program_osoby.osiagniecia_programu;
        SELF.osiagniecia_programu_ang := program_osoby.osiagniecia_programu_ang;
        SELF.wynik_studiow := program_osoby.wynik_studiow;
        SELF.wynik_studiow_ang := program_osoby.wynik_studiow_ang;
        SELF.umowa_data_przeczytania := program_osoby.umowa_data_przeczytania;
        SELF.umowa_data_podpisania := program_osoby.umowa_data_podpisania;
        SELF.umowa_sygnatura := program_osoby.umowa_sygnatura;
        SELF.kod_isced := program_osoby.kod_isced;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
