CREATE OR REPLACE TYPE BODY V2u_Program_Mapping_t AS
    CONSTRUCTOR FUNCTION V2u_Program_Mapping_t(
          SELF IN OUT NOCOPY V2u_Program_Mapping_t
        , university VARCHAR := NULL
        , faculty VARCHAR := NULL
        , studies_modetier VARCHAR := NULL
        , studies_field VARCHAR := NULL
        , studies_specialty VARCHAR := NULL
        , mapped_program_code VARCHAR := NULL
        , mapped_modetier_code VARCHAR := NULL
        , mapped_field_code VARCHAR := NULL
        , expr_semester_code VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty;
        SELF.mapped_program_code := mapped_program_code;
        SELF.mapped_modetier_code := mapped_modetier_code;
        SELF.mapped_field_code := mapped_field_code;
        SELF.expr_semester_code := expr_semester_code;
        RETURN;
    END;

    MEMBER FUNCTION match_expr_fields(
          specialty IN V2u_Ko_Specialty_t
        , semester_code IN VARCHAR
        ) RETURN INTEGER
    IS
        score NUMBER;
        local NUMBER;
    BEGIN
        score := 1;     -- if all expressions are NULL, then match is positive
        IF expr_semester_code IS NOT NULL THEN
            local := match_semester_code(semester_code);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        RETURN score;
    END;


    MEMBER FUNCTION match_semester_code(semester_code IN VARCHAR)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Range(expr_semester_code, semester_code);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
