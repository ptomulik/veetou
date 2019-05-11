CREATE OR REPLACE TYPE BODY V2u_Ko_Distinct_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Distinct_t(
              SELF IN OUT NOCOPY V2u_Ko_Distinct_t
            , id IN NUMBER := NULL
            , job_uuid IN RAW
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := job_uuid;
        RETURN;
    END;

    OVERRIDING MEMBER FUNCTION cmp_impl(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := (SELF AS V2u_Distinct_t).cmp_impl(other);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Cmp.RawN(job_uuid, TREAT(other AS V2u_Ko_Distinct_t).job_uuid);
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
