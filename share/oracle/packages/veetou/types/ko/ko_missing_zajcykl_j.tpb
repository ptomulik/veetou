CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Zajcykl_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Zajcykl_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zajcykl_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , map_subj_code VARCHAR2
            , classes_map_id IN NUMBER
            , classes_matching_score IN NUMBER
            , map_classes_type VARCHAR2
            , reason IN VARCHAR2
            , istniejace_tzaj_kody V2u_5Chars3_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , classes_type => classes_type
            , classes_hours => classes_hours
            , subject_map_id => subject_map_id
            , subject_matching_score => subject_matching_score
            , map_subj_code => map_subj_code
            , classes_map_id => classes_map_id
            , classes_matching_score => classes_matching_score
            , map_classes_type => map_classes_type
            , reason => reason
            , istniejace_tzaj_kody => istniejace_tzaj_kody
            );
        RETURN;
    END;

--    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Zajcykl_J_t(
--              SELF IN OUT NOCOPY V2u_Ko_Missing_Zajcykl_J_t
--            , semester IN V2u_Ko_Semester_t
--            , specialty IN V2u_Ko_Specialty_t
--            , subject IN V2u_Ko_Subject_t
--            , classes_type IN VARCHAR2
--            , classes_hours IN NUMBER
--            , subject_map IN V2u_Ko_Subject_Map_J_t
--            , classes_map IN V2u_Ko_Classes_Map_J_t
--            , reason IN VARCHAR2
--            , istniejace_tzaj_kody V2u_5Chars3_t
--            ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.init(
--              semester => semester
--            , specialty => specialty
--            , subject => subject
--            , classes_type => classes_type
--            , classes_hours => classes_hours
--            , subject_map => subject_map
--            , classes_map => classes_map
--            , reason => reason
--            , istniejace_tzaj_kody => istniejace_tzaj_kody
--            );
--        RETURN;
--    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zajcykl_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , classes_hours IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , map_subj_code VARCHAR2
            , classes_map_id IN NUMBER
            , classes_matching_score IN NUMBER
            , map_classes_type VARCHAR2
            , reason IN VARCHAR2
            , istniejace_tzaj_kody V2u_5Chars3_t
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , classes_type => classes_type
            , classes_hours => classes_hours
            );
        SELF.subject_map_id := subject_map_id;
        SELF.subject_matching_score := subject_matching_score;
        SELF.map_subj_code := map_subj_code;
        SELF.classes_map_id := classes_map_id;
        SELF.classes_matching_score := classes_matching_score;
        SELF.map_classes_type := map_classes_type;
        SELF.reason := reason;
        SELF.istniejace_tzaj_kody := istniejace_tzaj_kody;
    END;

--    MEMBER PROCEDURE init(
--              SELF IN OUT NOCOPY V2u_Ko_Missing_Zajcykl_J_t
--            , semester IN V2u_Ko_Semester_t
--            , specialty IN V2u_Ko_Specialty_t
--            , subject IN V2u_Ko_Subject_t
--            , classes_type IN VARCHAR2
--            , classes_hours IN NUMBER
--            , subject_map IN V2u_Ko_Subject_Map_J_t
--            , classes_map IN V2u_Ko_Classes_Map_J_t
--            , reason IN VARCHAR2
--            , istniejace_tzaj_kody V2u_5Chars3_t
--            )
--    IS
--    BEGIN
--        SELF.init(
--              semester => semester
--            , specialty => specialty
--            , subject => subject
--            , classes_type => classes_type
--            , classes_hours => classes_hours
--            );
--        SELF.subject_map_id := subject_map.map_id;
--        SELF.subject_matching_score := subject_map.matching_score;
--        SELECT MIN(sm.map_subj_code)
--            INTO SELF.map_subj_code
--            FROM v2u_subject_map sm
--            WHERE sm.id = subject_map.map_id;
--        SELF.classes_map_id := classes_map.map_id;
--        SELF.classes_matching_score := classes_map.matching_score;
--        SELECT MIN(cm.map_classes_type)
--            INTO SELF.map_classes_type
--            FROM v2u_classes_map cm
--            WHERE cm.id = subject_map.map_id;
--        SELF.reason := reason;
--        SELF.istniejace_tzaj_kody := istniejace_tzaj_kody;
--    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
