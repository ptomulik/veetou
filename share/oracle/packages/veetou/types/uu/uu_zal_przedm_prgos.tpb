CREATE OR REPLACE TYPE BODY V2u_Uu_Zal_Przedm_Prgos_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Zal_Przedm_Prgos_t(
              SELF IN OUT NOCOPY V2u_Uu_Zal_Przedm_Prgos_t
            , os_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , prgos_id IN NUMBER
            , stan IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , etpos_id IN NUMBER
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , do_sredniej IN VARCHAR2
            , do_sredniej_zmiana_os_id IN NUMBER
            , do_sredniej_zmiana_data IN DATE
            , podp_data IN DATE
            , podp_os_id IN NUMBER
            , czy_platny_ects_ustawa IN VARCHAR2
            , kto_placi IN VARCHAR2
            , podp_etpos_data IN DATE
            , podp_etpos_os_id IN NUMBER
            , katprz_id IN NUMBER
            , pw_ponadprogramowy IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_zal_przedm_prgos IN VARCHAR2
            -- DBG
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_os_ids IN NUMBER
            , dbg_cdyd_kody IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_prgos_ids IN NUMBER
            , dbg_etpos_ids IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_przedmioty_cykli IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_stany IN NUMBER
            , dbg_student_indexes IN NUMBER
            , dbg_subj_codes IN NUMBER
            , dbg_subject_mapped IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              os_id => os_id
            , prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , prgos_id => prgos_id
            , stan => stan
            , utw_id => utw_id
            , utw_data => utw_data
            , etpos_id => etpos_id
            , mod_id => mod_id
            , mod_data => mod_data
            , do_sredniej => do_sredniej
            , do_sredniej_zmiana_os_id => do_sredniej_zmiana_os_id
            , do_sredniej_zmiana_data => do_sredniej_zmiana_data
            , podp_data => podp_data
            , podp_os_id => podp_os_id
            , czy_platny_ects_ustawa => czy_platny_ects_ustawa
            , kto_placi => kto_placi
            , podp_etpos_data => podp_etpos_data
            , podp_etpos_os_id => podp_etpos_os_id
            , katprz_id => katprz_id
            , pw_ponadprogramowy => pw_ponadprogramowy
            -- KEY
            , job_uuid => job_uuid
            , pk_zal_przedm_prgos => pk_zal_przedm_prgos
            -- DBG
            , dbg_matched => dbg_matched
            , dbg_missing => dbg_missing
            , dbg_os_ids => dbg_os_ids
            , dbg_cdyd_kody => dbg_cdyd_kody
            , dbg_prz_kody => dbg_prz_kody
            , dbg_prgos_ids => dbg_prgos_ids
            , dbg_etpos_ids => dbg_etpos_ids
            , dbg_map_subj_codes => dbg_map_subj_codes
            , dbg_przedmioty_cykli => dbg_przedmioty_cykli
            , dbg_semester_codes => dbg_semester_codes
            , dbg_stany => dbg_stany
            , dbg_student_indexes => dbg_student_indexes
            , dbg_subj_codes => dbg_subj_codes
            , dbg_subject_mapped => dbg_subject_mapped
            , dbg_unique_match => dbg_unique_match
            , dbg_values_ok => dbg_values_ok
            -- CTL
            , change_type => change_type
            , safe_to_change => safe_to_change
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Zal_Przedm_Prgos_t
            , os_id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , prgos_id IN NUMBER
            , stan IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , etpos_id IN NUMBER
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , do_sredniej IN VARCHAR2
            , do_sredniej_zmiana_os_id IN NUMBER
            , do_sredniej_zmiana_data IN DATE
            , podp_data IN DATE
            , podp_os_id IN NUMBER
            , czy_platny_ects_ustawa IN VARCHAR2
            , kto_placi IN VARCHAR2
            , podp_etpos_data IN DATE
            , podp_etpos_os_id IN NUMBER
            , katprz_id IN NUMBER
            , pw_ponadprogramowy IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_zal_przedm_prgos IN VARCHAR2
            -- DBG
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_os_ids IN NUMBER
            , dbg_cdyd_kody IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_prgos_ids IN NUMBER
            , dbg_etpos_ids IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_przedmioty_cykli IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_stany IN NUMBER
            , dbg_student_indexes IN NUMBER
            , dbg_subj_codes IN NUMBER
            , dbg_subject_mapped IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
        )
    IS
    BEGIN
        SELF.init(
              os_id => os_id
            , prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , prgos_id => prgos_id
            , stan => stan
            , utw_id => utw_id
            , utw_data => utw_data
            , etpos_id => etpos_id
            , mod_id => mod_id
            , mod_data => mod_data
            , do_sredniej => do_sredniej
            , do_sredniej_zmiana_os_id => do_sredniej_zmiana_os_id
            , do_sredniej_zmiana_data => do_sredniej_zmiana_data
            , podp_data => podp_data
            , podp_os_id => podp_os_id
            , czy_platny_ects_ustawa => czy_platny_ects_ustawa
            , kto_placi => kto_placi
            , podp_etpos_data => podp_etpos_data
            , podp_etpos_os_id => podp_etpos_os_id
            , katprz_id => katprz_id
            , pw_ponadprogramowy => pw_ponadprogramowy
        );
        -- KEY
        SELF.job_uuid := job_uuid;
        SELF.pk_zal_przedm_prgos := pk_zal_przedm_prgos;
        -- DBG
        SELF.dbg_matched := dbg_matched;
        SELF.dbg_missing := dbg_missing;
        SELF.dbg_os_ids := dbg_os_ids;
        SELF.dbg_cdyd_kody := dbg_cdyd_kody;
        SELF.dbg_prz_kody := dbg_prz_kody;
        SELF.dbg_prgos_ids := dbg_prgos_ids;
        SELF.dbg_etpos_ids := dbg_etpos_ids;
        SELF.dbg_map_subj_codes := dbg_map_subj_codes;
        SELF.dbg_przedmioty_cykli := dbg_przedmioty_cykli;
        SELF.dbg_semester_codes := dbg_semester_codes;
        SELF.dbg_stany := dbg_stany;
        SELF.dbg_student_indexes := dbg_student_indexes;
        SELF.dbg_subj_codes := dbg_subj_codes;
        SELF.dbg_subject_mapped := dbg_subject_mapped;
        SELF.dbg_unique_match := dbg_unique_match;
        SELF.dbg_values_ok := dbg_values_ok;
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
