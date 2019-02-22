CREATE OR REPLACE TYPE BODY V2u_Ko_Skipped_Program_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Skipped_Program_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Skipped_Program_V_t
            , job_uuid IN RAW
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_number IN NUMBER
            , semester_code IN VARCHAR2
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , where_tryb_studiow IN VARCHAR2
            , where_rodzaj_studiow IN VARCHAR2
            , where_jed_org_kod_podst IN VARCHAR2
            , where_opis_like IN VARCHAR2
            , prg_kod IN VARCHAR2
            , opis IN VARCHAR2
            , data_od IN DATE
            , data_do IN DATE
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tryb_studiow IN VARCHAR2
            , rodzaj_studiow IN VARCHAR2
            , czas_trwania IN VARCHAR2
            , description IN VARCHAR2
            , dalsze_studia IN VARCHAR2
            , dalsze_studia_ang IN VARCHAR2
            , rodzaj_studiow_ang IN VARCHAR2
            , czas_trwania_ang IN VARCHAR2
            , tryb_studiow_ang IN VARCHAR2
            , tcdyd_kod IN VARCHAR2
            , liczba_jedn IN NUMBER
            , czy_wyswietlac IN VARCHAR2
            , uprawnienia_zawodowe IN CLOB
            , uprawnienia_zawodowe_ang IN CLOB
            , opis_nie IN VARCHAR2
            , opis_ros IN VARCHAR2
            , opis_his IN VARCHAR2
            , opis_fra IN VARCHAR2
            , konf_sr_kod IN VARCHAR2
            , prow_kier_id IN NUMBER
            , profil IN VARCHAR2
            , czy_studia_miedzyobszarowe IN VARCHAR2
            , czy_bezplatny_ustawa IN VARCHAR2
            , limit_ects IN NUMBER
            , dodatkowe_ects_ustawa IN NUMBER
            , dodatkowe_ects_uczelnia IN NUMBER
            , czynniki_szkodliwe IN VARCHAR2
            , zakres IN VARCHAR2
            , zakres_ang IN VARCHAR2
            , jed_org_kod_podst IN VARCHAR2
            , kod_polon_ism IN VARCHAR2
            , kod_polon_dr IN VARCHAR2
            , kod_isced IN VARCHAR2
            , kod_polon_rekrutacja IN VARCHAR2
            , jed_org_kod_prow IN VARCHAR2
            , ustal_date_konca_studiow IN VARCHAR2
            , pw_data_od_rekr IN DATE
            , pw_data_do_rekr IN DATE
            , pw_ects_obowiazkowe IN NUMBER
            , pw_ects_obieralne IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , specialty_id => specialty_id
            , semester_id => semester_id
            , university => university
            , faculty => faculty
            , studies_modetier => studies_modetier
            , studies_field => studies_field
            , studies_specialty => studies_specialty
            , semester_number => semester_number
            , semester_code => semester_code
            , ects_mandatory => ects_mandatory
            , ects_other => ects_other
            , ects_total => ects_total
            , where_tryb_studiow => where_tryb_studiow
            , where_rodzaj_studiow => where_rodzaj_studiow
            , where_jed_org_kod_podst => where_jed_org_kod_podst
            , where_opis_like => where_opis_like
            , prg_kod => prg_kod
            , opis => opis
            , data_od => data_od
            , data_do => data_do
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , tryb_studiow => tryb_studiow
            , rodzaj_studiow => rodzaj_studiow
            , czas_trwania => czas_trwania
            , description => description
            , dalsze_studia => dalsze_studia
            , dalsze_studia_ang => dalsze_studia_ang
            , rodzaj_studiow_ang => rodzaj_studiow_ang
            , czas_trwania_ang => czas_trwania_ang
            , tryb_studiow_ang => tryb_studiow_ang
            , tcdyd_kod => tcdyd_kod
            , liczba_jedn => liczba_jedn
            , czy_wyswietlac => czy_wyswietlac
            , uprawnienia_zawodowe => uprawnienia_zawodowe
            , uprawnienia_zawodowe_ang => uprawnienia_zawodowe_ang
            , opis_nie => opis_nie
            , opis_ros => opis_ros
            , opis_his => opis_his
            , opis_fra => opis_fra
            , konf_sr_kod => konf_sr_kod
            , prow_kier_id => prow_kier_id
            , profil => profil
            , czy_studia_miedzyobszarowe => czy_studia_miedzyobszarowe
            , czy_bezplatny_ustawa => czy_bezplatny_ustawa
            , limit_ects => limit_ects
            , dodatkowe_ects_ustawa => dodatkowe_ects_ustawa
            , dodatkowe_ects_uczelnia => dodatkowe_ects_uczelnia
            , czynniki_szkodliwe => czynniki_szkodliwe
            , zakres => zakres
            , zakres_ang => zakres_ang
            , jed_org_kod_podst => jed_org_kod_podst
            , kod_polon_ism => kod_polon_ism
            , kod_polon_dr => kod_polon_dr
            , kod_isced => kod_isced
            , kod_polon_rekrutacja => kod_polon_rekrutacja
            , jed_org_kod_prow => jed_org_kod_prow
            , ustal_date_konca_studiow => ustal_date_konca_studiow
            , pw_data_od_rekr => pw_data_od_rekr
            , pw_data_do_rekr => pw_data_do_rekr
            , pw_ects_obowiazkowe => pw_ects_obowiazkowe
            , pw_ects_obieralne => pw_ects_obieralne
            );
        RETURN;
    END;


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
            , job_uuid IN RAW
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_number IN NUMBER
            , semester_code IN VARCHAR2
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , where_tryb_studiow IN VARCHAR2
            , where_rodzaj_studiow IN VARCHAR2
            , where_jed_org_kod_podst IN VARCHAR2
            , where_opis_like IN VARCHAR2
            , prg_kod IN VARCHAR2
            , opis IN VARCHAR2
            , data_od IN DATE
            , data_do IN DATE
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tryb_studiow IN VARCHAR2
            , rodzaj_studiow IN VARCHAR2
            , czas_trwania IN VARCHAR2
            , description IN VARCHAR2
            , dalsze_studia IN VARCHAR2
            , dalsze_studia_ang IN VARCHAR2
            , rodzaj_studiow_ang IN VARCHAR2
            , czas_trwania_ang IN VARCHAR2
            , tryb_studiow_ang IN VARCHAR2
            , tcdyd_kod IN VARCHAR2
            , liczba_jedn IN NUMBER
            , czy_wyswietlac IN VARCHAR2
            , uprawnienia_zawodowe IN CLOB
            , uprawnienia_zawodowe_ang IN CLOB
            , opis_nie IN VARCHAR2
            , opis_ros IN VARCHAR2
            , opis_his IN VARCHAR2
            , opis_fra IN VARCHAR2
            , konf_sr_kod IN VARCHAR2
            , prow_kier_id IN NUMBER
            , profil IN VARCHAR2
            , czy_studia_miedzyobszarowe IN VARCHAR2
            , czy_bezplatny_ustawa IN VARCHAR2
            , limit_ects IN NUMBER
            , dodatkowe_ects_ustawa IN NUMBER
            , dodatkowe_ects_uczelnia IN NUMBER
            , czynniki_szkodliwe IN VARCHAR2
            , zakres IN VARCHAR2
            , zakres_ang IN VARCHAR2
            , jed_org_kod_podst IN VARCHAR2
            , kod_polon_ism IN VARCHAR2
            , kod_polon_dr IN VARCHAR2
            , kod_isced IN VARCHAR2
            , kod_polon_rekrutacja IN VARCHAR2
            , jed_org_kod_prow IN VARCHAR2
            , ustal_date_konca_studiow IN VARCHAR2
            , pw_data_od_rekr IN DATE
            , pw_data_do_rekr IN DATE
            , pw_ects_obowiazkowe IN NUMBER
            , pw_ects_obieralne IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , specialty_id => specialty_id
            , semester_id => semester_id
            , university => university
            , faculty => faculty
            , studies_modetier => studies_modetier
            , studies_field => studies_field
            , studies_specialty => studies_specialty
            , semester_number => semester_number
            , semester_code => semester_code
            , ects_mandatory => ects_mandatory
            , ects_other => ects_other
            , ects_total => ects_total
            );
        SELF.where_tryb_studiow := where_tryb_studiow;
        SELF.where_rodzaj_studiow := where_rodzaj_studiow;
        SELF.where_jed_org_kod_podst := where_jed_org_kod_podst;
        SELF.where_opis_like := where_opis_like;
        SELF.prg_kod := prg_kod;
        SELF.opis := opis;
        SELF.data_od := data_od;
        SELF.data_do := data_do;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.tryb_studiow := tryb_studiow;
        SELF.rodzaj_studiow := rodzaj_studiow;
        SELF.czas_trwania := czas_trwania;
        SELF.description := description;
        SELF.dalsze_studia := dalsze_studia;
        SELF.dalsze_studia_ang := dalsze_studia_ang;
        SELF.rodzaj_studiow_ang := rodzaj_studiow_ang;
        SELF.czas_trwania_ang := czas_trwania_ang;
        SELF.tryb_studiow_ang := tryb_studiow_ang;
        SELF.tcdyd_kod := tcdyd_kod;
        SELF.liczba_jedn := liczba_jedn;
        SELF.czy_wyswietlac := czy_wyswietlac;
        SELF.uprawnienia_zawodowe := uprawnienia_zawodowe;
        SELF.uprawnienia_zawodowe_ang := uprawnienia_zawodowe_ang;
        SELF.opis_nie := opis_nie;
        SELF.opis_ros := opis_ros;
        SELF.opis_his := opis_his;
        SELF.opis_fra := opis_fra;
        SELF.konf_sr_kod := konf_sr_kod;
        SELF.prow_kier_id := prow_kier_id;
        SELF.profil := profil;
        SELF.czy_studia_miedzyobszarowe := czy_studia_miedzyobszarowe;
        SELF.czy_bezplatny_ustawa := czy_bezplatny_ustawa;
        SELF.limit_ects := limit_ects;
        SELF.dodatkowe_ects_ustawa := dodatkowe_ects_ustawa;
        SELF.dodatkowe_ects_uczelnia := dodatkowe_ects_uczelnia;
        SELF.czynniki_szkodliwe := czynniki_szkodliwe;
        SELF.zakres := zakres;
        SELF.zakres_ang := zakres_ang;
        SELF.jed_org_kod_podst := jed_org_kod_podst;
        SELF.kod_polon_ism := kod_polon_ism;
        SELF.kod_polon_dr := kod_polon_dr;
        SELF.kod_isced := kod_isced;
        SELF.kod_polon_rekrutacja := kod_polon_rekrutacja;
        SELF.jed_org_kod_prow := jed_org_kod_prow;
        SELF.ustal_date_konca_studiow := ustal_date_konca_studiow;
        SELF.pw_data_od_rekr := pw_data_od_rekr;
        SELF.pw_data_do_rekr := pw_data_do_rekr;
        SELF.pw_ects_obowiazkowe := pw_ects_obowiazkowe;
        SELF.pw_ects_obieralne := pw_ects_obieralne;
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
