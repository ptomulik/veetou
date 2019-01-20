CREATE OR REPLACE TYPE Veetou_Ko_Semester_Summlog_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( semesters Veetou_Ko_Semester_Summaries_Typ

    , CONSTRUCTOR FUNCTION Veetou_Ko_Semester_Summlog_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Semester_Summlog_Typ
            , semesters IN Veetou_Ko_Semester_Summaries_Typ := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Semester_Summlog_Typ)
            RETURN NUMBER
    );

-- vim: set ft=sql ts=4 sw=4 et:
