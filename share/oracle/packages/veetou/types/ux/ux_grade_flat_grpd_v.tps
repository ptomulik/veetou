CREATE OR REPLACE TYPE V2u_Ux_Grade_Flat_Grpd_V_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( v2u_job_uuid RAW(16)
    , v2u_student_id NUMBER(38)
    , v2u_subject_id NUMBER(38)
    , v2u_specialty_id NUMBER(38)
    , v2u_semester_id NUMBER(38)
    , v2u_student_index VARCHAR2(32 CHAR)
    , v2u_student_name VARCHAR2(128 CHAR)
    , v2u_first_name VARCHAR2(48 CHAR)
    , v2u_last_name VARCHAR2(48 CHAR)
    , v2u_subj_code VARCHAR2(32 CHAR)
    , v2u_map_subj_code VARCHAR2(32 CHAR)
    , v2u_subj_name VARCHAR2(256 CHAR)
    , v2u_subj_hours_w NUMBER(8)
    , v2u_subj_hours_c NUMBER(8)
    , v2u_subj_hours_l NUMBER(8)
    , v2u_subj_hours_p NUMBER(8)
    , v2u_subj_hours_s NUMBER(8)
    , v2u_subj_credit_kind VARCHAR2(16 CHAR)
    , v2u_subj_ects NUMBER(4)
    , v2u_subj_tutor VARCHAR2(256 CHAR)
    , v2u_subj_grade VARCHAR2(10 CHAR)
    , v2u_subj_grade_date DATE
    , v2u_university VARCHAR2(8 CHAR)
    , v2u_faculty VARCHAR2(8 CHAR)
    , v2u_studies_modetier VARCHAR2(100 CHAR)
    , v2u_studies_field VARCHAR2(100 CHAR)
    , v2u_studies_specialty VARCHAR2(100 CHAR)
    , v2u_semester_code VARCHAR2(5 CHAR)
    , v2u_semester_number NUMBER(2)
    , v2u_ects_mandatory NUMBER(4)
    , v2u_ects_other NUMBER(4)
    , v2u_ects_total NUMBER(4)
    , v2u_tpro_kod VARCHAR2(3)
    -- USOS
    , os_id NUMBER(10)
    , st_id NUMBER(10)
    , etpos_id NUMBER(10)
    , prgos_id NUMBER(10)
    , prg_kod VARCHAR2(20 CHAR)
    , etp_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , tpro_kod VARCHAR2(20 CHAR)
    , prz_kod VARCHAR2(20 CHAR)
    -- DBG
    , dbg_os_id NUMBER(38)
    , dbg_st_id NUMBER(38)
    , dbg_etpos_id NUMBER(38)
    , dbg_prgos_id NUMBER(38)
    , dbg_prg_kod NUMBER(38)
    , dbg_etp_kod NUMBER(38)
    , dbg_cdyd_kod NUMBER(38)
    , dbg_prz_kod NUMBER(38)

    , CONSTRUCTOR FUNCTION V2u_Ux_Grade_Flat_Grpd_V_t(
              SELF IN OUT NOCOPY V2u_Ux_Grade_Flat_Grpd_V_t
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

    , CONSTRUCTOR FUNCTION V2u_Ux_Grade_Flat_Grpd_V_t(
              SELF IN OUT NOCOPY V2u_Ux_Grade_Flat_Grpd_V_t
            , grade_flat IN V2u_Ux_Grade_Flat_t
    ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ux_Grade_Flat_Grpd_V_t
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
    )
;

-- vim: set ft=sql ts=4 sw=4 et:
