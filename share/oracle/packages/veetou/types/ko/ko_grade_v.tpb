CREATE OR REPLACE TYPE BODY V2u_Ko_Grade_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Grade_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Grade_V_t
            , grade_j IN V2u_Ko_Grade_J_t
            , student IN V2u_Ko_Student_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := grade_j.job_uuid;
        SELF.student_id := grade_j.student_id;
        SELF.subject_id := grade_j.subject_id;
        SELF.specialty_id := grade_j.specialty_id;
        SELF.semester_id := grade_j.semester_id;
        SELF.classes_type := grade_j.classes_type;
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
        SELF.subj_grade := grade_j.subj_grade;
        SELF.subj_grade_date := grade_j.subj_grade_date;
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
        SELF.tr_id := grade_j.tr_id;
        SELF.opis := grade_j.opis;
        SELF.toc_kod := grade_j.toc_kod;
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
