CREATE OR REPLACE TYPE Veetou_Ko_Specialty_Typ
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( university VARCHAR2(256 CHAR)
    , faculty VARCHAR2(256 CHAR)
    , studies_modetier VARCHAR2(256 CHAR)
    , studies_field VARCHAR2(256 CHAR)
    , studies_specialty VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Specialty_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Specialty_Typ
            , university IN VARCHAR2 := NULL
            , faculty IN VARCHAR2 := NULL
            , studies_modetier IN VARCHAR2 := NULL
            , studies_field IN VARCHAR2 := NULL
            , studies_specialty IN VARCHAR2 := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION Veetou_Ko_Specialty_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Specialty_Typ
            , subject IN Veetou_Ko_Subject_Instance_Typ
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION Veetou_Ko_Specialty_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Specialty_Typ
            , header IN Veetou_Ko_Header_Typ
            , preamble IN Veetou_Ko_Preamble_Typ
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Specialty_Typ)
            RETURN INTEGER
    )  NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
