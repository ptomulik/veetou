CREATE OR REPLACE PACKAGE V2U_Util AUTHID CURRENT_USER AS
    FUNCTION Split_Range(str IN VARCHAR2, left OUT VARCHAR2, right OUT VARCHAR2)
        RETURN BOOLEAN;
    FUNCTION StrCmp(str1 IN VARCHAR2, str2 IN VARCHAR2)
        RETURN NUMBER;
    FUNCTION StrIcmp(str1 IN VARCHAR2, str2 IN VARCHAR2)
        RETURN NUMBER;
    FUNCTION TimestampCmp(ts1 IN TIMESTAMP, ts2 IN TIMESTAMP)
        RETURN NUMBER;
    FUNCTION RawCmp(r1 IN RAW, r2 IN RAW)
        RETURN NUMBER;
    FUNCTION StrNullCmp(str1 IN VARCHAR2, str2 IN VARCHAR2)
        RETURN NUMBER;
    FUNCTION StrNullIcmp(str1 IN VARCHAR2, str2 IN VARCHAR2)
        RETURN NUMBER;
    FUNCTION NumNullCmp(num1 IN NUMBER, num2 IN NUMBER)
        RETURN NUMBER;
    FUNCTION DateNullCmp(date1 IN DATE, date2 IN DATE)
        RETURN NUMBER;
    FUNCTION TimestampNullCmp(ts1 IN TIMESTAMP, ts2 IN TIMESTAMP)
        RETURN NUMBER;
    FUNCTION RawNullCmp(r1 IN RAW, r2 IN RAW)
        RETURN NUMBER;
    FUNCTION Semester_Add(semester_code IN VARCHAR2, offset IN NUMBER)
        RETURN VARCHAR2;
    FUNCTION Semester_Sub(semester_code IN VARCHAR2, offset IN NUMBER)
        RETURN VARCHAR2;
    FUNCTION Semester_Diff( lhs_semester_code IN VARCHAR2
                          , rhs_semester_code IN VARCHAR2)
        RETURN NUMBER;

    FUNCTION Max_Admission_Semester(semesters IN V2u_Ko_Semester_Instances_t)
        RETURN VARCHAR2;

    FUNCTION Next_Val(sequence IN VARCHAR2) RETURN NUMBER;
END V2U_Util;

-- vim: set ft=sql ts=4 sw=4 et:
