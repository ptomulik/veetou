CREATE OR REPLACE TYPE BODY V2u_Ko_Ambig_Subject_Map_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Ambig_Subject_Map_V_t(
          SELF IN OUT NOCOPY V2u_Ko_Ambig_Subject_Map_V_t
        , job_uuid IN RAW
        , subject_id IN NUMBER
        , specialty_id IN NUMBER
        , semester_id IN NUMBER
        , map_count IN NUMBER
        , map_ids IN V2u_Ids_t
        , matching_scores IN V2u_Integers_t
        , map_subj_codes IN V2u_Subj_Codes_t
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
        , university IN VARCHAR2
        , faculty IN VARCHAR2
        , studies_modetier IN VARCHAR2
        , studies_field IN VARCHAR2
        , studies_specialty IN VARCHAR2
        , semester_code IN VARCHAR2
        , semester_number IN NUMBER
        , ects_mandatory IN NUMBER
        , ects_other IN NUMBER
        , ects_total IN NUMBER
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.subject_id := subject_id;
        SELF.specialty_id := specialty_id;
        SELF.semester_id := semester_id;
        SELF.map_count := map_count;
        SELF.map_ids := map_ids;
        SELF.matching_scores := matching_scores;
        SELF.map_subj_codes := map_subj_codes;
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
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty;
        SELF.semester_code := semester_code;
        SELF.semester_number := semester_number;
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
        RETURN;
    END;


    CONSTRUCTOR FUNCTION V2u_Ko_Ambig_Subject_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Ambig_Subject_Map_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , map_count IN NUMBER
            , map_ids IN V2u_Ids_t
            , matching_scores IN V2u_Integers_t
            , map_subj_codes IN V2u_Subj_Codes_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := subject.job_uuid;
        SELF.subject_id := subject.id;
        SELF.specialty_id := specialty.id;
        SELF.semester_id := semester.id;
        SELF.map_count := map_count;
        SELF.map_ids := map_ids;
        SELF.matching_scores := matching_scores;
        SELF.map_subj_codes := map_subj_codes;
        SELF.subj_code := subject.subj_code;
        SELF.subj_name := subject.subj_name;
        SELF.subj_hours_w := subject.subj_hours_w;
        SELF.subj_hours_c := subject.subj_hours_c;
        SELF.subj_hours_l := subject.subj_hours_l;
        SELF.subj_hours_p := subject.subj_hours_p;
        SELF.subj_hours_s := subject.subj_hours_s;
        SELF.subj_credit_kind := subject.subj_credit_kind;
        SELF.subj_ects := subject.subj_ects;
        SELF.subj_tutor := subject.subj_tutor;
        SELF.university := specialty.university;
        SELF.faculty := specialty.faculty;
        SELF.studies_modetier := specialty.studies_modetier;
        SELF.studies_field := specialty.studies_field;
        SELF.studies_specialty := specialty.studies_specialty;
        SELF.semester_code := semester.semester_code;
        SELF.semester_number := semester.semester_number;
        SELF.ects_mandatory := semester.ects_mandatory;
        SELF.ects_other := semester.ects_other;
        SELF.ects_total := semester.ects_total;
        RETURN;
    END;


--    ORDER MEMBER FUNCTION cmp(other IN V2u_Ko_Ambig_Subject_Map_V_t)
--        RETURN INTEGER
--    IS
--        ord INTEGER;
--    BEGIN
--        ord := V2U_Cmp.StrNI(subj_code, other.subj_code);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(subj_name, other.subj_name);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(subj_hours_w, other.subj_hours_w);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(subj_hours_c, other.subj_hours_c);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(subj_hours_l, other.subj_hours_l);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(subj_hours_p, other.subj_hours_p);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(subj_hours_s, other.subj_hours_s);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(subj_credit_kind, other.subj_credit_kind);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(subj_ects, other.subj_ects);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(subj_tutor, other.subj_tutor);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(university, other.university);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(faculty, other.faculty);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(studies_modetier, other.studies_modetier);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(studies_field, other.studies_field);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(studies_specialty, other.studies_specialty);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(semester_code, other.semester_code);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(semester_number, other.semester_number);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(ects_mandatory, other.ects_mandatory);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(ects_other, other.ects_other);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(ects_total, other.ects_total);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        RETURN V2U_Cmp.RawN(job_uuid, other.job_uuid);
--    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
