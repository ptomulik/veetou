CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Speclty_Map_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Speclty_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Speclty_Map_V_t
            , id IN NUMBER := NULL
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , map_program_code IN VARCHAR2
            , map_modetier_code IN VARCHAR2
            , map_field_code IN VARCHAR2
            , map_specialty_code IN VARCHAR2
            , expr_semester_code IN VARCHAR2
            , expr_semester_number IN VARCHAR2
            , expr_ects_mandatory IN VARCHAR2
            , expr_ects_other IN VARCHAR2
            , expr_ects_total IN VARCHAR2
            , job_uuid IN RAW
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              id => id
            , university => university
            , faculty => faculty
            , studies_modetier => studies_modetier
            , studies_field => studies_field
            , studies_specialty => studies_specialty
            , map_program_code => map_program_code
            , map_modetier_code => map_modetier_code
            , map_field_code => map_field_code
            , map_specialty_code => map_specialty_code
            , expr_semester_code => expr_semester_code
            , expr_semester_number => expr_semester_number
            , expr_ects_mandatory => expr_ects_mandatory
            , expr_ects_other => expr_ects_other
            , expr_ects_total => expr_ects_total
            , job_uuid => job_uuid
            , specialty_id => specialty_id
            , semester_id => semester_id
            );
        RETURN;
    END;


    CONSTRUCTOR FUNCTION V2u_Ko_Missing_Speclty_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Speclty_Map_V_t
            , id IN NUMBER := NULL
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              id => id
            , specialty => specialty
            , semester => semester
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Speclty_Map_V_t
            , id IN NUMBER := NULL
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , map_program_code IN VARCHAR2
            , map_modetier_code IN VARCHAR2
            , map_field_code IN VARCHAR2
            , map_specialty_code IN VARCHAR2
            , expr_semester_code IN VARCHAR2
            , expr_semester_number IN VARCHAR2
            , expr_ects_mandatory IN VARCHAR2
            , expr_ects_other IN VARCHAR2
            , expr_ects_total IN VARCHAR2
            , job_uuid IN RAW
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              id => id
            , university => university
            , faculty => faculty
            , studies_modetier => studies_modetier
            , studies_field => studies_field
            , studies_specialty => studies_specialty
            , map_program_code => map_program_code
            , map_modetier_code => map_modetier_code
            , map_field_code => map_field_code
            , map_specialty_code => map_specialty_code
            , expr_semester_code => expr_semester_code
            , expr_semester_number => expr_semester_number
            , expr_ects_mandatory => expr_ects_mandatory
            , expr_ects_other => expr_ects_other
            , expr_ects_total => expr_ects_total
            );
        SELF.job_uuid := job_uuid;
        SELF.specialty_id := specialty_id;
        SELF.semester_id := semester_id;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Speclty_Map_V_t
            , id IN NUMBER := NULL
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            )
    IS
    BEGIN
        IF semester.job_uuid <> specialty.job_uuid THEN
            RAISE_APPLICATION_ERROR(
                  -20101
                , 'job_uuid missmatch in V2u_Ko_Missing_Speclty_Map_V_t.init:' ||
                  ' semester.job_uuid='  || RAWTOHEX(semester.job_uuid) ||
                  ' specialty.job_uuid=' || RAWTOHEX(specialty.job_uuid)
                );
        END IF;
        SELF.init(
              id => id
            , university => specialty.university
            , faculty => specialty.faculty
            , studies_modetier => specialty.studies_modetier
            , studies_field => specialty.studies_field
            , studies_specialty => specialty.studies_specialty
            , map_program_code => NULL
            , map_modetier_code => NULL
            , map_field_code => NULL
            , map_specialty_code => NULL
            , expr_semester_code => semester.semester_code
            , expr_semester_number => semester.semester_number
            , expr_ects_mandatory => semester.ects_mandatory
            , expr_ects_other => semester.ects_other
            , expr_ects_total => semester.ects_total
            );
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
