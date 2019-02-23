CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Etpos_J_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Etpos_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            , ects_attained IN NUMBER
            , specialty_map_id IN NUMBER
            , prgos_id IN NUMBER
            , prg_kod IN VARCHAR2
            , etpos_id IN NUMBER
            , etp_kod IN VARCHAR2
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
            , ects_attained => ects_attained
            , specialty_map_id => specialty_map_id
            , prgos_id => prgos_id
            , prg_kod => prg_kod
            , etpos_id => etpos_id
            , etp_kod => etp_kod
            , etp_kod_missmatch => etp_kod_missmatch
            , st_id => st_id
            , os_id => os_id
            );
        RETURN;
    END;

--    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Etpos_J_t(
--              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_J_t
--            , semester IN V2u_Ko_Semester_t
--            , specialty IN V2u_Ko_Specialty_t
--            , student IN V2u_Ko_Student_t
--            , ects_attained IN NUMBER
--            , specialty_map IN V2u_Ko_Specialty_Map_J_t
--            , prgos IN V2u_Dz_Program_Osoby_t
--            , etpos IN V2u_Dz_Etap_Osoby_t
--            , etp_kod_missmatch IN VARCHAR2
--            ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.init(
--              semester => semester
--            , specialty => specialty
--            , student => student
--            , ects_attained => ects_attained
--            , specialty_map => specialty_map
--            , prgos => prgos
--            , etpos => etpos
--            , etp_kod_missmatch  => etp_kod_missmatch
--            );
--        RETURN;
--    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , student_id IN NUMBER
            , ects_attained IN NUMBER
            , specialty_map_id IN NUMBER
            , prgos_id IN NUMBER
            , prg_kod IN VARCHAR2
            , etpos_id IN NUMBER
            , etp_kod IN VARCHAR2
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
            , ects_attained => ects_attained
            );
        SELF.specialty_map_id := specialty_map_id;
        SELF.prgos_id := prgos_id;
        SELF.prg_kod := prg_kod;
        SELF.etpos_id := etpos_id;
        SELF.etp_kod := etp_kod;
        SELF.etp_kod_missmatch := etp_kod_missmatch;
        SELF.st_id := st_id;
        SELF.os_id := os_id;
    END;

--    MEMBER PROCEDURE init(
--              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_J_t
--            , semester IN V2u_Ko_Semester_t
--            , specialty IN V2u_Ko_Specialty_t
--            , student IN V2u_Ko_Student_t
--            , ects_attained IN NUMBER
--            , specialty_map IN V2u_Ko_Specialty_Map_J_t
--            , prgos IN V2u_Dz_Program_Osoby_t
--            , etpos IN V2u_Dz_Etap_Osoby_t
--            , etp_kod_missmatch IN VARCHAR2
--            )
--    IS
--    BEGIN
--        SELF.init(
--              semester => semester
--            , specialty => specialty
--            , student => student
--            , ects_attained => ects_attained
--            );
--        SELF.specialty_map_id := specialty_map.map_id;
--        SELF.prgos_id := prgos.id;
--        SELF.etpos_id := etpos.id;
--        SELF.etp_kod_missmatch := etp_kod_missmatch;
--        SELF.st_id := prgos.st_id;
--        SELF.os_id := prgos.os_id;
--    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
