CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Zpprgos_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Zpprgos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zpprgos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , specialty_map_id IN NUMBER
            , st_id IN NUMBER
            , os_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , prgos_id IN NUMBER
            , etpos_id IN NUMBER
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
            , specialty_map_id => specialty_map_id
            , st_id => st_id
            , os_id => os_id
            , cdyd_kod => cdyd_kod
            , prz_kod => prz_kod
            , prgos_id => prgos_id
            , etpos_id => etpos_id
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zpprgos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , specialty_map_id IN NUMBER
            , st_id IN NUMBER
            , os_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , prgos_id IN NUMBER
            , etpos_id IN NUMBER
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
        SELF.specialty_map_id := specialty_map_id;
        SELF.st_id := st_id;
        SELF.os_id := os_id;
        SELF.cdyd_kod := cdyd_kod;
        SELF.prz_kod := prz_kod;
        SELF.prgos_id := prgos_id;
        SELF.etpos_id := etpos_id;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
