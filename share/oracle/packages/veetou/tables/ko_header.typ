CREATE OR REPLACE TYPE Veetou_Ko_Header_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( job_uuid RAW(16)
    , id NUMBER(38)
    , university VARCHAR(256 CHAR)
    , faculty VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Header_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Header_Typ
        , job_uuid IN RAW := NULL
        , id IN NUMBER := NULL
        , university IN VARCHAR := NULL
        , faculty IN VARCHAR := NULL
        )
        RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Header_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Header_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Header_Typ
        , job_uuid IN RAW := NULL
        , id IN NUMBER := NULL
        , university IN VARCHAR := NULL
        , faculty IN VARCHAR := NULL
        )
        RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        SELF.university := university;
        SELF.faculty := faculty;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
