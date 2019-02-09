CREATE OR REPLACE TYPE V2u_Ko_Rejected_Map_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( map_id NUMBER(38)
    , matching_score NUMBER(38)
    , reason VARCHAR2(80 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Rejected_Map_t(
              SELF IN OUT NOCOPY V2u_Ko_Rejected_Map_t
            , map_id IN NUMBER
            , matching_score IN NUMBER
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MAP MEMBER FUNCTION map_fcn RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Rejected_Maps_t
    AS TABLE OF V2u_Ko_Rejected_Map_t;

-- vim: set ft=sql ts=4 sw=4 et:
