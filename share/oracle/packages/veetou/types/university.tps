CREATE OR REPLACE TYPE V2u_University_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Distinct_t
    ( abbriev VARCHAR2(8 CHAR)
    , name VARCHAR2(100 CHAR)
    , CONSTRUCTOR FUNCTION V2u_University_t(
              SELF IN OUT NOCOPY V2u_University_t
            , id IN NUMBER := NULL
            , abbriev IN VARCHAR2
            , name IN VARCHAR2
            ) RETURN SELF AS RESULT

    , OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
        RETURN INTEGER
    , MEMBER FUNCTION cmp_val(other IN V2u_University_t)
        RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE V2u_University_Codes_t
    AS TABLE OF VARCHAR2(10 CHAR);
/
CREATE OR REPLACE TYPE V2u_Universities_t
    AS TABLE OF V2u_University_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
