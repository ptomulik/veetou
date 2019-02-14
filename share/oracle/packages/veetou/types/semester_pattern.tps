CREATE OR REPLACE TYPE V2u_Semester_Pattern_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( expr_semester_code VARCHAR2(256 CHAR)
    , expr_semester_number VARCHAR2(256 CHAR)
    , expr_ects_mandatory VARCHAR2(256 CHAR)
    , expr_ects_other VARCHAR2(256 CHAR)
    , expr_ects_total VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Semester_Pattern_t(
              SELF IN OUT NOCOPY V2u_Semester_Pattern_t
            , expr_semester_code IN VARCHAR2
            , expr_semester_number IN VARCHAR2
            , expr_ects_mandatory IN VARCHAR2
            , expr_ects_other IN VARCHAR2
            , expr_ects_total IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Semester_Pattern_t
            , expr_semester_code IN VARCHAR2
            , expr_semester_number IN VARCHAR2
            , expr_ects_mandatory IN VARCHAR2
            , expr_ects_other IN VARCHAR2
            , expr_ects_total IN VARCHAR2
            )

    , MEMBER FUNCTION match_attributes(
              semester_code IN VARCHAR2
            , semester_number IN NUMBER
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            ) RETURN INTEGER

    , MEMBER FUNCTION match_semester_code(semester_code IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_semester_number(semester_number IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_ects_mandatory(ects_mandatory IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_ects_other(ects_other IN INTEGER) RETURN INTEGER
    , MEMBER FUNCTION match_ects_total(ects_total IN INTEGER) RETURN INTEGER
    )
NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
