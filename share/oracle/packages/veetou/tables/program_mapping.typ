CREATE OR REPLACE TYPE Veetou_Program_Mapping_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( university VARCHAR(256 CHAR)
    , faculty VARCHAR(256 CHAR)
    , studies_modetier VARCHAR(256 CHAR)
    , studies_field VARCHAR(256 CHAR)
    , studies_specialty VARCHAR(256 CHAR)
    , mapped_program_code VARCHAR(32 CHAR)
    , mapped_modetier_code VARCHAR(32 CHAR)
    , mapped_field_code VARCHAR(32 CHAR)
    , expr_semester_code VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Program_Mapping_Typ(
              SELF IN OUT NOCOPY Veetou_Program_Mapping_Typ
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

    , MEMBER FUNCTION match_expr_fields(
              SELF IN Veetou_Program_Mapping_Typ
            , program IN Veetou_Ko_Specialty_Instance_Typ
            ) RETURN INTEGER

    , MEMBER FUNCTION match_expr_fields(
              SELF IN Veetou_Program_Mapping_Typ
            , refined IN Veetou_Ko_Refined_Typ
            ) RETURN INTEGER

    , MEMBER FUNCTION match_semester_code(
              SELF IN Veetou_Program_Mapping_Typ
            , semester_code IN VARCHAR
            ) RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Program_Mapping_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Program_Mapping_Typ(
          SELF IN OUT NOCOPY Veetou_Program_Mapping_Typ
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
          SELF IN Veetou_Program_Mapping_Typ
        , program IN Veetou_Ko_Specialty_Instance_Typ
        ) RETURN INTEGER
    IS
        score NUMBER;
        local NUMBER;
    BEGIN
        score := 1;     -- if all expressions are NULL, then match is positive
        IF SELF.expr_semester_code IS NOT NULL THEN
            local := SELF.match_semester_code(program.semester_code);
            IF local < 1 THEN
                RETURN local;
            ELSE
                score := score + 1;
            END IF;
        END IF;
        RETURN score;
    END;

    MEMBER FUNCTION match_expr_fields(
          SELF IN Veetou_Program_Mapping_Typ
        , refined IN Veetou_Ko_Refined_Typ
        ) RETURN INTEGER
    IS
    BEGIN
        RETURN SELF.match_expr_fields(Veetou_Ko_Specialty_Instance_Typ(refined));
    END;

    MEMBER FUNCTION match_semester_code(
        SELF IN Veetou_Program_Mapping_Typ
      , semester_code IN VARCHAR
      ) RETURN INTEGER
    IS
    BEGIN
        RETURN VEETOU_Match.String_Range(SELF.expr_semester_code, semester_code);
    END;
END;
/
CREATE OR REPLACE TYPE Veetou_Program_Mappings_Typ
    AS TABLE OF Veetou_Program_Mapping_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
