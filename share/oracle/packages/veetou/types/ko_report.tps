CREATE OR REPLACE TYPE V2u_Ko_Report_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , source VARCHAR(512 CHAR)
    , datetime TIMESTAMP
    , first_page NUMBER(10)
    , sheets_parsed NUMBER(10)
    , pages_parsed NUMBER(10)

    , CONSTRUCTOR FUNCTION V2u_Ko_Report_t(
              SELF IN OUT NOCOPY V2u_Ko_Report_t
            , id NUMBER := NULL
            , source VARCHAR := NULL
            , datetime TIMESTAMP := NULL
            , first_page NUMBER := NULL
            , sheets_parsed NUMBER := NULL
            , pages_parsed NUMBER := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Report_t)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Reports_t
    AS TABLE OF V2u_Ko_Report_t;

-- vim: set ft=sql ts=4 sw=4 et:
