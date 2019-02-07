CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Etpos_t AS
--    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Etpos_t(
--              SELF IN OUT NOCOPY V2u_Ko_Missing_Etpos_t
--            , job_uuid IN RAW
--            , student_id IN NUMBER
--            , specialty_id IN NUMBER
--            , semester_id IN NUMBER
--            , student_index VARCHAR2
--            , student_name VARCHAR2
--            , first_name VARCHAR2
--            , last_name VARCHAR2
--            , university IN VARCHAR2
--            , faculty IN VARCHAR2
--            , studies_modetier IN VARCHAR2
--            , studies_field IN VARCHAR2
--            , studies_specialty IN VARCHAR2
--            , semester_number IN NUMBER
--            , semester_code IN VARCHAR2
--            , ects_mandatory IN NUMBER
--            , ects_other IN NUMBER
--            , ects_total IN NUMBER
--            , ects_attained IN NUMBER
--            , prgos_ids IN V2u_Dz_Ids_t
--            ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.job_uuid := job_uuid;
--        SELF.student_id := student_id;
--        SELF.specialty_id := specialty_id;
--        SELF.semester_id := semester_id;
--        SELF.student_index := student_index;
--        SELF.student_name := student_name;
--        SELF.first_name := first_name;
--        SELF.last_name := last_name;
--        SELF.university := university;
--        SELF.faculty := faculty;
--        SELF.studies_modetier := studies_modetier;
--        SELF.studies_field := studies_field;
--        SELF.studies_specialty := studies_specialty;
--        SELF.semester_number := semester_number;
--        SELF.semester_code := semester_code;
--        SELF.ects_mandatory := ects_mandatory;
--        SELF.ects_other := ects_other;
--        SELF.ects_total := ects_total;
--        SELF.ects_attained := ects_attained;
--        SELF.prgos_ids := prgos_ids;
--        RETURN;
--    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Etpos_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Etpos_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , specialty_map_ids IN V2u_Ids_t
            , prgos_ids IN V2u_Dz_Ids_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
            student => student
          , specialty => specialty
          , semester => semester
          , ects_attained => ects_attained
          , specialty_map_ids => specialty_map_ids
          , prgos_ids => prgos_ids
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Etpos_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , specialty_map_ids IN V2u_Ids_t
            , prgos_ids IN V2u_Dz_Ids_t
            )
    IS
    BEGIN
        SELF.init(
            student => student
          , specialty => specialty
          , semester => semester
          , ects_attained => ects_attained
          , specialty_map_ids => specialty_map_ids
        );
        SELF.prgos_ids := prgos_ids;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
