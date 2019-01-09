CREATE OR REPLACE PACKAGE VEETOU_Func AUTHID CURRENT_USER AS
    TYPE TKoRefinedRow IS veetou_ko_refined%ROWTYPE;
    TYPE TKoRefinedRows IS TABLE OF TKoRefinedRow;

    TYPE TSubjectConducted IS RECORD
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
    TYPE TSubjectsConducted IS TABLE OF TSubjectConducted;

    FUNCTION SubjectConducted(row IN TKoRefinedRow) RETURN TSubjectConducted;


    FUNCTION SubjectConducted_Cmp(lhs IN TSubjectConducted,
                                  rhs IN TSubjectConducted) RETURN BOOLEAN;
END VEETOU_Func;

-- vim: set ft=sql ts=4 sw=4 et:
