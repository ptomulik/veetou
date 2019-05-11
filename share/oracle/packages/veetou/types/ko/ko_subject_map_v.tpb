CREATE OR REPLACE TYPE BODY V2u_Ko_Subject_Map_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Subject_Map_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Subject_Map_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , map IN V2u_Subject_Map_t
            , matching_score IN NUMBER
            , highest_score IN NUMBER
            , selected IN NUMBER
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := subject.job_uuid;
        SELF.subject_id := subject.id;
        SELF.specialty_id := specialty.id;
        SELF.semester_id := semester.id;
        SELF.map_id := map.id;
        SELF.matching_score := matching_score;
        SELF.highest_score := highest_score;
        SELF.selected := selected;
        SELF.reason := reason;
        SELF.subj_code := subject.subj_code;
        SELF.usr_subj_name := map.usr_subj_name;
        SELF.map_subj_code := map.map_subj_code;
        SELF.map_subj_name := map.map_subj_name;
        SELF.map_subj_lang := map.map_subj_lang;
        SELF.map_subj_ects := map.map_subj_ects;
        SELF.map_org_unit := map.map_org_unit;
        SELF.map_org_unit_recipient := map.map_org_unit_recipient;
        SELF.map_proto_type := map.map_proto_type;
        SELF.map_grade_type := map.map_grade_type;
        SELF.subj_name := subject.subj_name;
        SELF.expr_subj_name := map.expr_subj_name;
        SELF.subj_hours_w := subject.subj_hours_w;
        SELF.expr_subj_hours_w := map.expr_subj_hours_w;
        SELF.subj_hours_c := subject.subj_hours_c;
        SELF.expr_subj_hours_c := map.expr_subj_hours_c;
        SELF.subj_hours_l := subject.subj_hours_l;
        SELF.expr_subj_hours_l := map.expr_subj_hours_l;
        SELF.subj_hours_p := subject.subj_hours_p;
        SELF.expr_subj_hours_p := map.expr_subj_hours_p;
        SELF.subj_hours_s := subject.subj_hours_s;
        SELF.expr_subj_hours_s := map.expr_subj_hours_s;
        SELF.subj_credit_kind := subject.subj_credit_kind;
        SELF.expr_subj_credit_kind := map.expr_subj_credit_kind;
        SELF.subj_ects := subject.subj_ects;
        SELF.expr_subj_ects := map.expr_subj_ects;
        SELF.subj_tutor := subject.subj_tutor;
        SELF.expr_subj_tutor := map.expr_subj_tutor;
        SELF.university := specialty.university;
        SELF.expr_university := map.expr_university;
        SELF.faculty := specialty.faculty;
        SELF.expr_faculty := map.expr_faculty;
        SELF.studies_modetier := specialty.studies_modetier;
        SELF.expr_studies_modetier := map.expr_studies_modetier;
        SELF.studies_field := specialty.studies_field;
        SELF.expr_studies_field := map.expr_studies_field;
        SELF.studies_specialty := specialty.studies_specialty;
        SELF.expr_studies_specialty := map.expr_studies_specialty;
        SELF.semester_code := semester.semester_code;
        SELF.expr_semester_code := map.expr_semester_code;
        SELF.semester_number := semester.semester_number;
        SELF.expr_semester_number := map.expr_semester_number;
        SELF.ects_mandatory := semester.ects_mandatory;
        SELF.expr_ects_mandatory := map.expr_ects_mandatory;
        SELF.ects_other := semester.ects_other;
        SELF.expr_ects_other := map.expr_ects_other;
        SELF.ects_total := semester.ects_total;
        SELF.expr_ects_total := map.expr_ects_total;
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
