CREATE OR REPLACE TYPE Veetou_Ko_Refined_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , tr_id NUMBER(38)
    , subj_code VARCHAR(32 CHAR)
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
    , semester_code VARCHAR(32 CHAR)
    , semester_number NUMBER(4)
    , subj_tutor VARCHAR(256 CHAR)
    , subj_hours_w NUMBER(8)
    , subj_hours_c NUMBER(8)
    , subj_hours_l NUMBER(8)
    , subj_hours_p NUMBER(8)
    , subj_hours_s NUMBER(8)
    , subj_credit_kind VARCHAR(16 CHAR)
    , subj_ects NUMBER(16)
    , ects_mandatory NUMBER(16)
    , ects_other NUMBER(16)
    , ects_total NUMBER(16)
    , ects_attained NUMBER(16)
    , preamble_title VARCHAR(256 CHAR)
    , report_source VARCHAR(512 CHAR)
    , report_open_datetime TIMESTAMP
    , report_sheets_parsed NUMBER(16)
    , report_pages_parsed NUMBER(16)
    , page_number NUMBER(16)
    , sheet_first_page NUMBER(16)
    , sheet_pages_parsed NUMBER(16)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Refined_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Refined_Typ
            , job_uuid IN RAW := NULL
            , tr_id IN NUMBER := NULL
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
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Refined_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Refined_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Refined_Typ
        , job_uuid IN RAW := NULL
        , tr_id IN NUMBER := NULL
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
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.tr_id := tr_id;
        SELF.subj_code := subj_code;
        SELF.subj_name := subj_name;
        SELF.student_index := student_index;
        SELF.first_name := first_name;
        SELF.last_name := last_name;
        SELF.student_name := student_name;
        SELF.subj_grade := subj_grade;
        SELF.subj_grade_date := subj_grade_date;
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty;
        SELF.semester_code := semester_code;
        SELF.semester_number := semester_number;
        SELF.subj_tutor := subj_tutor;
        SELF.subj_hours_w := subj_hours_w;
        SELF.subj_hours_c := subj_hours_c;
        SELF.subj_hours_l := subj_hours_l;
        SELF.subj_hours_p := subj_hours_p;
        SELF.subj_hours_s := subj_hours_s;
        SELF.subj_credit_kind := subj_credit_kind;
        SELF.subj_ects := subj_ects;
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
        SELF.ects_attained := ects_attained;
        SELF.preamble_title := preamble_title;
        SELF.report_source := report_source;
        SELF.report_open_datetime := report_open_datetime;
        SELF.report_sheets_parsed := report_sheets_parsed;
        SELF.report_pages_parsed := report_pages_parsed;
        SELF.page_number := page_number;
        SELF.sheet_first_page := sheet_first_page;
        SELF.sheet_pages_parsed := sheet_pages_parsed;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
