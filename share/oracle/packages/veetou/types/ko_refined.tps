CREATE OR REPLACE TYPE Veetou_Ko_Refined_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( subj_code VARCHAR(32 CHAR)
    , subj_name VARCHAR(256 CHAR)
    , student_index VARCHAR(32 CHAR)
    , first_name VARCHAR(48 CHAR)
    , last_name VARCHAR(48 CHAR)
    , student_name VARCHAR(128 CHAR)
    , subj_grade VARCHAR(32 CHAR)
    , subj_grade_date DATE
    , university VARCHAR(256 CHAR)
    , faculty VARCHAR(256 CHAR)
    , studies_modetier VARCHAR(256 CHAR)
    , studies_field VARCHAR(256 CHAR)
    , studies_specialty VARCHAR(256 CHAR)
    , semester_code VARCHAR(5 CHAR)
    , semester_number NUMBER(2)
    , subj_tutor VARCHAR(256 CHAR)
    , subj_hours_w NUMBER(8)
    , subj_hours_c NUMBER(8)
    , subj_hours_l NUMBER(8)
    , subj_hours_p NUMBER(8)
    , subj_hours_s NUMBER(8)
    , subj_credit_kind VARCHAR(16 CHAR)
    , subj_ects NUMBER(4)
    , ects_mandatory NUMBER(4)
    , ects_other NUMBER(4)
    , ects_total NUMBER(4)
    , ects_attained NUMBER(4)
    , preamble_title VARCHAR(256 CHAR)
    , report_source VARCHAR(512 CHAR)
    , report_open_datetime TIMESTAMP
    , report_sheets_parsed NUMBER(10)
    , report_pages_parsed NUMBER(10)
    , page_number NUMBER(10)
    , sheet_first_page NUMBER(10)
    , sheet_pages_parsed NUMBER(2)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Refined_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Refined_Typ
            , subj_code IN VARCHAR := NULL
            , subj_name IN VARCHAR := NULL
            , student_index IN VARCHAR := NULL
            , first_name IN VARCHAR := NULL
            , last_name IN VARCHAR := NULL
            , student_name IN VARCHAR := NULL
            , subj_grade IN VARCHAR := NULL
            , subj_grade_date IN DATE
            , university IN VARCHAR := NULL
            , faculty IN VARCHAR := NULL
            , studies_modetier IN VARCHAR := NULL
            , studies_field IN VARCHAR := NULL
            , studies_specialty IN VARCHAR := NULL
            , semester_code IN VARCHAR := NULL
            , semester_number IN NUMBER := NULL
            , subj_tutor IN VARCHAR := NULL
            , subj_hours_w IN NUMBER := NULL
            , subj_hours_c IN NUMBER := NULL
            , subj_hours_l IN NUMBER := NULL
            , subj_hours_p IN NUMBER := NULL
            , subj_hours_s IN NUMBER := NULL
            , subj_credit_kind IN VARCHAR := NULL
            , subj_ects IN NUMBER := NULL
            , ects_mandatory IN NUMBER := NULL
            , ects_other IN NUMBER := NULL
            , ects_total IN NUMBER := NULL
            , ects_attained IN NUMBER := NULL
            , preamble_title IN VARCHAR := NULL
            , report_source IN VARCHAR := NULL
            , report_open_datetime IN TIMESTAMP
            , report_sheets_parsed IN NUMBER := NULL
            , report_pages_parsed IN NUMBER := NULL
            , page_number IN NUMBER := NULL
            , sheet_first_page IN NUMBER := NULL
            , sheet_pages_parsed IN NUMBER := NULL
            ) RETURN SELF AS RESULT
    );

-- vim: set ft=sql ts=4 sw=4 et:
