CREATE OR REPLACE TYPE V2u_Ko_Matched_Etpos_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Student_Semester_V_t
    ( specialty_map_id NUMBER(38)
    , etpos_id NUMBER(10)
    , data_zakon DATE
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , status_zaliczenia VARCHAR2(1 CHAR)
    , etp_kod VARCHAR2(20 CHAR)
    , prg_kod VARCHAR2(20 CHAR)
    , prgos_id NUMBER(10)
    , cdyd_kod VARCHAR2(20 CHAR)
    , status_zal_komentarz VARCHAR2(1000 CHAR)
    , liczba_war NUMBER(10)
    , wym_cdyd_kod VARCHAR2(20 CHAR)
    , czy_platny_na_2_kier VARCHAR2(1 CHAR)
    , ects_uzyskane NUMBER(5,2)
    , czy_przedluzenie VARCHAR2(1 CHAR)
    , urlop_kod VARCHAR2(1 CHAR)
    , ects_efekty_uczenia NUMBER(5,2)
    , ects_przepisane NUMBER(5,2)
    , kolejnosc NUMBER(2)
    , czy_erasmus VARCHAR2(1 CHAR)
    , jedn_dyplomujaca VARCHAR2(20 CHAR)
    , etp_kod_missmatch VARCHAR2(32 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Etpos_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_V_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , specialty_map_id IN NUMBER
            , etap_osoby IN V2u_Dz_Etap_Osoby_t
            , etp_kod_missmatch IN VARCHAR2
            ) RETURN SELF AS RESULT


    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_V_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , specialty_map_id IN NUMBER
            , etap_osoby IN V2u_Dz_Etap_Osoby_t
            , etp_kod_missmatch IN VARCHAR2
            )
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Etposes_V_t
    AS TABLE OF V2u_Ko_Matched_Etpos_V_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
