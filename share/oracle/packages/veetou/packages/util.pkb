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

--    FUNCTION Semester_Add(semester_code IN VARCHAR2, offset IN NUMBER)
--        RETURN VARCHAR2
--    IS
--        n NUMBER;
--    BEGIN
--        RETURN V2U_To.Semester_Code(V2U_To.Semester_Id(semester_code) + offset);
--    END;
--
--    FUNCTION Semester_Sub(semester_code IN VARCHAR2, offset IN NUMBER)
--        RETURN VARCHAR2
--    IS
--        n NUMBER;
--    BEGIN
--        RETURN V2U_To.Semester_Code(V2U_To.Semester_Id(semester_code) - offset);
--    END;
--
--    FUNCTION Semester_Diff( lhs_semester_code IN VARCHAR2
--                          , rhs_semester_code IN VARCHAR2)
--        RETURN NUMBER
--    IS
--        lhs_id NUMBER;
--        rhs_id NUMBER;
--    BEGIN
--        lhs_id := V2U_To.Semester_Id(lhs_semester_code);
--        rhs_id := V2U_To.Semester_Id(rhs_semester_code);
--        IF lhs_id IS NULL or rhs_id IS NULL THEN
--            RETURN NULL;
--        END IF;
--        return lhs_id - rhs_id;
--    END;

--    FUNCTION Max_Admission_Semester(semesters IN V2u_Ko_Semester_Instances_t)
--        RETURN VARCHAR2
--    IS
--        lowest V2u_Ko_Semester_Instance_t;
--    BEGIN
--        SELECT VALUE(s) INTO lowest
--            FROM TABLE(semesters) s
--            WHERE ROWNUM <= 1
--            ORDER BY 1;
--        RETURN Semester_Sub(lowest.semester_code, (lowest.semester_number-1));
--    END;

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
