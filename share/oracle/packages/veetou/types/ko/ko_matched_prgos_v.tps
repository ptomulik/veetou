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
            , job_uuid IN RAW
            , student_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , student_index VARCHAR2
            , student_name VARCHAR2
            , first_name VARCHAR2
            , last_name VARCHAR2
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_number IN NUMBER
            , semester_code IN VARCHAR2
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , ects_attained IN NUMBER
            , prgos_id IN NUMBER
            , os_id IN NUMBER
            , prg_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , st_id IN NUMBER
            , czy_glowny IN VARCHAR2
            , data_nast_zal IN DATE
            , uprawnienia_zawodowe IN VARCHAR2
            , uprawnienia_zawodowe_ang IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , dok_upr_id IN NUMBER
            , data_przyjecia IN DATE
            , plan_data_ukon IN DATE
            , czy_zgloszony IN VARCHAR2
            , status IN VARCHAR2
            , data_rozpoczecia IN DATE
            , numer_s IN NUMBER
            , numer_swiadectwa IN VARCHAR2
            , tecz_id IN NUMBER
            , data_arch IN DATE
            , warunki_przyjec_na_prog IN VARCHAR2
            , warunki_przyjec_na_prog_ang IN VARCHAR2
            , numer_do_banku IN NUMBER
            , numer_do_banku_sygn IN VARCHAR2
            , numer_5_proc IN NUMBER
            , numer_5_proc_sygn IN VARCHAR2
            , status_arch IN VARCHAR2
            , osiagniecia IN CLOB
            , osiagniecia_ang IN CLOB
            , nr_kierunku_ustawa IN VARCHAR2
            , limit_ects IN NUMBER
            , dodatkowe_ects_uczelnia IN NUMBER
            , wykorzystane_ects_obce IN NUMBER
            , limit_ects_podpiecia IN NUMBER
            , prgos_prgos_id IN NUMBER
            , osiagniecia_programu IN VARCHAR2
            , osiagniecia_programu_ang IN VARCHAR2
            , wynik_studiow IN VARCHAR2
            , wynik_studiow_ang IN VARCHAR2
            , umowa_data_przeczytania IN DATE
            , umowa_data_podpisania IN DATE
            , umowa_sygnatura IN VARCHAR2
            , kod_isced IN VARCHAR2
            ) RETURN SELF AS RESULT

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
            , job_uuid IN RAW
            , student_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , student_index VARCHAR2
            , student_name VARCHAR2
            , first_name VARCHAR2
            , last_name VARCHAR2
            , university IN VARCHAR2
            , faculty IN VARCHAR2
            , studies_modetier IN VARCHAR2
            , studies_field IN VARCHAR2
            , studies_specialty IN VARCHAR2
            , semester_number IN NUMBER
            , semester_code IN VARCHAR2
            , ects_mandatory IN NUMBER
            , ects_other IN NUMBER
            , ects_total IN NUMBER
            , ects_attained IN NUMBER
            , prgos_id IN NUMBER
            , os_id IN NUMBER
            , prg_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , st_id IN NUMBER
            , czy_glowny IN VARCHAR2
            , data_nast_zal IN DATE
            , uprawnienia_zawodowe IN VARCHAR2
            , uprawnienia_zawodowe_ang IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , dok_upr_id IN NUMBER
            , data_przyjecia IN DATE
            , plan_data_ukon IN DATE
            , czy_zgloszony IN VARCHAR2
            , status IN VARCHAR2
            , data_rozpoczecia IN DATE
            , numer_s IN NUMBER
            , numer_swiadectwa IN VARCHAR2
            , tecz_id IN NUMBER
            , data_arch IN DATE
            , warunki_przyjec_na_prog IN VARCHAR2
            , warunki_przyjec_na_prog_ang IN VARCHAR2
            , numer_do_banku IN NUMBER
            , numer_do_banku_sygn IN VARCHAR2
            , numer_5_proc IN NUMBER
            , numer_5_proc_sygn IN VARCHAR2
            , status_arch IN VARCHAR2
            , osiagniecia IN CLOB
            , osiagniecia_ang IN CLOB
            , nr_kierunku_ustawa IN VARCHAR2
            , limit_ects IN NUMBER
            , dodatkowe_ects_uczelnia IN NUMBER
            , wykorzystane_ects_obce IN NUMBER
            , limit_ects_podpiecia IN NUMBER
            , prgos_prgos_id IN NUMBER
            , osiagniecia_programu IN VARCHAR2
            , osiagniecia_programu_ang IN VARCHAR2
            , wynik_studiow IN VARCHAR2
            , wynik_studiow_ang IN VARCHAR2
            , umowa_data_przeczytania IN DATE
            , umowa_data_podpisania IN DATE
            , umowa_sygnatura IN VARCHAR2
            , kod_isced IN VARCHAR2
            )

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

-- vim: set ft=sql ts=4 sw=4 et:
