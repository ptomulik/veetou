CREATE OR REPLACE TYPE V2u_Ko_Header_t FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , university VARCHAR(100 CHAR)
    , faculty VARCHAR(100 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Header_t(
          SELF IN OUT NOCOPY V2u_Ko_Header_t
        , id IN NUMBER
        , university IN VARCHAR := NULL
        , faculty IN VARCHAR := NULL
        )
        RETURN SELF AS RESULT

--    , MAP MEMBER FUNCTION cat_attribs RETURN VARCHAR

    , ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Header_t)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Headers_t
    AS TABLE OF V2u_Ko_Header_t;

-- vim: set ft=sql ts=4 sw=4 et:
