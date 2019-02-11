CREATE OR REPLACE PACKAGE V2U_Get AUTHID CURRENT_USER AS
    FUNCTION University(abbriev IN VARCHAR2 := NULL, name IN VARCHAR2 := NULL)
            RETURN V2u_University_t;
    FUNCTION Faculty(abbriev IN VARCHAR2 := NULL, name IN VARCHAR2 := NULL)
            RETURN V2u_Faculty_t;
    FUNCTION Semester(code IN VARCHAR2)
            RETURN V2u_Semester_t;
    FUNCTION Semester(id IN NUMBER)
            RETURN V2u_Semester_t;
    FUNCTION Tpro_Kod(
              subj_credit_kind IN VARCHAR2
            , subj_grades IN V2u_Subj_Grades_t
            ) RETURN VARCHAR2;
END V2U_Get;

-- vim: set ft=sql ts=4 sw=4 et:
