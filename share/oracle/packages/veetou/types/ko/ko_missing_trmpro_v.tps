CREATE OR REPLACE TYPE V2u_Ko_Missing_Trmpro_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_V_t
    ( classes_type CHAR(1)
    , subj_grade_date VARCHAR2(10 CHAR)
    , subject_map_id NUMBER(38)
    , map_subj_code VARCHAR2(20 CHAR)
    , classes_map_id NUMBER(38)
    , map_classes_type VARCHAR2(20 CHAR)
    , coalesced_proto_type VARCHAR2(20 CHAR)
    , prot_id NUMBER(10)
    , nr NUMBER(10)
    , reason VARCHAR2(300 CHAR)
    , max_istniejacy_nr NUMBER(10)
    , istniejace_daty_zwrotow V2u_20Dates_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Trmpro_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Trmpro_V_t
            , missing_trmpro_j IN V2u_Ko_Missing_Trmpro_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Trmpro_V_t
            , missing_trmpro_j IN V2u_Ko_Missing_Trmpro_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            )
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Trmpros_V_t
    AS TABLE OF V2u_Ko_Missing_Trmpro_V_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
