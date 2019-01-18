CREATE OR REPLACE PACKAGE BODY VEETOU_Util AS
    FUNCTION Split_Range(str IN VARCHAR, left OUT VARCHAR, right OUT VARCHAR)
        RETURN BOOLEAN
    IS
        sp NUMBER;  -- separator position
    BEGIN
        sp := INSTR(str, '..');
        IF sp = 0 THEN
            left := TRIM(str);
            right := TRIM(str);
            RETURN TRUE;
        ELSE
            left := TRIM(SUBSTR(str, 1, sp-1));
            right := TRIM(SUBSTR(str, sp+2));
            RETURN TRUE;
        END IF;
    END;

    FUNCTION StrCmp(str1 IN VARCHAR, str2 IN VARCHAR)
        RETURN NUMBER
    IS
    BEGIN
        IF str1 = str2 THEN
            RETURN 0;
        ELSIF GREATEST(str1, str2) = str1 THEN
            RETURN 1;
        ELSIF GREATEST(str1, str2) = str2 THEN
            RETURN -1;
        ELSE
            RETURN NULL;
        END IF;
    END;

    FUNCTION StrIcmp(str1 IN VARCHAR, str2 IN VARCHAR)
        RETURN NUMBER
    IS
    BEGIN
        RETURN StrCmp(UPPER(str1), UPPER(str2));
    END;

    FUNCTION StrNullCmp(str1 IN VARCHAR, str2 IN VARCHAR)
        RETURN NUMBER
    IS
    BEGIN
        IF str1 IS NULL THEN
            IF str2 IS NULL THEN
                RETURN 0;
            END IF;
            RETURN -1;
        ELSIF str2 IS NULL THEN
            RETURN  1;
        ELSE
            RETURN StrCmp(str1, str2);
        END IF;
    END;

    FUNCTION StrNullIcmp(str1 IN VARCHAR, str2 IN VARCHAR)
        RETURN NUMBER
    IS
    BEGIN
        RETURN StrNullCmp(UPPER(str1), UPPER(str2));
    END;

    FUNCTION NumNullCmp(num1 IN NUMBER, num2 IN NUMBER)
        RETURN NUMBER
    IS
    BEGIN
        IF num1 IS NULL THEN
            IF num2 IS NULL THEN
                RETURN 0;
            END IF;
            RETURN -1;
        ELSIF num2 IS NULL THEN
            RETURN  1;
        ELSE
            RETURN SIGN(num1 - num2);
        END IF;
    END;

    FUNCTION To_Number_Or_Null(value IN VARCHAR)
        RETURN INTEGER
    IS
    BEGIN
        RETURN TO_NUMBER(value);
    EXCEPTION
        WHEN VALUE_ERROR THEN
            RETURN NULL;
    END;

    FUNCTION To_Semester_Code(semester_id IN NUMBER)
        RETURN VARCHAR
    IS
        y NUMBER;
        s CHARACTER(1);
    BEGIN
        y := TRUNC(semester_id/2);
        IF semester_id IS NULL OR y < 1900 OR y > 2099 THEN
            RETURN NULL;
        END IF;
        s := CASE MOD(semester_id, 2) WHEN 1 THEN 'Z' ELSE 'L' END;
        RETURN TO_CHAR(y, '0999') || s;
    END;

    FUNCTION To_Semester_Id(semester_code IN VARCHAR)
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

    FUNCTION Semester_Add(semester_code IN VARCHAR, offset IN NUMBER)
        RETURN VARCHAR
    IS
        n NUMBER;
    BEGIN
        RETURN To_Semester_Code(To_Semester_Id(semester_code) + offset);
    END;

    FUNCTION Semester_Sub(semester_code IN VARCHAR, offset IN NUMBER)
        RETURN VARCHAR
    IS
        n NUMBER;
    BEGIN
        RETURN To_Semester_Code(To_Semester_Id(semester_code) - offset);
    END;

    FUNCTION Semester_Diff( lhs_semester_code IN VARCHAR
                          , rhs_semester_code IN VARCHAR)
        RETURN NUMBER
    IS
        lhs_id NUMBER;
        rhs_id NUMBER;
    BEGIN
        lhs_id := To_Semester_Id(lhs_semester_code);
        rhs_id := To_Semester_Id(rhs_semester_code);
        IF lhs_id IS NULL or rhs_id IS NULL THEN
            RETURN NULL;
        END IF;
        return lhs_id - rhs_id;
    END;
END VEETOU_Util;

-- vim: set ft=sql ts=4 sw=4 et:
