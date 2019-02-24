CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Prgos_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Prgos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Prgos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            , ects_attained IN NUMBER
            , specialty_map_id IN NUMBER
            , prgos_id IN NUMBER
            , prg_kod IN VARCHAR2
            , st_id IN NUMBER
            , os_id IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , student_id => student_id
            , ects_attained => ects_attained
            , specialty_map_id => specialty_map_id
            , prgos_id => prgos_id
            , prg_kod => prg_kod
            , st_id => st_id
            , os_id => os_id
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Prgos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            , ects_attained IN NUMBER
            , specialty_map_id IN NUMBER
            , prgos_id IN NUMBER
            , prg_kod IN VARCHAR2
            , st_id IN NUMBER
            , os_id IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              job_uuid => job_uuid
            , semester_id => semester_id
            , specialty_id => specialty_id
            , student_id => student_id
            );
        SELF.ects_attained := ects_attained;
        SELF.specialty_map_id := specialty_map_id;
        SELF.prgos_id := prgos_id;
        SELF.prg_kod := prg_kod;
        SELF.st_id := st_id;
        SELF.os_id := os_id;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
