CREATE OR REPLACE TYPE V2u_Student_Pattern_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( expr_student_index VARCHAR2(256 CHAR)
    , expr_student_name VARCHAR2(256 CHAR)
    , expr_first_name VARCHAR2(256 CHAR)
    , expr_last_name VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Student_Pattern_t(
              SELF IN OUT NOCOPY V2u_Student_Pattern_t
            , expr_student_index IN VARCHAR2
            , expr_student_name IN VARCHAR2
            , expr_first_name IN VARCHAR2
            , expr_last_name IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Student_Pattern_t
            , expr_student_index IN VARCHAR2
            , expr_student_name IN VARCHAR2
            , expr_first_name IN VARCHAR2
            , expr_last_name IN VARCHAR2
            )

    , MEMBER FUNCTION match_attributes(
              student_index IN VARCHAR2
            , student_name IN VARCHAR2
            , first_name IN VARCHAR2
            , last_name IN VARCHAR2
            ) RETURN INTEGER

    , MEMBER FUNCTION match_student_index(student_index IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_student_name(student_name IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_first_name(first_name IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_last_name(last_name IN VARCHAR2) RETURN INTEGER
    )
NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
