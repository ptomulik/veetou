CREATE OR REPLACE TYPE BODY V2u_Distinct_t AS
    CONSTRUCTOR FUNCTION V2u_Distinct_t(
              SELF IN OUT NOCOPY V2u_Distinct_t
            , id IN NUMBER := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(id => id);
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Distinct_t
            , id IN NUMBER := NULL
            )
    IS
    BEGIN
        SELF.id := id;
    END;

    ORDER MEMBER FUNCTION cmp(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN cmp_impl(other);
    END;

    MEMBER FUNCTION cmp_impl(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        IF id IS NOT NULL AND other.id IS NOT NULL THEN
            RETURN cmp_id(other);
        ELSE
            RETURN cmp_val(other);
        END IF;
    END;

    MEMBER FUNCTION cmp_id(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN SIGN(id - other.id);
    END;

    MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN 0;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
