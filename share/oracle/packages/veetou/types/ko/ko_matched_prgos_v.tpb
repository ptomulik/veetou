CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Prgos_V_t AS
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
/
-- vim: set ft=sql ts=4 sw=4 et:
