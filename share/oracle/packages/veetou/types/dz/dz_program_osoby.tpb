CREATE OR REPLACE TYPE BODY V2u_Dz_Program_Osoby_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Program_Osoby_t(
              SELF IN OUT NOCOPY V2u_Dz_Program_Osoby_t
            , os_id IN NUMBER
            , prg_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , st_id IN NUMBER
            , czy_glowny IN VARCHAR2
            , id IN NUMBER
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
            , prgos_id IN NUMBER
            , osiagniecia_programu IN VARCHAR2
            , osiagniecia_programu_ang IN VARCHAR2
            , wynik_studiow IN VARCHAR2
            , wynik_studiow_ang IN VARCHAR2
            , umowa_data_przeczytania IN DATE
            , umowa_data_podpisania IN DATE
            , umowa_sygnatura IN VARCHAR2
            , kod_isced IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.os_id := os_id;
        SELF.prg_kod := prg_kod;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.st_id := st_id;
        SELF.czy_glowny := czy_glowny;
        SELF.id := id;
        SELF.data_nast_zal := data_nast_zal;
        SELF.uprawnienia_zawodowe := uprawnienia_zawodowe;
        SELF.uprawnienia_zawodowe_ang := uprawnienia_zawodowe_ang;
        SELF.jed_org_kod := jed_org_kod;
        SELF.dok_upr_id := dok_upr_id;
        SELF.data_przyjecia := data_przyjecia;
        SELF.plan_data_ukon := plan_data_ukon;
        SELF.czy_zgloszony := czy_zgloszony;
        SELF.status := status;
        SELF.data_rozpoczecia := data_rozpoczecia;
        SELF.numer_s := numer_s;
        SELF.numer_swiadectwa := numer_swiadectwa;
        SELF.tecz_id := tecz_id;
        SELF.data_arch := data_arch;
        SELF.warunki_przyjec_na_prog := warunki_przyjec_na_prog;
        SELF.warunki_przyjec_na_prog_ang := warunki_przyjec_na_prog_ang;
        SELF.numer_do_banku := numer_do_banku;
        SELF.numer_do_banku_sygn := numer_do_banku_sygn;
        SELF.numer_5_proc := numer_5_proc;
        SELF.numer_5_proc_sygn := numer_5_proc_sygn;
        SELF.status_arch := status_arch;
        SELF.osiagniecia := osiagniecia;
        SELF.osiagniecia_ang := osiagniecia_ang;
        SELF.nr_kierunku_ustawa := nr_kierunku_ustawa;
        SELF.limit_ects := limit_ects;
        SELF.dodatkowe_ects_uczelnia := dodatkowe_ects_uczelnia;
        SELF.wykorzystane_ects_obce := wykorzystane_ects_obce;
        SELF.limit_ects_podpiecia := limit_ects_podpiecia;
        SELF.prgos_id := prgos_id;
        SELF.osiagniecia_programu := osiagniecia_programu;
        SELF.osiagniecia_programu_ang := osiagniecia_programu_ang;
        SELF.wynik_studiow := wynik_studiow;
        SELF.wynik_studiow_ang := wynik_studiow_ang;
        SELF.umowa_data_przeczytania := umowa_data_przeczytania;
        SELF.umowa_data_podpisania := umowa_data_podpisania;
        SELF.umowa_sygnatura := umowa_sygnatura;
        SELF.kod_isced := kod_isced;
        RETURN;
    END;

--    CONSTRUCTOR FUNCTION V2u_Dz_Program_Osoby_t(
--              SELF IN OUT NOCOPY V2u_Dz_Program_Osoby_t
--            , student IN V2u_Ko_Student_t
--            , specialty IN V2u_Ko_Specialty_t
--            , specialty_map IN V2u_Specialty_Map_t
--            , semester_ids IN V2u_Ids_t
--            , thread_index IN NUMBER
--            , max_admission_semester IN VARCHAR2
--            ) RETURN SELF AS RESULT
--    IS
--    BEGIN
--        SELF.v2u_job_uuid := student.job_uuid;
--        SELF.v2u_student_id := student.id;
--        SELF.v2u_specialty_id := specialty.id;
--        SELF.v2u_specialty_map_id := specialty_map.id;
--        SELF.v2u_thread_index := thread_index;
--        SELF.v2u_student_index := student.student_index;
--        SELF.v2u_student_name := student.student_name;
--        SELF.v2u_first_name := student.first_name;
--        SELF.v2u_last_name := student.last_name;
--        SELF.v2u_university := specialty.university;
--        SELF.v2u_faculty := specialty.faculty;
--        SELF.v2u_studies_modetier := specialty.studies_modetier;
--        SELF.v2u_studies_field := specialty.studies_field;
--        SELF.v2u_studies_specialty := specialty.studies_specialty;
--        SELF.v2u_map_program_code := specialty_map.map_program_code;
--        SELF.v2u_map_modetier_code := specialty_map.map_modetier_code;
--        SELF.v2u_map_field_code := specialty_map.map_field_code;
--        SELF.v2u_map_specialty_code := specialty_map.map_specialty_code;
--        --
--        SELF.v2u_semester_ids := semester_ids;
--        SELF.v2u_semester_numbers := V2u_Ints2_t();
--        SELF.v2u_semester_codes := V2u_Semester_Codes_t();
--        SELECT
--              s.semester_number
--            , s.semester_code
--        BULK COLLECT INTO
--              SELF.v2u_semester_numbers
--            , SELF.v2u_semester_codes
--        FROM v2u_ko_semesters s
--        CROSS JOIN TABLE(semester_ids) s_ids
--            WHERE (s.id  = VALUE(s_ids));
--        --
--        SELF.v2u_max_admission_semester := max_admission_semester;
--        RETURN;
--    END;
--
--    ORDER MEMBER FUNCTION cmp(other IN V2u_Dz_Program_Osoby_t)
--            RETURN INTEGER
--    IS
--        ord INTEGER;
--    BEGIN
--        ord := V2U_Cmp.StrNI(v2u_student_index, other.v2u_student_index);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(v2u_student_name, other.v2u_student_name);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(v2u_first_name, other.v2u_first_name);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(v2u_last_name, other.v2u_last_name);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(v2u_university, other.v2u_university);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(v2u_faculty, other.v2u_faculty);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(v2u_studies_modetier, other.v2u_studies_modetier);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(v2u_studies_field, other.v2u_studies_field);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(v2u_studies_specialty, other.v2u_studies_specialty);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(v2u_map_program_code, other.v2u_map_program_code);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(v2u_map_modetier_code, other.v2u_map_modetier_code);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(v2u_map_field_code, other.v2u_map_field_code);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.StrNI(v2u_map_specialty_code, other.v2u_map_specialty_code);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        ord := V2U_Cmp.NumN(v2u_thread_index, other.v2u_thread_index);
--        IF ord <> 0 THEN RETURN ord; END IF;
--        RETURN V2U_Cmp.StrNI(v2u_max_admission_semester, other.v2u_max_admission_semester);
--    END;
END;

-- vim: set ft=sql ts=4 sw=4 et: