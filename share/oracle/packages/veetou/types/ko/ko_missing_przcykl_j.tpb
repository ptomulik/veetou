CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Przcykl_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Przcykl_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przcykl_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , reason IN VARCHAR2
            , istniejace_cdyd_kody IN V2u_Semester_Codes_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , subject_map_id => subject_map_id
            , map_subj_code => map_subj_code
            , reason => reason
            , istniejace_cdyd_kody => istniejace_cdyd_kody
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Przcykl_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , reason IN VARCHAR2
            , istniejace_cdyd_kody IN V2u_Semester_Codes_t
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , subject_map_id => subject_map_id
            , map_subj_code => map_subj_code
            , reason => reason
            );
        SELF.istniejace_cdyd_kody := istniejace_cdyd_kody;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
