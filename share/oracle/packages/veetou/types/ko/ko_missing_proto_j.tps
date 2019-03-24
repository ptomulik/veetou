CREATE OR REPLACE TYPE V2u_Ko_Missing_Proto_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Classes_Semester_I_t
    ( subject_map_id NUMBER(38)
    , map_subj_code VARCHAR2(20 CHAR)
    , classes_map_id NUMBER(38)
    , map_classes_type VARCHAR2(20 CHAR)
    , reason VARCHAR2(80 CHAR)
    , istniejace_tzaj_kody V2u_5Chars3_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Proto_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , reason IN VARCHAR2
            , istniejace_tzaj_kody V2u_5Chars3_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , reason IN VARCHAR2
            , istniejace_tzaj_kody V2u_5Chars3_t
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Protos_J_t
    AS TABLE OF V2u_Ko_Missing_Proto_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
