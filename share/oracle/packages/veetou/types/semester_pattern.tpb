CREATE OR REPLACE TYPE BODY V2u_Semester_Pattern_t AS
    CONSTRUCTOR FUNCTION V2u_Semester_Pattern_t(
              SELF IN OUT NOCOPY V2u_Semester_Pattern_t
            , expr_semester_code IN VARCHAR2
            , expr_semester_number IN VARCHAR2
            , expr_ects_mandatory IN VARCHAR2
            , expr_ects_other IN VARCHAR2
            , expr_ects_total IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              expr_semester_code => expr_semester_code
            , expr_semester_number => expr_semester_number
            , expr_ects_mandatory => expr_ects_mandatory
            , expr_ects_other => expr_ects_other
            , expr_ects_total => expr_ects_total
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Semester_Pattern_t
            , expr_semester_code IN VARCHAR2
            , expr_semester_number IN VARCHAR2
            , expr_ects_mandatory IN VARCHAR2
            , expr_ects_other IN VARCHAR2
            , expr_ects_total IN VARCHAR2
            )
    IS
    BEGIN
        SELF.expr_semester_code := expr_semester_code;
        SELF.expr_semester_number := expr_semester_number;
        SELF.expr_ects_mandatory := expr_ects_mandatory;
        SELF.expr_ects_other := expr_ects_other;
        SELF.expr_ects_total := expr_ects_total;
    END;


    MEMBER FUNCTION match_attributes(
              semester_code IN VARCHAR2
            , semester_number IN NUMBER
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            ) RETURN INTEGER
    IS
        total INTEGER;
        local INTEGER;
    BEGIN
        -- < 0 - expression error,
        --   0 - not matched,
        -- > 0 - matched (match_score)
        total := 1;
        IF expr_semester_code IS NOT NULL THEN
            local := match_semester_code(semester_code);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_semester_number IS NOT NULL THEN
            local := match_semester_number(semester_number);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_ects_mandatory IS NOT NULL THEN
            local := match_ects_mandatory(ects_mandatory);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_ects_other IS NOT NULL THEN
            local := match_ects_other(ects_other);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_ects_total IS NOT NULL THEN
            local := match_ects_total(ects_total);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        RETURN total;
    END;


    MEMBER FUNCTION match_semester_code(semester_code IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Range(expr_semester_code, semester_code);
    END;


    MEMBER FUNCTION match_semester_number(semester_number IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_semester_number, semester_number);
    END;


    MEMBER FUNCTION match_ects_mandatory(ects_mandatory IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_ects_mandatory, ects_mandatory);
    END;


    MEMBER FUNCTION match_ects_other(ects_other IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_ects_other, ects_other);
    END;


    MEMBER FUNCTION match_ects_total(ects_total IN INTEGER)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.Number_Range(expr_ects_total, ects_total);
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
