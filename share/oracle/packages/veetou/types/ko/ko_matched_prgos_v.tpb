CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Prgos_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Prgos_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Prgos_V_t
            , id IN NUMBER
            , job_uuid IN RAW
            , student_id IN NUMBER
            , specialty_id IN NUMBER
            , prgos_id IN NUMBER
            , ko_student_index IN VARCHAR2
            , ko_student_name IN VARCHAR2
            , ko_first_name IN VARCHAR2
            , ko_last_name IN VARCHAR2
            , ko_university IN VARCHAR2
            , ko_faculty IN VARCHAR2
            , ko_studies_modetier IN VARCHAR2
            , ko_studies_field IN VARCHAR2
            , ko_studies_specialty IN VARCHAR2
            , ko_semester_ids IN V2u_Ids_t
            , ko_semester_numbers IN V2u_Ints2_t
            , ko_semester_codes IN V2u_Semester_Codes_t
            , dz_os_id IN NUMBER
            , dz_prg_kod IN VARCHAR2
            --, dz_utw_id IN VARCHAR2
            --, dz_utw_data IN DATE
            --, dz_mod_id IN VARCHAR2
            --, dz_mod_data IN DATE
            , dz_st_id IN NUMBER
            , dz_czy_glowny IN VARCHAR2
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
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := job_uuid;
        SELF.student_id := student_id;
        SELF.specialty_id := specialty_id;
        SELF.prgos_id := prgos_id;
        SELF.ko_student_index := ko_student_index;
        SELF.ko_student_name := ko_student_name;
        SELF.ko_first_name := ko_first_name;
        SELF.ko_last_name := ko_last_name;
        SELF.ko_university := ko_university;
        SELF.ko_faculty := ko_faculty;
        SELF.ko_studies_modetier := ko_studies_modetier;
        SELF.ko_studies_field := ko_studies_field;
        SELF.ko_studies_specialty := ko_studies_specialty;
        SELF.ko_semester_ids := ko_semester_ids;
        SELF.ko_semester_numbers := ko_semester_numbers;
        SELF.ko_semester_codes := ko_semester_codes;
        SELF.dz_os_id := dz_os_id;
        SELF.dz_prg_kod := dz_prg_kod;
        --SELF.dz_utw_id := utw_id;
        --SELF.dz_utw_data := utw_data;
        --SELF.dz_mod_id := dz_mod_id;
        --SELF.dz_mod_data := dz_mod_data;
        SELF.dz_st_id := dz_st_id;
        SELF.dz_czy_glowny := dz_czy_glowny;
        --SELF.dz_data_nast_zal := dz_data_nast_zal;
        --SELF.dz_uprawnienia_zawodowe := dz_uprawnienia_zawodowe;
        --SELF.dz_uprawnienia_zawodowe_ang := dz_uprawnienia_zawodowe_ang;
        SELF.dz_jed_org_kod := dz_jed_org_kod;
        --SELF.dz_dok_upr_id := dz_dok_upr_id;
        SELF.dz_data_przyjecia := dz_data_przyjecia;
        --SELF.dz_plan_data_ukon := dz_plan_data_ukon;
        --SELF.dz_czy_zgloszony := dz_czy_zgloszony;
        SELF.dz_status := dz_status;
        SELF.dz_data_rozpoczecia := dz_data_rozpoczecia;
        --SELF.dz_numer_s := dz_numer_s;
        --SELF.dz_numer_swiadectwa := dz_numer_swiadectwa;
        --SELF.dz_tecz_id := dz_tecz_id;
        --SELF.dz_data_arch := dz_data_arch;
        --SELF.dz_warunki_przyjec_na_prog := dz_warunki_przyjec_na_prog;
        --SELF.dz_warunki_przyjec_na_prog_ang := dz_warunki_przyjec_na_prog_ang;
        --SELF.dz_numer_do_banku := dz_numer_do_banku;
        --SELF.dz_numer_do_banku_sygn := dz_numer_do_banku_sygn;
        --SELF.dz_numer_5_proc := dz_numer_5_proc;
        --SELF.dz_numer_5_proc_sygn := dz_numer_5_proc_sygn;
        --SELF.dz_status_arch := dz_status_arch;
        --SELF.dz_osiagniecia := dz_osiagniecia;
        --SELF.dz_osiagniecia_ang := dz_osiagniecia_ang;
        --SELF.dz_nr_kierunku_ustawa := dz_nr_kierunku_ustawa;
        --SELF.dz_limit_ects := dz_limit_ects;
        --SELF.dz_dodatkowe_ects_uczelnia := dz_dodatkowe_ects_uczelnia;
        --SELF.dz_wykorzystane_ects_obce := dz_wykorzystane_ects_obce;
        --SELF.dz_limit_ects_podpiecia := dz_limit_ects_podpiecia;
        SELF.dz_prgos_id := dz_prgos_id;
        --SELF.dz_osiagniecia_programu := dz_osiagniecia_programu;
        --SELF.dz_osiagniecia_programu_ang := dz_osiagniecia_programu_ang;
        --SELF.dz_wynik_studiow := dz_wynik_studiow;
        --SELF.dz_wynik_studiow_ang := dz_wynik_studiow_ang;
        --SELF.dz_umowa_data_przeczytania := dz_umowa_data_przeczytania;
        --SELF.dz_umowa_data_podpisania := dz_umowa_data_podpisania;
        --SELF.dz_umowa_sygnatura := dz_umowa_sygnatura;
        --SELF.dz_kod_isced := dz_kod_isced;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Prgos_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Prgos_V_t
            , id IN NUMBER
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , program_osoby IN V2u_Dz_Program_Osoby_t
            , semester_ids IN V2u_Ids_t
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := student.job_uuid;
        SELF.student_id := student.id;
        SELF.specialty_id := specialty.id;
        SELF.prgos_id := program_osoby.id;
        SELF.ko_student_index := student.student_index;
        SELF.ko_student_name := student.student_name;
        SELF.ko_first_name := student.first_name;
        SELF.ko_last_name := student.last_name;
        SELF.ko_university := specialty.university;
        SELF.ko_faculty := specialty.faculty;
        SELF.ko_studies_modetier := specialty.studies_modetier;
        SELF.ko_studies_field := specialty.studies_field;
        SELF.ko_studies_specialty := specialty.studies_specialty;
        --
        SELF.ko_semester_ids := semester_ids;
        SELF.ko_semester_numbers := V2u_Ints2_t();
        SELF.ko_semester_codes := V2u_Semester_Codes_t();
        SELECT
              s.semester_number
            , s.semester_code
        BULK COLLECT INTO
              SELF.ko_semester_numbers
            , SELF.ko_semester_codes
        FROM v2u_ko_semesters s
        CROSS JOIN TABLE(semester_ids) s_ids
            WHERE (s.id  = VALUE(s_ids))
        ORDER BY VALUE(s_ids);
        --
        SELF.dz_os_id := program_osoby.os_id;
        SELF.dz_prg_kod := program_osoby.prg_kod;
        --SELF.dz_utw_id := utw_id;
        --SELF.dz_utw_data := utw_data;
        --SELF.dz_mod_id := program_osoby.mod_id;
        --SELF.dz_mod_data := program_osoby.mod_data;
        SELF.dz_st_id := program_osoby.st_id;
        SELF.dz_czy_glowny := program_osoby.czy_glowny;
        --SELF.dz_data_nast_zal := program_osoby.data_nast_zal;
        --SELF.dz_uprawnienia_zawodowe := program_osoby.uprawnienia_zawodowe;
        --SELF.dz_uprawnienia_zawodowe_ang := program_osoby.uprawnienia_zawodowe_ang;
        SELF.dz_jed_org_kod := program_osoby.jed_org_kod;
        --SELF.dz_dok_upr_id := program_osoby.dok_upr_id;
        SELF.dz_data_przyjecia := program_osoby.data_przyjecia;
        --SELF.dz_plan_data_ukon := program_osoby.plan_data_ukon;
        --SELF.dz_czy_zgloszony := program_osoby.czy_zgloszony;
        SELF.dz_status := program_osoby.status;
        SELF.dz_data_rozpoczecia := program_osoby.data_rozpoczecia;
        --SELF.dz_numer_s := program_osoby.numer_s;
        --SELF.dz_numer_swiadectwa := program_osoby.numer_swiadectwa;
        --SELF.dz_tecz_id := program_osoby.tecz_id;
        --SELF.dz_data_arch := program_osoby.data_arch;
        --SELF.dz_warunki_przyjec_na_prog := program_osoby.warunki_przyjec_na_prog;
        --SELF.dz_warunki_przyjec_na_prog_ang := program_osoby.warunki_przyjec_na_prog_ang;
        --SELF.dz_numer_do_banku := program_osoby.numer_do_banku;
        --SELF.dz_numer_do_banku_sygn := program_osoby.numer_do_banku_sygn;
        --SELF.dz_numer_5_proc := program_osoby.numer_5_proc;
        --SELF.dz_numer_5_proc_sygn := program_osoby.numer_5_proc_sygn;
        --SELF.dz_status_arch := program_osoby.status_arch;
        --SELF.dz_osiagniecia := program_osoby.osiagniecia;
        --SELF.dz_osiagniecia_ang := program_osoby.osiagniecia_ang;
        --SELF.dz_nr_kierunku_ustawa := program_osoby.nr_kierunku_ustawa;
        --SELF.dz_limit_ects := program_osoby.limit_ects;
        --SELF.dz_dodatkowe_ects_uczelnia := program_osoby.dodatkowe_ects_uczelnia;
        --SELF.dz_wykorzystane_ects_obce := program_osoby.wykorzystane_ects_obce;
        --SELF.dz_limit_ects_podpiecia := program_osoby.limit_ects_podpiecia;
        SELF.dz_prgos_id := program_osoby.prgos_id;
        --SELF.dz_osiagniecia_programu := program_osoby.osiagniecia_programu;
        --SELF.dz_osiagniecia_programu_ang := program_osoby.osiagniecia_programu_ang;
        --SELF.dz_wynik_studiow := program_osoby.wynik_studiow;
        --SELF.dz_wynik_studiow_ang := program_osoby.wynik_studiow_ang;
        --SELF.dz_umowa_data_przeczytania := program_osoby.umowa_data_przeczytania;
        --SELF.dz_umowa_data_podpisania := program_osoby.umowa_data_podpisania;
        --SELF.dz_umowa_sygnatura := program_osoby.umowa_sygnatura;
        --SELF.dz_kod_isced := program_osoby.kod_isced;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
