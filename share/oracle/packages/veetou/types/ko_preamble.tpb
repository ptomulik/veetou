CREATE OR REPLACE TYPE BODY V2u_Ko_Preamble_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Preamble_t(
          SELF IN OUT NOCOPY V2u_Ko_Preamble_t
        , job_uuid IN RAW
        , id IN NUMBER
        , studies_modetier IN VARCHAR := NULL
        , title IN VARCHAR := NULL
        , student_index IN VARCHAR := NULL
        , first_name IN VARCHAR := NULL
        , last_name IN VARCHAR := NULL
        , student_name IN VARCHAR := NULL
        , semester_code IN VARCHAR := NULL
        , studies_field IN VARCHAR := NULL
        , semester_number IN NUMBER := NULL
        , studies_specialty IN VARCHAR := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
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
        ord := V2U_Util.StrNullCmp(student_index, other.student_index);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullCmp(first_name, other.first_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullCmp(last_name, other.last_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullCmp(student_name, other.student_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullCmp(studies_modetier, other.studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullCmp(studies_field, other.studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullCmp(studies_specialty, other.studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullCmp(semester_code, other.semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(semester_number, other.semester_number);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullCmp(title, other.title);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2u_Util.RawNullCmp(job_uuid, other.job_uuid);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
