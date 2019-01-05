CREATE OR REPLACE TYPE V2u_Ko_Matched_Zajcykl_V_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , classes_type VARCHAR2(1 CHAR)
    , classes_hours NUMBER(8)
    , subject_id NUMBER(38)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , subject_map_id NUMBER(38)
    , classes_map_id NUMBER(38)
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

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Zajcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zajcykl_V_t
            , matched_zajcykl_j IN V2u_Ko_Matched_Zajcykl_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , zajecia_cyklu IN V2u_Dz_Zajecia_Cyklu_t
            ) RETURN SELF AS RESULT

    );
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Zajcykles_V_t
    AS TABLE OF V2u_Ko_Matched_Zajcykl_V_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
