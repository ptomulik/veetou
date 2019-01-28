CREATE OR REPLACE PACKAGE V2U_Util AUTHID CURRENT_USER AS
    FUNCTION Split_Range(str IN VARCHAR2, left OUT VARCHAR2, right OUT VARCHAR2)
        RETURN BOOLEAN;
--    FUNCTION Semester_Add(semester_code IN VARCHAR2, offset IN NUMBER)
--        RETURN VARCHAR2;
--    FUNCTION Semester_Sub(semester_code IN VARCHAR2, offset IN NUMBER)
--        RETURN VARCHAR2;
--    FUNCTION Semester_Diff( lhs_semester_code IN VARCHAR2
--                          , rhs_semester_code IN VARCHAR2)
--        RETURN NUMBER;

--    FUNCTION Max_Admission_Semester(semesters IN V2u_Ko_Semester_Instances_t)
--        RETURN VARCHAR2;

    FUNCTION Next_Val(sequence IN VARCHAR2) RETURN NUMBER;
END V2U_Util;

-- vim: set ft=sql ts=4 sw=4 et:
