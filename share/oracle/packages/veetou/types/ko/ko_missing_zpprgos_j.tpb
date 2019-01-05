CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Zpprgos_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Zpprgos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zpprgos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , specialty_map_ids IN V2u_20Ids_t
            , semester_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , os_id IN NUMBER
            , prgos_id IN NUMBER
            , prgos_ids IN V2u_Dz_20Ids_t
            , etpos_id IN NUMBER
            , etpos_ids IN V2u_Dz_20Ids_t
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            , student_id => student_id
            , subject_map_id => subject_map_id
            , specialty_map_ids => specialty_map_ids
            , semester_code => semester_code
            , map_subj_code => map_subj_code
            , os_id => os_id
            , prgos_id => prgos_id
            , prgos_ids => prgos_ids
            , etpos_id => etpos_id
            , etpos_ids => etpos_ids
            , reason => reason
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Zpprgos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , specialty_map_ids IN V2u_20Ids_t
            , semester_code IN VARCHAR2
            , map_subj_code IN VARCHAR2
            , os_id IN NUMBER
            , prgos_id IN NUMBER
            , prgos_ids IN V2u_Dz_20Ids_t
            , etpos_id IN NUMBER
            , etpos_ids IN V2u_Dz_20Ids_t
            , reason IN VARCHAR2
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , subject_id => subject_id
            );
        SELF.student_id := student_id;
        SELF.subject_map_id := subject_map_id;
        SELF.specialty_map_ids := specialty_map_ids;
        SELF.semester_code := semester_code;
        SELF.map_subj_code := map_subj_code;
        SELF.os_id := os_id;
        SELF.prgos_id := prgos_id;
        SELF.prgos_ids := prgos_ids;
        SELF.etpos_id := etpos_id;
        SELF.etpos_ids := etpos_ids;
        SELF.reason := reason;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
