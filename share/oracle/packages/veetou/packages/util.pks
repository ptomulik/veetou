CREATE OR REPLACE PACKAGE V2U_Util AUTHID CURRENT_USER AS
    FUNCTION Split_Range(str IN VARCHAR, left OUT VARCHAR, right OUT VARCHAR)
        RETURN BOOLEAN;
    FUNCTION StrCmp(str1 IN VARCHAR, str2 IN VARCHAR)
        RETURN NUMBER;
    FUNCTION StrIcmp(str1 IN VARCHAR, str2 IN VARCHAR)
        RETURN NUMBER;
    FUNCTION TimestampCmp(ts1 IN TIMESTAMP, ts2 IN TIMESTAMP)
        RETURN NUMBER;
    FUNCTION RawCmp(r1 IN RAW, r2 IN RAW)
        RETURN NUMBER;
    FUNCTION StrNullCmp(str1 IN VARCHAR, str2 IN VARCHAR)
        RETURN NUMBER;
    FUNCTION StrNullIcmp(str1 IN VARCHAR, str2 IN VARCHAR)
        RETURN NUMBER;
    FUNCTION NumNullCmp(num1 IN NUMBER, num2 IN NUMBER)
        RETURN NUMBER;
    FUNCTION DateNullCmp(date1 IN DATE, date2 IN DATE)
        RETURN NUMBER;
    FUNCTION TimestampNullCmp(ts1 IN TIMESTAMP, ts2 IN TIMESTAMP)
        RETURN NUMBER;
    FUNCTION RawNullCmp(r1 IN RAW, r2 IN RAW)
        RETURN NUMBER;
    FUNCTION To_Number_Or_Null(value IN VARCHAR)
        RETURN INTEGER;
    FUNCTION To_Semester_Code(semester_id IN NUMBER)
        RETURN VARCHAR;
    FUNCTION To_Semester_Id(semester_code IN VARCHAR)
        RETURN NUMBER;
    FUNCTION Semester_Add(semester_code IN VARCHAR, offset IN NUMBER)
        RETURN VARCHAR;
    FUNCTION Semester_Sub(semester_code IN VARCHAR, offset IN NUMBER)
        RETURN VARCHAR;
    FUNCTION Semester_Diff( lhs_semester_code IN VARCHAR
                          , rhs_semester_code IN VARCHAR)
        RETURN NUMBER;

    FUNCTION To_Threads(semesters IN V2u_Ko_Semester_Instances_t)
        RETURN V2u_Ko_Semester_Threads_t;

    FUNCTION Max_Admission_Semester(semesters IN V2u_Ko_Semester_Instances_t)
        RETURN VARCHAR;

    FUNCTION To_CharMap( value IN NUMBER
                     , fmt IN VARCHAR := NULL
                     , nlsparam IN VARCHAR := NULL
                     , ifnull IN VARCHAR := NULL)
        RETURN VARCHAR;

    FUNCTION To_CharMap(str IN VARCHAR, n IN NUMBER)
        RETURN VARCHAR;
END V2U_Util;

-- vim: set ft=sql ts=4 sw=4 et:
