CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Zajcykl_V_t AS
--    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Zajcykl_V_t(
--              SELF IN OUT NOCOPY V2u_Ko_Matched_Zajcykl_V_t
--            , job_uuid IN RAW
--            , classes_type IN VARCHAR2
--            , subject_id IN NUMBER
--            , specialty_id IN NUMBER
--            , semester_id IN NUMBER
--            , subject_map_id IN NUMBER
--            , subject_matching_score IN NUMBER
--            , classes_map_id IN NUMBER
--            , classes_matching_score IN NUMBER
--            -- KO
--            , subj_code IN VARCHAR2
--            , subj_name IN VARCHAR2
--            , subj_hours_w IN NUMBER
--            , subj_hours_c IN NUMBER
--            , subj_hours_l IN NUMBER
--            , subj_hours_p IN NUMBER
--            , subj_hours_s IN NUMBER
--            , subj_credit_kind IN VARCHAR2
--            , subj_ects IN NUMBER
--            , subj_tutor IN VARCHAR2
--            , university IN VARCHAR2
--            , faculty IN VARCHAR2
--            , studies_modetier IN VARCHAR2
--            , studies_field IN VARCHAR2
--            , studies_specialty IN VARCHAR2
--            , semester_code IN VARCHAR2
--            , semester_number IN NUMBER
--            , ects_mandatory IN NUMBER
--            , ects_other IN NUMBER
--            , ects_total IN NUMBER
--            -- DZ
--            , prz_kod IN VARCHAR2
--            , cdyd_kod IN VARCHAR2
--            , tzaj_kod IN VARCHAR2
--            , liczba_godz IN NUMBER
--            , limit_miejsc IN NUMBER
--            , utw_id IN VARCHAR2
--            , utw_data IN DATE
--            , mod_id IN VARCHAR2
--            , mod_data IN DATE
--            , waga_pensum IN NUMBER
--            , tpro_kod IN VARCHAR2
--            , efekty_uczenia IN CLOB
--            , efekty_uczenia_ang IN CLOB
--            , kryteria_oceniania IN CLOB
--            , kryteria_oceniania_ang IN CLOB
--            , url IN VARCHAR2
--            , zakres_tematow IN CLOB
--            , zakres_tematow_ang IN CLOB
--            , metody_dyd IN CLOB
--            , metody_dyd_ang IN CLOB
--            , literatura IN CLOB
--            , literatura_ang IN CLOB
--            , czy_pokazywac_termin IN VARCHAR2
--            ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.job_uuid := job_uuid;
--        SELF.classes_type := classes_type;
--        SELF.subject_id := subject_id;
--        SELF.specialty_id := specialty_id;
--        SELF.semester_id := semester_id;
--        SELF.subject_map_id := subject_map_id;
--        SELF.subject_matching_score := subject_matching_score;
--        SELF.classes_map_id := classes_map_id;
--        SELF.classes_matching_score := classes_matching_score;
--        -- KO
--        SELF.subj_code := subj_code;
--        SELF.subj_name := subj_name;
--        SELF.subj_hours_w := subj_hours_w;
--        SELF.subj_hours_c := subj_hours_c;
--        SELF.subj_hours_l := subj_hours_l;
--        SELF.subj_hours_p := subj_hours_p;
--        SELF.subj_hours_s := subj_hours_s;
--        SELF.subj_credit_kind := subj_credit_kind;
--        SELF.subj_ects := subj_ects;
--        SELF.subj_tutor := subj_tutor;
--        SELF.university := university;
--        SELF.faculty := faculty;
--        SELF.studies_modetier := studies_modetier;
--        SELF.studies_field := studies_field;
--        SELF.studies_specialty := studies_specialty;
--        SELF.semester_code := semester_code;
--        SELF.semester_number := semester_number;
--        SELF.ects_mandatory := ects_mandatory;
--        SELF.ects_other := ects_other;
--        SELF.ects_total := ects_total;
--        -- DZ
--        SELF.prz_kod := prz_kod;
--        SELF.cdyd_kod := cdyd_kod;
--        SELF.tzaj_kod := tzaj_kod;
--        SELF.liczba_godz := liczba_godz;
--        SELF.limit_miejsc := limit_miejsc;
--        SELF.utw_id := utw_id;
--        SELF.utw_data := utw_data;
--        SELF.mod_id := mod_id;
--        SELF.mod_data := mod_data;
--        SELF.waga_pensum := waga_pensum;
--        SELF.tpro_kod := tpro_kod;
--        SELF.efekty_uczenia := efekty_uczenia;
--        SELF.efekty_uczenia_ang := efekty_uczenia_ang;
--        SELF.kryteria_oceniania := kryteria_oceniania;
--        SELF.kryteria_oceniania_ang := kryteria_oceniania_ang;
--        SELF.url := url;
--        SELF.zakres_tematow := zakres_tematow;
--        SELF.zakres_tematow_ang := zakres_tematow_ang;
--        SELF.metody_dyd := metody_dyd;
--        SELF.metody_dyd_ang := metody_dyd_ang;
--        SELF.literatura := literatura;
--        SELF.literatura_ang := literatura_ang;
--        SELF.czy_pokazywac_termin := czy_pokazywac_termin;
--        RETURN;
--    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Zajcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Zajcykl_V_t
            , classes_type IN VARCHAR2
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
        SELF.job_uuid := subject.job_uuid;
        SELF.classes_type := classes_type;
        SELF.subject_id := subject.id;
        SELF.specialty_id := specialty.id;
        SELF.semester_id := semester.id;
        SELF.subject_map_id := subject_map.id;
        SELF.subject_matching_score := subject_matching_score;
        SELF.classes_map_id := classes_map.id;
        SELF.classes_matching_score := classes_matching_score;
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

-- vim: set ft=sql ts=4 sw=4 et:
