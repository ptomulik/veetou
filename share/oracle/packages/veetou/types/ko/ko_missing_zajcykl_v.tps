CREATE OR REPLACE TYPE V2u_Ko_Missing_Zajcykl_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Classes_Semester_V_t
    ( subject_map_id NUMBER(38)
    , subject_matching_score NUMBER(38)
    , map_subj_code VARCHAR2(20 CHAR)
    , classes_map_id NUMBER(38)
    , classes_matching_score NUMBER(38)
    , map_classes_type VARCHAR2(20 CHAR)
    , reason VARCHAR2(80 CHAR)
    , istniejace_tzaj_kody V2u_5Chars3_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Zajcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zajcykl_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , classes_matching_score IN NUMBER
            , map_classes_type IN VARCHAR2
            , reason IN VARCHAR2
            , istniejace_tzaj_kody IN V2u_5Chars3_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zajcykl_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , classes_matching_score IN NUMBER
            , map_classes_type IN VARCHAR2
            , reason IN VARCHAR2
            , istniejace_tzaj_kody IN V2u_5Chars3_t
            )
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Zajcykles_V_t
    AS TABLE OF V2u_Ko_Missing_Zajcykl_V_t;

-- vim: set ft=sql ts=4 sw=4 et:
