CREATE OR REPLACE TYPE BODY V2u_Ko_Skipped_Program_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Skipped_Program_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Skipped_Program_V_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , where_tryb_studiow IN VARCHAR2
            , where_rodzaj_studiow IN VARCHAR2
            , where_jed_org_kod_podst IN VARCHAR2
            , where_opis_like IN VARCHAR2
            , program IN V2u_Dz_Program_B_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              specialty => specialty
            , semester => semester
            , where_tryb_studiow => where_tryb_studiow
            , where_rodzaj_studiow => where_rodzaj_studiow
            , where_jed_org_kod_podst => where_jed_org_kod_podst
            , where_opis_like => where_opis_like
            , program => program
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Skipped_Program_V_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , where_tryb_studiow IN VARCHAR2
            , where_rodzaj_studiow IN VARCHAR2
            , where_jed_org_kod_podst IN VARCHAR2
            , where_opis_like IN VARCHAR2
            , program IN V2u_Dz_Program_B_t
            )
    IS
    BEGIN
        SELF.init(
              specialty => specialty
            , semester => semester
            );
        SELF.where_tryb_studiow := where_tryb_studiow;
        SELF.where_rodzaj_studiow := where_rodzaj_studiow;
        SELF.where_jed_org_kod_podst := where_jed_org_kod_podst;
        SELF.where_opis_like := where_opis_like;
        SELF.prg_kod := program.kod;
        SELF.opis := program.opis;
        SELF.data_od := program.data_od;
        SELF.data_do := program.data_do;
        SELF.utw_id := program.utw_id;
        SELF.utw_data := program.utw_data;
        SELF.mod_id := program.mod_id;
        SELF.mod_data := program.mod_data;
        SELF.tryb_studiow := program.tryb_studiow;
        SELF.rodzaj_studiow := program.rodzaj_studiow;
        SELF.czas_trwania := program.czas_trwania;
        SELF.description := program.description;
        SELF.dalsze_studia := program.dalsze_studia;
        SELF.dalsze_studia_ang := program.dalsze_studia_ang;
        SELF.rodzaj_studiow_ang := program.rodzaj_studiow_ang;
        SELF.czas_trwania_ang := program.czas_trwania_ang;
        SELF.tryb_studiow_ang := program.tryb_studiow_ang;
        SELF.tcdyd_kod := program.tcdyd_kod;
        SELF.liczba_jedn := program.liczba_jedn;
        SELF.czy_wyswietlac := program.czy_wyswietlac;
        SELF.uprawnienia_zawodowe := program.uprawnienia_zawodowe;
        SELF.uprawnienia_zawodowe_ang := program.uprawnienia_zawodowe_ang;
        SELF.opis_nie := program.opis_nie;
        SELF.opis_ros := program.opis_ros;
        SELF.opis_his := program.opis_his;
        SELF.opis_fra := program.opis_fra;
        SELF.konf_sr_kod := program.konf_sr_kod;
        SELF.prow_kier_id := program.prow_kier_id;
        SELF.profil := program.profil;
        SELF.czy_studia_miedzyobszarowe := program.czy_studia_miedzyobszarowe;
        SELF.czy_bezplatny_ustawa := program.czy_bezplatny_ustawa;
        SELF.limit_ects := program.limit_ects;
        SELF.dodatkowe_ects_ustawa := program.dodatkowe_ects_ustawa;
        SELF.dodatkowe_ects_uczelnia := program.dodatkowe_ects_uczelnia;
        SELF.czynniki_szkodliwe := program.czynniki_szkodliwe;
        SELF.zakres := program.zakres;
        SELF.zakres_ang := program.zakres_ang;
        SELF.jed_org_kod_podst := program.jed_org_kod_podst;
        SELF.kod_polon_ism := program.kod_polon_ism;
        SELF.kod_polon_dr := program.kod_polon_dr;
        SELF.kod_isced := program.kod_isced;
        SELF.kod_polon_rekrutacja := program.kod_polon_rekrutacja;
        SELF.jed_org_kod_prow := program.jed_org_kod_prow;
        SELF.ustal_date_konca_studiow := program.ustal_date_konca_studiow;
        SELF.pw_data_od_rekr := program.pw_data_od_rekr;
        SELF.pw_data_do_rekr := program.pw_data_do_rekr;
        SELF.pw_ects_obowiazkowe := program.pw_ects_obowiazkowe;
        SELF.pw_ects_obieralne := program.pw_ects_obieralne;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
