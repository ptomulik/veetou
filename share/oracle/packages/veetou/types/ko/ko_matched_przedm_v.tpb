CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Przedm_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przedm_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przedm_V_t
            , matched_przedm_j IN V2u_Ko_Matched_Przedm_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , przedmiot IN V2u_Dz_Przedmiot_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := matched_przedm_j.job_uuid;
        SELF.subject_id := matched_przedm_j.subject_id;
        SELF.specialty_id := matched_przedm_j.specialty_id;
        SELF.semester_id := matched_przedm_j.semester_id;
        SELF.subject_map_id := matched_przedm_j.subject_map_id;
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
        SELF.kod := przedmiot.kod;
        SELF.nazwa := przedmiot.nazwa;
        SELF.jed_org_kod := przedmiot.jed_org_kod;
        SELF.utw_id := przedmiot.utw_id;
        SELF.utw_data := przedmiot.utw_data;
        SELF.mod_id := przedmiot.mod_id;
        SELF.mod_data := przedmiot.mod_data;
        SELF.tpro_kod := przedmiot.tpro_kod;
        SELF.czy_wielokrotne := przedmiot.czy_wielokrotne;
        SELF.name := przedmiot.name;
        SELF.skrocony_opis := przedmiot.skrocony_opis;
        SELF.short_description := przedmiot.short_description;
        SELF.jed_org_kod_biorca := przedmiot.jed_org_kod_biorca;
        SELF.jzk_kod := przedmiot.jzk_kod;
        SELF.kod_sok := przedmiot.kod_sok;
        SELF.opis := przedmiot.opis;
        SELF.description := przedmiot.description;
        SELF.literatura := przedmiot.literatura;
        SELF.bibliography := przedmiot.bibliography;
        SELF.efekty_uczenia := przedmiot.efekty_uczenia;
        SELF.efekty_uczenia_ang := przedmiot.efekty_uczenia_ang;
        SELF.kryteria_oceniania := przedmiot.kryteria_oceniania;
        SELF.kryteria_oceniania_ang := przedmiot.kryteria_oceniania_ang;
        SELF.praktyki_zawodowe := przedmiot.praktyki_zawodowe;
        SELF.praktyki_zawodowe_ang := przedmiot.praktyki_zawodowe_ang;
        SELF.url := przedmiot.url;
        SELF.kod_isced := przedmiot.kod_isced;
        SELF.nazwa_pol := przedmiot.nazwa_pol;
        SELF.guid := przedmiot.guid;
        SELF.pw_nazwa_supl := przedmiot.pw_nazwa_supl;
        SELF.pw_nazwa_supl_ang := przedmiot.pw_nazwa_supl_ang;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
