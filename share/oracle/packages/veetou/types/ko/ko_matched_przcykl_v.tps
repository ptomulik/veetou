CREATE OR REPLACE TYPE V2u_Ko_Matched_Przcykl_V_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(38)
    , job_uuid RAW(16)
    , subject_id NUMBER(38)
    , specialty_id NUMBER(38)
    , semester_id NUMBER(38)
    , subject_map_id NUMBER(38)
    , matching_score NUMBER(38)
    , prz_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , ko_subj_code VARCHAR2(32 CHAR)
    , ko_subj_name VARCHAR2(256 CHAR)
    , ko_subj_hours_w NUMBER(8)
    , ko_subj_hours_c NUMBER(8)
    , ko_subj_hours_l NUMBER(8)
    , ko_subj_hours_p NUMBER(8)
    , ko_subj_hours_s NUMBER(8)
    , ko_subj_credit_kind VARCHAR2(16 CHAR)
    , ko_subj_ects NUMBER(4)
    , ko_subj_tutor VARCHAR2(256 CHAR)
    , ko_university VARCHAR2(8 CHAR)
    , ko_faculty VARCHAR2(8 CHAR)
    , ko_studies_modetier VARCHAR2(100 CHAR)
    , ko_studies_field VARCHAR2(100 CHAR)
    , ko_studies_specialty VARCHAR2(100 CHAR)
    , ko_semester_code VARCHAR2(5 CHAR)
    , ko_semester_number NUMBER(2)
    , ko_ects_mandatory NUMBER(4)
    , ko_ects_other NUMBER(4)
    , ko_ects_total NUMBER(4)
    , dz_utw_id VARCHAR2(30 CHAR)
    , dz_utw_data DATE
    , dz_mod_id VARCHAR2(30 CHAR)
    , dz_mod_data DATE
    , dz_tpro_kod VARCHAR2(20 CHAR)
    , dz_uczestnicy VARCHAR2(1 CHAR)
    , dz_url VARCHAR2(500 CHAR)
    , dz_uwagi CLOB
    , dz_notes CLOB
    , dz_literatura CLOB
    , dz_literatura_ang CLOB
    , dz_opis CLOB
    , dz_opis_ang CLOB
    , dz_skrocony_opis VARCHAR2(2000 CHAR)
    , dz_skrocony_opis_ang VARCHAR2(2000 CHAR)
    , dz_status_sylabusu VARCHAR2(1 CHAR)
    , dz_guid VARCHAR2(32 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przcykl_V_t(
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

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Przcykl_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Przcykl_V_t
            , id IN NUMBER
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , subject_map IN V2u_Subject_Map_t
            , przedmiot_cyklu IN V2u_Dz_Przedmiot_Cyklu_t
            , matching_score IN NUMBER
            ) RETURN SELF AS RESULT

    );
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Przcykles_V_t
    AS TABLE OF V2u_Ko_Matched_Przcykl_V_t;

-- vim: set ft=sql ts=4 sw=4 et:
