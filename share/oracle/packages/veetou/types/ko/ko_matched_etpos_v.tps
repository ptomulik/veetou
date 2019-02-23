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

--    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Etpos_V_t(
--              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_V_t
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
--            , specialty_map_id IN NUMBER
--            , etpos_id IN NUMBER
--            , data_zakon IN DATE
--            , utw_id IN VARCHAR2
--            , utw_data IN DATE
--            , mod_id IN VARCHAR2
--            , mod_data IN DATE
--            , status_zaliczenia IN VARCHAR2
--            , etp_kod IN VARCHAR2
--            , prg_kod IN VARCHAR2
--            , prgos_id IN NUMBER
--            , cdyd_kod IN VARCHAR2
--            , status_zal_komentarz IN VARCHAR2
--            , liczba_war IN NUMBER
--            , wym_cdyd_kod IN VARCHAR2
--            , czy_platny_na_2_kier IN VARCHAR2
--            , ects_uzyskane IN NUMBER
--            , czy_przedluzenie IN VARCHAR2
--            , urlop_kod IN VARCHAR2
--            , ects_efekty_uczenia IN NUMBER
--            , ects_przepisane IN NUMBER
--            , kolejnosc IN NUMBER
--            , czy_erasmus IN VARCHAR2
--            , jedn_dyplomujaca IN VARCHAR2
--            , etp_kod_missmatch IN VARCHAR2
--            ) RETURN SELF AS RESULT

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

--    , MEMBER PROCEDURE init(
--              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_V_t
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
--            , specialty_map_id IN NUMBER
--            , etpos_id IN NUMBER
--            , data_zakon IN DATE
--            , utw_id IN VARCHAR2
--            , utw_data IN DATE
--            , mod_id IN VARCHAR2
--            , mod_data IN DATE
--            , status_zaliczenia IN VARCHAR2
--            , etp_kod IN VARCHAR2
--            , prg_kod IN VARCHAR2
--            , prgos_id IN NUMBER
--            , cdyd_kod IN VARCHAR2
--            , status_zal_komentarz IN VARCHAR2
--            , liczba_war IN NUMBER
--            , wym_cdyd_kod IN VARCHAR2
--            , czy_platny_na_2_kier IN VARCHAR2
--            , ects_uzyskane IN NUMBER
--            , czy_przedluzenie IN VARCHAR2
--            , urlop_kod IN VARCHAR2
--            , ects_efekty_uczenia IN NUMBER
--            , ects_przepisane IN NUMBER
--            , kolejnosc IN NUMBER
--            , czy_erasmus IN VARCHAR2
--            , jedn_dyplomujaca IN VARCHAR2
--            , etp_kod_missmatch IN VARCHAR2
--            )

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

-- vim: set ft=sql ts=4 sw=4 et:
