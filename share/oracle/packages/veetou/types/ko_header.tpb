CREATE OR REPLACE TYPE BODY V2u_Ko_Header_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Header_t(
          SELF IN OUT NOCOPY V2u_Ko_Header_t
        , job_uuid IN RAW
        , id IN NUMBER
        , university IN VARCHAR := NULL
        , faculty IN VARCHAR := NULL
        )
        RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.university := university;
        SELF.faculty := faculty;
        RETURN;
    END;

--    MAP MEMBER FUNCTION cat_attribs
--        RETURN VARCHAR
--    IS
--    BEGIN
--        RETURN V2U_Util.To_CharMap(university, 100)
--                || '|' ||
--                faculty;
--    END;

    ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Header_t)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := V2U_Util.StrNullIcmp(university, other.university);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(faculty, other.faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2u_Util.RawNullCmp(job_uuid, other.job_uuid);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
