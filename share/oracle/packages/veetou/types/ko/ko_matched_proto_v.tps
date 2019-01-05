CREATE OR REPLACE TYPE V2u_Ko_Matched_Proto_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Grade_U_t
    ( zaj_cyk_id NUMBER(10)
    , opis VARCHAR2(100 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , tpro_kod VARCHAR2(20 CHAR)
    , prot_id NUMBER(10)
    , prz_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , czy_do_sredniej VARCHAR2(1 CHAR)
    , edycja VARCHAR2(1 CHAR)
    , opis_ang VARCHAR2(100 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Proto_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Proto_V_t
            , matched_proto_j IN V2u_Ko_Matched_Proto_J_t
            , grade_i IN V2u_Ko_Grade_I_t
            , student IN V2u_Ko_Student_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , protokol IN V2u_Dz_Protokol_t
            ) RETURN SELF AS RESULT

    );
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Protos_V_t
    AS TABLE OF V2u_Ko_Matched_Proto_V_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
