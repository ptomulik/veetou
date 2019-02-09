CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Przcykl_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przcykl_V_t
            , id IN NUMBER
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , matching_score IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
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
            , dz_utw_id IN VARCHAR2
            , dz_utw_data IN DATE
            , dz_mod_id IN VARCHAR2
            , dz_mod_data IN DATE
            , dz_tpro_kod IN VARCHAR2
            , dz_uczestnicy IN VARCHAR2
            , dz_url IN VARCHAR2
            , dz_uwagi IN CLOB
            , dz_notes IN CLOB
            , dz_literatura IN CLOB
            , dz_literatura_ang IN CLOB
            , dz_opis IN CLOB
            , dz_opis_ang IN CLOB
            , dz_skrocony_opis IN VARCHAR2
            , dz_skrocony_opis_ang IN VARCHAR2
            , dz_status_sylabusu IN VARCHAR2
            , dz_guid IN VARCHAR2
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
        SELF.cdyd_kod := cdyd_kod;
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
        SELF.dz_utw_id := dz_utw_id;
        SELF.dz_utw_data := dz_utw_data;
        SELF.dz_mod_id := dz_mod_id;
        SELF.dz_mod_data := dz_mod_data;
        SELF.dz_tpro_kod := dz_tpro_kod;
        SELF.dz_uczestnicy := dz_uczestnicy;
        SELF.dz_url := dz_url;
        SELF.dz_uwagi := dz_uwagi;
        SELF.dz_notes := dz_notes;
        SELF.dz_literatura := dz_literatura;
        SELF.dz_literatura_ang := dz_literatura_ang;
        SELF.dz_opis := dz_opis;
        SELF.dz_opis_ang := dz_opis_ang;
        SELF.dz_skrocony_opis := dz_skrocony_opis;
        SELF.dz_skrocony_opis_ang := dz_skrocony_opis_ang;
        SELF.dz_status_sylabusu := dz_status_sylabusu;
        SELF.dz_guid := dz_guid;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przcykl_V_t
            , id IN NUMBER
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map IN V2u_Subject_Map_t
            , przedmiot_cyklu IN V2u_Dz_Przedmiot_Cyklu_t
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
        SELF.prz_kod := przedmiot_cyklu.prz_kod;
        SELF.cdyd_kod := przedmiot_cyklu.cdyd_kod;
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
        SELF.dz_utw_id := przedmiot_cyklu.utw_id;
        SELF.dz_utw_data := przedmiot_cyklu.utw_data;
        SELF.dz_mod_id := przedmiot_cyklu.mod_id;
        SELF.dz_mod_data := przedmiot_cyklu.mod_data;
        SELF.dz_tpro_kod := przedmiot_cyklu.tpro_kod;
        SELF.dz_uczestnicy := przedmiot_cyklu.uczestnicy;
        SELF.dz_url := przedmiot_cyklu.url;
        SELF.dz_uwagi := przedmiot_cyklu.uwagi;
        SELF.dz_notes := przedmiot_cyklu.notes;
        SELF.dz_literatura := przedmiot_cyklu.literatura;
        SELF.dz_literatura_ang := przedmiot_cyklu.literatura_ang;
        SELF.dz_opis := przedmiot_cyklu.opis;
        SELF.dz_opis_ang := przedmiot_cyklu.opis_ang;
        SELF.dz_skrocony_opis := przedmiot_cyklu.skrocony_opis;
        SELF.dz_skrocony_opis_ang := przedmiot_cyklu.skrocony_opis_ang;
        SELF.dz_status_sylabusu := przedmiot_cyklu.status_sylabusu;
        SELF.dz_guid := przedmiot_cyklu.guid;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
