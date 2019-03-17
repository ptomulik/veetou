CREATE OR REPLACE TYPE V2u_Ko_Matched_Pktprz_I_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Matched_Przedm_I_t
    ( pktprz_id NUMBER(10)
    , prg_kod VARCHAR2(20 CHAR)
    , cdyd_pocz VARCHAR2(20 CHAR)
    , cdyd_kon VARCHAR2(20 CHAR)
    , ilosc_missmatch VARCHAR2(32 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Pktprz_I_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Pktprz_I_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , prz_kod IN VARCHAR2
            , pktprz_id IN NUMBER
            , prg_kod IN VARCHAR2
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            , ilosc_missmatch IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Pktprz_I_t
            , job_uuid IN RAW
            , subject_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , subject_map_id IN NUMBER
            , prz_kod IN VARCHAR2
            , pktprz_id IN NUMBER
            , prg_kod IN VARCHAR2
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            , ilosc_missmatch IN VARCHAR2
            )
    )
NOT FINAL NOT INSTANTIABLE;
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Przcykles_J_t
    AS TABLE OF V2u_Ko_Matched_Pktprz_I_t;

-- vim: set ft=sql ts=4 sw=4 et:
