CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Przedm_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przedm_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przedm_t
            , id IN NUMBER
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , matching_score IN NUMBER
            , prz_kod IN VARCHAR2
            , ko_subj_code IN VARCHAR2
            , ko_subj_name IN VARCHAR2
            , ko_subj_hours_w IN NUMBER
            , ko_subj_hours_c IN NUMBER
            , ko_subj_hours_l IN NUMBER
            , ko_subj_hours_p IN NUMBER
            , ko_subj_hours_s IN NUMBER
            , ko_subj_credit_kind IN VARCHAR2
            , ko_subj_ects IN NUMBER
            , ko_subj_tutor IN VARCHAR2
            , ko_university IN VARCHAR2
            , ko_faculty IN VARCHAR2
            , ko_studies_modetier IN VARCHAR2
            , ko_studies_field IN VARCHAR2
            , ko_studies_specialty IN VARCHAR2
            , ko_semester_code IN VARCHAR2
            , ko_semester_number IN NUMBER
            , ko_ects_mandatory IN NUMBER
            , ko_ects_other IN NUMBER
            , ko_ects_total IN NUMBER
            , dz_nazwa IN VARCHAR2
            , dz_jed_org_kod IN VARCHAR2
            , dz_utw_id IN VARCHAR2
            , dz_utw_data IN DATE
            , dz_mod_id IN VARCHAR2
            , dz_mod_data IN DATE
            , dz_tpro_kod IN VARCHAR2
            , dz_czy_wielokrotne IN NUMBER
            , dz_name IN VARCHAR2
            , dz_skrocony_opis IN VARCHAR2
            , dz_short_description IN VARCHAR2
            , dz_jed_org_kod_biorca IN VARCHAR2
            , dz_jzk_kod IN VARCHAR2
            , dz_kod_sok IN VARCHAR2
            , dz_opis IN CLOB
            , dz_description IN CLOB
            , dz_literatura IN CLOB
            , dz_bibliography IN CLOB
            , dz_efekty_uczenia IN CLOB
            , dz_efekty_uczenia_ang IN CLOB
            , dz_kryteria_oceniania IN CLOB
            , dz_kryteria_oceniania_ang IN CLOB
            , dz_praktyki_zawodowe IN VARCHAR2
            , dz_praktyki_zawodowe_ang IN VARCHAR2
            , dz_url IN VARCHAR2
            , dz_kod_isced IN VARCHAR2
            , dz_nazwa_pol IN VARCHAR2
            , dz_guid IN VARCHAR2
            , dz_pw_nazwa_supl IN VARCHAR2
            , dz_pw_nazwa_supl_ang IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := job_uuid;
        SELF.subject_id := subject_id;
        SELF.specialty_id := specialty_id;
        SELF.semester_id := semester_id;
        SELF.subject_map_id := subject_map_id;
        SELF.matching_score := matching_score;
        SELF.prz_kod := prz_kod;
        SELF.ko_subj_code := ko_subj_code;
        SELF.ko_subj_name := ko_subj_name;
        SELF.ko_subj_hours_w := ko_subj_hours_w;
        SELF.ko_subj_hours_c := ko_subj_hours_c;
        SELF.ko_subj_hours_l := ko_subj_hours_l;
        SELF.ko_subj_hours_p := ko_subj_hours_p;
        SELF.ko_subj_hours_s := ko_subj_hours_s;
        SELF.ko_subj_credit_kind := ko_subj_credit_kind;
        SELF.ko_subj_ects := ko_subj_ects;
        SELF.ko_subj_tutor := ko_subj_tutor;
        SELF.ko_university := ko_university;
        SELF.ko_faculty := ko_faculty;
        SELF.ko_studies_modetier := ko_studies_modetier;
        SELF.ko_studies_field := ko_studies_field;
        SELF.ko_studies_specialty := ko_studies_specialty;
        SELF.ko_semester_code := ko_semester_code;
        SELF.ko_semester_number := ko_semester_number;
        SELF.ko_ects_mandatory := ko_ects_mandatory;
        SELF.ko_ects_other := ko_ects_other;
        SELF.ko_ects_total := ko_ects_total;
        SELF.dz_nazwa := dz_nazwa;
        SELF.dz_jed_org_kod := dz_jed_org_kod;
        SELF.dz_utw_id := dz_utw_id;
        SELF.dz_utw_data := dz_utw_data;
        SELF.dz_mod_id := dz_mod_id;
        SELF.dz_mod_data := dz_mod_data;
        SELF.dz_tpro_kod := dz_tpro_kod;
        SELF.dz_czy_wielokrotne := dz_czy_wielokrotne;
        SELF.dz_name := dz_name;
        SELF.dz_skrocony_opis := dz_skrocony_opis;
        SELF.dz_short_description := dz_short_description;
        SELF.dz_jed_org_kod_biorca := dz_jed_org_kod_biorca;
        SELF.dz_jzk_kod := dz_jzk_kod;
        SELF.dz_kod_sok := dz_kod_sok;
        SELF.dz_opis := dz_opis;
        SELF.dz_description := dz_description;
        SELF.dz_literatura := dz_literatura;
        SELF.dz_bibliography := dz_bibliography;
        SELF.dz_efekty_uczenia := dz_efekty_uczenia;
        SELF.dz_efekty_uczenia_ang := dz_efekty_uczenia_ang;
        SELF.dz_kryteria_oceniania := dz_kryteria_oceniania;
        SELF.dz_kryteria_oceniania_ang := dz_kryteria_oceniania_ang;
        SELF.dz_praktyki_zawodowe := dz_praktyki_zawodowe;
        SELF.dz_praktyki_zawodowe_ang := dz_praktyki_zawodowe_ang;
        SELF.dz_url := dz_url;
        SELF.dz_kod_isced := dz_kod_isced;
        SELF.dz_nazwa_pol := dz_nazwa_pol;
        SELF.dz_guid := dz_guid;
        SELF.dz_pw_nazwa_supl := dz_pw_nazwa_supl;
        SELF.dz_pw_nazwa_supl_ang := dz_pw_nazwa_supl_ang;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przedm_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przedm_t
            , id IN NUMBER
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map IN V2u_Subject_Map_t
            , przedmiot IN V2u_Dz_Przedmiot_t
            , matching_score IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := subject.job_uuid;
        SELF.subject_id := subject.id;
        SELF.specialty_id := specialty.id;
        SELF.semester_id := semester.id;
        SELF.subject_map_id := subject_map.id;
        SELF.matching_score := matching_score;
        SELF.prz_kod := przedmiot.kod;
        SELF.ko_subj_code := subject.subj_code;
        SELF.ko_subj_name := subject.subj_name;
        SELF.ko_subj_hours_w := subject.subj_hours_w;
        SELF.ko_subj_hours_c := subject.subj_hours_c;
        SELF.ko_subj_hours_l := subject.subj_hours_l;
        SELF.ko_subj_hours_p := subject.subj_hours_p;
        SELF.ko_subj_hours_s := subject.subj_hours_s;
        SELF.ko_subj_credit_kind := subject.subj_credit_kind;
        SELF.ko_subj_ects := subject.subj_ects;
        SELF.ko_subj_tutor := subject.subj_tutor;
        SELF.ko_university := specialty.university;
        SELF.ko_faculty := specialty.faculty;
        SELF.ko_studies_modetier := specialty.studies_modetier;
        SELF.ko_studies_field := specialty.studies_field;
        SELF.ko_studies_specialty := specialty.studies_specialty;
        SELF.ko_semester_code := semester.semester_code;
        SELF.ko_semester_number := semester.semester_number;
        SELF.ko_ects_mandatory := semester.ects_mandatory;
        SELF.ko_ects_other := semester.ects_other;
        SELF.ko_ects_total := semester.ects_total;
        SELF.dz_nazwa := przedmiot.nazwa;
        SELF.dz_jed_org_kod := przedmiot.jed_org_kod;
        SELF.dz_utw_id := przedmiot.utw_id;
        SELF.dz_utw_data := przedmiot.utw_data;
        SELF.dz_mod_id := przedmiot.mod_id;
        SELF.dz_mod_data := przedmiot.mod_data;
        SELF.dz_tpro_kod := przedmiot.tpro_kod;
        SELF.dz_czy_wielokrotne := przedmiot.czy_wielokrotne;
        SELF.dz_name := przedmiot.name;
        SELF.dz_skrocony_opis := przedmiot.skrocony_opis;
        SELF.dz_short_description := przedmiot.short_description;
        SELF.dz_jed_org_kod_biorca := przedmiot.jed_org_kod_biorca;
        SELF.dz_jzk_kod := przedmiot.jzk_kod;
        SELF.dz_kod_sok := przedmiot.kod_sok;
        SELF.dz_opis := przedmiot.opis;
        SELF.dz_description := przedmiot.description;
        SELF.dz_literatura := przedmiot.literatura;
        SELF.dz_bibliography := przedmiot.bibliography;
        SELF.dz_efekty_uczenia := przedmiot.efekty_uczenia;
        SELF.dz_efekty_uczenia_ang := przedmiot.efekty_uczenia_ang;
        SELF.dz_kryteria_oceniania := przedmiot.kryteria_oceniania;
        SELF.dz_kryteria_oceniania_ang := przedmiot.kryteria_oceniania_ang;
        SELF.dz_praktyki_zawodowe := przedmiot.praktyki_zawodowe;
        SELF.dz_praktyki_zawodowe_ang := przedmiot.praktyki_zawodowe_ang;
        SELF.dz_url := przedmiot.url;
        SELF.dz_kod_isced := przedmiot.kod_isced;
        SELF.dz_nazwa_pol := przedmiot.nazwa_pol;
        SELF.dz_guid := przedmiot.guid;
        SELF.dz_pw_nazwa_supl := przedmiot.pw_nazwa_supl;
        SELF.dz_pw_nazwa_supl_ang := przedmiot.pw_nazwa_supl_ang;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
