CREATE OR REPLACE TYPE BODY V2u_Ko_Matched_Etpos_V_t AS
    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Etpos_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_V_t
            , id IN NUMBER
            , job_uuid IN RAW
            , student_id IN NUMBER
            , specialty_id IN NUMBER
            , semester_id IN NUMBER
            , specialty_map_id IN NUMBER
            , etpos_id IN NUMBER
            , etp_kod_missmatch IN VARCHAR2
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
            , ko_semester_number IN NUMBER
            , ko_semester_code IN VARCHAR2
            , dz_data_zakon IN DATE
            , dz_utw_id IN VARCHAR2
            , dz_utw_data IN DATE
            , dz_mod_id IN VARCHAR2
            , dz_mod_data IN DATE
            , dz_status_zaliczenia IN VARCHAR2
            , dz_etp_kod IN VARCHAR2
            , dz_prg_kod IN VARCHAR2
            , dz_prgos_id IN NUMBER
            , dz_cdyd_kod IN VARCHAR2
            , dz_status_zal_komentarz IN VARCHAR2
            , dz_liczba_war IN NUMBER
            , dz_wym_cdyd_kod IN VARCHAR2
            , dz_czy_platny_na_2_kier IN VARCHAR2
            , dz_ects_uzyskane IN NUMBER
            , dz_czy_przedluzenie IN VARCHAR2
            , dz_urlop_kod IN VARCHAR2
            , dz_ects_efekty_uczenia IN NUMBER
            , dz_ects_przepisane IN NUMBER
            , dz_kolejnosc IN NUMBER
            , dz_czy_erasmus IN VARCHAR2
            , dz_jedn_dyplomujaca IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := job_uuid;
        SELF.student_id := student_id;
        SELF.specialty_id := specialty_id;
        SELF.semester_id := semester_id;
        SELF.specialty_map_id := specialty_map_id;
        SELF.etpos_id := etpos_id;
        SELF.etp_kod_missmatch := etp_kod_missmatch;
        SELF.ko_student_index := ko_student_index;
        SELF.ko_student_name := ko_student_name;
        SELF.ko_first_name := ko_first_name;
        SELF.ko_last_name := ko_last_name;
        SELF.ko_university := ko_university;
        SELF.ko_faculty := ko_faculty;
        SELF.ko_studies_modetier := ko_studies_modetier;
        SELF.ko_studies_field := ko_studies_field;
        SELF.ko_studies_specialty := ko_studies_specialty;
        SELF.ko_map_program_code := ko_map_program_code;
        SELF.ko_map_modetier_code := ko_map_modetier_code;
        SELF.ko_map_field_code := ko_map_field_code;
        SELF.ko_map_specialty_code := ko_map_specialty_code;
        SELF.ko_semester_number := ko_semester_number;
        SELF.ko_semester_code := ko_semester_code;
        SELF.dz_data_zakon := dz_data_zakon;
        SELF.dz_utw_id := dz_utw_id;
        SELF.dz_utw_data := dz_utw_data;
        SELF.dz_mod_id := dz_mod_id;
        SELF.dz_mod_data := dz_mod_data;
        SELF.dz_status_zaliczenia := dz_status_zaliczenia;
        SELF.dz_etp_kod := dz_etp_kod;
        SELF.dz_prg_kod := dz_prg_kod;
        SELF.dz_prgos_id := dz_prgos_id;
        SELF.dz_cdyd_kod := dz_cdyd_kod;
        SELF.dz_status_zal_komentarz := dz_status_zal_komentarz;
        SELF.dz_liczba_war := dz_liczba_war;
        SELF.dz_wym_cdyd_kod := dz_wym_cdyd_kod;
        SELF.dz_czy_platny_na_2_kier := dz_czy_platny_na_2_kier;
        SELF.dz_ects_uzyskane := dz_ects_uzyskane;
        SELF.dz_czy_przedluzenie := dz_czy_przedluzenie;
        SELF.dz_urlop_kod := dz_urlop_kod;
        SELF.dz_ects_efekty_uczenia := dz_ects_efekty_uczenia;
        SELF.dz_ects_przepisane := dz_ects_przepisane;
        SELF.dz_kolejnosc := dz_kolejnosc;
        SELF.dz_czy_erasmus := dz_czy_erasmus;
        SELF.dz_jedn_dyplomujaca := dz_jedn_dyplomujaca;
        RETURN;
    END;

    CONSTRUCTOR FUNCTION V2u_Ko_Matched_Etpos_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Matched_Etpos_V_t
            , id IN NUMBER
            , student IN V2u_Ko_Student_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , specialty_map IN V2u_Specialty_Map_t
            , etap_osoby IN V2u_Dz_Etap_Osoby_t
            , etp_kod_missmatch IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.id := id;
        SELF.job_uuid := student.job_uuid;
        SELF.student_id := student.id;
        SELF.specialty_id := specialty.id;
        SELF.semester_id := semester.id;
        SELF.specialty_map_id := specialty_map.id;
        SELF.etpos_id := etap_osoby.id;
        SELF.etp_kod_missmatch := etp_kod_missmatch;
        SELF.ko_student_index := student.student_index;
        SELF.ko_student_name := student.student_name;
        SELF.ko_first_name := student.first_name;
        SELF.ko_last_name := student.last_name;
        SELF.ko_university := specialty.university;
        SELF.ko_faculty := specialty.faculty;
        SELF.ko_studies_modetier := specialty.studies_modetier;
        SELF.ko_studies_field := specialty.studies_field;
        SELF.ko_studies_specialty := specialty.studies_specialty;
        SELF.ko_map_program_code := specialty_map.map_program_code;
        SELF.ko_map_modetier_code := specialty_map.map_modetier_code;
        SELF.ko_map_field_code := specialty_map.map_field_code;
        SELF.ko_map_specialty_code := specialty_map.map_specialty_code;
        SELF.ko_semester_number := semester.semester_number;
        SELF.ko_semester_code := semester.semester_code;
        SELF.dz_data_zakon := etap_osoby.data_zakon;
        SELF.dz_utw_id := etap_osoby.utw_id;
        SELF.dz_utw_data := etap_osoby.utw_data;
        SELF.dz_mod_id := etap_osoby.mod_id;
        SELF.dz_mod_data := etap_osoby.mod_data;
        SELF.dz_status_zaliczenia := etap_osoby.status_zaliczenia;
        SELF.dz_etp_kod := etap_osoby.etp_kod;
        SELF.dz_prg_kod := etap_osoby.prg_kod;
        SELF.dz_prgos_id := etap_osoby.prgos_id;
        SELF.dz_cdyd_kod := etap_osoby.cdyd_kod;
        SELF.dz_status_zal_komentarz := etap_osoby.status_zal_komentarz;
        SELF.dz_liczba_war := etap_osoby.liczba_war;
        SELF.dz_wym_cdyd_kod := etap_osoby.wym_cdyd_kod;
        SELF.dz_czy_platny_na_2_kier := etap_osoby.czy_platny_na_2_kier;
        SELF.dz_ects_uzyskane := etap_osoby.ects_uzyskane;
        SELF.dz_czy_przedluzenie := etap_osoby.czy_przedluzenie;
        SELF.dz_urlop_kod := etap_osoby.urlop_kod;
        SELF.dz_ects_efekty_uczenia := etap_osoby.ects_efekty_uczenia;
        SELF.dz_ects_przepisane := etap_osoby.ects_przepisane;
        SELF.dz_kolejnosc := etap_osoby.kolejnosc;
        SELF.dz_czy_erasmus := etap_osoby.czy_erasmus;
        SELF.dz_jedn_dyplomujaca := etap_osoby.jedn_dyplomujaca;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
