CREATE OR REPLACE TYPE BODY V2u_Specialty_Map_Pattern_t AS
    CONSTRUCTOR FUNCTION V2u_Specialty_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Specialty_Map_Pattern_t
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , map_program_code IN VARCHAR2
            , map_modetier_code IN VARCHAR2
            , map_field_code IN VARCHAR2
            , map_specialty_code IN VARCHAR2
            , semester_pattern IN V2u_Semester_Pattern_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              university => university
            , faculty => faculty
            , studies_modetier => studies_modetier
            , studies_field => studies_field
            , studies_specialty => studies_specialty
            , map_program_code => map_program_code
            , map_modetier_code => map_modetier_code
            , map_field_code => map_field_code
            , map_specialty_code => map_specialty_code
            , semester_pattern => semester_pattern
            );
        RETURN;
    END;


    CONSTRUCTOR FUNCTION V2u_Specialty_Map_Pattern_t(
              SELF IN OUT NOCOPY V2u_Specialty_Map_Pattern_t
            , specialty_map IN V2u_Specialty_Map_B_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(specialty_map);
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Specialty_Map_Pattern_t
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , map_program_code IN VARCHAR2
            , map_modetier_code IN VARCHAR2
            , map_field_code IN VARCHAR2
            , map_specialty_code IN VARCHAR2
            , semester_pattern IN V2u_Semester_Pattern_t
            )
    IS
    BEGIN
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty;
        SELF.map_program_code := map_program_code;
        SELF.map_modetier_code := map_modetier_code;
        SELF.map_field_code := map_field_code;
        SELF.map_specialty_code := map_specialty_code;
        SELF.semester_pattern := semester_pattern;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Specialty_Map_Pattern_t
            , specialty_map IN V2u_Specialty_Map_B_t
            )
    IS
    BEGIN
        SELF.init(
              university => specialty_map.university
            , faculty => specialty_map.faculty
            , studies_modetier => specialty_map.studies_modetier
            , studies_field => specialty_map.studies_field
            , studies_specialty => specialty_map.studies_specialty
            , map_program_code => specialty_map.map_program_code
            , map_modetier_code => specialty_map.map_modetier_code
            , map_field_code => specialty_map.map_field_code
            , map_specialty_code => specialty_map.map_specialty_code
            , semester_pattern => V2u_Semester_Pattern_t(
                  expr_semester_code => specialty_map.expr_semester_code
                , expr_semester_number => specialty_map.expr_semester_number
                , expr_ects_mandatory => specialty_map.expr_ects_mandatory
                , expr_ects_other => specialty_map.expr_ects_other
                , expr_ects_total => specialty_map.expr_ects_total
              )
            );
    END;


    MEMBER FUNCTION match_attributes(
              semester_code IN VARCHAR2
            , semester_number IN INTEGER
            , ects_mandatory IN INTEGER
            , ects_other IN INTEGER
            , ects_total IN INTEGER
            ) RETURN INTEGER
    IS
        total INTEGER;
    BEGIN
        total := semester_pattern.match_attributes(
              semester_code => semester_code
            , semester_number => semester_number
            , ects_mandatory => ects_mandatory
            , ects_other => ects_other
            , ects_total => ects_total
            );
        IF total < 1 THEN
            RETURN total;
        END IF;
        -- bonus for map_program_code being NOT NULL
        IF map_program_code IS NOT NULL THEN
            total := total + 1;
        END IF;
        RETURN total;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
