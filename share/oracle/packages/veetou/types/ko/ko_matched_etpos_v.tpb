CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Etpos_V_t AS
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
/
-- vim: set ft=sql ts=4 sw=4 et:
