CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Zajcykl_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Zajcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zajcykl_V_t
            , matched_zajcykl_j IN V2u_Ko_Matched_Zajcykl_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , zajecia_cyklu IN V2u_Dz_Zajecia_Cyklu_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := subject.job_uuid;
        SELF.classes_type := matched_zajcykl_j.classes_type;
        SELF.classes_hours := matched_zajcykl_j.classes_hours;
        SELF.subject_id := matched_zajcykl_j.subject_id;
        SELF.specialty_id := matched_zajcykl_j.specialty_id;
        SELF.semester_id := matched_zajcykl_j.semester_id;
        SELF.subject_map_id := matched_zajcykl_j.subject_map_id;
        SELF.classes_map_id := matched_zajcykl_j.classes_map_id;
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
        SELF.prz_kod := zajecia_cyklu.prz_kod;
        SELF.cdyd_kod := zajecia_cyklu.cdyd_kod;
        SELF.tzaj_kod := zajecia_cyklu.tzaj_kod;
        SELF.liczba_godz := zajecia_cyklu.liczba_godz;
        SELF.limit_miejsc := zajecia_cyklu.limit_miejsc;
        SELF.utw_id := zajecia_cyklu.utw_id;
        SELF.utw_data := zajecia_cyklu.utw_data;
        SELF.mod_id := zajecia_cyklu.mod_id;
        SELF.mod_data := zajecia_cyklu.mod_data;
        SELF.waga_pensum := zajecia_cyklu.waga_pensum;
        SELF.tpro_kod := zajecia_cyklu.tpro_kod;
        SELF.efekty_uczenia := zajecia_cyklu.efekty_uczenia;
        SELF.efekty_uczenia_ang := zajecia_cyklu.efekty_uczenia_ang;
        SELF.kryteria_oceniania := zajecia_cyklu.kryteria_oceniania;
        SELF.kryteria_oceniania_ang := zajecia_cyklu.kryteria_oceniania_ang;
        SELF.url := zajecia_cyklu.url;
        SELF.zakres_tematow := zajecia_cyklu.zakres_tematow;
        SELF.zakres_tematow_ang := zajecia_cyklu.zakres_tematow_ang;
        SELF.metody_dyd := zajecia_cyklu.metody_dyd;
        SELF.metody_dyd_ang := zajecia_cyklu.metody_dyd_ang;
        SELF.literatura := zajecia_cyklu.literatura;
        SELF.literatura_ang := zajecia_cyklu.literatura_ang;
        SELF.czy_pokazywac_termin := zajecia_cyklu.czy_pokazywac_termin;
        RETURN;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
