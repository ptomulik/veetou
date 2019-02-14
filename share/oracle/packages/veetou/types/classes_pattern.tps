CREATE OR REPLACE TYPE V2u_Classes_Pattern_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( expr_subj_code VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Classes_Pattern_t(
              SELF IN OUT NOCOPY V2u_Classes_Pattern_t
            , expr_subj_code IN VARCHAR2
            )
        RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Classes_Pattern_t
            , expr_subj_code IN VARCHAR2
            )

    , MEMBER FUNCTION match_attributes(
              subj_code IN VARCHAR2
            ) RETURN INTEGER

    , MEMBER FUNCTION match_subj_code(subj_code IN VARCHAR2) RETURN INTEGER
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
