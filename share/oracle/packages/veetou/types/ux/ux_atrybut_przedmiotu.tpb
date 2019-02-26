CREATE OR REPLACE TYPE BODY V2u_Ux_Atrybut_Przedmiotu_t AS
    CONSTRUCTOR FUNCTION V2u_Ux_Atrybut_Przedmiotu_t(
              SELF IN OUT NOCOPY V2u_Ux_Atrybut_Przedmiotu_t
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
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , pk_attribute IN VARCHAR2
            , subj_codes IN V2u_Subj_20Codes_t
            , all_subj_codes IN V2u_Subj_20Codes_t
            -- DBG
            , dbg_map_subj_codes IN NUMBER
            , dbg_subj_codes IN NUMBER
            , dbg_all_subj_codes IN NUMBER
            , dbg_ids IN NUMBER
            -- INF
            , change_type IN NUMBER
            , safe_to_add IN NUMBER
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
            , job_uuid => job_uuid
            , pk_subject => pk_subject
            , pk_attribute => pk_attribute
            , subj_codes => subj_codes
            , all_subj_codes => all_subj_codes
            , dbg_map_subj_codes => dbg_map_subj_codes
            , dbg_subj_codes => dbg_subj_codes
            , dbg_all_subj_codes => dbg_all_subj_codes
            , dbg_ids => dbg_ids
            , change_type => change_type
            , safe_to_add => safe_to_add
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ux_Atrybut_Przedmiotu_t
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
            , job_uuid IN RAW
            , pk_subject IN VARCHAR2
            , pk_attribute IN VARCHAR2
            , subj_codes IN V2u_Subj_20Codes_t
            , all_subj_codes IN V2u_Subj_20Codes_t
            -- DBG
            , dbg_map_subj_codes IN NUMBER
            , dbg_subj_codes IN NUMBER
            , dbg_all_subj_codes IN NUMBER
            , dbg_ids IN NUMBER
            -- INF
            , change_type IN NUMBER
            , safe_to_add IN NUMBER
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
        SELF.job_uuid := job_uuid;
        SELF.pk_subject := pk_subject;
        SELF.pk_attribute := pk_attribute;
        SELF.subj_codes := subj_codes;
        SELF.all_subj_codes := all_subj_codes;
        SELF.dbg_map_subj_codes := dbg_map_subj_codes;
        SELF.dbg_subj_codes := dbg_subj_codes;
        SELF.dbg_all_subj_codes := dbg_all_subj_codes;
        SELF.dbg_ids := dbg_ids;
        SELF.change_type := change_type;
        SELF.safe_to_add := safe_to_add;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
