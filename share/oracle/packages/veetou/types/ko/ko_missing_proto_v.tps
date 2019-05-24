CREATE OR REPLACE TYPE V2u_Ko_Missing_Proto_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Credit_U_t
    ( subject_map_id NUMBER(38)
    , map_subj_code VARCHAR2(20 CHAR)
    , classes_map_id NUMBER(38)
    , map_classes_type VARCHAR2(20 CHAR)
    , proto_type VARCHAR2(20 CHAR)
    , zaj_cyk_id NUMBER(10)
    , prot_id NUMBER(10)
    , reason VARCHAR2(300 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Missing_Proto_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_V_t
            , missing_proto_j IN V2u_Ko_Missing_Proto_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Missing_Proto_V_t
            , missing_proto_j IN V2u_Ko_Missing_Proto_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            )
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Missing_Protos_V_t
    AS TABLE OF V2u_Ko_Missing_Proto_V_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
