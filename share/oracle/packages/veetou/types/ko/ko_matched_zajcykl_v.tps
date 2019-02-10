CREATE OR REPLACE TYPE V2u_Ko_Matched_Zajcykl_V_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , job_uuid RAW(16)
    , subject_id NUMBER(38)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , subject_map_id NUMBER(38)
    , subject_matching_score NUMBER(38)
    , classes_map_id NUMBER(38)
    , classes_matching_score NUMBER(38)
    --
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
    --
    , dz_prz_kod VARCHAR2(20 CHAR)
    , dz_cdyd_kod VARCHAR2(20 CHAR)
    , dz_tzaj_kod VARCHAR(3 CHAR)
    , dz_liczba_godz NUMBER(12,2)
    , dz_limit_miejsc NUMBER(10)
    , dz_utw_id VARCHAR2(30 CHAR)
    , dz_utw_data DATE
    , dz_mod_id VARCHAR2(30 CHAR)
    , dz_mod_data DATE
    , dz_waga_pensum NUMBER(3,2)
    , dz_tpro_kod VARCHAR2(20 CHAR)
    , dz_efekty_uczenia CLOB
    , dz_efekty_uczenia_ang CLOB
    , dz_kryteria_oceniania CLOB
    , dz_kryteria_oceniania_ang CLOB
    , dz_url VARCHAR2(500 CHAR)
    , dz_zakres_tematow CLOB
    , dz_zakres_tematow_ang CLOB
    , dz_metody_dyd CLOB
    , dz_metody_dyd_ang CLOB
    , dz_literatura CLOB
    , dz_literatura_ang CLOB
    , dz_czy_pokazywac_termin VARCHAR2(1 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Zajcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zajcykl_V_t
            , id IN NUMBER
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , classes_map_id IN NUMBER
            , classes_matching_score IN NUMBER
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
            , dz_prz_kod IN VARCHAR2
            , dz_cdyd_kod IN VARCHAR2
            , dz_tzaj_kod IN VARCHAR2
            , dz_liczba_godz IN NUMBER
            , dz_limit_miejsc IN NUMBER
            , dz_utw_id IN VARCHAR2
            , dz_utw_data IN DATE
            , dz_mod_id IN VARCHAR2
            , dz_mod_data IN DATE
            , dz_waga_pensum IN NUMBER
            , dz_tpro_kod IN VARCHAR2
            , dz_efekty_uczenia IN CLOB
            , dz_efekty_uczenia_ang IN CLOB
            , dz_kryteria_oceniania IN CLOB
            , dz_kryteria_oceniania_ang IN CLOB
            , dz_url IN VARCHAR2
            , dz_zakres_tematow IN CLOB
            , dz_zakres_tematow_ang IN CLOB
            , dz_metody_dyd IN CLOB
            , dz_metody_dyd_ang IN CLOB
            , dz_literatura IN CLOB
            , dz_literatura_ang IN CLOB
            , dz_czy_pokazywac_termin IN VARCHAR2
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Zajcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zajcykl_V_t
            , id IN NUMBER
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map IN V2u_Subject_Map_t
            , classes_map IN V2u_Classes_Map_t
            , zajecia_cyklu IN V2u_Dz_Zajecia_Cyklu_t
            , subject_matching_score IN NUMBER
            , classes_matching_score IN NUMBER
            ) RETURN SELF AS RESULT

    );
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Zajcykles_V_t
    AS TABLE OF V2u_Ko_Matched_Zajcykl_V_t;

-- vim: set ft=sql ts=4 sw=4 et:
