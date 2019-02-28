CREATE OR REPLACE TYPE BODY V2u_Uu_Atrybut_Przedmiotu_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Atrybut_Przedmiotu_t(
              SELF IN OUT NOCOPY V2u_Uu_Atrybut_Przedmiotu_t
            , tatr_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , wart_lst_id IN NUMBER
            , prz_kod_rel IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , wartosc IN CLOB
            , wartosc_ang IN CLOB
            , id IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , pk_attribute IN VARCHAR2
            -- DBG
            , dbg_mapped IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_subj_codes IN NUMBER
            , dbg_subj_codes_tab IN V2u_Subj_20Codes_t
            , dbg_rev_subj_codes IN NUMBER
            , dbg_rev_subj_codes_tab IN V2u_Subj_20Codes_t
            , dbg_ids IN NUMBER
            , dbg_unique_match IN NUMBER
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              tatr_kod => tatr_kod
            , prz_kod => prz_kod
            , wart_lst_id => wart_lst_id
            , prz_kod_rel => prz_kod_rel
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , wartosc => wartosc
            , wartosc_ang => wartosc_ang
            , id => id
            -- KEY
            , job_uuid => job_uuid
            , pk_subject => pk_subject
            , pk_attribute => pk_attribute
            -- DBG
            , dbg_mapped => dbg_mapped
            , dbg_map_subj_codes => dbg_map_subj_codes
            , dbg_subj_codes => dbg_subj_codes
            , dbg_subj_codes_tab => dbg_subj_codes_tab
            , dbg_rev_subj_codes => dbg_rev_subj_codes
            , dbg_rev_subj_codes_tab => dbg_rev_subj_codes_tab
            , dbg_ids => dbg_ids
            , dbg_unique_match => dbg_unique_match
            -- CTL
            , change_type => change_type
            , safe_to_change => safe_to_change
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Atrybut_Przedmiotu_t
            , tatr_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , wart_lst_id IN NUMBER
            , prz_kod_rel IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , wartosc IN CLOB
            , wartosc_ang IN CLOB
            , id IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , pk_attribute IN VARCHAR2
            -- DBG
            , dbg_mapped IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_subj_codes IN NUMBER
            , dbg_subj_codes_tab IN V2u_Subj_20Codes_t
            , dbg_rev_subj_codes IN NUMBER
            , dbg_rev_subj_codes_tab IN V2u_Subj_20Codes_t
            , dbg_ids IN NUMBER
            , dbg_unique_match IN NUMBER
            -- CTL
            , change_type IN CHAR
            , safe_to_change IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              tatr_kod => tatr_kod
            , prz_kod => prz_kod
            , wart_lst_id => wart_lst_id
            , prz_kod_rel => prz_kod_rel
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , wartosc => wartosc
            , wartosc_ang => wartosc_ang
            , id => id
        );
        -- KEY
        SELF.job_uuid := job_uuid;
        SELF.pk_subject := pk_subject;
        SELF.pk_attribute := pk_attribute;
        -- DBG
        SELF.dbg_mapped := dbg_mapped;
        SELF.dbg_map_subj_codes := dbg_map_subj_codes;
        SELF.dbg_subj_codes := dbg_subj_codes;
        SELF.dbg_subj_codes_tab := dbg_subj_codes_tab;
        SELF.dbg_rev_subj_codes := dbg_rev_subj_codes;
        SELF.dbg_rev_subj_codes_tab := dbg_rev_subj_codes_tab;
        SELF.dbg_ids := dbg_ids;
        SELF.dbg_unique_match := dbg_unique_match;
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
