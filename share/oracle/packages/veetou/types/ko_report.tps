CREATE OR REPLACE TYPE Veetou_Ko_Report_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , source VARCHAR(512 CHAR)
    , datetime TIMESTAMP
    , first_page NUMBER(10)
    , sheets_parsed NUMBER(10)
    , pages_parsed NUMBER(10)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Report_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Report_Typ
            , id NUMBER := NULL
            , source VARCHAR := NULL
            , datetime TIMESTAMP := NULL
            , first_page NUMBER := NULL
            , sheets_parsed NUMBER := NULL
            , pages_parsed NUMBER := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Report_Typ)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE Veetou_Ko_Reports_Typ
    AS TABLE OF Veetou_Ko_Report_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
