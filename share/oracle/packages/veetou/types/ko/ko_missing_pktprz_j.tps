CREATE OR REPLACE TYPE V2u_Ko_Missing_Pktprz_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_I_t
    ( subject_map_id NUMBER(38)
    , map_subj_code VARCHAR2(20 CHAR)
    , specialty_map_ids V2u_20Ids_t
    , map_program_codes V2u_Program_20Codes_t
    , istniejace_pkt_prz_ids V2u_Dz_20Ids_t
    , reason VARCHAR2(300 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Pktprz_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Pktprz_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , specialty_map_ids IN V2u_20Ids_t
            , map_program_codes IN V2u_Program_20Codes_t
            , istniejace_pkt_prz_ids IN V2u_Dz_20Ids_t
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT


    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Pktprz_J_t
            , job_uuid IN RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , specialty_map_ids IN V2u_20Ids_t
            , map_program_codes IN V2u_Program_20Codes_t
            , istniejace_pkt_prz_ids IN V2u_Dz_20Ids_t
            , reason IN VARCHAR2
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Pktprzes_J_t
    AS TABLE OF V2u_Ko_Missing_Pktprz_J_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
