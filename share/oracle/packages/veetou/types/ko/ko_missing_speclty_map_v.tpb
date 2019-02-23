CREATE OR REPLACE TYPE BODY V2u_Ko_Missing_Speclty_Map_V_t AS
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
