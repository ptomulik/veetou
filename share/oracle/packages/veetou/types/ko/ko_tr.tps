CREATE OR REPLACE TYPE V2u_Ko_Tr_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
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
    , subj_grade VARCHAR2(10 CHAR)
    , subj_grade_date DATE

    , CONSTRUCTOR FUNCTION V2u_Ko_Tr_t(
              SELF IN OUT NOCOPY V2u_Ko_Tr_t
            , job_uuid IN RAW
            , id IN NUMBER
            , subj_code IN VARCHAR2 := NULL
            , subj_name IN VARCHAR2 := NULL
            , subj_hours_w IN NUMBER := NULL
            , subj_hours_c IN NUMBER := NULL
            , subj_hours_l IN NUMBER := NULL
            , subj_hours_p IN NUMBER := NULL
            , subj_hours_s IN NUMBER := NULL
            , subj_credit_kind IN VARCHAR2 := NULL
            , subj_ects IN NUMBER := NULL
            , subj_tutor IN VARCHAR2 := NULL
            , subj_grade IN VARCHAR2 := NULL
            , subj_grade_date IN DATE := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION rawpk RETURN RAW
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Trs_t
    AS TABLE OF V2u_Ko_Tr_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
