-- Object types
CREATE OR REPLACE TYPE T_Veetou_Subject_Conducted FORCE AS OBJECT
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
                           rhs IN T_Veetou_Subject_Conducted)
        RETURN INTEGER;
END VEETOU_Common;

-- vim: set ft=sql ts=4 sw=4 et:
