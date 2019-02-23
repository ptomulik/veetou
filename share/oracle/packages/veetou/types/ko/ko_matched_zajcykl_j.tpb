CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Zajcykl_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Zajcykl_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zajcykl_J_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , classes_map_id IN NUMBER
            , classes_matching_score IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tzaj_kod IN VARCHAR2
            , zajcykl_id IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , subject_id => subject_id
            , specialty_id => specialty_id
            , semester_id => semester_id
            , subject_map_id => subject_map_id
            , subject_matching_score => subject_matching_score
            , classes_map_id => classes_map_id
            , classes_matching_score => classes_matching_score
            , prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , tzaj_kod => tzaj_kod
            , zajcykl_id => zajcykl_id
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zajcykl_J_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , classes_map_id IN NUMBER
            , classes_matching_score IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tzaj_kod IN VARCHAR2
            , zajcykl_id IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , subject_id => subject_id
            , specialty_id => specialty_id
            , semester_id => semester_id
            );
        SELF.subject_map_id := subject_map_id;
        SELF.subject_matching_score := subject_matching_score;
        SELF.classes_map_id := classes_map_id;
        SELF.classes_matching_score := classes_matching_score;
        SELF.prz_kod := prz_kod;
        SELF.cdyd_kod := cdyd_kod;
        SELF.tzaj_kod := tzaj_kod;
        SELF.zajcykl_id := zajcykl_id;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
