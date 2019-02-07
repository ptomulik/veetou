CREATE OR REPLACE PACKAGE V2U_To AUTHID CURRENT_USER AS
--    FUNCTION Semester_Code(semester_id IN NUMBER) RETURN VARCHAR2;
--    FUNCTION Semester_Id(semester_code IN VARCHAR2) RETURN NUMBER;
    FUNCTION Threads(semesters IN V2u_Ko_Semesters_t)
        RETURN V2u_Ko_Semester_Tables_t;
END V2U_To;

-- vim: set ft=sql ts=4 sw=4 et:
