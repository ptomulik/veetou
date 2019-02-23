CREATE OR REPLACE TYPE V2u_Ko_Matched_Przedm_V_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , subject_id NUMBER(38)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , subject_map_id NUMBER(38)
    , matching_score NUMBER(38)
    , prz_kod VARCHAR2(20 CHAR)
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

--    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przedm_V_t(
--              SELF IN OUT NOCOPY V2u_Ko_Matched_Przedm_V_t
--            , job_uuid IN RAW
--            , subject_id IN NUMBER
--            , specialty_id IN NUMBER
--            , semester_id IN NUMBER
--            , subject_map_id IN NUMBER
--            , matching_score IN NUMBER
--            , prz_kod IN VARCHAR2
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
--            , nazwa IN VARCHAR2
--            , jed_org_kod IN VARCHAR2
--            , utw_id IN VARCHAR2
--            , utw_data IN DATE
--            , mod_id IN VARCHAR2
--            , mod_data IN DATE
--            , tpro_kod IN VARCHAR2
--            , czy_wielokrotne IN NUMBER
--            , name IN VARCHAR2
--            , skrocony_opis IN VARCHAR2
--            , short_description IN VARCHAR2
--            , jed_org_kod_biorca IN VARCHAR2
--            , jzk_kod IN VARCHAR2
--            , kod_sok IN VARCHAR2
--            , opis IN CLOB
--            , description IN CLOB
--            , literatura IN CLOB
--            , bibliography IN CLOB
--            , efekty_uczenia IN CLOB
--            , efekty_uczenia_ang IN CLOB
--            , kryteria_oceniania IN CLOB
--            , kryteria_oceniania_ang IN CLOB
--            , praktyki_zawodowe IN VARCHAR2
--            , praktyki_zawodowe_ang IN VARCHAR2
--            , url IN VARCHAR2
--            , kod_isced IN VARCHAR2
--            , nazwa_pol IN VARCHAR2
--            , guid IN VARCHAR2
--            , pw_nazwa_supl IN VARCHAR2
--            , pw_nazwa_supl_ang IN VARCHAR2
--            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przedm_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przedm_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map IN V2u_Subject_Map_t
            , przedmiot IN V2u_Dz_Przedmiot_t
            , matching_score IN NUMBER
            ) RETURN SELF AS RESULT

    );
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Przedms_V_t
    AS TABLE OF V2u_Ko_Matched_Przedm_V_t;

-- vim: set ft=sql ts=4 sw=4 et:
