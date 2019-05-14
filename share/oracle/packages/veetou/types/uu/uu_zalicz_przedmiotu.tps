CREATE OR REPLACE TYPE V2u_Uu_Zalicz_Przedmiotu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Zalicz_Przedmiotu_B_t
    ( job_uuid RAW(16)
    , pk_zalicz_przedmiotu VARCHAR2(128 CHAR)
    -- DBG
    , dbg_matched NUMBER(5)
    , dbg_missing NUMBER(5)
    , dbg_os_ids NUMBER(5)
    , dbg_cdyd_kody NUMBER(5)
    , dbg_prz_kody NUMBER(5)
    , dbg_map_subj_codes NUMBER(5)
    , dbg_przedmioty_cykli NUMBER(5)
    , dbg_semester_codes NUMBER(5)
    , dbg_statusy_rej NUMBER(5)
    , dbg_statusy_zal NUMBER(5)
    , dbg_student_indexes NUMBER(5)
    , dbg_subj_codes NUMBER(5)
    , dbg_subject_mapped NUMBER(5)
    , dbg_unique_match NUMBER(1)
    , dbg_values_ok NUMBER(1)
    -- CTL
    , change_type VARCHAR2(1 CHAR)
    , safe_to_change NUMBER(1)

    , CONSTRUCTOR FUNCTION V2u_Uu_Zalicz_Przedmiotu_t(
              SELF IN OUT NOCOPY V2u_Uu_Zalicz_Przedmiotu_t
            , status_rej IN VARCHAR2
            , opis_statusu_rej IN VARCHAR2
            , status_zal IN VARCHAR2
            , opis_statusu_zal IN VARCHAR2
            , suma_ocen IN NUMBER
            , liczba_ocen IN NUMBER
            , os_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , utw_data IN DATE
            , utw_id IN VARCHAR2
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , nr_wyb IN NUMBER
            -- KEY
            , job_uuid IN RAW
            , pk_zalicz_przedmiotu IN VARCHAR2
            -- DBG
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_os_ids IN NUMBER
            , dbg_cdyd_kody IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_przedmioty_cykli IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_statusy_rej IN NUMBER
            , dbg_statusy_zal IN NUMBER
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
              SELF IN OUT NOCOPY V2u_Uu_Zalicz_Przedmiotu_t
            , status_rej IN VARCHAR2
            , opis_statusu_rej IN VARCHAR2
            , status_zal IN VARCHAR2
            , opis_statusu_zal IN VARCHAR2
            , suma_ocen IN NUMBER
            , liczba_ocen IN NUMBER
            , os_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , utw_data IN DATE
            , utw_id IN VARCHAR2
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , nr_wyb IN NUMBER
            -- KEY
            , job_uuid IN RAW
            , pk_zalicz_przedmiotu IN VARCHAR2
            -- DBG
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_os_ids IN NUMBER
            , dbg_cdyd_kody IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_przedmioty_cykli IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_statusy_rej IN NUMBER
            , dbg_statusy_zal IN NUMBER
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
CREATE OR REPLACE TYPE V2u_Uu_Zalicz_Przedmiotow_t
    AS TABLE OF V2u_Uu_Zalicz_Przedmiotu_t;

-- vim: set ft=sql ts=4 sw=4 et:
