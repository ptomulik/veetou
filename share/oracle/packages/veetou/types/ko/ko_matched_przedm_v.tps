CREATE OR REPLACE TYPE V2u_Ko_Matched_Przedm_V_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , subject_id NUMBER(38)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , subject_map_id NUMBER(38)
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
    , kod VARCHAR2(20 CHAR)
    , nazwa VARCHAR2(200 CHAR)
    , jed_org_kod VARCHAR2(20 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , tpro_kod VARCHAR2(20 CHAR)
    , czy_wielokrotne NUMBER(1)
    , name VARCHAR2(200 CHAR)
    , skrocony_opis VARCHAR2(1000 CHAR)
    , short_description VARCHAR2(1000 CHAR)
    , jed_org_kod_biorca VARCHAR2(20 CHAR)
    , jzk_kod VARCHAR2(3 CHAR)
    , kod_sok VARCHAR2(5 CHAR)
    , opis CLOB
    , description CLOB
    , literatura CLOB
    , bibliography CLOB
    , efekty_uczenia CLOB
    , efekty_uczenia_ang CLOB
    , kryteria_oceniania CLOB
    , kryteria_oceniania_ang CLOB
    , praktyki_zawodowe VARCHAR2(1000 CHAR)
    , praktyki_zawodowe_ang VARCHAR2(1000 CHAR)
    , url VARCHAR2(500 CHAR)
    , kod_isced VARCHAR2(5 CHAR)
    , nazwa_pol VARCHAR2(200 CHAR)
    , guid VARCHAR2(32 CHAR)
    , pw_nazwa_supl VARCHAR2(200 CHAR)
    , pw_nazwa_supl_ang VARCHAR2(200 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przedm_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przedm_V_t
            , matched_przedm_j IN V2u_Ko_Matched_Przedm_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , przedmiot IN V2u_Dz_Przedmiot_t
            ) RETURN SELF AS RESULT

    );
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Przedms_V_t
    AS TABLE OF V2u_Ko_Matched_Przedm_V_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
