CREATE OR REPLACE TYPE V2u_Ko_Matched_Pktprz_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Matched_Pktprz_I_t
    ( CONSTRUCTOR FUNCTION V2u_Ko_Matched_Pktprz_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Pktprz_J_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , matching_score IN NUMBER
            , prz_kod IN VARCHAR2
            , pktprz_id IN NUMBER
            , prg_kod IN VARCHAR2
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Pktprzes_J_t
    AS TABLE OF V2u_Ko_Matched_Pktprz_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
