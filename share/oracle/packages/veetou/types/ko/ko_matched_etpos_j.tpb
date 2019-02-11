CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Etpos_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Etpos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            , etpos_id IN NUMBER
            , prgos_id IN NUMBER
            , specialty_map_id IN NUMBER
            , etp_kod_missmatch IN VARCHAR2
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
            , etpos_id => etpos_id
            , prgos_id => prgos_id
            , specialty_map_id => specialty_map_id
            , etp_kod_missmatch  => etp_kod_missmatch
            , st_id => st_id
            , os_id => os_id
            );
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Etpos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , student IN V2u_Ko_Student_t
            , etpos IN V2u_Dz_Etap_Osoby_t
            , prgos IN V2u_Dz_Program_Osoby_t
            , specialty_map IN V2u_Ko_Specialty_Map_J_t
            , etp_kod_missmatch IN VARCHAR2
            , st_id IN NUMBER
            , os_id IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              semester => semester
            , specialty => specialty
            , student => student
            , etpos => etpos
            , prgos => prgos
            , specialty_map => specialty_map
            , etp_kod_missmatch  => etp_kod_missmatch
            , st_id => st_id
            , os_id => os_id
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            , etpos_id IN NUMBER
            , prgos_id IN NUMBER
            , specialty_map_id IN NUMBER
            , etp_kod_missmatch IN VARCHAR2
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
        SELF.etpos_id := etpos_id;
        SELF.prgos_id := prgos_id;
        SELF.specialty_map_id := specialty_map_id;
        SELF.etp_kod_missmatch := etp_kod_missmatch;
        SELF.st_id := st_id;
        SELF.os_id := os_id;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_J_t
            , semester IN V2u_Ko_Semester_t
            , specialty IN V2u_Ko_Specialty_t
            , student IN V2u_Ko_Student_t
            , etpos IN V2u_Dz_Etap_Osoby_t
            , prgos IN V2u_Dz_Program_Osoby_t
            , specialty_map IN V2u_Ko_Specialty_Map_J_t
            , etp_kod_missmatch IN VARCHAR2
            , st_id IN NUMBER
            , os_id IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              semester => semester
            , specialty => specialty
            , student => student
            );
        SELF.etpos_id := etpos.id;
        SELF.prgos_id := prgos.id;
        SELF.specialty_map_id := specialty_map.map_id;
        SELF.etp_kod_missmatch := etp_kod_missmatch;
        SELF.st_id := st_id;
        SELF.os_id := os_id;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
