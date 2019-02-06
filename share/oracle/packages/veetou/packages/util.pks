CREATE OR REPLACE PACKAGE V2U_Util AUTHID CURRENT_USER AS
    FUNCTION Max_Admission_Semester(semesters IN V2u_Ko_Semesters_t)
        RETURN VARCHAR2;
END V2U_Util;

-- vim: set ft=sql ts=4 sw=4 et:
