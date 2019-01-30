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

    OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN cmp_val(TREAT(other AS V2u_Faculty_t));
    END;

    MEMBER FUNCTION cmp_val(other IN V2u_Faculty_t)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Cmp.StrNI(abbriev, other.abbriev);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Cmp.StrNI(name, other.name);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
