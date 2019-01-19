CREATE OR REPLACE TYPE Veetou_Ko_Preamble_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( studies_modetier VARCHAR(256 CHAR)
    , title VARCHAR(256 CHAR)
    , student_index VARCHAR(32 CHAR)
    , first_name VARCHAR(48 CHAR)
    , last_name VARCHAR(48 CHAR)
    , student_name VARCHAR(128 CHAR)
    , semester_code VARCHAR(32 CHAR)
    , studies_field VARCHAR(256 CHAR)
    , semester_number NUMBER(2)
    , studies_specialty VARCHAR(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Preamble_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Preamble_Typ
            , studies_modetier VARCHAR := NULL
            , title VARCHAR := NULL
            , student_index VARCHAR := NULL
            , first_name VARCHAR := NULL
            , last_name VARCHAR := NULL
            , student_name VARCHAR := NULL
            , semester_code VARCHAR := NULL
            , studies_field VARCHAR := NULL
            , semester_number NUMBER := NULL
            , studies_specialty VARCHAR := NULL
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_attribs(other IN Veetou_Ko_Preamble_Typ)
        RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Preamble_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Preamble_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Preamble_Typ
        , studies_modetier VARCHAR := NULL
        , title VARCHAR := NULL
        , student_index VARCHAR := NULL
        , first_name VARCHAR := NULL
        , last_name VARCHAR := NULL
        , student_name VARCHAR := NULL
        , semester_code VARCHAR := NULL
        , studies_field VARCHAR := NULL
        , semester_number NUMBER := NULL
        , studies_specialty VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.studies_modetier := studies_modetier;
        SELF.title := title;
        SELF.student_index := student_index;
        SELF.first_name := first_name;
        SELF.last_name := last_name;
        SELF.student_name := student_name;
        SELF.semester_code := semester_code;
        SELF.studies_field := studies_field;
        SELF.semester_number := semester_number;
        SELF.studies_specialty := studies_specialty;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_attribs(other IN Veetou_Ko_Preamble_Typ)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := VEETOU_Util.StrNullIcmp(student_index, other.student_index);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(first_name, other.first_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(last_name, other.last_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(student_name, other.student_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(studies_modetier, other.studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(studies_field, other.studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(studies_specialty, other.studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(semester_code, other.semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.NumNullCmp(semester_number, other.semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN VEETOU_Util.StrNullIcmp(title, other.title);
    END;
END;
/
CREATE OR REPLACE TYPE Veetou_Ko_Preambles_Typ
    AS TABLE OF Veetou_Ko_Preamble_Typ;

-- vim: set ft=sql ts=4 sw=4 et:
