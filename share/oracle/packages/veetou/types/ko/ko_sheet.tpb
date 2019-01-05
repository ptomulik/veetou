CREATE OR REPLACE TYPE BODY V2u_Ko_Sheet_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Sheet_t(
          SELF IN OUT NOCOPY V2u_Ko_Sheet_t
        , job_uuid IN RAW
        , id IN NUMBER
        , pages_parsed IN NUMBER := NULL
        , first_page IN NUMBER := NULL
        , ects_mandatory IN NUMBER := NULL
        , ects_other IN NUMBER := NULL
        , ects_total IN NUMBER := NULL
        , ects_attained IN NUMBER := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.pages_parsed := pages_parsed;
        SELF.first_page := first_page;
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
        SELF.ects_attained := ects_attained;
        RETURN;
    END;

    MAP MEMBER FUNCTION rawpk
        RETURN RAW
    IS
    BEGIN
        RETURN UTL_RAW.CONCAT(UTL_RAW.CAST_FROM_NUMBER(id), job_uuid);
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
