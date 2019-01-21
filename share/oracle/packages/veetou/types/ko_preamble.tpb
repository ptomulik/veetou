CREATE OR REPLACE TYPE BODY V2u_Ko_Preamble_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Preamble_t(
          SELF IN OUT NOCOPY V2u_Ko_Preamble_t
        , id NUMBER := NULL
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
        SELF.id := id;
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

    ORDER MEMBER FUNCTION cmp_with(other IN V2u_Ko_Preamble_t)
        RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := V2U_Util.StrNullIcmp(student_index, other.student_index);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(first_name, other.first_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(last_name, other.last_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(student_name, other.student_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(studies_modetier, other.studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(studies_field, other.studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(studies_specialty, other.studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(semester_code, other.semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(semester_number, other.semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Util.StrNullIcmp(title, other.title);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
