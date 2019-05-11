CREATE OR REPLACE TYPE V2u_Ko_Matched_Proto_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_I_t
    ( classes_type CHAR(1)
    , subject_map_id NUMBER(38)
    , classes_map_id NUMBER(38)
    , prz_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , tpro_kod VARCHAR2(20 CHAR)
    , prot_id NUMBER(10)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Proto_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , prot_id IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , prot_id IN NUMBER
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Protos_J_t
    AS TABLE OF V2u_Ko_Matched_Proto_J_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
