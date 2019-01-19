CREATE OR REPLACE TYPE Veetou_Ko_Subject_Instance_Typ FORCE AUTHID CURRENT_USER AS OBJECT
    ( subj_code VARCHAR2(32 CHAR)
    , subj_name VARCHAR2(256 CHAR)
    , university VARCHAR2(256 CHAR)
    , faculty VARCHAR2(256 CHAR)
    , studies_modetier VARCHAR2(256 CHAR)
    , studies_field VARCHAR2(256 CHAR)
    , studies_specialty VARCHAR2(256 CHAR)
    , semester_code VARCHAR2(32 CHAR)
    , subj_hours_w NUMBER(8)
    , subj_hours_c NUMBER(8)
    , subj_hours_l NUMBER(8)
    , subj_hours_p NUMBER(8)
    , subj_hours_s NUMBER(8)
    , subj_credit_kind VARCHAR2(16 CHAR)
    , subj_ects NUMBER(4)
    , subj_tutor VARCHAR2(256 CHAR)

    , CONSTRUCTOR FUNCTION Veetou_Ko_Subject_Instance_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Subject_Instance_Typ
            , subj_code IN VARCHAR2 := NULL
            , subj_name IN VARCHAR2 := NULL
            , university IN VARCHAR2 := NULL
            , faculty IN VARCHAR2 := NULL
            , studies_modetier IN VARCHAR2 := NULL
            , studies_field IN VARCHAR2 := NULL
            , studies_specialty IN VARCHAR2 := NULL
            , semester_code IN VARCHAR2 := NULL
            , subj_hours_w IN NUMBER := NULL
            , subj_hours_c IN NUMBER := NULL
            , subj_hours_l IN NUMBER := NULL
            , subj_hours_p IN NUMBER := NULL
            , subj_hours_s IN NUMBER := NULL
            , subj_credit_kind IN VARCHAR2 := NULL
            , subj_ects IN NUMBER := NULL
            , subj_tutor IN VARCHAR2 := NULL
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION Veetou_Ko_Subject_Instance_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Subject_Instance_Typ
            , refined IN Veetou_Ko_Refined_Typ
            ) RETURN SELF AS RESULT

    , ORDER MEMBER FUNCTION ord_all_attr (
              other Veetou_Ko_Subject_Instance_Typ
            ) RETURN NUMBER
    );
/
CREATE OR REPLACE TYPE BODY Veetou_Ko_Subject_Instance_Typ AS
    CONSTRUCTOR FUNCTION Veetou_Ko_Subject_Instance_Typ(
          SELF IN OUT NOCOPY Veetou_Ko_Subject_Instance_Typ
        , subj_code IN VARCHAR2 := NULL
        , subj_name IN VARCHAR2 := NULL
        , university IN VARCHAR2 := NULL
        , faculty IN VARCHAR2 := NULL
        , studies_modetier IN VARCHAR2 := NULL
        , studies_field IN VARCHAR2 := NULL
        , studies_specialty IN VARCHAR2 := NULL
        , semester_code IN VARCHAR2 := NULL
        , subj_hours_w IN NUMBER := NULL
        , subj_hours_c IN NUMBER := NULL
        , subj_hours_l IN NUMBER := NULL
        , subj_hours_p IN NUMBER := NULL
        , subj_hours_s IN NUMBER := NULL
        , subj_credit_kind IN VARCHAR2 := NULL
        , subj_ects IN NUMBER := NULL
        , subj_tutor IN VARCHAR2 := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.subj_code := subj_code;
        SELF.subj_name := subj_name;
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty;
        SELF.semester_code := semester_code;
        SELF.subj_hours_w := subj_hours_w;
        SELF.subj_hours_c := subj_hours_c;
        SELF.subj_hours_l := subj_hours_l;
        SELF.subj_hours_p := subj_hours_p;
        SELF.subj_hours_s := subj_hours_s;
        SELF.subj_credit_kind := subj_credit_kind;
        SELF.subj_ects := subj_ects;
        SELF.subj_tutor := subj_tutor;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION Veetou_Ko_Subject_Instance_Typ(
              SELF IN OUT NOCOPY Veetou_Ko_Subject_Instance_Typ
            , refined IN Veetou_Ko_Refined_Typ
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.subj_code := refined.subj_code;
        SELF.subj_name := refined.subj_name;
        SELF.university := refined.university;
        SELF.faculty := refined.faculty;
        SELF.studies_modetier := refined.studies_modetier;
        SELF.studies_field := refined.studies_field;
        SELF.studies_specialty := refined.studies_specialty;
        SELF.semester_code := refined.semester_code;
        SELF.subj_hours_w := refined.subj_hours_w;
        SELF.subj_hours_c := refined.subj_hours_c;
        SELF.subj_hours_l := refined.subj_hours_l;
        SELF.subj_hours_p := refined.subj_hours_p;
        SELF.subj_hours_s := refined.subj_hours_s;
        SELF.subj_credit_kind := refined.subj_credit_kind;
        SELF.subj_ects := refined.subj_ects;
        SELF.subj_tutor := refined.subj_tutor;
        RETURN;
    END;

    ORDER MEMBER FUNCTION ord_all_attr(
              other Veetou_Ko_Subject_Instance_Typ
            ) RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := VEETOU_Util.StrNullIcmp(subj_code, other.subj_code);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        ord := VEETOU_Util.StrNullIcmp(subj_name, other.subj_name);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
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
        ord := VEETOU_Util.StrNullIcmp(studies_specialty, other.studies_specialty);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        ord := VEETOU_Util.StrNullIcmp(semester_code, other.semester_code);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        ord := VEETOU_Util.NumNullCmp(subj_hours_w, other.subj_hours_w);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        ord := VEETOU_Util.NumNullCmp(subj_hours_c, other.subj_hours_c);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        ord := VEETOU_Util.NumNullCmp(subj_hours_l, other.subj_hours_l);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        ord := VEETOU_Util.NumNullCmp(subj_hours_p, other.subj_hours_p);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        ord := VEETOU_Util.NumNullCmp(subj_hours_s, other.subj_hours_s);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        ord := VEETOU_Util.StrNullIcmp(subj_credit_kind, other.subj_credit_kind);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        ord := VEETOU_Util.NumNullCmp(subj_ects, other.subj_ects);
        IF ord <> 0 THEN
            RETURN ord;
        END IF;
        RETURN VEETOU_Util.StrNullIcmp(subj_tutor, other.subj_tutor);
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
