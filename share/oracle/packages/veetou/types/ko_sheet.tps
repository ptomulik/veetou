CREATE OR REPLACE TYPE V2u_Ko_Sheet_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , pages_parsed NUMBER(2)
    , first_page NUMBER(10)
    , ects_mandatory NUMBER(4)
    , ects_other NUMBER(4)
    , ects_total NUMBER(4)
    , ects_attained NUMBER(4)

    , CONSTRUCTOR FUNCTION V2u_Ko_Sheet_t(
              SELF IN OUT NOCOPY V2u_Ko_Sheet_t
            , id IN NUMBER
            , pages_parsed IN NUMBER := NULL
            , first_page IN NUMBER := NULL
            , ects_mandatory IN NUMBER := NULL
            , ects_other IN NUMBER := NULL
            , ects_total IN NUMBER := NULL
            , ects_attained IN NUMBER := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION cat_attribs RETURN VARCHAR
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Sheets_t
    AS TABLE OF V2u_Ko_Sheet_t;

-- vim: set ft=sql ts=4 sw=4 et:
