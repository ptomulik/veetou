CREATE OR REPLACE TYPE V2u_Ko_Tbody_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , remark VARCHAR(256)

    , CONSTRUCTOR FUNCTION V2u_Ko_Tbody_t(
              SELF IN OUT NOCOPY V2u_Ko_Tbody_t
            , id NUMBER := NULL
            , remark VARCHAR := NULL
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION cat_attribs RETURN VARCHAR
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Tbodies_t
    AS TABLE OF V2u_Ko_Tbody_t;

-- vim: set ft=sql ts=4 sw=4 et:
