CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Zajcykl_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Zajcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zajcykl_V_t
            , id IN NUMBER
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , subject_matching_score IN NUMBER
            , classes_map_id IN NUMBER
            , classes_matching_score IN NUMBER
            --
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
            --
            , dz_prz_kod IN VARCHAR2
            , dz_cdyd_kod IN VARCHAR2
            , dz_tzaj_kod IN VARCHAR2
            , dz_liczba_godz IN NUMBER
            , dz_limit_miejsc IN NUMBER
            , dz_utw_id IN VARCHAR2
            , dz_utw_data IN DATE
            , dz_mod_id IN VARCHAR2
            , dz_mod_data IN DATE
            , dz_waga_pensum IN NUMBER
            , dz_tpro_kod IN VARCHAR2
            , dz_efekty_uczenia IN CLOB
            , dz_efekty_uczenia_ang IN CLOB
            , dz_kryteria_oceniania IN CLOB
            , dz_kryteria_oceniania_ang IN CLOB
            , dz_url IN VARCHAR2
            , dz_zakres_tematow IN CLOB
            , dz_zakres_tematow_ang IN CLOB
            , dz_metody_dyd IN CLOB
            , dz_metody_dyd_ang IN CLOB
            , dz_literatura IN CLOB
            , dz_literatura_ang IN CLOB
            , dz_czy_pokazywac_termin IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := job_uuid;
        SELF.subject_id := subject_id;
        SELF.specialty_id := specialty_id;
        SELF.semester_id := semester_id;
        SELF.subject_map_id := subject_map_id;
        SELF.subject_matching_score := subject_matching_score;
        SELF.classes_map_id := classes_map_id;
        SELF.classes_matching_score := classes_matching_score;
        --
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
        --
        SELF.dz_prz_kod := dz_prz_kod;
        SELF.dz_cdyd_kod := dz_cdyd_kod;
        SELF.dz_tzaj_kod := dz_tzaj_kod;
        SELF.dz_liczba_godz := dz_liczba_godz;
        SELF.dz_limit_miejsc := dz_limit_miejsc;
        SELF.dz_utw_id := dz_utw_id;
        SELF.dz_utw_data := dz_utw_data;
        SELF.dz_mod_id := dz_mod_id;
        SELF.dz_mod_data := dz_mod_data;
        SELF.dz_waga_pensum := dz_waga_pensum;
        SELF.dz_tpro_kod := dz_tpro_kod;
        SELF.dz_efekty_uczenia := dz_efekty_uczenia;
        SELF.dz_efekty_uczenia_ang := dz_efekty_uczenia_ang;
        SELF.dz_kryteria_oceniania := dz_kryteria_oceniania;
        SELF.dz_kryteria_oceniania_ang := dz_kryteria_oceniania_ang;
        SELF.dz_url := dz_url;
        SELF.dz_zakres_tematow := dz_zakres_tematow;
        SELF.dz_zakres_tematow_ang := dz_zakres_tematow_ang;
        SELF.dz_metody_dyd := dz_metody_dyd;
        SELF.dz_metody_dyd_ang := dz_metody_dyd_ang;
        SELF.dz_literatura := dz_literatura;
        SELF.dz_literatura_ang := dz_literatura_ang;
        SELF.dz_czy_pokazywac_termin := dz_czy_pokazywac_termin;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Zajcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zajcykl_V_t
            , id IN NUMBER
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map IN V2u_Subject_Map_t
            , classes_map IN V2u_Classes_Map_t
            , zajecia_cyklu IN V2u_Dz_Zajecia_Cyklu_t
            , subject_matching_score IN NUMBER
            , classes_matching_score IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := subject.job_uuid;
        SELF.subject_id := subject.id;
        SELF.specialty_id := specialty.id;
        SELF.semester_id := semester.id;
        SELF.subject_map_id := subject_map.id;
        SELF.subject_matching_score := subject_matching_score;
        SELF.classes_map_id := classes_map.id;
        SELF.classes_matching_score := classes_matching_score;
        --
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
        --
        SELF.dz_prz_kod := zajecia_cyklu.prz_kod;
        SELF.dz_cdyd_kod := zajecia_cyklu.cdyd_kod;
        SELF.dz_tzaj_kod := zajecia_cyklu.tzaj_kod;
        SELF.dz_liczba_godz := zajecia_cyklu.liczba_godz;
        SELF.dz_limit_miejsc := zajecia_cyklu.limit_miejsc;
        SELF.dz_utw_id := zajecia_cyklu.utw_id;
        SELF.dz_utw_data := zajecia_cyklu.utw_data;
        SELF.dz_mod_id := zajecia_cyklu.mod_id;
        SELF.dz_mod_data := zajecia_cyklu.mod_data;
        SELF.dz_waga_pensum := zajecia_cyklu.waga_pensum;
        SELF.dz_tpro_kod := zajecia_cyklu.tpro_kod;
        SELF.dz_efekty_uczenia := zajecia_cyklu.efekty_uczenia;
        SELF.dz_efekty_uczenia_ang := zajecia_cyklu.efekty_uczenia_ang;
        SELF.dz_kryteria_oceniania := zajecia_cyklu.kryteria_oceniania;
        SELF.dz_kryteria_oceniania_ang := zajecia_cyklu.kryteria_oceniania_ang;
        SELF.dz_url := zajecia_cyklu.url;
        SELF.dz_zakres_tematow := zajecia_cyklu.zakres_tematow;
        SELF.dz_zakres_tematow_ang := zajecia_cyklu.zakres_tematow_ang;
        SELF.dz_metody_dyd := zajecia_cyklu.metody_dyd;
        SELF.dz_metody_dyd_ang := zajecia_cyklu.metody_dyd_ang;
        SELF.dz_literatura := zajecia_cyklu.literatura;
        SELF.dz_literatura_ang := zajecia_cyklu.literatura_ang;
        SELF.dz_czy_pokazywac_termin := zajecia_cyklu.czy_pokazywac_termin;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
