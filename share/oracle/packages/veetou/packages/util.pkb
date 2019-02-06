CREATE OR REPLACE PACKAGE BODY V2U_Util AS
    FUNCTION Max_Admission_Semester(semesters IN V2u_Ko_Semesters_t)
        RETURN VARCHAR2
    IS
        lowest V2u_Ko_Semester_t;
    BEGIN
        SELECT VALUE(s) INTO lowest
            FROM TABLE(semesters) s
            WHERE ROWNUM <= 1
            ORDER BY 1;
        RETURN V2u_Semester_t.sem_sub(lowest.semester_code, (lowest.semester_number-1));
    END;
END V2U_Util;

-- vim: set ft=sql ts=4 sw=4 et:
