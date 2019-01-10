CREATE OR REPLACE PACKAGE VEETOU_Common AUTHID CURRENT_USER AS
    --
--    SUBTYPE T_Subj_Code IS VARCHAR(32 CHAR);
--    TYPE T_Subj_Codes IS TABLE OF T_Subj_Code;

    TYPE T_Subject_Mappings_Rows IS TABLE OF veetou_subject_mappings%ROWTYPE;

    -- PL/SQL Record types
    TYPE T_Subject_Conducted IS RECORD
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
    );
    TYPE T_Subjects_Conducted IS TABLE OF T_Subject_Conducted;

    -- Constructor fo T_Sobject_Conducted
    FUNCTION Subject_Conducted( subj_code IN VARCHAR2 := NULL
                              , subj_name IN VARCHAR2 := NULL
                              , university IN VARCHAR2 := NULL
                              , faculty IN VARCHAR2 := NULL
                              , studies_modetier IN VARCHAR2 := NULL
                              , studies_field IN VARCHAR2 := NULL
                              , studies_specialty IN VARCHAR2 := NULL
                              , semester_code IN VARCHAR2 := NULL
                              , subj_tutor IN VARCHAR2 := NULL
                              , subj_hours_w IN NUMBER := NULL
                              , subj_hours_c IN NUMBER := NULL
                              , subj_hours_l IN NUMBER := NULL
                              , subj_hours_p IN NUMBER := NULL
                              , subj_hours_s IN NUMBER := NULL
                              , subj_credit_kind IN VARCHAR2 := NULL
                              , subj_ects IN NUMBER := NULL)
        RETURN T_Subject_Conducted;

    -- Converting an object to T_Subject_Conducted
    FUNCTION To_Subject_Conducted(row IN veetou_ko_refined%ROWTYPE)
        RETURN T_Subject_Conducted;


    -- Find mapped subjects for given faculty subject record
    FUNCTION Matching_Subject_Mappings(subject IN T_Subject_Conducted)
        RETURN T_Subject_Mappings_Rows;


--    FUNCTION SubjectConducted_Cmp(lhs IN T_SubjectConducted,
--                                  rhs IN T_SubjectConducted) RETURN BOOLEAN;
END VEETOU_Common;

-- vim: set ft=sql ts=4 sw=4 et:
