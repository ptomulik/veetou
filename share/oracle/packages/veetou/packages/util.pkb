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

    FUNCTION StrIcmp(str1 IN VARCHAR, str2 IN VARCHAR)
        RETURN NUMBER
    IS
    BEGIN
        RETURN StrCmp(UPPER(str1), UPPER(str2));
    END;

    FUNCTION StrNullCmp(str1 IN VARCHAR, str2 IN VARCHAR)
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

    FUNCTION StrNullIcmp(str1 IN VARCHAR, str2 IN VARCHAR)
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

    FUNCTION Find_Threads(semesters IN Veetou_Ko_Semester_Summaries_Typ)
        RETURN Veetou_Ko_Thread_Indices_Typ
    IS
        t Veetou_Ko_Thread_Indices_Typ := Veetou_Ko_Thread_Indices_Typ();
        n NUMBER := 0;
        i NUMBER := 1;
        j NUMBER;
        sn NUMBER(2);
        prev NUMBER(2);
    BEGIN
        t.EXTEND(semesters.COUNT);
        WHILE (n <> semesters.COUNT AND i < 10)
        LOOP
            prev := 0;
            j := 1;
            FOR s IN (SELECT * FROM TABLE(semesters) ORDER BY 1)
            LOOP
                IF t(j) IS NULL THEN
                    sn := s.semester_number;
                    IF sn >= prev AND ((prev = 0) OR (sn - prev <= 1)) THEN
                        t(j) := i;
                        prev := sn;
                        n := n + 1;
                    ELSE
                        EXIT;
                    END IF;
                END IF;
                j := j+1;
            END LOOP;
            i := i+1;
        END LOOP;
        IF i = 10 THEN
            RAISE PROGRAM_ERROR;
        END IF;
        RETURN t;
    END;

    FUNCTION To_Threads(semesters IN Veetou_Ko_Semester_Summaries_Typ)
        RETURN Veetou_Ko_Semester_Threads_Typ
    IS
        n NUMBER := 0;
        i NUMBER := 1;
        j NUMBER;
        tn Veetou_Ko_Thread_Indices_Typ;
        tt Veetou_Ko_Semester_Threads_Typ := Veetou_Ko_Semester_Threads_Typ();
    BEGIN
        tn := Find_Threads(semesters);
        WHILE (n <> semesters.COUNT AND i < 10)
        LOOP
            tt.EXTEND(1);
            tt(tt.COUNT) := Veetou_Ko_Semester_Summaries_Typ();
            j := 1;
            FOR s IN (SELECT * FROM TABLE(semesters) ORDER BY 1)
            LOOP
                IF tn(j) = i THEN
                    tt(i).EXTEND(1);
                    tt(i)(tt(i).COUNT) := Veetou_Ko_Semester_Summary_Typ(
                          semester_code => s.semester_code
                        , semester_number => s.semester_number
                        , ects_mandatory => s.ects_mandatory
                        , ects_other => s.ects_other
                        , ects_total => s.ects_total
                        , ects_attained => s.ects_attained
                        , sheet_id => s.sheet_id
                    );
                    n := n + 1;
                END IF;
                j := j + 1;
            END LOOP;
            i := i + 1;
        END LOOP;
        IF i = 10 THEN
            RAISE PROGRAM_ERROR;
        END IF;
        RETURN tt;
    END;

    FUNCTION Max_Admission_Semester(semesters IN Veetou_Ko_Semester_Summaries_Typ)
        RETURN VARCHAR
    IS
        lowest Veetou_Ko_Semester_Summary_Typ;
    BEGIN
        SELECT VALUE(s) INTO lowest
            FROM TABLE(semesters) s
            WHERE ROWNUM <= 1
            ORDER BY 1;
        RETURN Semester_Sub(lowest.semester_code, (lowest.semester_number-1));
    END;
END VEETOU_Util;

-- vim: set ft=sql ts=4 sw=4 et:
