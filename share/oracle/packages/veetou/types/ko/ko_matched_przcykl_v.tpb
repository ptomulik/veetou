CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Przcykl_V_t AS
--    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przcykl_V_t(
--              SELF IN OUT NOCOPY V2u_Ko_Matched_Przcykl_V_t
--            , job_uuid IN RAW
--            , subject_id IN NUMBER
--            , specialty_id IN NUMBER
--            , semester_id IN NUMBER
--            , subject_map_id IN NUMBER
--            , matching_score IN NUMBER
--            , prz_kod IN VARCHAR2
--            , cdyd_kod IN VARCHAR2
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
--            , utw_id IN VARCHAR2
--            , utw_data IN DATE
--            , mod_id IN VARCHAR2
--            , mod_data IN DATE
--            , tpro_kod IN VARCHAR2
--            , uczestnicy IN VARCHAR2
--            , url IN VARCHAR2
--            , uwagi IN CLOB
--            , notes IN CLOB
--            , literatura IN CLOB
--            , literatura_ang IN CLOB
--            , opis IN CLOB
--            , opis_ang IN CLOB
--            , skrocony_opis IN VARCHAR2
--            , skrocony_opis_ang IN VARCHAR2
--            , status_sylabusu IN VARCHAR2
--            , guid IN VARCHAR2
--            ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.job_uuid := job_uuid;
--        SELF.subject_id := subject_id;
--        SELF.specialty_id := specialty_id;
--        SELF.semester_id := semester_id;
--        SELF.subject_map_id := subject_map_id;
--        SELF.matching_score := matching_score;
--        SELF.prz_kod := prz_kod;
--        SELF.cdyd_kod := cdyd_kod;
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
--        SELF.utw_id := utw_id;
--        SELF.utw_data := utw_data;
--        SELF.mod_id := mod_id;
--        SELF.mod_data := mod_data;
--        SELF.tpro_kod := tpro_kod;
--        SELF.uczestnicy := uczestnicy;
--        SELF.url := url;
--        SELF.uwagi := uwagi;
--        SELF.notes := notes;
--        SELF.literatura := literatura;
--        SELF.literatura_ang := literatura_ang;
--        SELF.opis := opis;
--        SELF.opis_ang := opis_ang;
--        SELF.skrocony_opis := skrocony_opis;
--        SELF.skrocony_opis_ang := skrocony_opis_ang;
--        SELF.status_sylabusu := status_sylabusu;
--        SELF.guid := guid;
--        RETURN;
--    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przcykl_V_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map IN V2u_Subject_Map_t
            , przedmiot_cyklu IN V2u_Dz_Przedmiot_Cyklu_t
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
        SELF.prz_kod := przedmiot_cyklu.prz_kod;
        SELF.cdyd_kod := przedmiot_cyklu.cdyd_kod;
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
