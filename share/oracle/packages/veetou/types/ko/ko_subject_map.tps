--CREATE OR REPLACE TYPE V2u_Ko_Subject_Map_t FORCE AUTHID CURRENT_USER AS OBJECT
--    ( job_uuid RAW(16)
--    , subject_entity_id NUMBER(38)
--    , subject_map_id NUMBER(38)
--    , matching_score NUMBER(38)
--    , subj_code VARCHAR2(32 CHAR)
--    , mapped_subj_code VARCHAR2(20 CHAR)
--    , subj_name VARCHAR2(256 CHAR)
--    , expr_subj_name VARCHAR2(256 CHAR)
--    , university VARCHAR2(8 CHAR)
--    , expr_university VARCHAR2(256 CHAR)
--    , faculty VARCHAR2(8 CHAR)
--    , expr_faculty VARCHAR2(256 CHAR)
--    , studies_modetier VARCHAR2(100 CHAR)
--    , expr_studies_modetier VARCHAR2(256 CHAR)
--    , studies_field VARCHAR2(100 CHAR)
--    , expr_studies_field VARCHAR2(256 CHAR)
--    , studies_specialty VARCHAR2(100 CHAR)
--    , expr_studies_specialty VARCHAR2(256 CHAR)
--    , semester_code VARCHAR2(32 CHAR)
--    , expr_semester_code VARCHAR2(256 CHAR)
--    , subj_hours_w NUMBER(8)
--    , expr_subj_hours_w VARCHAR2(256 CHAR)
--    , subj_hours_c NUMBER(8)
--    , expr_subj_hours_c VARCHAR2(256 CHAR)
--    , subj_hours_l NUMBER(8)
--    , expr_subj_hours_l VARCHAR2(256 CHAR)
--    , subj_hours_p NUMBER(8)
--    , expr_subj_hours_p VARCHAR2(256 CHAR)
--    , subj_hours_s NUMBER(8)
--    , expr_subj_hours_s VARCHAR2(256 CHAR)
--    , subj_credit_kind VARCHAR2(16 CHAR)
--    , expr_subj_credit_kind VARCHAR2(256 CHAR)
--    , subj_ects NUMBER(4)
--    , expr_subj_ects VARCHAR2(256 CHAR)
--    , subj_tutor VARCHAR2(256 CHAR)
--    , expr_subj_tutor VARCHAR2(256 CHAR)
--
--    , CONSTRUCTOR FUNCTION V2u_Ko_Subject_Map_t(
--              SELF IN OUT NOCOPY V2u_Ko_Subject_Map_t
--            , job_uuid IN RAW
--            , subject_entity_id IN NUMBER
--            , subject_map_id IN NUMBER
--            , matching_score IN NUMBER
--            , subj_code IN VARCHAR2
--            , mapped_subj_code IN VARCHAR2
--            , subj_name IN VARCHAR2
--            , expr_subj_name IN VARCHAR2
--            , university IN VARCHAR2
--            , expr_university IN VARCHAR2
--            , faculty IN VARCHAR2
--            , expr_faculty IN VARCHAR2
--            , studies_modetier IN VARCHAR2
--            , expr_studies_modetier IN VARCHAR2
--            , studies_field IN VARCHAR2
--            , expr_studies_field IN VARCHAR2
--            , studies_specialty IN VARCHAR2
--            , expr_studies_specialty IN VARCHAR2
--            , semester_code IN VARCHAR2
--            , expr_semester_code IN VARCHAR2
--            , subj_hours_w IN NUMBER
--            , expr_subj_hours_w IN VARCHAR2
--            , subj_hours_c IN NUMBER
--            , expr_subj_hours_c IN VARCHAR2
--            , subj_hours_l IN NUMBER
--            , expr_subj_hours_l IN VARCHAR2
--            , subj_hours_p IN NUMBER
--            , expr_subj_hours_p IN VARCHAR2
--            , subj_hours_s IN NUMBER
--            , expr_subj_hours_s IN VARCHAR2
--            , subj_credit_kind IN VARCHAR2
--            , expr_subj_credit_kind IN VARCHAR2
--            , subj_ects IN NUMBER
--            , expr_subj_ects IN VARCHAR2
--            , subj_tutor IN VARCHAR2
--            , expr_subj_tutor IN VARCHAR2
--            ) RETURN SELF AS RESULT
--
--    , CONSTRUCTOR FUNCTION V2u_Ko_Subject_Map_t(
--              SELF IN OUT NOCOPY V2u_Ko_Subject_Map_t
--            , subject IN V2u_Ko_Specialty_t
--            , semester IN V2u_Ko_Semester_t
--            , map IN V2u_Subject_Map_t
--            , matching_score IN NUMBER
--            ) RETURN SELF AS RESULT
--
--    , ORDER MEMBER FUNCTION cmp_with (other V2u_Ko_Subject_Map_t)
--            RETURN INTEGER
--    );

-- vim: set ft=sql ts=4 sw=4 et:
