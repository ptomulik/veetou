CREATE OR REPLACE TYPE V2u_Ko_Etap_Osoby_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , job_uuid RAW(16)
    , student_id NUMBER(38)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , specialty_map_id NUMBER(38)
    , etpos_id NUMBER(10)
    , ko_student_index VARCHAR2(32 CHAR)
    , ko_student_name VARCHAR2(128 CHAR)
    , ko_first_name VARCHAR2(48 CHAR)
    , ko_last_name VARCHAR2(48 CHAR)
    , ko_university VARCHAR2(8 CHAR)
    , ko_faculty VARCHAR2(8 CHAR)
    , ko_studies_modetier VARCHAR2(100 CHAR)
    , ko_studies_field VARCHAR2(100 CHAR)
    , ko_studies_specialty VARCHAR2(100 CHAR)
    , ko_map_program_code VARCHAR2(32 CHAR)
    , ko_map_modetier_code VARCHAR2(32 CHAR)
    , ko_map_field_code VARCHAR2(32 CHAR)
    , ko_map_specialty_code VARCHAR2(32 CHAR)
    , ko_semester_number NUMBER(2)
    , ko_semester_code VARCHAR2(5 CHAR)
    , dz_data_zakon DATE
    , dz_utw_id VARCHAR2(30 CHAR)
    , dz_utw_data DATE
    , dz_mod_id VARCHAR2(30 CHAR)
    , dz_mod_data DATE
    , dz_status_zaliczenia VARCHAR2(1 CHAR)
    , dz_etp_kod VARCHAR2(20 CHAR)
    , dz_prg_kod VARCHAR2(20 CHAR)
    , dz_prgos_id NUMBER(10)
    , dz_cdyd_kod VARCHAR2(20 CHAR)
    , dz_status_zal_komentarz VARCHAR2(1000 CHAR)
    , dz_liczba_war NUMBER(10)
    , dz_wym_cdyd_kod VARCHAR2(20 CHAR)
    , dz_czy_platny_na_2_kier VARCHAR2(1 CHAR)
    , dz_ects_uzyskane NUMBER(5,2)
    , dz_czy_przedluzenie VARCHAR2(1 CHAR)
    , dz_urlop_kod VARCHAR2(1 CHAR)
    , dz_ects_efekty_uczenia NUMBER(5,2)
    , dz_ects_przepisane NUMBER(5,2)
    , dz_kolejnosc NUMBER(2)
    , dz_czy_erasmus VARCHAR2(1 CHAR)
    , dz_jedn_dyplomujaca VARCHAR2(20 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Etap_Osoby_t(
              SELF IN OUT NOCOPY V2u_Ko_Etap_Osoby_t
            , id IN NUMBER
            , job_uuid IN RAW
            , student_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , specialty_map_id IN NUMBER
            , etpos_id IN NUMBER
            , ko_student_index IN VARCHAR2
            , ko_student_name IN VARCHAR2
            , ko_first_name IN VARCHAR2
            , ko_last_name IN VARCHAR2
            , ko_university IN VARCHAR2
            , ko_faculty IN VARCHAR2
            , ko_studies_modetier IN VARCHAR2
            , ko_studies_field IN VARCHAR2
            , ko_studies_specialty IN VARCHAR2
            , ko_map_program_code IN VARCHAR2
            , ko_map_modetier_code IN VARCHAR2
            , ko_map_field_code IN VARCHAR2
            , ko_map_specialty_code IN VARCHAR2
            , ko_semester_number IN NUMBER
            , ko_semester_code IN VARCHAR2
            , dz_data_zakon IN DATE
            , dz_utw_id IN VARCHAR2
            , dz_utw_data IN DATE
            , dz_mod_id IN VARCHAR2
            , dz_mod_data IN DATE
            , dz_status_zaliczenia IN VARCHAR2
            , dz_etp_kod IN VARCHAR2
            , dz_prg_kod IN VARCHAR2
            , dz_prgos_id IN NUMBER
            , dz_cdyd_kod IN VARCHAR2
            , dz_status_zal_komentarz IN VARCHAR2
            , dz_liczba_war IN NUMBER
            , dz_wym_cdyd_kod IN VARCHAR2
            , dz_czy_platny_na_2_kier IN VARCHAR2
            , dz_ects_uzyskane IN NUMBER
            , dz_czy_przedluzenie IN VARCHAR2
            , dz_urlop_kod IN VARCHAR2
            , dz_ects_efekty_uczenia IN NUMBER
            , dz_ects_przepisane IN NUMBER
            , dz_kolejnosc IN NUMBER
            , dz_czy_erasmus IN VARCHAR2
            , dz_jedn_dyplomujaca IN VARCHAR2
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Etap_Osoby_t(
              SELF IN OUT NOCOPY V2u_Ko_Etap_Osoby_t
            , id IN NUMBER
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , specialty_map IN V2u_Specialty_Map_t
            , etap_osoby IN V2u_Dz_Etap_Osoby_t
            ) RETURN SELF AS RESULT

--    , ORDER MEMBER FUNCTION cmp(other IN V2u_Ko_Etap_Osoby_t)
--            RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Etapy_Osob_t
    AS TABLE OF V2u_Ko_Etap_Osoby_t;

-- vim: set ft=sql ts=4 sw=4 et:
