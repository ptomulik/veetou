CREATE OR REPLACE TYPE V2u_Ko_Student_Thread_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , student_id NUMBER(38)
    , specialty_id NUMBER(38)
    , specialty_map_id NUMBER(38)
    , thread_index NUMBER(4)
    , student_index VARCHAR2(32 CHAR)
    , student_name VARCHAR2(128 CHAR)
    , first_name VARCHAR2(48 CHAR)
    , last_name VARCHAR2(48 CHAR)
    , university VARCHAR2(8 CHAR)
    , faculty VARCHAR2(8 CHAR)
    , studies_modetier VARCHAR2(100 CHAR)
    , studies_field VARCHAR2(100 CHAR)
    , studies_specialty VARCHAR2(100 CHAR)
    , map_program_code VARCHAR2(32 CHAR)
    , map_modetier_code VARCHAR2(32 CHAR)
    , map_field_code VARCHAR2(32 CHAR)
    , map_specialty_code VARCHAR2(32 CHAR)
    , semester_ids V2u_Ids_t
    , semester_numbers V2u_Ints2_t
    , semester_codes V2u_Semester_Codes_t
    , max_admission_semester VARCHAR2(6 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Student_Thread_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_Thread_t
            , job_uuid IN RAW
            , student_id IN NUMBER
            , specialty_id IN NUMBER
            , specialty_map_id IN NUMBER
            , thread_index IN NUMBER
            , student_index IN VARCHAR2
            , student_name IN VARCHAR2
            , first_name IN VARCHAR2
            , last_name IN VARCHAR2
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , map_program_code IN VARCHAR2
            , map_modetier_code IN VARCHAR2
            , map_field_code IN VARCHAR2
            , map_specialty_code IN VARCHAR2
            , semester_ids IN V2u_Ids_t
            , semester_numbers IN V2u_Ints2_t
            , semester_codes IN V2u_Semester_Codes_t
            , max_admission_semester IN VARCHAR2
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Student_Thread_t(
              SELF IN OUT NOCOPY V2u_Ko_Student_Thread_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , specialty_map IN V2u_Specialty_Map_t
            , semester_ids IN V2u_Ids_t
            , thread_index IN NUMBER
            , max_admission_semester IN VARCHAR2
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp(other IN V2u_Ko_Student_Thread_t)
            RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Student_Threads_t
    AS TABLE OF V2u_Ko_Student_Thread_t;

-- vim: set ft=sql ts=4 sw=4 et:
