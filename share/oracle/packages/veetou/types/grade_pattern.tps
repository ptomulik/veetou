CREATE OR REPLACE TYPE V2u_Grade_Pattern_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( expr_classes_type VARCHAR2(256 CHAR)
    , expr_subj_grade VARCHAR2(256 CHAR)
    , expr_subj_grade_date VARCHAR2(256 CHAR)
    , expr_map_subj_grade VARCHAR2(256 CHAR)
    , expr_map_subj_grade_type VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Grade_Pattern_t(
              SELF IN OUT NOCOPY V2u_Grade_Pattern_t
            , expr_classes_type IN VARCHAR2
            , expr_subj_grade IN VARCHAR2
            , expr_subj_grade_date IN VARCHAR2
            , expr_map_subj_grade IN VARCHAR2
            , expr_map_subj_grade_type IN VARCHAR2
            )
        RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Grade_Pattern_t
            , expr_classes_type IN VARCHAR2
            , expr_subj_grade IN VARCHAR2
            , expr_subj_grade_date IN VARCHAR2
            , expr_map_subj_grade IN VARCHAR2
            , expr_map_subj_grade_type IN VARCHAR2
            )

    , MEMBER FUNCTION match_attributes(
              classes_type IN VARCHAR2
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , map_subj_grade IN VARCHAR2
            , map_subj_grade_type IN VARCHAR2
            )
        RETURN INTEGER

    , MEMBER FUNCTION match_classes_type(classes_type IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_subj_grade(subj_grade IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_subj_grade_date(subj_grade_date IN DATE) RETURN INTEGER
    , MEMBER FUNCTION match_map_subj_grade(map_subj_grade IN VARCHAR2) RETURN INTEGER
    , MEMBER FUNCTION match_map_subj_grade_type(map_subj_grade_type IN VARCHAR2) RETURN INTEGER
    )
NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
