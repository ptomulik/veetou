CREATE OR REPLACE TYPE T_Veetou_Ko_Refined FORCE AS
    OBJECT
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
    );
/

-- Object types
CREATE OR REPLACE TYPE T_Veetou_Subject_Instance FORCE AS
    OBJECT
    ( subj_code VARCHAR2(32 CHAR)
    , subj_name VARCHAR2(256 CHAR)
    , university VARCHAR2(256 CHAR)
    , faculty VARCHAR2(256 CHAR)
    , studies_modetier VARCHAR2(256 CHAR)
    , studies_field VARCHAR2(256 CHAR)
    , studies_specialty VARCHAR2(256 CHAR)
    , semester_code VARCHAR2(32 CHAR)
    , subj_tutor VARCHAR2(256 CHAR)
    , subj_hours_w NUMBER(8)
    , subj_hours_c NUMBER(8)
    , subj_hours_l NUMBER(8)
    , subj_hours_p NUMBER(8)
    , subj_hours_s NUMBER(8)
    , subj_credit_kind VARCHAR2(16 CHAR)
    , subj_ects NUMBER(16)

    , CONSTRUCTOR FUNCTION T_Veetou_Subject_Instance(
            ko_refined IN T_Veetou_Ko_Refined
        ) RETURN SELF AS RESULT
    );

/
CREATE OR REPLACE TYPE T_Veetou_Matchable FORCE AS OBJECT
    ( matcher_id VARCHAR(128 CHAR)
    , matcher_arg VARCHAR(200 CHAR) )
NOT FINAL;
/

CREATE OR REPLACE TYPE T_Veetou_Matchable_Subject FORCE UNDER T_Veetou_Matchable
    ( subj_code VARCHAR2(32 CHAR) )
NOT FINAL;
/

CREATE OR REPLACE TYPE T_Veetou_Subject_Mapping FORCE UNDER T_Veetou_Matchable_Subject
    ( mapped_subj_code VARCHAR(20 CHAR) )
FINAL;
/


CREATE OR REPLACE PACKAGE VEETOU_Common AUTHID CURRENT_USER AS
    FUNCTION Records_Match(lhs IN T_Veetou_Matchable_Subject,
                           rhs IN T_Veetou_Subject_Instance)
        RETURN INTEGER;

    -- Conversions
    FUNCTION To_Subject_Instance(row IN veetou_ko_refined%ROWTYPE)
        RETURN T_Veetou_Subject_Instance;
END VEETOU_Common;

-- vim: set ft=sql ts=4 sw=4 et:
