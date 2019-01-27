CREATE OR REPLACE TYPE BODY V2u_Ko_Mapped_Subject_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Mapped_Subject_t(
          SELF IN OUT NOCOPY V2u_Ko_Mapped_Subject_t
        , job_uuid IN RAW
        , subject_issue_id IN NUMBER
        , subject_map_id IN NUMBER
        , matching_score IN NUMBER
        , subj_code IN VARCHAR2 := NULL
        , mapped_subj_code IN VARCHAR2 := NULL
        , subj_name IN VARCHAR2 := NULL
        , expr_subj_name IN VARCHAR2 := NULL
        , university IN VARCHAR2 := NULL
        , expr_university IN VARCHAR2 := NULL
        , faculty IN VARCHAR2 := NULL
        , expr_faculty IN VARCHAR2 := NULL
        , studies_modetier IN VARCHAR2 := NULL
        , expr_studies_modetier IN VARCHAR2 := NULL
        , studies_field IN VARCHAR2 := NULL
        , expr_studies_field IN VARCHAR2 := NULL
        , studies_specialty IN VARCHAR2 := NULL
        , expr_studies_specialty IN VARCHAR2 := NULL
        , semester_code IN VARCHAR2 := NULL
        , expr_semester_code IN VARCHAR2 := NULL
        , subj_hours_w IN NUMBER := NULL
        , expr_subj_hours_w IN VARCHAR2 := NULL
        , subj_hours_c IN NUMBER := NULL
        , expr_subj_hours_c IN VARCHAR2 := NULL
        , subj_hours_l IN NUMBER := NULL
        , expr_subj_hours_l IN VARCHAR2 := NULL
        , subj_hours_p IN NUMBER := NULL
        , expr_subj_hours_p IN VARCHAR2 := NULL
        , subj_hours_s IN NUMBER := NULL
        , expr_subj_hours_s IN VARCHAR2 := NULL
        , subj_credit_kind IN VARCHAR2 := NULL
        , expr_subj_credit_kind IN VARCHAR2 := NULL
        , subj_ects IN NUMBER := NULL
        , expr_subj_ects IN VARCHAR2 := NULL
        , subj_tutor IN VARCHAR2 := NULL
        , expr_subj_tutor IN VARCHAR2 := NULL
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.subject_issue_id := subject_issue_id;
        SELF.subject_map_id := subject_map_id;
        SELF.matching_score := matching_score;
        SELF.subj_code := subj_code;
        SELF.mapped_subj_code := mapped_subj_code;
        SELF.subj_name := subj_name;
        SELF.expr_subj_name := expr_subj_name;
        SELF.university := university;
        SELF.expr_university := expr_university;
        SELF.faculty := faculty;
        SELF.expr_faculty := expr_faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.expr_studies_modetier := expr_studies_modetier;
        SELF.studies_field := studies_field;
        SELF.expr_studies_field := expr_studies_field;
        SELF.studies_specialty := studies_specialty;
        SELF.expr_studies_specialty := expr_studies_specialty;
        SELF.semester_code := semester_code;
        SELF.expr_semester_code := expr_semester_code;
        SELF.subj_hours_w := subj_hours_w;
        SELF.expr_subj_hours_w := expr_subj_hours_w;
        SELF.subj_hours_c := subj_hours_c;
        SELF.expr_subj_hours_c := expr_subj_hours_c;
        SELF.subj_hours_l := subj_hours_l;
        SELF.expr_subj_hours_l := expr_subj_hours_l;
        SELF.subj_hours_p := subj_hours_p;
        SELF.expr_subj_hours_p := expr_subj_hours_p;
        SELF.subj_hours_s := subj_hours_s;
        SELF.expr_subj_hours_s := expr_subj_hours_s;
        SELF.subj_credit_kind := subj_credit_kind;
        SELF.expr_subj_credit_kind := expr_subj_credit_kind;
        SELF.subj_ects := subj_ects;
        SELF.expr_subj_ects := expr_subj_ects;
        SELF.subj_tutor := subj_tutor;
        SELF.expr_subj_tutor := expr_subj_tutor;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_with(
              other V2u_Ko_Mapped_Subject_t
            ) RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Cmp.StrNI(subj_code, other.subj_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(mapped_subj_code, other.mapped_subj_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(matching_score, other.matching_score);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(subj_name, other.subj_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(university, other.university);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(faculty, other.faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_modetier, other.studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_field, other.studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_specialty, other.studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(semester_code, other.semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(subj_hours_w, other.subj_hours_w);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(subj_hours_c, other.subj_hours_c);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(subj_hours_l, other.subj_hours_l);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(subj_hours_p, other.subj_hours_p);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(subj_hours_s, other.subj_hours_s);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(subj_credit_kind, other.subj_credit_kind);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.NumN(subj_ects, other.subj_ects);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(subj_tutor, other.subj_tutor);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(mapped_subj_code, other.mapped_subj_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_subj_name, other.expr_subj_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_university, other.expr_university);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_faculty, other.expr_faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_studies_modetier, other.expr_studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_studies_field, other.expr_studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_studies_specialty, other.expr_studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_semester_code, other.expr_semester_code);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_subj_hours_w, other.expr_subj_hours_w);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_subj_hours_c, other.expr_subj_hours_c);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_subj_hours_l, other.expr_subj_hours_l);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_subj_hours_p, other.expr_subj_hours_p);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_subj_hours_s, other.expr_subj_hours_s);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_subj_credit_kind, other.expr_subj_credit_kind);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_subj_ects, other.expr_subj_ects);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrN(expr_subj_tutor, other.expr_subj_tutor);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Cmp.RawN(job_uuid, other.job_uuid);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
