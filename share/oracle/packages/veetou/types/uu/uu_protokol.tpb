CREATE OR REPLACE TYPE BODY V2u_Uu_Protokol_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Protokol_t(
              SELF IN OUT NOCOPY V2u_Uu_Protokol_t
            , zaj_cyk_id IN NUMBER
            , opis IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , czy_do_sredniej IN VARCHAR2
            , edycja IN VARCHAR2
            , opis_ang IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_protokol IN VARCHAR2
            -- DBG
            , dbg_subj_codes IN NUMBER
            , dbg_classes_types IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_map_proto_types IN NUMBER
            , dbg_map_classes_types IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_prot_ids IN NUMBER
            , dbg_opisy IN NUMBER
            , dbg_czy_do_sredniej IN NUMBER
            , dbg_edycje IN NUMBER
            , dbg_opisy_ang IN NUMBER
            , dbg_zaj_cyk_ids IN NUMBER
            , dbg_subj_grades IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_subject_mapped IN NUMBER
            , dbg_classes_mapped IN NUMBER
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              zaj_cyk_id => zaj_cyk_id
            , opis => opis
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , tpro_kod => tpro_kod
            , id => id
            , prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , czy_do_sredniej => czy_do_sredniej
            , edycja => edycja
            , opis_ang => opis_ang
            );
        -- KEY
        SELF.job_uuid := job_uuid;
        SELF.pk_protokol := pk_protokol;
        -- DBG
        SELF.dbg_subj_codes := dbg_subj_codes;
        SELF.dbg_classes_types := dbg_classes_types;
        SELF.dbg_map_subj_codes := dbg_map_subj_codes;
        SELF.dbg_map_proto_types := dbg_map_proto_types;
        SELF.dbg_map_classes_types := dbg_map_classes_types;
        SELF.dbg_subj_credit_kinds := dbg_subj_credit_kinds;
        SELF.dbg_prot_ids := dbg_prot_ids;
        SELF.dbg_opisy := dbg_opisy;
        SELF.dbg_czy_do_sredniej := dbg_czy_do_sredniej;
        SELF.dbg_edycje := dbg_edycje;
        SELF.dbg_opisy_ang := dbg_opisy_ang;
        SELF.dbg_zaj_cyk_ids := dbg_zaj_cyk_ids;
        SELF.dbg_subj_grades := dbg_subj_grades;
        SELF.dbg_values_ok := dbg_values_ok;
        SELF.dbg_unique_match := dbg_unique_match;
        SELF.dbg_matched := dbg_matched;
        SELF.dbg_missing := dbg_missing;
        SELF.dbg_subject_mapped := dbg_subject_mapped;
        SELF.dbg_classes_mapped := dbg_classes_mapped;
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
