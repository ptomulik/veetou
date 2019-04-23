CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Ocena_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Ocena_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Ocena_V_t
            , matched_ocena_j IN V2u_Ko_Matched_Ocena_J_t
            , student IN V2u_Ko_Student_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := matched_ocena_j.job_uuid;
        SELF.student_id := matched_ocena_j.student_id;
        SELF.subject_id := matched_ocena_j.subject_id;
        SELF.specialty_id := matched_ocena_j.specialty_id;
        SELF.semester_id := matched_ocena_j.semester_id;
        SELF.classes_type := matched_ocena_j.classes_type;
        SELF.student_index := student.student_index;
        SELF.student_name := student.student_name;
        SELF.first_name := student.first_name;
        SELF.last_name := student.last_name;
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
        SELF.subj_grade := matched_ocena_j.subj_grade;
        SELF.subj_grade_date := matched_ocena_j.subj_grade_date;
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
--        SELF.tr_id := matched_ocena_j.tr_id;
--        SELF.ocena_opis := matched_ocena_j.ocena_opis;
--        SELF.toc_kod := matched_ocena_j.toc_kod;
        SELF.os_id := matched_ocena_j.os_id;
        SELF.prot_id := matched_ocena_j.prot_id;
        SELF.term_prot_nr := matched_ocena_j.term_prot_nr;
        SELF.ocena_missmatch := matched_ocena_j.ocena_missmatch;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
