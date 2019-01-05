CREATE OR REPLACE TYPE V2u_Uu_Zal_Przedm_Prgos_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Zal_Przedm_Prgos_B_t
    ( job_uuid RAW(16)
    , pk_zal_przedm_prgos VARCHAR2(200 CHAR)
    -- DBG
    , dbg_matched NUMBER(5)
    , dbg_missing NUMBER(5)
    , dbg_os_ids NUMBER(5)
    , dbg_cdyd_kody NUMBER(5)
    , dbg_prz_kody NUMBER(5)
    , dbg_prgos_ids NUMBER(5)
    , dbg_etpos_ids NUMBER(5)
    , dbg_map_subj_codes NUMBER(5)
    , dbg_przedmioty_cykli NUMBER(5)
    , dbg_semester_codes NUMBER(5)
    , dbg_stany NUMBER(5)
    , dbg_student_indexes NUMBER(5)
    , dbg_subj_codes NUMBER(5)
    , dbg_subject_mapped NUMBER(5)
    , dbg_unique_match NUMBER(1)
    , dbg_values_ok NUMBER(1)
    -- CTL
    , change_type VARCHAR2(1 CHAR)
    , safe_to_change NUMBER(1)

    , CONSTRUCTOR FUNCTION V2u_Uu_Zal_Przedm_Prgos_t(
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

    , MEMBER PROCEDURE init(
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
    );
/
CREATE OR REPLACE TYPE V2u_Uu_Zal_Przedm_Prgoses_t
    AS TABLE OF V2u_Uu_Zal_Przedm_Prgos_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
