CREATE OR REPLACE TYPE V2u_Ko_Przedmiot_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , job_uuid RAW(16)
    , subject_id NUMBER(38)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , subject_map_id NUMBER(38)
    , matching_score NUMBER(38)
    , prz_kod VARCHAR2(20 CHAR)
    , ko_subj_code VARCHAR2(32 CHAR)
    , ko_subj_name VARCHAR2(256 CHAR)
    , ko_subj_hours_w NUMBER(8)
    , ko_subj_hours_c NUMBER(8)
    , ko_subj_hours_l NUMBER(8)
    , ko_subj_hours_p NUMBER(8)
    , ko_subj_hours_s NUMBER(8)
    , ko_subj_credit_kind VARCHAR2(16 CHAR)
    , ko_subj_ects NUMBER(4)
    , ko_subj_tutor VARCHAR2(256 CHAR)
    , ko_university VARCHAR2(8 CHAR)
    , ko_faculty VARCHAR2(8 CHAR)
    , ko_studies_modetier VARCHAR2(100 CHAR)
    , ko_studies_field VARCHAR2(100 CHAR)
    , ko_studies_specialty VARCHAR2(100 CHAR)
    , ko_semester_code VARCHAR2(5 CHAR)
    , ko_semester_number NUMBER(2)
    , ko_ects_mandatory NUMBER(4)
    , ko_ects_other NUMBER(4)
    , ko_ects_total NUMBER(4)
    , dz_nazwa VARCHAR2(200 CHAR)
    , dz_jed_org_kod VARCHAR2(20 CHAR)
    , dz_utw_id VARCHAR2(30 CHAR)
    , dz_utw_data DATE
    , dz_mod_id VARCHAR2(30 CHAR)
    , dz_mod_data DATE
    , dz_tpro_kod VARCHAR2(20 CHAR)
    , dz_czy_wielokrotne NUMBER(1)
    , dz_name VARCHAR2(200 CHAR)
    , dz_skrocony_opis VARCHAR2(1000 CHAR)
    , dz_short_description VARCHAR2(1000 CHAR)
    , dz_jed_org_kod_biorca VARCHAR2(20 CHAR)
    , dz_jzk_kod VARCHAR2(3 CHAR)
    , dz_kod_sok VARCHAR2(5 CHAR)
    , dz_opis CLOB
    , dz_description CLOB
    , dz_literatura CLOB
    , dz_bibliography CLOB
    , dz_efekty_uczenia CLOB
    , dz_efekty_uczenia_ang CLOB
    , dz_kryteria_oceniania CLOB
    , dz_kryteria_oceniania_ang CLOB
    , dz_praktyki_zawodowe VARCHAR2(1000 CHAR)
    , dz_praktyki_zawodowe_ang VARCHAR2(1000 CHAR)
    , dz_url VARCHAR2(500 CHAR)
    , dz_kod_isced VARCHAR2(5 CHAR)
    , dz_nazwa_pol VARCHAR2(200 CHAR)
    , dz_guid VARCHAR2(32 CHAR)
    , dz_pw_nazwa_supl VARCHAR2(200 CHAR)
    , dz_pw_nazwa_supl_ang VARCHAR2(200 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Przedmiot_t(
              SELF IN OUT NOCOPY V2u_Ko_Przedmiot_t
            , id IN NUMBER
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , matching_score IN NUMBER
            , prz_kod IN VARCHAR2
            , ko_subj_code IN VARCHAR2
            , ko_subj_name IN VARCHAR2
            , ko_subj_hours_w IN NUMBER
            , ko_subj_hours_c IN NUMBER
            , ko_subj_hours_l IN NUMBER
            , ko_subj_hours_p IN NUMBER
            , ko_subj_hours_s IN NUMBER
            , ko_subj_credit_kind IN VARCHAR2
            , ko_subj_ects IN NUMBER
            , ko_subj_tutor IN VARCHAR2
            , ko_university IN VARCHAR2
            , ko_faculty IN VARCHAR2
            , ko_studies_modetier IN VARCHAR2
            , ko_studies_field IN VARCHAR2
            , ko_studies_specialty IN VARCHAR2
            , ko_semester_code IN VARCHAR2
            , ko_semester_number IN NUMBER
            , ko_ects_mandatory IN NUMBER
            , ko_ects_other IN NUMBER
            , ko_ects_total IN NUMBER
            , dz_nazwa IN VARCHAR2
            , dz_jed_org_kod IN VARCHAR2
            , dz_utw_id IN VARCHAR2
            , dz_utw_data IN DATE
            , dz_mod_id IN VARCHAR2
            , dz_mod_data IN DATE
            , dz_tpro_kod IN VARCHAR2
            , dz_czy_wielokrotne IN NUMBER
            , dz_name IN VARCHAR2
            , dz_skrocony_opis IN VARCHAR2
            , dz_short_description IN VARCHAR2
            , dz_jed_org_kod_biorca IN VARCHAR2
            , dz_jzk_kod IN VARCHAR2
            , dz_kod_sok IN VARCHAR2
            , dz_opis IN CLOB
            , dz_description IN CLOB
            , dz_literatura IN CLOB
            , dz_bibliography IN CLOB
            , dz_efekty_uczenia IN CLOB
            , dz_efekty_uczenia_ang IN CLOB
            , dz_kryteria_oceniania IN CLOB
            , dz_kryteria_oceniania_ang IN CLOB
            , dz_praktyki_zawodowe IN VARCHAR2
            , dz_praktyki_zawodowe_ang IN VARCHAR2
            , dz_url IN VARCHAR2
            , dz_kod_isced IN VARCHAR2
            , dz_nazwa_pol IN VARCHAR2
            , dz_guid IN VARCHAR2
            , dz_pw_nazwa_supl IN VARCHAR2
            , dz_pw_nazwa_supl_ang IN VARCHAR2
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Przedmiot_t(
              SELF IN OUT NOCOPY V2u_Ko_Przedmiot_t
            , id IN NUMBER
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map IN V2u_Subject_Map_t
            , przedmiot IN V2u_Dz_Przedmiot_t
            , matching_score IN NUMBER
            ) RETURN SELF AS RESULT

    );
/
CREATE OR REPLACE TYPE V2u_Ko_Przedmioty_t
    AS TABLE OF V2u_Ko_Przedmiot_t;

-- vim: set ft=sql ts=4 sw=4 et:
