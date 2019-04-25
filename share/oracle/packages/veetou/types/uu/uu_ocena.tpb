CREATE OR REPLACE TYPE BODY V2u_Uu_Ocena_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Ocena_t(
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
    IS
    BEGIN
        SELF.init(
              os_id => os_id
            , komentarz_pub => komentarz_pub
            , komentarz_pryw => komentarz_pryw
            , toc_kod => toc_kod
            , wart_oc_kolejnosc => wart_oc_kolejnosc
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , prot_id => prot_id
            , term_prot_nr => term_prot_nr
            , zmiana_os_id => zmiana_os_id
            , zmiana_data => zmiana_data
            , pos_komi_id => pos_komi_id
            );
        -- KEY
        SELF.job_uuid := job_uuid;
        SELF.pk_ocena := pk_ocena;
        -- DBG
        SELF.dbg_os_ids := dbg_os_ids;
        SELF.dbg_prot_ids := dbg_prot_ids;
        SELF.dbg_term_prot_nry := dbg_term_prot_nry;
        SELF.dbg_student_indices := dbg_student_indices;
        SELF.dbg_map_subj_codes := dbg_map_subj_codes;
        SELF.dbg_subj_codes := dbg_subj_codes;
        SELF.dbg_semester_codes := dbg_semester_codes;
        SELF.dbg_map_classes_types := dbg_map_classes_types;
        SELF.dbg_classes_types := dbg_classes_types;
        SELF.dbg_subj_grade_dates := dbg_subj_grade_dates;
        SELF.dbg_toc_kody := dbg_toc_kody;
        SELF.dbg_opisy := dbg_opisy;
        SELF.dbg_wart_oc_kolejnosci := dbg_wart_oc_kolejnosci;
        SELF.dbg_matched := dbg_matched;
        SELF.dbg_missing := dbg_missing;
        SELF.dbg_subject_mapped := dbg_subject_mapped;
        SELF.dbg_classes_mapped := dbg_classes_mapped;
        SELF.dbg_unique_match := dbg_unique_match;
        SELF.dbg_values_ok := dbg_values_ok;
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
