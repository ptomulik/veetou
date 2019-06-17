CREATE OR REPLACE TYPE BODY V2u_Grade_Pattern_t AS
    CONSTRUCTOR FUNCTION V2u_Grade_Pattern_t(
              SELF IN OUT NOCOPY V2u_Grade_Pattern_t
            , expr_classes_type IN VARCHAR2
            , expr_subj_grade IN VARCHAR2
            , expr_subj_grade_date IN VARCHAR2
            , expr_map_subj_grade IN VARCHAR2
            , expr_map_subj_grade_type IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              expr_classes_type => expr_classes_type
            , expr_subj_grade => expr_subj_grade
            , expr_subj_grade_date => expr_subj_grade_date
            , expr_map_subj_grade => expr_map_subj_grade
            , expr_map_subj_grade_type => expr_map_subj_grade_type
        );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Grade_Pattern_t
            , expr_classes_type IN VARCHAR2
            , expr_subj_grade IN VARCHAR2
            , expr_subj_grade_date IN VARCHAR2
            , expr_map_subj_grade IN VARCHAR2
            , expr_map_subj_grade_type IN VARCHAR2
            )
    IS
    BEGIN
        SELF.expr_classes_type := expr_classes_type;
        SELF.expr_subj_grade := expr_subj_grade;
        SELF.expr_subj_grade_date := expr_subj_grade_date;
        SELF.expr_map_subj_grade := expr_map_subj_grade;
        SELF.expr_map_subj_grade_type := expr_map_subj_grade_type;
    END;


    MEMBER FUNCTION match_attributes(
              classes_type IN VARCHAR2
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , map_subj_grade IN VARCHAR2
            , map_subj_grade_type IN VARCHAR2
            ) RETURN INTEGER
    IS
        total INTEGER;
        local INTEGER;
    BEGIN
        -- < 0 - expression error,
        --   0 - not matched,
        -- > 0 - matched (match_score)
        total := 1;
        IF expr_classes_type IS NOT NULL THEN
            local := match_classes_type(classes_type);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_subj_grade IS NOT NULL THEN
            local := match_subj_grade(subj_grade);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_subj_grade_date IS NOT NULL THEN
            local := match_subj_grade_date(subj_grade_date);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_map_subj_grade IS NOT NULL THEN
            local := match_map_subj_grade(map_subj_grade);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        IF expr_map_subj_grade_type IS NOT NULL THEN
            local := match_map_subj_grade_type(map_subj_grade_type);
            IF local < 1 THEN
                RETURN local;
            ELSE
                total := total + 1;
            END IF;
        END IF;
        RETURN total;
    END;


    MEMBER FUNCTION match_classes_type(classes_type IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(UPPER(expr_classes_type), UPPER(classes_type));
    END;


    MEMBER FUNCTION match_subj_grade(subj_grade IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(UPPER(expr_subj_grade), UPPER(subj_grade));
    END;


    MEMBER FUNCTION match_subj_grade_date(subj_grade_date IN DATE)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Range(expr_subj_grade_date, TO_CHAR(subj_grade_date, 'YYYY-MM-DD'));
    END;


    MEMBER FUNCTION match_map_subj_grade(map_subj_grade IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(UPPER(expr_map_subj_grade), UPPER(map_subj_grade));
    END;

    MEMBER FUNCTION match_map_subj_grade_type(map_subj_grade_type IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(UPPER(expr_map_subj_grade_type), map_subj_grade_type);
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
