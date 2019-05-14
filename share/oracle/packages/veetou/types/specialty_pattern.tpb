CREATE OR REPLACE TYPE BODY V2u_Specialty_Pattern_t AS
    CONSTRUCTOR FUNCTION V2u_Specialty_Pattern_t(
          SELF IN OUT NOCOPY V2u_Specialty_Pattern_t
        , expr_university IN VARCHAR2
        , expr_faculty IN VARCHAR2
        , expr_studies_modetier IN VARCHAR2
        , expr_studies_field IN VARCHAR2
        , expr_studies_specialty IN VARCHAR2
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
          expr_university => expr_university
        , expr_faculty => expr_faculty
        , expr_studies_modetier => expr_studies_modetier
        , expr_studies_field => expr_studies_field
        , expr_studies_specialty => expr_studies_specialty
        );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Specialty_Pattern_t
            , expr_university IN VARCHAR2
            , expr_faculty IN VARCHAR2
            , expr_studies_modetier IN VARCHAR2
            , expr_studies_field IN VARCHAR2
            , expr_studies_specialty IN VARCHAR2
            )
    IS
    BEGIN
        SELF.expr_university := expr_university;
        SELF.expr_faculty := expr_faculty;
        SELF.expr_studies_modetier := expr_studies_modetier;
        SELF.expr_studies_field := expr_studies_field;
        SELF.expr_studies_specialty := expr_studies_specialty;
    END;


    MEMBER FUNCTION match_attributes(
          university IN VARCHAR2
        , faculty IN VARCHAR2
        , studies_modetier IN VARCHAR2
        , studies_field IN VARCHAR2
        , studies_specialty IN VARCHAR2
        ) RETURN INTEGER
    IS
        total INTEGER;
        local INTEGER;
    BEGIN
        -- < 0 - expression error,
        --   0 - not matched,
        -- > 0 - matched (match_score)
        total := 1;
        IF expr_university IS NOT NULL THEN
            local := match_university(university);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_faculty IS NOT NULL THEN
            local := match_faculty(faculty);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_studies_modetier IS NOT NULL THEN
            local := match_studies_modetier(studies_modetier);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_studies_field IS NOT NULL THEN
            local := match_studies_field(studies_field);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_studies_specialty IS NOT NULL THEN
            local := match_studies_specialty(studies_specialty);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        RETURN total;
    END;


    MEMBER FUNCTION match_university(university IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_university, university);
    END;


    MEMBER FUNCTION match_faculty(faculty IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_faculty, faculty);
    END;


    MEMBER FUNCTION match_studies_modetier(studies_modetier IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_studies_modetier, studies_modetier);
    END;


    MEMBER FUNCTION match_studies_field(studies_field IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_studies_field, studies_field);
    END;


    MEMBER FUNCTION match_studies_specialty(studies_specialty IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_studies_specialty, studies_specialty);
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
