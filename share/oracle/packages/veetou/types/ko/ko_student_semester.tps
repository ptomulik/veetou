CREATE OR REPLACE TYPE V2u_Ko_Student_Semester_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , student_id NUMBER(38)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , student_index VARCHAR2(32 CHAR)
    , student_name VARCHAR2(128 CHAR)
    , first_name VARCHAR2(48 CHAR)
    , last_name VARCHAR2(48 CHAR)
    , university VARCHAR2(8 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , studies_modetier VARCHAR2(100 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , studies_specialty VARCHAR2(100 CHAR)
    , semester_number NUMBER(2)
    , semester_code VARCHAR2(5 CHAR)
    , ects_mandatory NUMBER(4)
    , ects_other NUMBER(4)
    , ects_total NUMBER(4)
    , ects_attained NUMBER(4)
--    , sheet_ids V2u_Ids_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Student_Semester_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_Semester_t
            , job_uuid IN RAW
            , student_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , student_index VARCHAR2
            , student_name VARCHAR2
            , first_name VARCHAR2
            , last_name VARCHAR2
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_number IN NUMBER
            , semester_code IN VARCHAR2
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , ects_attained IN NUMBER
--            , sheet_ids IN V2u_Ids_t := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Student_Semester_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_Semester_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp(other IN V2u_Ko_Student_Semester_t)
            RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Student_Semesters_t
    AS TABLE OF V2u_Ko_Student_Semester_t;

-- vim: set ft=sql ts=4 sw=4 et:
