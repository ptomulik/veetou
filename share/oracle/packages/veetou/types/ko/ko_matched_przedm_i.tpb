CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Przedm_I_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przedm_I_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przedm_I_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , matching_score IN NUMBER
            , prz_kod IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , subject_id => subject_id
            , specialty_id => specialty_id
            , semester_id => semester_id
            , subject_map_id => subject_map_id
            , matching_score => matching_score
            , prz_kod => prz_kod
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przedm_I_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , matching_score IN NUMBER
            , prz_kod IN VARCHAR2
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
        SELF.matching_score := matching_score;
        SELF.prz_kod := prz_kod;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et: