CREATE OR REPLACE TYPE BODY V2u_Ko_Subject_Map_V_t AS
--      CONSTRUCTOR FUNCTION V2u_Ko_Subject_Map_V_t(
--              SELF IN OUT NOCOPY V2u_Ko_Subject_Map_V_t
--            , job_uuid IN RAW
--            , subject_id IN NUMBER
--            , specialty_id IN NUMBER
--            , semester_id IN NUMBER
--            , map_id IN NUMBER
--            , matching_score IN NUMBER
--            , highest_score IN NUMBER
--            , selected IN NUMBER
--            , reason IN VARCHAR2
--            , subj_code IN VARCHAR2
--            , map_subj_code IN VARCHAR2
--            , map_subj_lang IN VARCHAR2
--            , subj_name IN VARCHAR2
--            , expr_subj_name IN VARCHAR2
--            , subj_hours_w IN NUMBER
--            , expr_subj_hours_w IN VARCHAR2
--            , subj_hours_c IN NUMBER
--            , expr_subj_hours_c IN VARCHAR2
--            , subj_hours_l IN NUMBER
--            , expr_subj_hours_l IN VARCHAR2
--            , subj_hours_p IN NUMBER
--            , expr_subj_hours_p IN VARCHAR2
--            , subj_hours_s IN NUMBER
--            , expr_subj_hours_s IN VARCHAR2
--            , subj_credit_kind IN VARCHAR2
--            , expr_subj_credit_kind IN VARCHAR2
--            , subj_ects IN NUMBER
--            , expr_subj_ects IN VARCHAR2
--            , subj_tutor IN VARCHAR2
--            , expr_subj_tutor IN VARCHAR2
--            , university IN VARCHAR2
--            , expr_university IN VARCHAR2
--            , faculty IN VARCHAR2
--            , expr_faculty IN VARCHAR2
--            , studies_modetier IN VARCHAR2
--            , expr_studies_modetier IN VARCHAR2
--            , studies_field IN VARCHAR2
--            , expr_studies_field IN VARCHAR2
--            , studies_specialty IN VARCHAR2
--            , expr_studies_specialty IN VARCHAR2
--            , semester_code IN VARCHAR2
--            , expr_semester_code IN VARCHAR2
--            , semester_number IN NUMBER
--            , expr_semester_number IN VARCHAR2
--            , ects_mandatory IN NUMBER
--            , expr_ects_mandatory IN VARCHAR2
--            , ects_other IN NUMBER
--            , expr_ects_other IN VARCHAR2
--            , ects_total IN NUMBER
--            , expr_ects_total IN VARCHAR2
--            ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.job_uuid := job_uuid;
--        SELF.subject_id := subject_id;
--        SELF.specialty_id := specialty_id;
--        SELF.semester_id := semester_id;
--        SELF.map_id := map_id;
--        SELF.matching_score := matching_score;
--        SELF.highest_score := highest_score;
--        SELF.selected := selected;
--        SELF.reason := reason;
--        SELF.subj_code := subj_code;
--        SELF.map_subj_code := map_subj_code;
--        SELF.map_subj_lang := map_subj_lang;
--        SELF.subj_name := subj_name;
--        SELF.expr_subj_name := expr_subj_name;
--        SELF.subj_hours_w := subj_hours_w;
--        SELF.expr_subj_hours_w := expr_subj_hours_w;
--        SELF.subj_hours_c := subj_hours_c;
--        SELF.expr_subj_hours_c := expr_subj_hours_c;
--        SELF.subj_hours_l := subj_hours_l;
--        SELF.expr_subj_hours_l := expr_subj_hours_l;
--        SELF.subj_hours_p := subj_hours_p;
--        SELF.expr_subj_hours_p := expr_subj_hours_p;
--        SELF.subj_hours_s := subj_hours_s;
--        SELF.expr_subj_hours_s := expr_subj_hours_s;
--        SELF.subj_credit_kind := subj_credit_kind;
--        SELF.expr_subj_credit_kind := expr_subj_credit_kind;
--        SELF.subj_ects := subj_ects;
--        SELF.expr_subj_ects := expr_subj_ects;
--        SELF.subj_tutor := subj_tutor;
--        SELF.expr_subj_tutor := expr_subj_tutor;
--        SELF.university := university;
--        SELF.expr_university := expr_university;
--        SELF.faculty := faculty;
--        SELF.expr_faculty := expr_faculty;
--        SELF.studies_modetier := studies_modetier;
--        SELF.expr_studies_modetier := expr_studies_modetier;
--        SELF.studies_field := studies_field;
--        SELF.expr_studies_field := expr_studies_field;
--        SELF.studies_specialty := studies_specialty;
--        SELF.expr_studies_specialty := expr_studies_specialty;
--        SELF.semester_code := semester_code;
--        SELF.expr_semester_code := expr_semester_code;
--        SELF.semester_number := semester_number;
--        SELF.expr_semester_number := expr_semester_number;
--        SELF.ects_mandatory := ects_mandatory;
--        SELF.expr_ects_mandatory := expr_ects_mandatory;
--        SELF.ects_other := ects_other;
--        SELF.expr_ects_other := expr_ects_other;
--        SELF.ects_total := ects_total;
--        SELF.expr_ects_total := expr_ects_total;
--        RETURN;
--    END;


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
        SELF.map_subj_code := map.map_subj_code;
        SELF.map_subj_lang := map.map_subj_lang;
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

-- vim: set ft=sql ts=4 sw=4 et:
