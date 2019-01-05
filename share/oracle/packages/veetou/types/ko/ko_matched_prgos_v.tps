CREATE OR REPLACE TYPE V2u_Ko_Matched_Prgos_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Student_Semester_V_t
    ( prgos_id NUMBER(10)
    , os_id NUMBER(10)
    , prg_kod VARCHAR2(20 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , st_id NUMBER(10)
    , czy_glowny VARCHAR2(1 CHAR)
    , data_nast_zal DATE
    , uprawnienia_zawodowe VARCHAR2(4000 CHAR)
    , uprawnienia_zawodowe_ang VARCHAR2(4000 CHAR)
    , jed_org_kod VARCHAR2(20 CHAR)
    , dok_upr_id NUMBER(10)
    , data_przyjecia DATE
    , plan_data_ukon DATE
    , czy_zgloszony VARCHAR2(1 CHAR)
    , status VARCHAR2(6 CHAR)
    , data_rozpoczecia DATE
    , numer_s NUMBER(10)
    , numer_swiadectwa VARCHAR2(25 CHAR)
    , tecz_id NUMBER(10)
    , data_arch DATE
    , warunki_przyjec_na_prog VARCHAR2(2000 CHAR)
    , warunki_przyjec_na_prog_ang VARCHAR2(2000 CHAR)
    , numer_do_banku NUMBER(10)
    , numer_do_banku_sygn VARCHAR2(50 CHAR)
    , numer_5_proc NUMBER(10)
    , numer_5_proc_sygn VARCHAR2(50 CHAR)
    , status_arch VARCHAR2(1 CHAR)
    , osiagniecia CLOB
    , osiagniecia_ang CLOB
    , nr_kierunku_ustawa VARCHAR2(1 CHAR)
    , limit_ects NUMBER(15,2)
    , dodatkowe_ects_uczelnia NUMBER(15,2)
    , wykorzystane_ects_obce NUMBER(15,2)
    , limit_ects_podpiecia NUMBER(15,2)
    , prgos_prgos_id NUMBER(10)
    , osiagniecia_programu VARCHAR2(4000 CHAR)
    , osiagniecia_programu_ang VARCHAR2(4000 CHAR)
    , wynik_studiow VARCHAR2(100 CHAR)
    , wynik_studiow_ang VARCHAR2(100 CHAR)
    , umowa_data_przeczytania DATE
    , umowa_data_podpisania DATE
    , umowa_sygnatura VARCHAR2(20 CHAR)
    , kod_isced VARCHAR2(5 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Matched_Prgos_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Prgos_V_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , program_osoby IN V2u_Dz_Program_Osoby_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Prgos_V_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , ects_attained IN NUMBER
            , program_osoby IN V2u_Dz_Program_Osoby_t
            )
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Matched_Prgoses_V_t
    AS TABLE OF V2u_Ko_Matched_Prgos_V_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
