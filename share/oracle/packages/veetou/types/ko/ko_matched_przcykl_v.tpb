CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Przcykl_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przcykl_V_t
            , matched_przcykl_j IN V2u_Ko_Matched_Przcykl_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , przedmiot_cyklu IN V2u_Dz_Przedmiot_Cyklu_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := matched_przcykl_j.job_uuid;
        SELF.subject_id := matched_przcykl_j.subject_id;
        SELF.specialty_id := matched_przcykl_j.specialty_id;
        SELF.semester_id := matched_przcykl_j.semester_id;
        SELF.subject_map_id := matched_przcykl_j.subject_map_id;
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
        SELF.prz_kod := przedmiot_cyklu.prz_kod;
        SELF.cdyd_kod := przedmiot_cyklu.cdyd_kod;
        SELF.utw_id := przedmiot_cyklu.utw_id;
        SELF.utw_data := przedmiot_cyklu.utw_data;
        SELF.mod_id := przedmiot_cyklu.mod_id;
        SELF.mod_data := przedmiot_cyklu.mod_data;
        SELF.tpro_kod := przedmiot_cyklu.tpro_kod;
        SELF.uczestnicy := przedmiot_cyklu.uczestnicy;
        SELF.url := przedmiot_cyklu.url;
        SELF.uwagi := przedmiot_cyklu.uwagi;
        SELF.notes := przedmiot_cyklu.notes;
        SELF.literatura := przedmiot_cyklu.literatura;
        SELF.literatura_ang := przedmiot_cyklu.literatura_ang;
        SELF.opis := przedmiot_cyklu.opis;
        SELF.opis_ang := przedmiot_cyklu.opis_ang;
        SELF.skrocony_opis := przedmiot_cyklu.skrocony_opis;
        SELF.skrocony_opis_ang := przedmiot_cyklu.skrocony_opis_ang;
        SELF.status_sylabusu := przedmiot_cyklu.status_sylabusu;
        SELF.guid := przedmiot_cyklu.guid;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
