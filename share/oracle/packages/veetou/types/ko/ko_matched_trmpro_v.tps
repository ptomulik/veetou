CREATE OR REPLACE TYPE V2u_Ko_Matched_Trmpro_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Credit_U_t
    ( prot_id NUMBER(10)
    , nr NUMBER(10)
    , status VARCHAR2(2 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , opis VARCHAR2(100 CHAR)
    , data_zwrotu DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , egzamin_komisyjny VARCHAR2(1 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Trmpro_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Trmpro_V_t
            , matched_trmpro_j IN V2u_Ko_Matched_Trmpro_J_t
            , subject IN V2u_Ko_Subject_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , student IN V2u_Ko_Student_t
            , termin_protokolu IN V2u_Dz_Termin_Protokolu_t
            ) RETURN SELF AS RESULT

    );
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Trmpros_V_t
    AS TABLE OF V2u_Ko_Matched_Trmpro_V_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
