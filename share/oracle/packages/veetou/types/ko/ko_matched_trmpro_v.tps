CREATE OR REPLACE TYPE V2u_Ko_Matched_Trmpro_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Credit_U_t
    ( -- PROTOKOL
      zaj_cyk_id NUMBER(10)
    , prot_opis VARCHAR2(100 CHAR)
    , tpro_kod VARCHAR2(20 CHAR)
    , prot_id NUMBER(10)
    , prz_kod VARCHAR2(20 CHAR)
    , cdyd_kod VARCHAR2(20 CHAR)
    , czy_do_sredniej VARCHAR2(1 CHAR)
    , edycja VARCHAR2(1 CHAR)
    , prot_opis_ang VARCHAR2(100 CHAR)
    -- TERMIN_PROTOKOLU
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
            , protokol IN V2u_Dz_Protokol_t
            , termin_protokolu IN V2u_Dz_Termin_Protokolu_t
            ) RETURN SELF AS RESULT

    );
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Trmpros_V_t
    AS TABLE OF V2u_Ko_Matched_Trmpro_V_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
