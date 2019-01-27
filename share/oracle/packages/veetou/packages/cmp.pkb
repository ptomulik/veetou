CREATE OR REPLACE PACKAGE BODY V2U_Cmp AS
    FUNCTION NullCmp(lhs IN BOOLEAN, rhs IN BOOLEAN)
        RETURN NUMBER
    IS
    BEGIN
        IF lhs THEN
            IF rhs THEN
                RETURN 0;
            END IF;
            RETURN -1;
        ELSIF rhs THEN
            RETURN  1;
        ELSE
            -- further comparison required
            RETURN NULL;
        END IF;
    END;

    FUNCTION Str(str1 IN VARCHAR2, str2 IN VARCHAR2)
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

    FUNCTION Tstamp(ts1 IN TIMESTAMP, ts2 IN TIMESTAMP)
        RETURN NUMBER
    IS
    BEGIN
        IF ts1 = ts2 THEN
            RETURN 0;
        ELSIF GREATEST(ts1, ts2) = ts1 THEN
            RETURN 1;
        ELSIF GREATEST(ts1, ts2) = ts2 THEN
            RETURN -1;
        ELSE
            RETURN NULL;
        END IF;
    END;

    FUNCTION RawCmp(r1 IN RAW, r2 IN RAW)
        RETURN NUMBER
    IS
    BEGIN
        IF r1 = r2 THEN
            RETURN 0;
        ELSIF r1 > r2 THEN
            RETURN 1;
        ELSIF r1 < r2 THEN
            RETURN -1;
        ELSE
            RETURN NULL;
        END IF;
    END;

    FUNCTION StrI(str1 IN VARCHAR2, str2 IN VARCHAR2)
        RETURN NUMBER
    IS
    BEGIN
        RETURN Str(UPPER(str1), UPPER(str2));
    END;

    FUNCTION StrN(str1 IN VARCHAR2, str2 IN VARCHAR2)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := NullCmp(str1 IS NULL, str2 IS NULL);
        IF ord IS NULL THEN
            ord := Str(str1, str2);
        END IF;
        RETURN ord;
    END;

    FUNCTION StrNI(str1 IN VARCHAR2, str2 IN VARCHAR2)
        RETURN NUMBER
    IS
    BEGIN
        RETURN StrN(UPPER(str1), UPPER(str2));
    END;

    FUNCTION NumN(num1 IN NUMBER, num2 IN NUMBER)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := NullCmp(num1 IS NULL, num2 IS NULL);
        IF ord IS NULL THEN
            ord := SIGN(num1 - num2);
        END IF;
        RETURN ord;
    END;

    FUNCTION DateN(date1 IN DATE, date2 IN DATE)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := NullCmp(date1 IS NULL, date2 IS NULL);
        IF ord IS NULL THEN
            ord := SIGN(date1 - date2);
        END IF;
        RETURN ord;
    END;

    FUNCTION TstampN(ts1 IN TIMESTAMP, ts2 IN TIMESTAMP)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := NullCmp(ts1 IS NULL, ts2 IS NULL);
        IF ord IS NULL THEN
            ord := Tstamp(ts1, ts2);
        END IF;
        RETURN ord;
    END;

    FUNCTION RawN(r1 IN RAW, r2 IN RAW)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := NullCmp(r2 IS NULL, r2 IS NULL);
        IF ord IS NULL THEN
            ord := RawCmp(r1, r2);
        END IF;
        RETURN ord;
    END;

END V2U_Cmp;

-- vim: set ft=sql ts=4 sw=4 et:
