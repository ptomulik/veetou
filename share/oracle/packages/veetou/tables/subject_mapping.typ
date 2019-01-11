CREATE OR REPLACE TYPE Veetou_Subject_Mapping_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER
    , subj_code VARCHAR(20 CHAR)
    , mapped_subj_code VARCHAR(20 CHAR)
    , matcher_id VARCHAR(128 CHAR)
    , matcher_arg VARCHAR(200 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Subject_Mapping_Typ(
              SELF IN OUT NOCOPY Veetou_Subject_Mapping_Typ
            , id IN NUMBER := NULL
            , subj_code IN VARCHAR := NULL
            , mapped_subj_code IN VARCHAR := NULL
            , matcher_id IN VARCHAR := NULL
            , matcher_arg IN VARCHAR := NULL
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Subject_Mapping_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Subject_Mapping_Typ(
          SELF IN OUT NOCOPY Veetou_Subject_Mapping_Typ
        , id IN NUMBER := NULL
        , subj_code IN VARCHAR := NULL
        , mapped_subj_code IN VARCHAR := NULL
        , matcher_id IN VARCHAR := NULL
        , matcher_arg IN VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.subj_code := subj_code;
        SELF.mapped_subj_code := mapped_subj_code;
        SELF.matcher_id := matcher_id;
        SELF.matcher_arg := matcher_arg;
        RETURN;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
