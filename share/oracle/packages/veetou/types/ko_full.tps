CREATE OR REPLACE TYPE Veetou_Ko_Full_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , tr_id NUMBER(38)
    , tr_subj_code VARCHAR(32 CHAR)
    , tr_subj_name VARCHAR(256 CHAR)
    , tr_subj_hours_w NUMBER(8)
    , tr_subj_hours_c NUMBER(8)
    , tr_subj_hours_l NUMBER(8)
    , tr_subj_hours_p NUMBER(8)
    , tr_subj_hours_s NUMBER(8)
    , tr_subj_credit_kind VARCHAR(16 CHAR)
    , tr_subj_ects NUMBER(4)
    , tr_subj_tutor VARCHAR(256 CHAR)
    , tr_subj_grade VARCHAR(32 CHAR)
    , tr_subj_grade_date DATE
    , tbody_id NUMBER(38)
    , tbody_remark VARCHAR(256)
    , page_id NUMBER(38)
    , page_page_number NUMBER(10)
    , page_parser_page_number NUMBER(10)
    , sheet_id NUMBER(38)
    , sheet_pages_parsed NUMBER(2)
    , sheet_first_page NUMBER(10)
    , sheet_ects_mandatory NUMBER(4)
    , sheet_ects_other NUMBER(4)
    , sheet_ects_total NUMBER(4)
    , sheet_ects_attained NUMBER(4)
    , report_id NUMBER(38)
    , report_source VARCHAR(512 CHAR)
    , report_datetime TIMESTAMP
    , report_first_page NUMBER(10)
    , report_sheets_parsed NUMBER(10)
    , report_pages_parsed NUMBER(10)
    , preamble_id NUMBER(38)
    , preamble_studies_modetier VARCHAR(256 CHAR)
    , preamble_title VARCHAR(256 CHAR)
    , preamble_student_index VARCHAR(32 CHAR)
    , preamble_first_name VARCHAR(48 CHAR)
    , preamble_last_name VARCHAR(48 CHAR)
    , preamble_student_name VARCHAR(128 CHAR)
    , preamble_semester_code VARCHAR(5 CHAR)
    , preamble_studies_field VARCHAR(256 CHAR)
    , preamble_semester_number NUMBER(2)
    , preamble_studies_specialty VARCHAR(256 CHAR)
    , header_id NUMBER(38)
    , header_university VARCHAR(256 CHAR)
    , header_faculty VARCHAR(256 CHAR)
    , footer_id NUMBER(38)
    , footer_pagination VARCHAR(32 CHAR)
    , footer_sheet_page_number NUMBER(2)
    , footer_sheet_pages_total NUMBER(2)
    , footer_generator_name VARCHAR(256 CHAR)
    , footer_generator_home VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Full_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Full_Typ
            , job_uuid IN RAW := NULL
            , tr_id IN NUMBER := NULL
            , tr_subj_code IN VARCHAR := NULL
            , tr_subj_name IN VARCHAR := NULL
            , tr_subj_hours_w IN NUMBER := NULL
            , tr_subj_hours_c IN NUMBER := NULL
            , tr_subj_hours_l IN NUMBER := NULL
            , tr_subj_hours_p IN NUMBER := NULL
            , tr_subj_hours_s IN NUMBER := NULL
            , tr_subj_credit_kind IN VARCHAR := NULL
            , tr_subj_ects IN NUMBER := NULL
            , tr_subj_tutor IN VARCHAR := NULL
            , tr_subj_grade IN VARCHAR := NULL
            , tr_subj_grade_date IN DATE
            , tbody_id IN NUMBER := NULL
            , tbody_remark IN VARCHAR := NULL
            , page_id IN NUMBER := NULL
            , page_page_number IN NUMBER := NULL
            , page_parser_page_number IN NUMBER := NULL
            , sheet_id IN NUMBER := NULL
            , sheet_pages_parsed IN NUMBER := NULL
            , sheet_first_page IN NUMBER := NULL
            , sheet_ects_mandatory IN NUMBER := NULL
            , sheet_ects_other IN NUMBER := NULL
            , sheet_ects_total IN NUMBER := NULL
            , sheet_ects_attained IN NUMBER := NULL
            , report_id IN NUMBER := NULL
            , report_source IN VARCHAR := NULL
            , report_datetime IN TIMESTAMP
            , report_first_page IN NUMBER := NULL
            , report_sheets_parsed IN NUMBER := NULL
            , report_pages_parsed IN NUMBER := NULL
            , preamble_id IN NUMBER := NULL
            , preamble_studies_modetier IN VARCHAR := NULL
            , preamble_title IN VARCHAR := NULL
            , preamble_student_index IN VARCHAR := NULL
            , preamble_first_name IN VARCHAR := NULL
            , preamble_last_name IN VARCHAR := NULL
            , preamble_student_name IN VARCHAR := NULL
            , preamble_semester_code IN VARCHAR := NULL
            , preamble_studies_field IN VARCHAR := NULL
            , preamble_semester_number IN NUMBER := NULL
            , preamble_studies_specialty IN VARCHAR := NULL
            , header_id IN NUMBER := NULL
            , header_university IN VARCHAR := NULL
            , header_faculty IN VARCHAR := NULL
            , footer_id IN NUMBER := NULL
            , footer_pagination IN VARCHAR := NULL
            , footer_sheet_page_number IN NUMBER := NULL
            , footer_sheet_pages_total IN NUMBER := NULL
            , footer_generator_name IN VARCHAR := NULL
            , footer_generator_home IN VARCHAR := NULL
            ) RETURN SELF AS RESULT
    );

-- vim: set ft=sql ts=4 sw=4 et:
