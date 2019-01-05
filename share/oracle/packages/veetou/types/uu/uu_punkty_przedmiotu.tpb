CREATE OR REPLACE TYPE BODY V2u_Uu_Punkty_Przedmiotu_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Punkty_Przedmiotu_t(
              SELF IN OUT NOCOPY V2u_Uu_Punkty_Przedmiotu_t
            , prz_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , tpkt_kod IN VARCHAR2
            , ilosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , id IN NUMBER
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_punkty_przedmiotu IN VARCHAR2
            -- DBG
            , dbg_pktprz_ids IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_prg_kody IN NUMBER
            , dbg_cdyd_pocz IN NUMBER
            , dbg_cdyd_kon IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_coalesced_subj_codes IN NUMBER
            , dbg_coalesced_subj_ectses IN NUMBER
            , dbg_map_program_codes IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_ectses_per_id IN NUMBER
            , dbg_ectses_per_non_id IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_subject_mapped IN NUMBER
            , dbg_specialty_mapped IN NUMBER
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              prz_kod => prz_kod
            , prg_kod => prg_kod
            , tpkt_kod => tpkt_kod
            , ilosc => ilosc
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , id => id
            , cdyd_pocz => cdyd_pocz
            , cdyd_kon => cdyd_kon
            -- KEY
            , job_uuid => job_uuid
            , pk_punkty_przedmiotu => pk_punkty_przedmiotu
            -- DBG
            , dbg_pktprz_ids => dbg_pktprz_ids
            , dbg_prz_kody => dbg_prz_kody
            , dbg_prg_kody => dbg_prg_kody
            , dbg_cdyd_pocz => dbg_cdyd_pocz
            , dbg_cdyd_kon => dbg_cdyd_kon
            , dbg_map_subj_codes => dbg_map_subj_codes
            , dbg_coalesced_subj_codes => dbg_coalesced_subj_codes
            , dbg_coalesced_subj_ectses => dbg_coalesced_subj_ectses
            , dbg_map_program_codes => dbg_map_program_codes
            , dbg_semester_codes => dbg_semester_codes
            , dbg_ectses_per_id => dbg_ectses_per_id
            , dbg_ectses_per_non_id => dbg_ectses_per_non_id
            , dbg_unique_match => dbg_unique_match
            , dbg_values_ok => dbg_values_ok
            , dbg_matched => dbg_matched
            , dbg_missing => dbg_missing
            , dbg_subject_mapped => dbg_subject_mapped
            , dbg_specialty_mapped => dbg_specialty_mapped
            -- CTL
            , change_type => change_type
            , safe_to_change => safe_to_change
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Punkty_Przedmiotu_t
            , prz_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , tpkt_kod IN VARCHAR2
            , ilosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , id IN NUMBER
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_punkty_przedmiotu IN VARCHAR2
            -- DBG
            , dbg_pktprz_ids IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_prg_kody IN NUMBER
            , dbg_cdyd_pocz IN NUMBER
            , dbg_cdyd_kon IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_coalesced_subj_codes IN NUMBER
            , dbg_coalesced_subj_ectses IN NUMBER
            , dbg_map_program_codes IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_ectses_per_id IN NUMBER
            , dbg_ectses_per_non_id IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_subject_mapped IN NUMBER
            , dbg_specialty_mapped IN NUMBER
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              prz_kod => prz_kod
            , prg_kod => prg_kod
            , tpkt_kod => tpkt_kod
            , ilosc => ilosc
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , id => id
            , cdyd_pocz => cdyd_pocz
            , cdyd_kon => cdyd_kon
            );
        -- KEY
        SELF.job_uuid := job_uuid;
        SELF.pk_punkty_przedmiotu := pk_punkty_przedmiotu;
        -- DBG
        SELF.dbg_pktprz_ids := dbg_pktprz_ids;
        SELF.dbg_prz_kody := dbg_prz_kody;
        SELF.dbg_prg_kody := dbg_prg_kody;
        SELF.dbg_cdyd_pocz := dbg_cdyd_pocz;
        SELF.dbg_cdyd_kon := dbg_cdyd_kon;
        SELF.dbg_map_subj_codes := dbg_map_subj_codes;
        SELF.dbg_coalesced_subj_codes := dbg_coalesced_subj_codes;
        SELF.dbg_coalesced_subj_ectses := dbg_coalesced_subj_ectses;
        SELF.dbg_map_program_codes := dbg_map_program_codes;
        SELF.dbg_semester_codes := dbg_semester_codes;
        SELF.dbg_ectses_per_id := dbg_ectses_per_id;
        SELF.dbg_ectses_per_non_id := dbg_ectses_per_non_id;
        SELF.dbg_unique_match := dbg_unique_match;
        SELF.dbg_values_ok := dbg_values_ok;
        SELF.dbg_matched := dbg_matched;
        SELF.dbg_missing := dbg_missing;
        SELF.dbg_subject_mapped := dbg_subject_mapped;
        SELF.dbg_specialty_mapped := dbg_specialty_mapped;
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
