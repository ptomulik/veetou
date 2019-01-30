CREATE OR REPLACE TYPE BODY V2u_Ko_Subject_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Subject_t(
          SELF IN OUT NOCOPY V2u_Ko_Subject_t
        , id IN NUMBER := NULL
        , job_uuid IN RAW
        , subj_code IN VARCHAR2
        , subj_name IN VARCHAR2
        , subj_hours_w IN NUMBER
        , subj_hours_c IN NUMBER
        , subj_hours_l IN NUMBER
        , subj_hours_p IN NUMBER
        , subj_hours_s IN NUMBER
        , subj_credit_kind IN VARCHAR2
        , subj_ects IN NUMBER
        , subj_tutor IN VARCHAR2
        /* , subj_grades IN V2u_Subj_20Grades_t */
        , tr_ids IN V2u_Ids_t
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := job_uuid;
        SELF.subj_code := subj_code;
        SELF.subj_name := subj_name;
        SELF.subj_hours_w := subj_hours_w;
        SELF.subj_hours_c := subj_hours_c;
        SELF.subj_hours_l := subj_hours_l;
        SELF.subj_hours_p := subj_hours_p;
        SELF.subj_hours_s := subj_hours_s;
        SELF.subj_credit_kind := subj_credit_kind;
        SELF.subj_ects := subj_ects;
        SELF.subj_tutor := subj_tutor;
        /* SELF.subj_grades := subj_grades; */
        SELF.tr_ids := tr_ids;
        RETURN;
    END;

    OVERRIDING MEMBER FUNCTION cmp_val(other IN V2u_Distinct_t)
            RETURN INTEGER
    IS
    BEGIN
        RETURN cmp_val(TREAT(other AS V2u_Ko_Subject_t));
    END;

    MEMBER FUNCTION cmp_val(other IN V2u_Ko_Subject_t)
            RETURN INTEGER
    IS
        ord INTEGER;
    BEGIN
        ord := V2U_Cmp.StrNI(subj_code, other.subj_code);
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
        RETURN V2U_Cmp.StrNI(subj_name, other.subj_name);
    END;

    MEMBER FUNCTION dup(new_tr_ids IN V2u_Ids_t := NULL)
            RETURN V2u_Ko_Subject_t
    IS
    BEGIN
        RETURN V2u_Ko_Subject_t(
              id => id
            , job_uuid => job_uuid
            , subj_code => subj_code
            , subj_name => subj_name
            , subj_hours_w => subj_hours_w
            , subj_hours_c => subj_hours_c
            , subj_hours_l => subj_hours_l
            , subj_hours_p => subj_hours_p
            , subj_hours_s => subj_hours_s
            , subj_credit_kind => subj_credit_kind
            , subj_ects => subj_ects
            , subj_tutor => subj_tutor
            , tr_ids => new_tr_ids
            );
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
