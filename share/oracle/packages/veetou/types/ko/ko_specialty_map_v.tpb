CREATE OR REPLACE TYPE BODY V2u_Ko_Specialty_Map_V_t AS
--    CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Map_V_t(
--              SELF IN OUT NOCOPY V2u_Ko_Specialty_Map_V_t
--            , job_uuid IN RAW
--            , specialty_id IN NUMBER
--            , semester_id IN NUMBER
--            , map_id IN NUMBER
--            , matching_score IN NUMBER
--            , highest_score NUMBER
--            , selected NUMBER
--            , reason VARCHAR2
--            , university VARCHAR2
--            , faculty VARCHAR2
--            , studies_modetier VARCHAR2
--            , studies_field VARCHAR2
--            , studies_specialty VARCHAR2
--            , map_program_code VARCHAR2
--            , map_modetier_code VARCHAR2
--            , map_field_code VARCHAR2
--            , map_specialty_code VARCHAR2
--            , semester_number NUMBER
--            , expr_semester_number VARCHAR2
--            , semester_code VARCHAR2
--            , expr_semester_code VARCHAR2
--            , ects_mandatory NUMBER
--            , expr_ects_mandatory VARCHAR2
--            , ects_other NUMBER
--            , expr_ects_other VARCHAR2
--            , ects_total NUMBER
--            , expr_ects_total VARCHAR2
--            ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.job_uuid := job_uuid;
--        SELF.specialty_id := specialty_id;
--        SELF.semester_id := semester_id;
--        SELF.map_id := map_id;
--        SELF.matching_score := matching_score;
--        SELF.highest_score := highest_score;
--        SELF.selected := selected;
--        SELF.reason := reason;
--        SELF.university := university;
--        SELF.faculty := faculty;
--        SELF.studies_modetier := studies_modetier;
--        SELF.studies_field := studies_field;
--        SELF.studies_specialty := studies_specialty;
--        SELF.map_program_code := map_program_code;
--        SELF.map_modetier_code := map_modetier_code;
--        SELF.map_field_code := map_field_code;
--        SELF.map_specialty_code := map_specialty_code;
--        SELF.semester_number := semester_number;
--        SELF.expr_semester_number := expr_semester_number;
--        SELF.semester_code := semester_code;
--        SELF.expr_semester_code := expr_semester_code;
--        SELF.ects_mandatory := ects_mandatory;
--        SELF.expr_ects_mandatory := expr_ects_mandatory;
--        SELF.ects_other := ects_other;
--        SELF.expr_ects_other := expr_ects_other;
--        SELF.ects_total := ects_total;
--        SELF.expr_ects_total := expr_ects_total;
--        RETURN;
--    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Specialty_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Specialty_Map_V_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , map IN V2u_Specialty_Map_t
            , matching_score IN NUMBER
            , highest_score NUMBER
            , selected NUMBER
            , reason VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := specialty.job_uuid;
        SELF.specialty_id := specialty.id;
        SELF.semester_id := semester.id;
        SELF.map_id := map.id;
        SELF.matching_score := matching_score;
        SELF.highest_score := highest_score;
        SELF.selected := selected;
        SELF.reason := reason;
        SELF.university := specialty.university;
        SELF.faculty := specialty.faculty;
        SELF.studies_modetier := specialty.studies_modetier;
        SELF.studies_field := specialty.studies_field;
        SELF.studies_specialty := specialty.studies_specialty;
        SELF.map_program_code := map.map_program_code;
        SELF.map_modetier_code := map.map_modetier_code;
        SELF.map_field_code := map.map_field_code;
        SELF.map_specialty_code := map.map_specialty_code;
        SELF.semester_number := semester.semester_number;
        SELF.expr_semester_number := map.expr_semester_number;
        SELF.semester_code := semester.semester_code;
        SELF.expr_semester_code := map.expr_semester_code;
        SELF.ects_mandatory := semester.ects_mandatory;
        SELF.expr_ects_mandatory := map.expr_ects_mandatory;
        SELF.ects_other := semester.ects_other;
        SELF.expr_ects_other := map.expr_ects_other;
        SELF.ects_total := semester.ects_total;
        SELF.expr_ects_total := map.expr_ects_total;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
