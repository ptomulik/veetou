CREATE OR REPLACE TYPE V2u_Ko_Grade_V_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , student_id NUMBER(38)
    , subject_id NUMBER(38)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , student_index VARCHAR2(32 CHAR)
    , student_name VARCHAR2(128 CHAR)
    , first_name VARCHAR2(48 CHAR)
    , last_name VARCHAR2(48 CHAR)
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
    , tr_id NUMBER(38)

    , CONSTRUCTOR FUNCTION V2u_Ko_Grade_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Grade_V_t
            , job_uuid IN RAW
            , student_id IN NUMBER
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , student_index IN VARCHAR2
            , student_name IN VARCHAR2
            , first_name IN VARCHAR2
            , last_name IN VARCHAR2
            , subj_code IN VARCHAR2
            , subj_name IN VARCHAR2
            , subj_hours_w IN NUMBER
            , subj_hours_c IN NUMBER
            , subj_hours_l IN NUMBER
            , subj_hours_p IN NUMBER
            , subj_hours_s IN NUMBER
            , subj_credit_kind IN VARCHAR2
            , subj_ects IN NUMBER
            , subj_tutor IN VARCHAR2
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_code IN VARCHAR2
            , semester_number IN NUMBER
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , tr_id IN NUMBER
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Grade_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Grade_V_t
            , student IN V2u_Ko_Student_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , tr_id IN NUMBER
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp(other V2u_Ko_Grade_V_t)
            RETURN INTEGER
    );

-- vim: set ft=sql ts=4 sw=4 et:
