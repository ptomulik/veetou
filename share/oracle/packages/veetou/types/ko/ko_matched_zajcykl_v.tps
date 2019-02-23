CREATE OR REPLACE TYPE V2u_Ko_Matched_Zajcykl_V_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , classes_type VARCHAR2(1 CHAR)
    , subject_id NUMBER(38)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , subject_map_id NUMBER(38)
    , subject_matching_score NUMBER(38)
    , classes_map_id NUMBER(38)
    , classes_matching_score NUMBER(38)
    -- KO
    , subj_code VARCHAR2(32 CHAR)
    , subj_name VARCHAR2(256 CHAR)
    , subj_hours_w NUMBER(8)
    , subj_hours_c NUMBER(8)
    , subj_hours_l NUMBER(8)
    , subj_hours_p NUMBER(8)
    , subj_hours_s NUMBER(8)
    , subj_credit_kind VARCHAR2(16 CHAR)
    , subj_ects NUMBER(4)
    , subj_tutor VARCHAR2(256 CHAR)
    , university VARCHAR2(8 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , studies_modetier VARCHAR2(100 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , studies_specialty VARCHAR2(100 CHAR)
    , semester_code VARCHAR2(5 CHAR)
    , semester_number NUMBER(2)
    , ects_mandatory NUMBER(4)
    , ects_other NUMBER(4)
    , ects_total NUMBER(4)
    -- DZ
    , prz_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , tzaj_kod VARCHAR(3 CHAR)
    , liczba_godz NUMBER(12,2)
    , limit_miejsc NUMBER(10)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , waga_pensum NUMBER(3,2)
    , tpro_kod VARCHAR2(20 CHAR)
    , efekty_uczenia CLOB
    , efekty_uczenia_ang CLOB
    , kryteria_oceniania CLOB
    , kryteria_oceniania_ang CLOB
    , url VARCHAR2(500 CHAR)
    , zakres_tematow CLOB
    , zakres_tematow_ang CLOB
    , metody_dyd CLOB
    , metody_dyd_ang CLOB
    , literatura CLOB
    , literatura_ang CLOB
    , czy_pokazywac_termin VARCHAR2(1 CHAR)

--    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Zajcykl_V_t(
--              SELF IN OUT NOCOPY V2u_Ko_Matched_Zajcykl_V_t
--            , job_uuid IN RAW
--            , classes_type IN VARCHAR2
--            , subject_id IN NUMBER
--            , specialty_id IN NUMBER
--            , semester_id IN NUMBER
--            , subject_map_id IN NUMBER
--            , subject_matching_score IN NUMBER
--            , classes_map_id IN NUMBER
--            , classes_matching_score IN NUMBER
--            -- KO
--            , subj_code IN VARCHAR2
--            , subj_name IN VARCHAR2
--            , subj_hours_w IN NUMBER
--            , subj_hours_c IN NUMBER
--            , subj_hours_l IN NUMBER
--            , subj_hours_p IN NUMBER
--            , subj_hours_s IN NUMBER
--            , subj_credit_kind IN VARCHAR2
--            , subj_ects IN NUMBER
--            , subj_tutor IN VARCHAR2
--            , university IN VARCHAR2
--            , faculty IN VARCHAR2
--            , studies_modetier IN VARCHAR2
--            , studies_field IN VARCHAR2
--            , studies_specialty IN VARCHAR2
--            , semester_code IN VARCHAR2
--            , semester_number IN NUMBER
--            , ects_mandatory IN NUMBER
--            , ects_other IN NUMBER
--            , ects_total IN NUMBER
--            -- DZ
--            , prz_kod IN VARCHAR2
--            , cdyd_kod IN VARCHAR2
--            , tzaj_kod IN VARCHAR2
--            , liczba_godz IN NUMBER
--            , limit_miejsc IN NUMBER
--            , utw_id IN VARCHAR2
--            , utw_data IN DATE
--            , mod_id IN VARCHAR2
--            , mod_data IN DATE
--            , waga_pensum IN NUMBER
--            , tpro_kod IN VARCHAR2
--            , efekty_uczenia IN CLOB
--            , efekty_uczenia_ang IN CLOB
--            , kryteria_oceniania IN CLOB
--            , kryteria_oceniania_ang IN CLOB
--            , url IN VARCHAR2
--            , zakres_tematow IN CLOB
--            , zakres_tematow_ang IN CLOB
--            , metody_dyd IN CLOB
--            , metody_dyd_ang IN CLOB
--            , literatura IN CLOB
--            , literatura_ang IN CLOB
--            , czy_pokazywac_termin IN VARCHAR2
--            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Zajcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zajcykl_V_t
            , classes_type IN VARCHAR2
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
