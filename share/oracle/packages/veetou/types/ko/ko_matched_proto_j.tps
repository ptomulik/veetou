CREATE OR REPLACE TYPE V2u_Ko_Matched_Proto_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Credit_I_t
    ( subject_map_id NUMBER(38)
    , classes_map_id NUMBER(38)
    , protocol_map_id NUMBER(38)
    , proto_type VARCHAR2(20 CHAR)
    , prot_id NUMBER(10)
    , zaj_cyk_id NUMBER(10)
    , prz_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , tpro_kod VARCHAR2(20 CHAR)
    , tpro_kod_missmatch VARCHAR(128 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Proto_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , protocol_map_id IN NUMBER
            , proto_type IN VARCHAR2
            , prot_id IN NUMBER
            , zaj_cyk_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , tpro_kod_missmatch IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN CHAR
            , student_id IN NUMBER
            , subject_map_id IN NUMBER
            , classes_map_id IN NUMBER
            , protocol_map_id IN NUMBER
            , proto_type IN VARCHAR2
            , prot_id IN NUMBER
            , zaj_cyk_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tpro_kod IN VARCHAR2
            , tpro_kod_missmatch IN VARCHAR2
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Protos_J_t
    AS TABLE OF V2u_Ko_Matched_Proto_J_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
