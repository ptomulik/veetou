CREATE OR REPLACE TYPE Veetou_Subject_Matcher_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( id VARCHAR(128 CHAR)
    , description VARCHAR(1024 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Subject_Matcher_Typ(
              SELF IN OUT NOCOPY Veetou_Subject_Matcher_Typ
            , id IN VARCHAR := NULL
            , description IN VARCHAR := NULL
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Subject_Matcher_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Subject_Matcher_Typ(
          SELF IN OUT NOCOPY Veetou_Subject_Matcher_Typ
        , id IN VARCHAR := NULL
        , description IN VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.description := description;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
