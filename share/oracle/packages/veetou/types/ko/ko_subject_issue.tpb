CREATE OR REPLACE TYPE BODY V2u_Ko_Subject_Issue_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Subject_Issue_t(
          SELF IN OUT NOCOPY V2u_Ko_Subject_Issue_t
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
        , subj_grades IN V2u_Subj_20Grades_t := NULL
        , tr_ids IN V2u_Ids_t := NULL
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
        SELF.subj_grades := subj_grades;
        SELF.tr_ids := tr_ids;
        RETURN;
    END;

    ORDER MEMBER FUNCTION cmp_with(
              other V2u_Ko_Subject_Issue_t
            ) RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Cmp.StrNI(subj_code, other.subj_code);
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
        ord := V2U_Cmp.NumN(subj_ects, other.subj_ects);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(subj_tutor, other.subj_tutor);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(subj_credit_kind, other.subj_credit_kind);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(subj_name, other.subj_name);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_specialty, other.studies_specialty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_field, other.studies_field);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(studies_modetier, other.studies_modetier);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(faculty, other.faculty);
        IF ord <> 0 THEN RETURN ord; END IF;
        ord := V2U_Cmp.StrNI(university, other.university);
        IF ord <> 0 THEN RETURN ord; END IF;
        RETURN V2U_Cmp.RawN(job_uuid, other.job_uuid);
    END;

    MEMBER FUNCTION dup_with(
              new_id IN NUMBER
            , new_subj_grades IN V2u_Subj_20Grades_t := NULL
            , new_tr_ids IN V2u_Ids_t := NULL
            ) RETURN V2u_Ko_Subject_Issue_t
    IS
    BEGIN
        RETURN V2u_Ko_Subject_Issue_t(
              job_uuid => job_uuid
            , id => new_id
            , subj_code => subj_code
            , subj_name => subj_name
            , university => university
            , faculty => faculty
            , studies_modetier => studies_modetier
            , studies_field => studies_field
            , studies_specialty => studies_specialty
            , semester_code => semester_code
            , subj_hours_w => subj_hours_w
            , subj_hours_c => subj_hours_c
            , subj_hours_l => subj_hours_l
            , subj_hours_p => subj_hours_p
            , subj_hours_s => subj_hours_s
            , subj_credit_kind => subj_credit_kind
            , subj_ects => subj_ects
            , subj_tutor => subj_tutor
            , subj_grades => new_subj_grades
            , tr_ids => new_tr_ids
            );
    END;

    MEMBER FUNCTION dup_with(
              new_id_seq IN VARCHAR2
            , new_subj_grades IN V2u_Subj_20Grades_t := NULL
            , new_tr_ids IN V2u_Ids_t := NULL
            ) RETURN V2u_Ko_Subject_Issue_t
    IS
    BEGIN
        RETURN dup_with( V2U_Util.Next_Val(new_id_seq)
                       , new_subj_grades, new_tr_ids);
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
