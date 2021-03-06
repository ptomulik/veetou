CREATE OR REPLACE TYPE BODY V2u_Classes_Pattern_t AS
    CONSTRUCTOR FUNCTION V2u_Classes_Pattern_t(
              SELF IN OUT NOCOPY V2u_Classes_Pattern_t
            , expr_classes_type IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(expr_classes_type => expr_classes_type);
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Classes_Pattern_t
            , expr_classes_type IN VARCHAR2
            )
    IS
    BEGIN
        SELF.expr_classes_type := expr_classes_type;
    END;


    MEMBER FUNCTION match_attributes(
          classes_type IN VARCHAR2
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
                total := total + local;
            END IF;
        END IF;
        RETURN total;
    END;

    MEMBER FUNCTION match_classes_type(classes_type IN VARCHAR2)
        RETURN INTEGER
    IS
    BEGIN
        RETURN V2U_Match.String_Like(expr_classes_type, classes_type);
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
