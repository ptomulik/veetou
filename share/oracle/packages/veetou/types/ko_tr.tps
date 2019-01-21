CREATE OR REPLACE TYPE Veetou_Ko_Tr_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , subj_code VARCHAR(32 CHAR)
    , subj_name VARCHAR(256 CHAR)
    , subj_hours_w NUMBER(8)
    , subj_hours_c NUMBER(8)
    , subj_hours_l NUMBER(8)
    , subj_hours_p NUMBER(8)
    , subj_hours_s NUMBER(8)
    , subj_credit_kind VARCHAR(16 CHAR)
    , subj_ects NUMBER(4)
    , subj_tutor VARCHAR(256 CHAR)
    , subj_grade VARCHAR(32 CHAR)
    , subj_grade_date DATE

    , CONSTRUCTOR FUNCTION Veetou_Ko_Tr_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Tr_Typ
            , id IN NUMBER := NULL
            , subj_code IN VARCHAR := NULL
            , subj_name IN VARCHAR := NULL
            , subj_hours_w IN NUMBER := NULL
            , subj_hours_c IN NUMBER := NULL
            , subj_hours_l IN NUMBER := NULL
            , subj_hours_p IN NUMBER := NULL
            , subj_hours_s IN NUMBER := NULL
            , subj_credit_kind IN VARCHAR := NULL
            , subj_ects IN NUMBER := NULL
            , subj_tutor IN VARCHAR := NULL
            , subj_grade IN VARCHAR := NULL
            , subj_grade_date IN DATE := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Tr_Typ)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE Veetou_Ko_Trs_Typ
    AS TABLE OF Veetou_Ko_Tr_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
