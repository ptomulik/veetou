CREATE OR REPLACE TYPE BODY V2u_Ko_Distinct_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Distinct_t(
              SELF IN OUT NOCOPY V2u_Ko_Distinct_t
            , job_uuid IN RAW
            , id IN NUMBER := NULL
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp(other IN V2u_Ko_Distinct_t)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        IF id IS NOT NULL AND other.id IS NOT NULL THEN
            ord := cmp_id(other);
        ELSE
            ord := cmp_val(other);
        END IF;
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Cmp.RawN(job_uuid, other.job_uuid);
    END;

    MEMBER FUNCTION cmp_id(other IN V2u_Ko_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN SIGN(id - other.id);
    END;

    MEMBER FUNCTION cmp_val(other IN V2u_Ko_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN 0;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
