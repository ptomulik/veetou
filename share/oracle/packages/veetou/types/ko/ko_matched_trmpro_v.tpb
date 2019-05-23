CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Trmpro_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Trmpro_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Trmpro_V_t
            , matched_trmpro_j IN V2u_Ko_Matched_Trmpro_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , termin_protokolu IN V2u_Dz_Termin_Protokolu_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := matched_trmpro_j.job_uuid;
        SELF.classes_type := matched_trmpro_j.classes_type;
        SELF.subj_grade_date := matched_trmpro_j.subj_grade_date;
        SELF.subject_id := matched_trmpro_j.subject_id;
        SELF.specialty_id := matched_trmpro_j.specialty_id;
        SELF.semester_id := matched_trmpro_j.semester_id;
        SELF.subject_map_id := matched_trmpro_j.subject_map_id;
        SELF.classes_map_id := matched_trmpro_j.classes_map_id;
        -- KO
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
        -- DZ
        SELF.prot_id := termin_protokolu.prot_id;
        SELF.nr := termin_protokolu.nr;
        SELF.status := termin_protokolu.status;
        SELF.utw_id := termin_protokolu.utw_id;
        SELF.utw_data := termin_protokolu.utw_data;
        SELF.opis := termin_protokolu.opis;
        SELF.data_zwrotu := termin_protokolu.data_zwrotu;
        SELF.mod_id := termin_protokolu.mod_id;
        SELF.mod_data := termin_protokolu.mod_data;
        SELF.egzamin_komisyjny := termin_protokolu.egzamin_komisyjny;
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
