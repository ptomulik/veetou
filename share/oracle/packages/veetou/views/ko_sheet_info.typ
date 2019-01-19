CREATE OR REPLACE TYPE Veetou_Ko_Sheet_Info_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    -- header
    ( university VARCHAR2(256 CHAR)
    , faculty VARCHAR2(256 CHAR)
    -- preamble
    , studies_modetier VARCHAR(256 CHAR)
    , student_index VARCHAR(32 CHAR)
    , first_name VARCHAR(48 CHAR)
    , last_name VARCHAR(48 CHAR)
    , student_name VARCHAR(128 CHAR)
    , semester_code VARCHAR(32 CHAR)
    , studies_field VARCHAR(256 CHAR)
    , semester_number NUMBER(2)
    , studies_specialty VARCHAR(256 CHAR)
    -- sheet
    , ects_mandatory NUMBER(4)
    , ects_other NUMBER(4)
    , ects_total NUMBER(4)
    , ects_attained NUMBER(4)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Sheet_Info_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Sheet_Info_Typ
            , university IN VARCHAR := NULL
            , faculty IN VARCHAR := NULL
            -- preamble
            , studies_modetier IN VARCHAR := NULL
            , student_index IN VARCHAR := NULL
            , first_name IN VARCHAR := NULL
            , last_name IN VARCHAR := NULL
            , student_name IN VARCHAR := NULL
            , semester_code IN VARCHAR := NULL
            , studies_field IN VARCHAR := NULL
            , semester_number IN NUMBER := NULL
            , studies_specialty IN VARCHAR := NULL
            -- sheet
            , ects_mandatory IN NUMBER := NULL
            , ects_other IN NUMBER := NULL
            , ects_total IN NUMBER := NULL
            , ects_attained IN NUMBER := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION Veetou_Ko_Sheet_Info_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Sheet_Info_Typ
            , refined IN Veetou_Ko_Refined_Typ
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION Veetou_Ko_Sheet_Info_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Sheet_Info_Typ
            , header IN Veetou_Ko_Header_Typ
            , preamble IN Veetou_Ko_Preamble_Typ
            , sheet IN Veetou_Ko_Sheet_Typ
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION cmp_attribs(
                other IN Veetou_Ko_Sheet_Info_Typ
            ) RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Sheet_Info_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Sheet_Info_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Sheet_Info_Typ
        , university IN VARCHAR := NULL
        , faculty IN VARCHAR := NULL
        -- preamble
        , studies_modetier IN VARCHAR := NULL
        , student_index IN VARCHAR := NULL
        , first_name IN VARCHAR := NULL
        , last_name IN VARCHAR := NULL
        , student_name IN VARCHAR := NULL
        , semester_code IN VARCHAR := NULL
        , studies_field IN VARCHAR := NULL
        , semester_number IN NUMBER := NULL
        , studies_specialty IN VARCHAR := NULL
        -- sheet
        , ects_mandatory IN NUMBER := NULL
        , ects_other IN NUMBER := NULL
        , ects_total IN NUMBER := NULL
        , ects_attained IN NUMBER := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.university := university;
        SELF.faculty := faculty;
        -- preamble
        SELF.studies_modetier := studies_modetier;
        SELF.student_index := student_index;
        SELF.first_name := first_name;
        SELF.last_name := last_name;
        SELF.student_name := student_name;
        SELF.semester_code := semester_code;
        SELF.studies_field := studies_field;
        SELF.semester_number := semester_number;
        SELF.studies_specialty := studies_specialty;
        -- sheet
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
        SELF.ects_attained := ects_attained;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION Veetou_Ko_Sheet_Info_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Sheet_Info_Typ
            , refined IN Veetou_Ko_Refined_Typ
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.university := refined.university;
        SELF.faculty := refined.faculty;
        -- preamble
        SELF.studies_modetier := refined.studies_modetier;
        SELF.student_index := refined.student_index;
        SELF.first_name := refined.first_name;
        SELF.last_name := refined.last_name;
        SELF.student_name := refined.student_name;
        SELF.semester_code := refined.semester_code;
        SELF.studies_field := refined.studies_field;
        SELF.semester_number := refined.semester_number;
        SELF.studies_specialty := refined.studies_specialty;
        -- sheet
        SELF.ects_mandatory := refined.ects_mandatory;
        SELF.ects_other := refined.ects_other;
        SELF.ects_total := refined.ects_total;
        SELF.ects_attained := refined.ects_attained;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION Veetou_Ko_Sheet_Info_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Sheet_Info_Typ
            , header IN Veetou_Ko_Header_Typ
            , preamble IN Veetou_Ko_Preamble_Typ
            , sheet IN Veetou_Ko_Sheet_Typ
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.university := header.university;
        SELF.faculty := header.faculty;
        -- preamble
        SELF.studies_modetier := preamble.studies_modetier;
        SELF.student_index := preamble.student_index;
        SELF.first_name := preamble.first_name;
        SELF.last_name := preamble.last_name;
        SELF.student_name := preamble.student_name;
        SELF.semester_code := preamble.semester_code;
        SELF.studies_field := preamble.studies_field;
        SELF.semester_number := preamble.semester_number;
        SELF.studies_specialty := preamble.studies_specialty;
        -- sheet
        SELF.ects_mandatory := sheet.ects_mandatory;
        SELF.ects_other := sheet.ects_other;
        SELF.ects_total := sheet.ects_total;
        SELF.ects_attained := sheet.ects_attained;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_attribs(
                other IN Veetou_Ko_Sheet_Info_Typ
            ) RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := VEETOU_Util.StrNullIcmp(student_index, other.student_index);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(first_name, other.first_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(last_name, other.last_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(student_name, other.student_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(university, other.university);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(faculty, other.faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(studies_modetier, other.studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(studies_field, other.studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(studies_specialty, other.studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.NumNullcmp(semester_number, other.semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.StrNullIcmp(semester_code, other.semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.NumNullCmp(ects_mandatory, other.ects_mandatory);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.NumNullCmp(ects_other, other.ects_other);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := VEETOU_Util.NumNullCmp(ects_total, other.ects_total);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN VEETOU_Util.NumNullCmp(ects_attained, other.ects_attained);
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
