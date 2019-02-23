CREATE OR REPLACE TYPE BODY V2u_Ko_Grade_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Grade_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Grade_V_t
            , student IN V2u_Ko_Student_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subj_grade IN VARCHAR2
            , subj_grade_date IN DATE
            , tr_id IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := student.job_uuid;
        SELF.student_id := student.id;
        SELF.subject_id := subject.id;
        SELF.specialty_id := specialty.id;
        SELF.semester_id := semester.id;
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
        SELF.subj_grade := subj_grade;
        SELF.subj_grade_date := subj_grade_date;
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
        SELF.tr_id := tr_id;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
