CREATE OR REPLACE TYPE V2u_Ko_Missing_Zajcykl_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Classes_Semester_J_t
    ( subject_map_id NUMBER(38)
    , subject_matching_score NUMBER(38)
    , map_subj_code VARCHAR2(32 CHAR)
    , classes_map_id NUMBER(38)
    , classes_matching_score NUMBER(38)
    , map_classes_type VARCHAR2(3 CHAR)
    , reason VARCHAR2(80 CHAR)
    , dbg_classes_hours INTEGER
    , dbg_subject_maps INTEGER
    , dbg_map_subj_codes INTEGER
    , dbg_classes_maps INTEGER
    , dbg_map_class_types INTEGER
    , dbg_semester_codes INTEGER
    , istniejace_tzaj_kody V2u_5Chars3_t

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Zajcykl_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zajcykl_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , classes_matching_score IN NUMBER
            , map_classes_type IN VARCHAR2
            , istniejace_tzaj_kody V2u_5Chars3_t
            , reason IN VARCHAR2
            , dbg_classes_hours IN INTEGER
            , dbg_subject_maps IN INTEGER
            , dbg_map_subj_codes IN INTEGER
            , dbg_classes_maps IN INTEGER
            , dbg_map_class_types IN INTEGER
            , dbg_semester_codes IN INTEGER
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Zajcykl_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zajcykl_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , subject IN V2u_Ko_Subject_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            , subject_map IN V2u_Ko_Subject_Map_J_t
            , classes_map IN V2u_Ko_Classes_Map_J_t
            , istniejace_tzaj_kody V2u_5Chars3_t
            , reason IN VARCHAR2
            , dbg_classes_hours IN INTEGER
            , dbg_subject_maps IN INTEGER
            , dbg_map_subj_codes IN INTEGER
            , dbg_classes_maps IN INTEGER
            , dbg_map_class_types IN INTEGER
            , dbg_semester_codes IN INTEGER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zajcykl_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , classes_matching_score IN NUMBER
            , map_classes_type IN VARCHAR2
            , istniejace_tzaj_kody V2u_5Chars3_t
            , reason IN VARCHAR2
            , dbg_classes_hours IN INTEGER
            , dbg_subject_maps IN INTEGER
            , dbg_map_subj_codes IN INTEGER
            , dbg_classes_maps IN INTEGER
            , dbg_map_class_types IN INTEGER
            , dbg_semester_codes IN INTEGER
            )

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zajcykl_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , subject IN V2u_Ko_Subject_t
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            , subject_map IN V2u_Ko_Subject_Map_J_t
            , classes_map IN V2u_Ko_Classes_Map_J_t
            , istniejace_tzaj_kody V2u_5Chars3_t
            , reason IN VARCHAR2
            , dbg_classes_hours IN INTEGER
            , dbg_subject_maps IN INTEGER
            , dbg_map_subj_codes IN INTEGER
            , dbg_classes_maps IN INTEGER
            , dbg_map_class_types IN INTEGER
            , dbg_semester_codes IN INTEGER
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Zajcykles_J_t
    AS TABLE OF V2u_Ko_Missing_Zajcykl_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
