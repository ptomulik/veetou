CREATE OR REPLACE TYPE BODY V2u_Semester_t AS
    CONSTRUCTOR FUNCTION V2u_Semester_t(
          SELF IN OUT NOCOPY V2u_Semester_t
        , id IN NUMBER := NULL
        , code IN VARCHAR2
        , start_date IN DATE
        , end_date IN DATE
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.code := code;
        IF id IS NULL THEN
            SELF.id := V2u_Semester_t.to_id(code);
        ELSE
            SELF.id := id;
        END IF;
        SELF.start_date := start_date;
        SELF.end_date := end_date;
        RETURN;
    END;

    OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    IS
    BEGIN
        RETURN cmp_val(TREAT(other as V2u_Semester_t));
    END;

    MEMBER FUNCTION cmp_val(other IN V2u_Semester_t)
        RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2u_Cmp.StrNI(code, other.code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2u_Cmp.DateN(start_date, other.start_date);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2u_Cmp.DateN(end_date, other.end_date);
    END;

    STATIC FUNCTION to_code(semester_id IN NUMBER)
        RETURN VARCHAR2
    IS
        y NUMBER;
        s CHARACTER(1);
    BEGIN
        y := TRUNC(semester_id/2);
        IF semester_id IS NULL OR y < 1900 OR y > 2099 THEN
            RETURN NULL;
        END IF;
        s := CASE MOD(semester_id, 2) WHEN 1 THEN 'Z' ELSE 'L' END;
        RETURN TO_CHAR(y, 'FM0999') || s;
    END;

    STATIC FUNCTION to_id(semester_code IN VARCHAR2)
        RETURN NUMBER
    IS
        y NUMBER;
        s CHARACTER(1);
    BEGIN
        IF REGEXP_INSTR(UPPER(semester_code), '^(19|20)[0-9]{2}[LZ]$') <> 1
        THEN
            RETURN NULL;
        END IF;
        y := TO_NUMBER(SUBSTR(semester_code, 1, 4));    -- year as number
        s := SUBSTR(semester_code, 5, 1);               -- season (L/Z)
        RETURN (2 * y + CASE UPPER(s) WHEN 'Z' THEN 1 ELSE 0 END);
    END;

    STATIC FUNCTION sem_add(semester_code IN VARCHAR2, offset IN NUMBER)
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN to_code(to_id(semester_code) + offset);
    END;

    STATIC FUNCTION sem_sub(semester_code IN VARCHAR2, offset IN NUMBER)
        RETURN VARCHAR2
    IS
    BEGIN
        RETURN to_code(to_id(semester_code) - offset);
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
