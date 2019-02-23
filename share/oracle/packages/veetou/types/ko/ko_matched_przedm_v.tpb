CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Przedm_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przedm_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przedm_V_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , matching_score IN NUMBER
            , prz_kod IN VARCHAR2
            , subj_code IN VARCHAR2
            , subj_name IN VARCHAR2
            , subj_hours_w IN NUMBER
            , subj_hours_c IN NUMBER
            , subj_hours_l IN NUMBER
            , subj_hours_p IN NUMBER
            , subj_hours_s IN NUMBER
            , subj_credit_kind IN VARCHAR2
            , subj_ects IN NUMBER
            , subj_tutor IN VARCHAR2
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_code IN VARCHAR2
            , semester_number IN NUMBER
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , nazwa IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , czy_wielokrotne IN NUMBER
            , name IN VARCHAR2
            , skrocony_opis IN VARCHAR2
            , short_description IN VARCHAR2
            , jed_org_kod_biorca IN VARCHAR2
            , jzk_kod IN VARCHAR2
            , kod_sok IN VARCHAR2
            , opis IN CLOB
            , description IN CLOB
            , literatura IN CLOB
            , bibliography IN CLOB
            , efekty_uczenia IN CLOB
            , efekty_uczenia_ang IN CLOB
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            , praktyki_zawodowe IN VARCHAR2
            , praktyki_zawodowe_ang IN VARCHAR2
            , url IN VARCHAR2
            , kod_isced IN VARCHAR2
            , nazwa_pol IN VARCHAR2
            , guid IN VARCHAR2
            , pw_nazwa_supl IN VARCHAR2
            , pw_nazwa_supl_ang IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := job_uuid;
        SELF.subject_id := subject_id;
        SELF.specialty_id := specialty_id;
        SELF.semester_id := semester_id;
        SELF.subject_map_id := subject_map_id;
        SELF.matching_score := matching_score;
        SELF.prz_kod := prz_kod;
        SELF.subj_code := subj_code;
        SELF.subj_name := subj_name;
        SELF.subj_hours_w := subj_hours_w;
        SELF.subj_hours_c := subj_hours_c;
        SELF.subj_hours_l := subj_hours_l;
        SELF.subj_hours_p := subj_hours_p;
        SELF.subj_hours_s := subj_hours_s;
        SELF.subj_credit_kind := subj_credit_kind;
        SELF.subj_ects := subj_ects;
        SELF.subj_tutor := subj_tutor;
        SELF.university := university;
        SELF.faculty := faculty;
        SELF.studies_modetier := studies_modetier;
        SELF.studies_field := studies_field;
        SELF.studies_specialty := studies_specialty;
        SELF.semester_code := semester_code;
        SELF.semester_number := semester_number;
        SELF.ects_mandatory := ects_mandatory;
        SELF.ects_other := ects_other;
        SELF.ects_total := ects_total;
        SELF.nazwa := nazwa;
        SELF.jed_org_kod := jed_org_kod;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.tpro_kod := tpro_kod;
        SELF.czy_wielokrotne := czy_wielokrotne;
        SELF.name := name;
        SELF.skrocony_opis := skrocony_opis;
        SELF.short_description := short_description;
        SELF.jed_org_kod_biorca := jed_org_kod_biorca;
        SELF.jzk_kod := jzk_kod;
        SELF.kod_sok := kod_sok;
        SELF.opis := opis;
        SELF.description := description;
        SELF.literatura := literatura;
        SELF.bibliography := bibliography;
        SELF.efekty_uczenia := efekty_uczenia;
        SELF.efekty_uczenia_ang := efekty_uczenia_ang;
        SELF.kryteria_oceniania := kryteria_oceniania;
        SELF.kryteria_oceniania_ang := kryteria_oceniania_ang;
        SELF.praktyki_zawodowe := praktyki_zawodowe;
        SELF.praktyki_zawodowe_ang := praktyki_zawodowe_ang;
        SELF.url := url;
        SELF.kod_isced := kod_isced;
        SELF.nazwa_pol := nazwa_pol;
        SELF.guid := guid;
        SELF.pw_nazwa_supl := pw_nazwa_supl;
        SELF.pw_nazwa_supl_ang := pw_nazwa_supl_ang;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przedm_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przedm_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map IN V2u_Subject_Map_t
            , przedmiot IN V2u_Dz_Przedmiot_t
            , matching_score IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.job_uuid := subject.job_uuid;
        SELF.subject_id := subject.id;
        SELF.specialty_id := specialty.id;
        SELF.semester_id := semester.id;
        SELF.subject_map_id := subject_map.id;
        SELF.matching_score := matching_score;
        SELF.prz_kod := przedmiot.kod;
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
