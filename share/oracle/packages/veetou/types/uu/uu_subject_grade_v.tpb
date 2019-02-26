CREATE OR REPLACE TYPE BODY V2u_Uu_Subject_Grade_V_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Subject_Grade_V_t(
              SELF IN OUT NOCOPY V2u_Uu_Subject_Grade_V_t
            , v2u_job_uuid IN RAW
            , v2u_student_id IN NUMBER
            , v2u_subject_id IN NUMBER
            , v2u_specialty_id IN NUMBER
            , v2u_semester_id IN NUMBER
            , v2u_student_index IN VARCHAR2
            , v2u_student_name IN VARCHAR2
            , v2u_first_name IN VARCHAR2
            , v2u_last_name IN VARCHAR2
            , v2u_subj_code IN VARCHAR2
            , v2u_map_subj_code IN VARCHAR2
            , v2u_subj_name IN VARCHAR2
            , v2u_subj_hours_w IN NUMBER
            , v2u_subj_hours_c IN NUMBER
            , v2u_subj_hours_l IN NUMBER
            , v2u_subj_hours_p IN NUMBER
            , v2u_subj_hours_s IN NUMBER
            , v2u_subj_credit_kind IN VARCHAR2
            , v2u_subj_ects IN NUMBER
            , v2u_subj_tutor IN VARCHAR2
            , v2u_subj_grade IN VARCHAR2
            , v2u_subj_grade_date IN DATE
            , v2u_university IN VARCHAR2
            , v2u_faculty IN VARCHAR2
            , v2u_studies_modetier IN VARCHAR2
            , v2u_studies_field IN VARCHAR2
            , v2u_studies_specialty IN VARCHAR2
            , v2u_semester_code IN VARCHAR2
            , v2u_semester_number IN NUMBER
            , v2u_ects_mandatory IN NUMBER
            , v2u_ects_other IN NUMBER
            , v2u_ects_total IN NUMBER
            , v2u_tpro_kod IN VARCHAR2
            -- USOS
            , os_id IN NUMBER
            , st_id IN NUMBER
            , etpos_id IN NUMBER
            , prgos_id IN NUMBER
            , prg_kod IN VARCHAR2
            , etp_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            -- DBG
            , dbg_os_id IN NUMBER
            , dbg_st_id IN NUMBER
            , dbg_etpos_id IN NUMBER
            , dbg_prgos_id IN NUMBER
            , dbg_prg_kod IN NUMBER
            , dbg_etp_kod IN NUMBER
            , dbg_cdyd_kod IN NUMBER
            , dbg_prz_kod IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              v2u_job_uuid => v2u_job_uuid
            , v2u_student_id => v2u_student_id
            , v2u_subject_id => v2u_subject_id
            , v2u_specialty_id => v2u_specialty_id
            , v2u_semester_id => v2u_semester_id
            , v2u_student_index => v2u_student_index
            , v2u_student_name => v2u_student_name
            , v2u_first_name => v2u_first_name
            , v2u_last_name => v2u_last_name
            , v2u_subj_code => v2u_subj_code
            , v2u_map_subj_code => v2u_map_subj_code
            , v2u_subj_name => v2u_subj_name
            , v2u_subj_hours_w => v2u_subj_hours_w
            , v2u_subj_hours_c => v2u_subj_hours_c
            , v2u_subj_hours_l => v2u_subj_hours_l
            , v2u_subj_hours_p => v2u_subj_hours_p
            , v2u_subj_hours_s => v2u_subj_hours_s
            , v2u_subj_credit_kind => v2u_subj_credit_kind
            , v2u_subj_ects => v2u_subj_ects
            , v2u_subj_tutor => v2u_subj_tutor
            , v2u_subj_grade => v2u_subj_grade
            , v2u_subj_grade_date => v2u_subj_grade_date
            , v2u_university => v2u_university
            , v2u_faculty => v2u_faculty
            , v2u_studies_modetier => v2u_studies_modetier
            , v2u_studies_field => v2u_studies_field
            , v2u_studies_specialty => v2u_studies_specialty
            , v2u_semester_code => v2u_semester_code
            , v2u_semester_number => v2u_semester_number
            , v2u_ects_mandatory => v2u_ects_mandatory
            , v2u_ects_other => v2u_ects_other
            , v2u_ects_total => v2u_ects_total
            , v2u_tpro_kod => v2u_tpro_kod
            -- USOS
            , os_id => os_id
            , st_id => st_id
            , etpos_id => etpos_id
            , prgos_id => prgos_id
            , prg_kod => prg_kod
            , etp_kod => etp_kod
            , cdyd_kod => cdyd_kod
            , tpro_kod => tpro_kod
            , prz_kod => prz_kod
            -- DBG
            , dbg_os_id => dbg_os_id
            , dbg_st_id => dbg_st_id
            , dbg_etpos_id => dbg_etpos_id
            , dbg_prgos_id => dbg_prgos_id
            , dbg_prg_kod => dbg_prg_kod
            , dbg_etp_kod => dbg_etp_kod
            , dbg_cdyd_kod => dbg_etp_kod
            , dbg_prz_kod => dbg_prz_kod
            );
    END;

    CONSTRUCTOR FUNCTION V2u_Uu_Subject_Grade_V_t(
              SELF IN OUT NOCOPY V2u_Uu_Subject_Grade_V_t
            , classes_grade IN V2u_Uu_Classes_Grade_t
    ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              v2u_job_uuid => classes_grade.v2u_job_uuid
            , v2u_student_id => classes_grade.v2u_student_id
            , v2u_subject_id => classes_grade.v2u_subject_id
            , v2u_specialty_id => classes_grade.v2u_specialty_id
            , v2u_semester_id => classes_grade.v2u_semester_id
            , v2u_student_index => classes_grade.v2u_student_index
            , v2u_student_name => classes_grade.v2u_student_name
            , v2u_first_name => classes_grade.v2u_first_name
            , v2u_last_name => classes_grade.v2u_last_name
            , v2u_subj_code => classes_grade.v2u_subj_code
            , v2u_map_subj_code => classes_grade.v2u_map_subj_code
            , v2u_subj_name => classes_grade.v2u_subj_name
            , v2u_subj_hours_w => classes_grade.v2u_subj_hours_w
            , v2u_subj_hours_c => classes_grade.v2u_subj_hours_c
            , v2u_subj_hours_l => classes_grade.v2u_subj_hours_l
            , v2u_subj_hours_p => classes_grade.v2u_subj_hours_p
            , v2u_subj_hours_s => classes_grade.v2u_subj_hours_s
            , v2u_subj_credit_kind => classes_grade.v2u_subj_credit_kind
            , v2u_subj_ects => classes_grade.v2u_subj_ects
            , v2u_subj_tutor => classes_grade.v2u_subj_tutor
            , v2u_subj_grade => classes_grade.v2u_subj_grade
            , v2u_subj_grade_date => classes_grade.v2u_subj_grade_date
            , v2u_university => classes_grade.v2u_university
            , v2u_faculty => classes_grade.v2u_faculty
            , v2u_studies_modetier => classes_grade.v2u_studies_modetier
            , v2u_studies_field => classes_grade.v2u_studies_field
            , v2u_studies_specialty => classes_grade.v2u_studies_specialty
            , v2u_semester_code => classes_grade.v2u_semester_code
            , v2u_semester_number => classes_grade.v2u_semester_number
            , v2u_ects_mandatory => classes_grade.v2u_ects_mandatory
            , v2u_ects_other => classes_grade.v2u_ects_other
            , v2u_ects_total => classes_grade.v2u_ects_total
            , v2u_tpro_kod => classes_grade.v2u_tpro_kod
            -- USOS
            , os_id => classes_grade.os_id
            , st_id => classes_grade.st_id
            , etpos_id => classes_grade.etpos_id
            , prgos_id => classes_grade.prgos_id
            , prg_kod => classes_grade.prg_kod
            , etp_kod => classes_grade.etp_kod
            , cdyd_kod => classes_grade.cdyd_kod
            , tpro_kod => classes_grade.tpro_kod
            , prz_kod => classes_grade.prz_kod
            -- DBG
            , dbg_os_id => classes_grade.dbg_os_id
            , dbg_st_id => classes_grade.dbg_st_id
            , dbg_etpos_id => classes_grade.dbg_etpos_id
            , dbg_prgos_id => classes_grade.dbg_prgos_id
            , dbg_prg_kod => classes_grade.dbg_prg_kod
            , dbg_etp_kod => classes_grade.dbg_etp_kod
            , dbg_cdyd_kod => classes_grade.dbg_etp_kod
            , dbg_prz_kod => classes_grade.dbg_prz_kod
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Subject_Grade_V_t
            , v2u_job_uuid IN RAW
            , v2u_student_id IN NUMBER
            , v2u_subject_id IN NUMBER
            , v2u_specialty_id IN NUMBER
            , v2u_semester_id IN NUMBER
            , v2u_student_index IN VARCHAR2
            , v2u_student_name IN VARCHAR2
            , v2u_first_name IN VARCHAR2
            , v2u_last_name IN VARCHAR2
            , v2u_subj_code IN VARCHAR2
            , v2u_map_subj_code IN VARCHAR2
            , v2u_subj_name IN VARCHAR2
            , v2u_subj_hours_w IN NUMBER
            , v2u_subj_hours_c IN NUMBER
            , v2u_subj_hours_l IN NUMBER
            , v2u_subj_hours_p IN NUMBER
            , v2u_subj_hours_s IN NUMBER
            , v2u_subj_credit_kind IN VARCHAR2
            , v2u_subj_ects IN NUMBER
            , v2u_subj_tutor IN VARCHAR2
            , v2u_subj_grade IN VARCHAR2
            , v2u_subj_grade_date IN DATE
            , v2u_university IN VARCHAR2
            , v2u_faculty IN VARCHAR2
            , v2u_studies_modetier IN VARCHAR2
            , v2u_studies_field IN VARCHAR2
            , v2u_studies_specialty IN VARCHAR2
            , v2u_semester_code IN VARCHAR2
            , v2u_semester_number IN NUMBER
            , v2u_ects_mandatory IN NUMBER
            , v2u_ects_other IN NUMBER
            , v2u_ects_total IN NUMBER
            , v2u_tpro_kod IN VARCHAR2
            -- USOS
            , os_id IN NUMBER
            , st_id IN NUMBER
            , etpos_id IN NUMBER
            , prgos_id IN NUMBER
            , prg_kod IN VARCHAR2
            , etp_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            -- DBG
            , dbg_os_id IN NUMBER
            , dbg_st_id IN NUMBER
            , dbg_etpos_id IN NUMBER
            , dbg_prgos_id IN NUMBER
            , dbg_prg_kod IN NUMBER
            , dbg_etp_kod IN NUMBER
            , dbg_cdyd_kod IN NUMBER
            , dbg_prz_kod IN NUMBER
            )
    IS
    BEGIN
        SELF.v2u_job_uuid := v2u_job_uuid;
        SELF.v2u_student_id := v2u_student_id;
        SELF.v2u_subject_id := v2u_subject_id;
        SELF.v2u_specialty_id := v2u_specialty_id;
        SELF.v2u_semester_id := v2u_semester_id;
        SELF.v2u_student_index := v2u_student_index;
        SELF.v2u_student_name := v2u_student_name;
        SELF.v2u_first_name := v2u_first_name;
        SELF.v2u_last_name := v2u_last_name;
        SELF.v2u_subj_code := v2u_subj_code;
        SELF.v2u_map_subj_code := v2u_map_subj_code;
        SELF.v2u_subj_name := v2u_subj_name;
        SELF.v2u_subj_hours_w := v2u_subj_hours_w;
        SELF.v2u_subj_hours_c := v2u_subj_hours_c;
        SELF.v2u_subj_hours_l := v2u_subj_hours_l;
        SELF.v2u_subj_hours_p := v2u_subj_hours_p;
        SELF.v2u_subj_hours_s := v2u_subj_hours_s;
        SELF.v2u_subj_credit_kind := v2u_subj_credit_kind;
        SELF.v2u_subj_ects := v2u_subj_ects;
        SELF.v2u_subj_tutor := v2u_subj_tutor;
        SELF.v2u_subj_grade := v2u_subj_grade;
        SELF.v2u_subj_grade_date := v2u_subj_grade_date;
        SELF.v2u_university := v2u_university;
        SELF.v2u_faculty := v2u_faculty;
        SELF.v2u_studies_modetier := v2u_studies_modetier;
        SELF.v2u_studies_field := v2u_studies_field;
        SELF.v2u_studies_specialty := v2u_studies_specialty;
        SELF.v2u_semester_code := v2u_semester_code;
        SELF.v2u_semester_number := v2u_semester_number;
        SELF.v2u_ects_mandatory := v2u_ects_mandatory;
        SELF.v2u_ects_other := v2u_ects_other;
        SELF.v2u_ects_total := v2u_ects_total;
        SELF.v2u_tpro_kod := v2u_tpro_kod;
        -- USOS
        SELF.os_id := os_id;
        SELF.st_id := st_id;
        SELF.etpos_id := etpos_id;
        SELF.prgos_id := prgos_id;
        SELF.prg_kod := prg_kod;
        SELF.etp_kod := etp_kod;
        SELF.cdyd_kod := cdyd_kod;
        SELF.tpro_kod := tpro_kod;
        SELF.prz_kod := prz_kod;
        -- DBG
        SELF.dbg_os_id := dbg_os_id;
        SELF.dbg_st_id := dbg_st_id;
        SELF.dbg_etpos_id := dbg_etpos_id;
        SELF.dbg_prgos_id := dbg_prgos_id;
        SELF.dbg_prg_kod := dbg_prg_kod;
        SELF.dbg_etp_kod := dbg_etp_kod;
        SELF.dbg_cdyd_kod := dbg_etp_kod;
        SELF.dbg_prz_kod := dbg_prz_kod;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
