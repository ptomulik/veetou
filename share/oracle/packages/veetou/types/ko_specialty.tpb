CREATE OR REPLACE TYPE BODY Veetou_Ko_Specialty_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Specialty_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Specialty_Typ
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

    CONSTRUCTOR FUNCTION Veetou_Ko_Specialty_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Specialty_Typ
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


    CONSTRUCTOR FUNCTION Veetou_Ko_Specialty_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Specialty_Typ
            , header IN Veetou_Ko_Header_Typ
            , preamble IN Veetou_Ko_Preamble_Typ
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.university := header.university;
        SELF.faculty := header.faculty;
        SELF.studies_modetier := preamble.studies_modetier;
        SELF.studies_field := preamble.studies_field;
        SELF.studies_specialty := preamble.studies_specialty;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_with(other IN Veetou_Ko_Specialty_Typ)
        RETURN INTEGER
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
