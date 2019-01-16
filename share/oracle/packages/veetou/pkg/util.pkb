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

END VEETOU_Util;

-- vim: set ft=sql ts=4 sw=4 et:
