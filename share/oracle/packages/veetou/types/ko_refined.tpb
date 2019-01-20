CREATE OR REPLACE TYPE BODY Veetou_Ko_Refined_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Refined_Typ(
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
    IS
    BEGIN
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
