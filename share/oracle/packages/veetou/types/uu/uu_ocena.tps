CREATE OR REPLACE TYPE V2u_Uu_Ocena_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Ocena_B_t
    ( job_uuid RAW(16)
    , pk_ocena VARCHAR2(128 CHAR)
      -- DBG
    , dbg_os_ids NUMBER(5)
    , dbg_prot_ids NUMBER(5)
    , dbg_term_prot_nry NUMBER(5)
    , dbg_student_indices NUMBER(5)
    , dbg_map_subj_codes NUMBER(5)
    , dbg_subj_codes NUMBER(5)
    , dbg_semester_codes NUMBER(5)
    , dbg_map_classes_types NUMBER(5)
    , dbg_classes_types NUMBER(5)
    , dbg_subj_grade_dates NUMBER(5)
    , dbg_toc_kody NUMBER(5)
    , dbg_opisy NUMBER(5)
    , dbg_wart_oc_kolejnosci NUMBER(5)
    , dbg_matched NUMBER(5)
    , dbg_missing NUMBER(5)
    , dbg_subject_mapped NUMBER(5)
    , dbg_classes_mapped NUMBER(5)
    , dbg_unique_match NUMBER(1)
    , dbg_values_ok NUMBER(1)
      -- CTL
    , change_type CHAR(1)
    , safe_to_change NUMBER(1)

    , CONSTRUCTOR FUNCTION V2u_Uu_Ocena_t(
              SELF IN OUT NOCOPY V2u_Uu_Ocena_t
            , os_id IN NUMBER
            , komentarz_pub IN VARCHAR2
            , komentarz_pryw IN VARCHAR2
            , toc_kod IN VARCHAR2
            , wart_oc_kolejnosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , prot_id IN NUMBER
            , term_prot_nr IN NUMBER
            , zmiana_os_id IN NUMBER
            , zmiana_data IN DATE
            , pos_komi_id IN NUMBER
            -- KEY
            , job_uuid IN RAW
            , pk_ocena IN VARCHAR2
            -- DBG
            , dbg_os_ids IN NUMBER
            , dbg_prot_ids IN NUMBER
            , dbg_term_prot_nry IN NUMBER
            , dbg_student_indices IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_subj_codes IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_map_classes_types IN NUMBER
            , dbg_classes_types IN NUMBER
            , dbg_subj_grade_dates IN NUMBER
            , dbg_toc_kody IN NUMBER
            , dbg_opisy IN NUMBER
            , dbg_wart_oc_kolejnosci IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_subject_mapped IN NUMBER
            , dbg_classes_mapped IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Uu_Oceny_t
    AS TABLE OF V2u_Uu_Ocena_t;
/

-- vim: set ft=sql ts=4 sw=4 et:
