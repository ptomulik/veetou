CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Przedm_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przedm_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przedm_J_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
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
            , prz_kod => prz_kod
            );
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
