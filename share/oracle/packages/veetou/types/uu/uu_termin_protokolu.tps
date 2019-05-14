CREATE OR REPLACE TYPE V2u_Uu_Termin_Protokolu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Termin_Protokolu_B_t
    ( job_uuid RAW(16)
    , pk_termin_protokolu VARCHAR2(128 CHAR)
      -- DBG
    , dbg_subj_codes NUMBER(5)
    , dbg_classes_types NUMBER(5)
    , dbg_map_subj_codes NUMBER(5)
    , dbg_map_proto_types NUMBER(5)
    , dbg_map_classes_types NUMBER(5)
    , dbg_subj_credit_kinds NUMBER(5)
    , dbg_prot_ids NUMBER(5)
    , dbg_nrs NUMBER(5)
    , dbg_statusy NUMBER(5)
    , dbg_opisy NUMBER(5)
    , dbg_daty_zwrotu NUMBER(5)
    , dbg_egzaminy_komisyjne NUMBER(5)
    , dbg_subj_grades NUMBER(5)
    , dbg_subj_grade_dates NUMBER(5)
    , dbg_mi_prot_ids NUMBER(5)
    , dbg_max_istniejace_nry NUMBER(5)
    , dbg_subj_grade_date_ranks NUMBER(5)
    , dbg_matched NUMBER(5)
    , dbg_missing NUMBER(5)
    , dbg_subject_mapped NUMBER(5)
    , dbg_classes_mapped NUMBER(5)
    , dbg_unique_match NUMBER(1)
    , dbg_values_ok NUMBER(1)
      -- CTL
    , change_type CHAR(1)
    , safe_to_change NUMBER(1)
    , CONSTRUCTOR FUNCTION V2u_Uu_Termin_Protokolu_t(
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
    );
/
-- vim: set ft=sql ts=4 sw=4 et:
