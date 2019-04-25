CREATE OR REPLACE TYPE V2u_Ko_Missing_Trmpro_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_I_t
    ( classes_type CHAR(1)
    , subj_grade_date DATE
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

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Trmpro_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Trmpro_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , subj_grade_date IN DATE
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , coalesced_proto_type IN VARCHAR2
            , prot_id IN NUMBER
            , nr IN NUMBER
            , reason IN VARCHAR2
            , max_istniejacy_nr IN NUMBER
            , istniejace_daty_zwrotow IN V2u_20Dates_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Trmpro_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , subj_grade_date IN DATE
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , coalesced_proto_type IN VARCHAR2
            , prot_id IN NUMBER
            , nr IN NUMBER
            , reason IN VARCHAR2
            , max_istniejacy_nr IN NUMBER
            , istniejace_daty_zwrotow IN V2u_20Dates_t
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Trmpros_J_t
    AS TABLE OF V2u_Ko_Missing_Trmpro_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
