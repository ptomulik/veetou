CREATE OR REPLACE TYPE V2u_Ko_Dz_Program_Osoby_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( ko_job_uuid RAW(16)
    , ko_thread_id NUMBER(38)
    , ko_student_id NUMBER(38)
    , ko_specialty_id NUMBER(38)
    , ko_specialty_map_id NUMBER(38)
    , ko_thread_index NUMBER(4)
    , ko_student_index VARCHAR2(32 CHAR)
    , ko_student_name VARCHAR2(128 CHAR)
    , ko_first_name VARCHAR2(48 CHAR)
    , ko_last_name VARCHAR2(48 CHAR)
    , ko_university VARCHAR2(8 CHAR)
    , ko_faculty VARCHAR2(8 CHAR)
    , ko_studies_modetier VARCHAR2(100 CHAR)
    , ko_studies_field VARCHAR2(100 CHAR)
    , ko_studies_specialty VARCHAR2(100 CHAR)
    , ko_map_program_code VARCHAR2(32 CHAR)
    , ko_map_modetier_code VARCHAR2(32 CHAR)
    , ko_map_field_code VARCHAR2(32 CHAR)
    , ko_map_specialty_code VARCHAR2(32 CHAR)
    , ko_semester_ids V2u_Ids_t
    , ko_semester_numbers V2u_Ints2_t
    , ko_semester_codes V2u_Semester_Codes_t
    , ko_max_admission_semester VARCHAR2(6 CHAR)
    , dz_os_id NUMBER(10)
    , dz_prg_kod VARCHAR2(20 CHAR)
    --, dz_utw_id VARCHAR2(30 CHAR)
    --, dz_utw_data DATE
    --, dz_mod_id VARCHAR2(30 CHAR)
    --, dz_mod_data DATE
    , dz_st_id NUMBER(10)
    , dz_czy_glowny VARCHAR2(1 CHAR)
    , dz_id NUMBER(10)
    --, dz_data_nast_zal DATE
    --, dz_uprawnienia_zawodowe VARCHAR2(4000 CHAR)
    --, dz_uprawnienia_zawodowe_ang VARCHAR2(4000 CHAR)
    , dz_jed_org_kod VARCHAR2(20 CHAR)
    --, dz_dok_upr_id NUMBER(10)
    , dz_data_przyjecia DATE
    --, dz_plan_data_ukon DATE
    --, dz_czy_zgloszony VARCHAR2(1 CHAR)
    , dz_status VARCHAR2(6 CHAR)
    , dz_data_rozpoczecia DATE
    --, dz_numer_s NUMBER(10)
    --, dz_numer_swiadectwa VARCHAR2(25 CHAR)
    --, dz_tecz_id NUMBER(10)
    --, dz_data_arch DATE
    --, dz_warunki_przyjec_na_prog VARCHAR2(2000 CHAR)
    --, dz_warunki_przyjec_na_prog_ang VARCHAR2(2000 CHAR)
    --, dz_numer_do_banku NUMBER(10)
    --, dz_numer_do_banku_sygn VARCHAR2(50 CHAR)
    --, dz_numer_5_proc NUMBER(10)
    --, dz_numer_5_proc_sygn VARCHAR2(50 CHAR)
    --, dz_status_arch VARCHAR2(1 CHAR)
    --, dz_osiagniecia CLOB
    --, dz_osiagniecia_ang CLOB
    --, dz_nr_kierunku_ustawa VARCHAR2(1 CHAR)
    --, dz_limit_ects NUMBER(15,2)
    --, dz_dodatkowe_ects_uczelnia NUMBER(15,2)
    --, dz_wykorzystane_ects_obce NUMBER(15,2)
    --, dz_limit_ects_podpiecia NUMBER(15,2)
    , dz_prgos_id NUMBER(10)
    --, dz_osiagniecia_programu VARCHAR2(4000 CHAR)
    --, dz_osiagniecia_programu_ang VARCHAR2(4000 CHAR)
    --, dz_wynik_studiow VARCHAR2(100 CHAR)
    --, dz_wynik_studiow_ang VARCHAR2(100 CHAR)
    --, dz_umowa_data_przeczytania DATE
    --, dz_umowa_data_podpisania DATE
    --, dz_umowa_sygnatura VARCHAR2(20 CHAR)
    --, dz_kod_isced VARCHAR2(5 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Ko_Dz_Program_Osoby_t(
              SELF IN OUT NOCOPY V2u_Ko_Dz_Program_Osoby_t
            , ko_job_uuid IN RAW
            , ko_thread_id IN NUMBER
            , ko_student_id IN NUMBER
            , ko_specialty_id IN NUMBER
            , ko_specialty_map_id IN NUMBER
            , ko_thread_index IN NUMBER
            , ko_student_index IN VARCHAR2
            , ko_student_name IN VARCHAR2
            , ko_first_name IN VARCHAR2
            , ko_last_name IN VARCHAR2
            , ko_university IN VARCHAR2
            , ko_faculty IN VARCHAR2
            , ko_studies_modetier IN VARCHAR2
            , ko_studies_field IN VARCHAR2
            , ko_studies_specialty IN VARCHAR2
            , ko_map_program_code IN VARCHAR2
            , ko_map_modetier_code IN VARCHAR2
            , ko_map_field_code IN VARCHAR2
            , ko_map_specialty_code IN VARCHAR2
            , ko_semester_ids IN V2u_Ids_t
            , ko_semester_numbers IN V2u_Ints2_t
            , ko_semester_codes IN V2u_Semester_Codes_t
            , ko_max_admission_semester IN VARCHAR2
            , dz_os_id IN NUMBER
            , dz_prg_kod IN VARCHAR2
            --, dz_utw_id IN VARCHAR2
            --, dz_utw_data IN DATE
            --, dz_mod_id IN VARCHAR2
            --, dz_mod_data IN DATE
            , dz_st_id IN NUMBER
            , dz_czy_glowny IN VARCHAR2
            , dz_id IN NUMBER
            --, dz_data_nast_zal IN DATE
            --, dz_uprawnienia_zawodowe IN VARCHAR2
            --, dz_uprawnienia_zawodowe_ang IN VARCHAR2
            , dz_jed_org_kod IN VARCHAR2
            --, dz_dok_upr_id IN NUMBER
            , dz_data_przyjecia IN DATE
            --, dz_plan_data_ukon IN DATE
            --, dz_czy_zgloszony IN VARCHAR2
            , dz_status IN VARCHAR2
            , dz_data_rozpoczecia IN DATE
            --, dz_numer_s IN NUMBER
            --, dz_numer_swiadectwa IN VARCHAR2
            --, dz_tecz_id IN NUMBER
            --, dz_data_arch IN DATE
            --, dz_warunki_przyjec_na_prog IN VARCHAR2
            --, dz_warunki_przyjec_na_prog_ang IN VARCHAR2
            --, dz_numer_do_banku IN NUMBER
            --, dz_numer_do_banku_sygn IN VARCHAR2
            --, dz_numer_5_proc IN NUMBER
            --, dz_numer_5_proc_sygn IN VARCHAR2
            --, dz_status_arch IN VARCHAR2
            --, dz_osiagniecia IN CLOB
            --, dz_osiagniecia_ang IN CLOB
            --, dz_nr_kierunku_ustawa IN VARCHAR2
            --, dz_limit_ects IN NUMBER
            --, dz_dodatkowe_ects_uczelnia IN NUMBER
            --, dz_wykorzystane_ects_obce IN NUMBER
            --, dz_limit_ects_podpiecia IN NUMBER
            , dz_prgos_id IN NUMBER
            --, dz_osiagniecia_programu IN VARCHAR2
            --, dz_osiagniecia_programu_ang IN VARCHAR2
            --, dz_wynik_studiow IN VARCHAR2
            --, dz_wynik_studiow_ang IN VARCHAR2
            --, dz_umowa_data_przeczytania IN DATE
            --, dz_umowa_data_podpisania IN DATE
            --, dz_umowa_sygnatura IN VARCHAR2
            --, dz_kod_isced IN VARCHAR2
            ) RETURN SELF AS RESULT

    , CONSTRUCTOR FUNCTION V2u_Ko_Dz_Program_Osoby_t(
              SELF IN OUT NOCOPY V2u_Ko_Dz_Program_Osoby_t
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , specialty_map IN V2u_Specialty_Map_t
            , program_osoby IN V2u_Dz_Program_Osoby_t
            , semester_ids IN V2u_Ids_t
            , thread_id IN NUMBER
            , thread_index IN NUMBER
            , max_admission_semester IN VARCHAR2
            ) RETURN SELF AS RESULT

--    , ORDER MEMBER FUNCTION cmp(other IN V2u_Ko_Dz_Program_Osoby_t)
--            RETURN INTEGER
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Dz_Programy_Osob_t
    AS TABLE OF V2u_Ko_Dz_Program_Osoby_t;

-- vim: set ft=sql ts=4 sw=4 et:
