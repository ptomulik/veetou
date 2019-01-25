CREATE OR REPLACE PACKAGE BODY V2U_Util AS
    FUNCTION Split_Range(str IN VARCHAR2, left OUT VARCHAR2, right OUT VARCHAR2)
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

    FUNCTION StrCmp(str1 IN VARCHAR2, str2 IN VARCHAR2)
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

    FUNCTION TimestampCmp(ts1 IN TIMESTAMP, ts2 IN TIMESTAMP)
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

    FUNCTION StrIcmp(str1 IN VARCHAR2, str2 IN VARCHAR2)
        RETURN NUMBER
    IS
    BEGIN
        RETURN StrCmp(UPPER(str1), UPPER(str2));
    END;

    FUNCTION StrNullCmp(str1 IN VARCHAR2, str2 IN VARCHAR2)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := NullCmp(str1 IS NULL, str2 IS NULL);
        IF ord IS NULL THEN
            ord := StrCmp(str1, str2);
        END IF;
        RETURN ord;
    END;

    FUNCTION StrNullIcmp(str1 IN VARCHAR2, str2 IN VARCHAR2)
        RETURN NUMBER
    IS
    BEGIN
        RETURN StrNullCmp(UPPER(str1), UPPER(str2));
    END;

    FUNCTION NumNullCmp(num1 IN NUMBER, num2 IN NUMBER)
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

    FUNCTION DateNullCmp(date1 IN DATE, date2 IN DATE)
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

    FUNCTION TimestampNullCmp(ts1 IN TIMESTAMP, ts2 IN TIMESTAMP)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := NullCmp(ts1 IS NULL, ts2 IS NULL);
        IF ord IS NULL THEN
            ord := TimestampCmp(ts1, ts2);
        END IF;
        RETURN ord;
    END;

    FUNCTION RawNullCmp(r1 IN RAW, r2 IN RAW)
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

    FUNCTION Semester_Add(semester_code IN VARCHAR2, offset IN NUMBER)
        RETURN VARCHAR2
    IS
        n NUMBER;
    BEGIN
        RETURN V2U_To.Semester_Code(V2U_To.Semester_Id(semester_code) + offset);
    END;

    FUNCTION Semester_Sub(semester_code IN VARCHAR2, offset IN NUMBER)
        RETURN VARCHAR2
    IS
        n NUMBER;
    BEGIN
        RETURN V2U_To.Semester_Code(V2U_To.Semester_Id(semester_code) - offset);
    END;

    FUNCTION Semester_Diff( lhs_semester_code IN VARCHAR2
                          , rhs_semester_code IN VARCHAR2)
        RETURN NUMBER
    IS
        lhs_id NUMBER;
        rhs_id NUMBER;
    BEGIN
        lhs_id := V2U_To.Semester_Id(lhs_semester_code);
        rhs_id := V2U_To.Semester_Id(rhs_semester_code);
        IF lhs_id IS NULL or rhs_id IS NULL THEN
            RETURN NULL;
        END IF;
        return lhs_id - rhs_id;
    END;

    FUNCTION Max_Admission_Semester(semesters IN V2u_Ko_Semester_Instances_t)
        RETURN VARCHAR2
    IS
        lowest V2u_Ko_Semester_Instance_t;
    BEGIN
        SELECT VALUE(s) INTO lowest
            FROM TABLE(semesters) s
            WHERE ROWNUM <= 1
            ORDER BY 1;
        RETURN Semester_Sub(lowest.semester_code, (lowest.semester_number-1));
    END;

    FUNCTION Next_Val(sequence IN VARCHAR2)
        RETURN NUMBER
    IS
        nextval NUMBER;
        column VARCHAR2(128);
    BEGIN
        column := DBMS_ASSERT.SQL_OBJECT_NAME(sequence) || '.NEXTVAL';
        EXECUTE IMMEDIATE 'SELECT ' || column || ' FROM dual' INTO nextval;
        RETURN nextval;
    END;
END V2U_Util;

-- vim: set ft=sql ts=4 sw=4 et:
