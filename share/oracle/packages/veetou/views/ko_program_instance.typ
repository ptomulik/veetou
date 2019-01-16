CREATE OR REPLACE TYPE Veetou_Ko_Program_Instance_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( university VARCHAR2(256 CHAR)
    , faculty VARCHAR2(256 CHAR)
    , studies_modetier VARCHAR2(256 CHAR)
    , studies_field VARCHAR2(256 CHAR)
    , studies_specialty VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Program_Instance_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Program_Instance_Typ
            , university IN VARCHAR2 := NULL
            , faculty IN VARCHAR2 := NULL
            , studies_modetier IN VARCHAR2 := NULL
            , studies_field IN VARCHAR2 := NULL
            , studies_specialty IN VARCHAR2 := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION Veetou_Ko_Program_Instance_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Program_Instance_Typ
            , subject IN Veetou_Ko_Subject_Instance_Typ
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION Veetou_Ko_Program_Instance_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Program_Instance_Typ
            , refined IN Veetou_Ko_Refined_Typ
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION ord_all_fields(
                other IN Veetou_Ko_Program_Instance_Typ
            ) RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Program_Instance_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Program_Instance_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Program_Instance_Typ
        , university IN VARCHAR2 := NULL
        , faculty IN VARCHAR2 := NULL
        , studies_modetier IN VARCHAR2 := NULL
        , studies_field IN VARCHAR2 := NULL
        , studies_specialty IN VARCHAR2 := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION Veetou_Ko_Program_Instance_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Program_Instance_Typ
            , subject IN Veetou_Ko_Subject_Instance_Typ
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.university := subject.university;
        SELF.faculty := subject.faculty;
        SELF.studies_modetier := subject.studies_modetier;
        SELF.studies_field := subject.studies_field;
        SELF.studies_specialty := subject.studies_specialty;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION Veetou_Ko_Program_Instance_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Program_Instance_Typ
            , refined IN Veetou_Ko_Refined_Typ
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.university := refined.university;
        SELF.faculty := refined.faculty;
        SELF.studies_modetier := refined.studies_modetier;
        SELF.studies_field := refined.studies_field;
        SELF.studies_specialty := refined.studies_specialty;
        RETURN;
    END;

    ORDER MEMBER FUNCTION ord_all_fields(
                other IN Veetou_Ko_Program_Instance_Typ
            ) RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := VEETOU_Util.StrNullIcmp(university, other.university);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        ord := VEETOU_Util.StrNullIcmp(faculty, other.faculty);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        ord := VEETOU_Util.StrNullIcmp(studies_modetier, other.studies_modetier);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        ord := VEETOU_Util.StrNullIcmp(studies_field, other.studies_field);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        RETURN VEETOU_Util.StrNullIcmp(studies_specialty, other.studies_specialty);
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
