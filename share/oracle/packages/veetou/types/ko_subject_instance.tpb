CREATE OR REPLACE TYPE BODY V2u_Ko_Subject_Instance_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Subject_Instance_t(
          SELF IN OUT NOCOPY V2u_Ko_Subject_Instance_t
        , job_uuid IN RAW
        , id IN NUMBER
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
        SELF.job_uuid := job_uuid;
        SELF.id := id;
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

    CONSTRUCTOR FUNCTION V2u_Ko_Subject_Instance_t(
              SELF IN OUT NOCOPY V2u_Ko_Subject_Instance_t
            , job_uuid IN RAW
            , id IN NUMBER
            , header IN V2u_Ko_Header_t
            , preamble IN V2u_Ko_Preamble_t
            , tr IN V2u_Ko_Tr_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.id := id;
        --
        SELF.university := header.university;
        SELF.faculty := header.faculty;
        --
        SELF.studies_modetier := preamble.studies_modetier;
        SELF.studies_field := preamble.studies_field;
        SELF.studies_specialty := preamble.studies_specialty;
        SELF.semester_code := preamble.semester_code;
        --
        SELF.subj_code := tr.subj_code;
        SELF.subj_name := tr.subj_name;
        SELF.subj_hours_w := tr.subj_hours_w;
        SELF.subj_hours_c := tr.subj_hours_c;
        SELF.subj_hours_l := tr.subj_hours_l;
        SELF.subj_hours_p := tr.subj_hours_p;
        SELF.subj_hours_s := tr.subj_hours_s;
        SELF.subj_credit_kind := tr.subj_credit_kind;
        SELF.subj_ects := tr.subj_ects;
        SELF.subj_tutor := tr.subj_tutor;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_with(
              other V2u_Ko_Subject_Instance_t
            ) RETURN NUMBER
    IS
        ord NUMBER;
    BEGIN
        ord := V2u_Util.RawNullCmp(job_uuid, other.job_uuid);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(subj_code, other.subj_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(subj_name, other.subj_name);
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
        ord := V2U_Util.StrNullIcmp(semester_code, other.semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(subj_hours_w, other.subj_hours_w);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(subj_hours_c, other.subj_hours_c);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(subj_hours_l, other.subj_hours_l);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(subj_hours_p, other.subj_hours_p);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(subj_hours_s, other.subj_hours_s);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.StrNullIcmp(subj_credit_kind, other.subj_credit_kind);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Util.NumNullCmp(subj_ects, other.subj_ects);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Util.StrNullIcmp(subj_tutor, other.subj_tutor);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
