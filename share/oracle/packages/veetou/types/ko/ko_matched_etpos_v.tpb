CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Etpos_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Etpos_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_V_t
            , job_uuid IN RAW
            , student_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , student_index VARCHAR2
            , student_name VARCHAR2
            , first_name VARCHAR2
            , last_name VARCHAR2
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
            , ects_attained IN NUMBER
            , specialty_map_id IN NUMBER
            , etpos_id IN NUMBER
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
            , etp_kod_missmatch IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , student_id => student_id
            , specialty_id => specialty_id
            , semester_id => semester_id
            , student_index => student_index
            , student_name => student_name
            , first_name => first_name
            , last_name => last_name
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
            , ects_attained => ects_attained
            , specialty_map_id => specialty_map_id
            , etpos_id => etpos_id
            , data_zakon => data_zakon
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , status_zaliczenia => status_zaliczenia
            , etp_kod => etp_kod
            , prg_kod => prg_kod
            , prgos_id => prgos_id
            , cdyd_kod => cdyd_kod
            , status_zal_komentarz => status_zal_komentarz
            , liczba_war => liczba_war
            , wym_cdyd_kod => wym_cdyd_kod
            , czy_platny_na_2_kier => czy_platny_na_2_kier
            , ects_uzyskane => ects_uzyskane
            , czy_przedluzenie => czy_przedluzenie
            , urlop_kod => urlop_kod
            , ects_efekty_uczenia => ects_efekty_uczenia
            , ects_przepisane => ects_przepisane
            , kolejnosc => kolejnosc
            , czy_erasmus => czy_erasmus
            , jedn_dyplomujaca => jedn_dyplomujaca
            , etp_kod_missmatch => etp_kod_missmatch
            );
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Etpos_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_V_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , specialty_map_id IN NUMBER
            , etap_osoby IN V2u_Dz_Etap_Osoby_t
            , etp_kod_missmatch IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              student => student
            , specialty => specialty
            , semester => semester
            , ects_attained => ects_attained
            , specialty_map_id => specialty_map_id
            , etap_osoby => etap_osoby
            , etp_kod_missmatch => etp_kod_missmatch
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_V_t
            , job_uuid IN RAW
            , student_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , student_index VARCHAR2
            , student_name VARCHAR2
            , first_name VARCHAR2
            , last_name VARCHAR2
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
            , ects_attained IN NUMBER
            , specialty_map_id IN NUMBER
            , etpos_id IN NUMBER
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
            , etp_kod_missmatch IN VARCHAR2
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , student_id => student_id
            , specialty_id => specialty_id
            , semester_id => semester_id
            , student_index => student_index
            , student_name => student_name
            , first_name => first_name
            , last_name => last_name
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
            , ects_attained => ects_attained
            );
        SELF.specialty_map_id := specialty_map_id;
        SELF.etpos_id := etpos_id;
        SELF.data_zakon := data_zakon;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.status_zaliczenia := status_zaliczenia;
        SELF.etp_kod := etp_kod;
        SELF.prg_kod := prg_kod;
        SELF.prgos_id := prgos_id;
        SELF.cdyd_kod := cdyd_kod;
        SELF.status_zal_komentarz := status_zal_komentarz;
        SELF.liczba_war := liczba_war;
        SELF.wym_cdyd_kod := wym_cdyd_kod;
        SELF.czy_platny_na_2_kier := czy_platny_na_2_kier;
        SELF.ects_uzyskane := ects_uzyskane;
        SELF.czy_przedluzenie := czy_przedluzenie;
        SELF.urlop_kod := urlop_kod;
        SELF.ects_efekty_uczenia := ects_efekty_uczenia;
        SELF.ects_przepisane := ects_przepisane;
        SELF.kolejnosc := kolejnosc;
        SELF.czy_erasmus := czy_erasmus;
        SELF.jedn_dyplomujaca := jedn_dyplomujaca;
        SELF.etp_kod_missmatch := etp_kod_missmatch;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_V_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , specialty_map_id IN NUMBER
            , etap_osoby IN V2u_Dz_Etap_Osoby_t
            , etp_kod_missmatch IN VARCHAR2
            )
    IS
    BEGIN
        SELF.init(
              student => student
            , specialty => specialty
            , semester => semester
            , ects_attained => ects_attained
            );
        SELF.specialty_map_id := specialty_map_id;
        SELF.etpos_id := etap_osoby.id;
        SELF.data_zakon := etap_osoby.data_zakon;
        SELF.utw_id := etap_osoby.utw_id;
        SELF.utw_data := etap_osoby.utw_data;
        SELF.mod_id := etap_osoby.mod_id;
        SELF.mod_data := etap_osoby.mod_data;
        SELF.status_zaliczenia := etap_osoby.status_zaliczenia;
        SELF.etp_kod := etap_osoby.etp_kod;
        SELF.prg_kod := etap_osoby.prg_kod;
        SELF.prgos_id := etap_osoby.prgos_id;
        SELF.cdyd_kod := etap_osoby.cdyd_kod;
        SELF.status_zal_komentarz := etap_osoby.status_zal_komentarz;
        SELF.liczba_war := etap_osoby.liczba_war;
        SELF.wym_cdyd_kod := etap_osoby.wym_cdyd_kod;
        SELF.czy_platny_na_2_kier := etap_osoby.czy_platny_na_2_kier;
        SELF.ects_uzyskane := etap_osoby.ects_uzyskane;
        SELF.czy_przedluzenie := etap_osoby.czy_przedluzenie;
        SELF.urlop_kod := etap_osoby.urlop_kod;
        SELF.ects_efekty_uczenia := etap_osoby.ects_efekty_uczenia;
        SELF.ects_przepisane := etap_osoby.ects_przepisane;
        SELF.kolejnosc := etap_osoby.kolejnosc;
        SELF.czy_erasmus := etap_osoby.czy_erasmus;
        SELF.jedn_dyplomujaca := etap_osoby.jedn_dyplomujaca;
        SELF.etp_kod_missmatch := etp_kod_missmatch;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
