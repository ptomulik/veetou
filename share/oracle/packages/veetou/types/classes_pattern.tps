CREATE OR REPLACE TYPE V2u_Classes_Pattern_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( expr_classes_type VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Classes_Pattern_t(
              SELF IN OUT NOCOPY V2u_Classes_Pattern_t
            , expr_classes_type IN VARCHAR2
            )
        RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Classes_Pattern_t
            , expr_classes_type IN VARCHAR2
            )

    , MEMBER FUNCTION match_attributes(
              classes_type IN VARCHAR2
            ) RETURN INTEGER

    , MEMBER FUNCTION match_classes_type(classes_type IN VARCHAR2) RETURN INTEGER
    )
NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
