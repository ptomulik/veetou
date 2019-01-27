CREATE OR REPLACE TYPE BODY V2u_Faculty_t AS
    CONSTRUCTOR FUNCTION V2u_Faculty_t(
              SELF IN OUT NOCOPY V2u_Faculty_t
            , id IN NUMBER := NULL
            , abbriev IN VARCHAR2
            , name IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.abbriev := abbriev;
        SELF.name := name;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_with(other IN V2u_Faculty_t)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := V2U_Util.StrNullIcmp(abbriev, other.abbriev);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Util.StrNullIcmp(name, other.name);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
