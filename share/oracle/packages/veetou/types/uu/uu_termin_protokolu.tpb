CREATE OR REPLACE TYPE BODY V2u_Uu_Termin_Protokolu_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Termin_Protokolu_t(
              SELF IN OUT NOCOPY V2u_Uu_Termin_Protokolu_t
            , prot_id IN NUMBER
            , nr IN NUMBER
            , status IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , opis IN VARCHAR2
            , data_zwrotu IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , egzamin_komisyjny IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_termin_protokolu IN VARCHAR2
            -- DBG
            , dbg_subj_codes IN NUMBER
            , dbg_classes_types IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_map_proto_types IN NUMBER
            , dbg_map_classes_types IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_prot_ids IN NUMBER
            , dbg_nrs IN NUMBER
            , dbg_statusy IN NUMBER
            , dbg_opisy IN NUMBER
            , dbg_daty_zwrotu IN NUMBER
            , dbg_egzaminy_komisyjne IN NUMBER
            , dbg_subj_grades IN NUMBER
            , dbg_subj_grade_dates IN NUMBER
            , dbg_mi_prot_ids IN NUMBER
            , dbg_max_istniejace_nry IN NUMBER
            , dbg_subj_grade_date_ranks IN NUMBER
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
              prot_id => prot_id
            , nr => nr
            , status => status
            , utw_id => utw_id
            , utw_data => utw_data
            , opis => opis
            , data_zwrotu => data_zwrotu
            , mod_id => mod_id
            , mod_data => mod_data
            , egzamin_komisyjny => egzamin_komisyjny
            );
        -- KEY
        SELF.job_uuid := job_uuid;
        SELF.pk_termin_protokolu := pk_termin_protokolu;
        -- DBG
        SELF.dbg_subj_codes := dbg_subj_codes;
        SELF.dbg_classes_types := dbg_classes_types;
        SELF.dbg_map_subj_codes := dbg_map_subj_codes;
        SELF.dbg_map_proto_types := dbg_map_proto_types;
        SELF.dbg_map_classes_types := dbg_map_classes_types;
        SELF.dbg_subj_credit_kinds := dbg_subj_credit_kinds;
        SELF.dbg_prot_ids := dbg_prot_ids;
        SELF.dbg_nrs := dbg_nrs;
        SELF.dbg_statusy := dbg_statusy;
        SELF.dbg_opisy := dbg_opisy;
        SELF.dbg_daty_zwrotu := dbg_daty_zwrotu;
        SELF.dbg_egzaminy_komisyjne := dbg_egzaminy_komisyjne;
        SELF.dbg_subj_grades := dbg_subj_grades;
        SELF.dbg_subj_grade_dates := dbg_subj_grade_dates;
        SELF.dbg_mi_prot_ids := dbg_mi_prot_ids;
        SELF.dbg_max_istniejace_nry := dbg_max_istniejace_nry;
        SELF.dbg_subj_grade_date_ranks := dbg_subj_grade_date_ranks;
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
/
-- vim: set ft=sql ts=4 sw=4 et:
