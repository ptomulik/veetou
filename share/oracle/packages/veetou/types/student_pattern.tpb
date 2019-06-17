CREATE OR REPLACE TYPE BODY V2u_Student_Pattern_t AS
    CONSTRUCTOR FUNCTION V2u_Student_Pattern_t(
              SELF IN OUT NOCOPY V2u_Student_Pattern_t
            , expr_student_index IN VARCHAR2
            , expr_student_name IN VARCHAR2
            , expr_first_name IN VARCHAR2
            , expr_last_name IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              expr_student_index => expr_student_index
            , expr_student_name => expr_student_name
            , expr_first_name => expr_first_name
            , expr_last_name => expr_last_name
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Student_Pattern_t
            , expr_student_index IN VARCHAR2
            , expr_student_name IN VARCHAR2
            , expr_first_name IN VARCHAR2
            , expr_last_name IN VARCHAR2
            )
    IS
    BEGIN
        SELF.expr_student_index := expr_student_index;
        SELF.expr_student_name := expr_student_name;
        SELF.expr_first_name := expr_first_name;
        SELF.expr_last_name := expr_last_name;
    END;


    MEMBER FUNCTION match_attributes(
              student_index IN VARCHAR2
            , student_name IN VARCHAR2
            , first_name IN VARCHAR2
            , last_name IN VARCHAR2
            ) RETURN INTEGER
    IS
        total INTEGER;
        local INTEGER;
    BEGIN
        -- < 0 - expression error,
        --   0 - not matched,
        -- > 0 - matched (match_score)
        total := 1;
        IF expr_student_index IS NOT NULL THEN
            local := match_student_index(student_index);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_student_name IS NOT NULL THEN
            local := match_student_name(student_name);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_first_name IS NOT NULL THEN
            local := match_first_name(first_name);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_last_name IS NOT NULL THEN
            local := match_last_name(last_name);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        RETURN total;
    END;


    MEMBER FUNCTION match_student_index(student_index IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(UPPER(expr_student_index), UPPER(student_index));
    END;

    MEMBER FUNCTION match_student_name(student_name IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(UPPER(expr_student_name), UPPER(student_name));
    END;

    MEMBER FUNCTION match_first_name(first_name IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(UPPER(expr_first_name), UPPER(first_name));
    END;

    MEMBER FUNCTION match_last_name(last_name IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(UPPER(expr_last_name), UPPER(last_name));
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
