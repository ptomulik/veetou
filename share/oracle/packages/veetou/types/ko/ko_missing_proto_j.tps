CREATE OR REPLACE TYPE V2u_Ko_Missing_Proto_J_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Subject_Semester_I_t
    ( classes_type CHAR(1)
    , subject_map_id NUMBER(38)
    , map_subj_code VARCHAR2(20 CHAR)
    , classes_map_id NUMBER(38)
    , map_classes_type VARCHAR2(20 CHAR)
    , coalesced_proto_type VARCHAR2(20 CHAR)
    , zaj_cyk_id NUMBER(10)
    , prot_id NUMBER(10)
    , reason VARCHAR2(200 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Proto_J_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , coalesced_proto_type IN VARCHAR2
            , zaj_cyk_id IN NUMBER
            , prot_id IN NUMBER
            , reason IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_J_t
            , job_uuid RAW
            , semester_id IN NUMBER
            , specialty_id IN NUMBER
            , subject_id IN NUMBER
            , classes_type IN VARCHAR2
            , subject_map_id IN NUMBER
            , map_subj_code IN VARCHAR2
            , classes_map_id IN NUMBER
            , map_classes_type IN VARCHAR2
            , coalesced_proto_type IN VARCHAR2
            , zaj_cyk_id IN NUMBER
            , prot_id IN NUMBER
            , reason IN VARCHAR2
            )
    )
NOT FINAL;
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Protos_J_t
    AS TABLE OF V2u_Ko_Missing_Proto_J_t;

-- vim: set ft=sql ts=4 sw=4 et:
