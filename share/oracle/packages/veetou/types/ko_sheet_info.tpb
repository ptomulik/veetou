CREATE OR REPLACE TYPE BODY V2u_Ko_Sheet_Info_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Sheet_Info_t(
          SELF IN OUT NOCOPY V2u_Ko_Sheet_Info_t
        , university IN VARCHAR := NULL
        , faculty IN VARCHAR := NULL
        , studies_modetier IN VARCHAR := NULL
        , student_index IN VARCHAR := NULL
        , first_name IN VARCHAR := NULL
        , last_name IN VARCHAR := NULL
        , student_name IN VARCHAR := NULL
        , semester_code IN VARCHAR := NULL
        , studies_field IN VARCHAR := NULL
        , semester_number IN NUMBER := NULL
        , studies_specialty IN VARCHAR := NULL
        , ects_mandatory IN NUMBER := NULL
        , ects_other IN NUMBER := NULL
        , ects_total IN NUMBER := NULL
        , ects_attained IN NUMBER := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.student_index := student_index;
        SELF.first_name := first_name;
        SELF.last_name := last_name;
        SELF.student_name := student_name;
        SELF.semester_code := semester_code;
        SELF.studies_field := studies_field;
        SELF.semester_number := semester_number;
        SELF.studies_specialty := studies_specialty;
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
        SELF.ects_attained := ects_attained;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Sheet_Info_t(
              SELF IN OUT NOCOPY V2u_Ko_Sheet_Info_t
            , header IN V2u_Ko_Header_t
            , preamble IN V2u_Ko_Preamble_t
            , sheet IN V2u_Ko_Sheet_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.university := header.university;
        SELF.faculty := header.faculty;
        SELF.studies_modetier := preamble.studies_modetier;
        SELF.student_index := preamble.student_index;
        SELF.first_name := preamble.first_name;
        SELF.last_name := preamble.last_name;
        SELF.student_name := preamble.student_name;
        SELF.semester_code := preamble.semester_code;
        SELF.studies_field := preamble.studies_field;
        SELF.semester_number := preamble.semester_number;
        SELF.studies_specialty := preamble.studies_specialty;
        SELF.ects_mandatory := sheet.ects_mandatory;
        SELF.ects_other := sheet.ects_other;
        SELF.ects_total := sheet.ects_total;
        SELF.ects_attained := sheet.ects_attained;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_with(
                other IN V2u_Ko_Sheet_Info_t
            ) RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Util.StrNullIcmp(student_index, other.student_index);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(first_name, other.first_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(last_name, other.last_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(student_name, other.student_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(university, other.university);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(faculty, other.faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(studies_modetier, other.studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(studies_field, other.studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(studies_specialty, other.studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullcmp(semester_number, other.semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(semester_code, other.semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(ects_mandatory, other.ects_mandatory);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(ects_other, other.ects_other);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(ects_total, other.ects_total);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Util.NumNullCmp(ects_attained, other.ects_attained);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
