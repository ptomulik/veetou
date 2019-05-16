CREATE OR REPLACE TYPE BODY V2u_Uu_Przedmiot_Cyklu_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Przedmiot_Cyklu_t(
              SELF IN OUT NOCOPY V2u_Uu_Przedmiot_Cyklu_t
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , uczestnicy IN VARCHAR2
            , url IN VARCHAR2
            , uwagi IN CLOB
            , notes IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , opis IN CLOB
            , opis_ang IN CLOB
            , skrocony_opis IN VARCHAR2
            , skrocony_opis_ang IN VARCHAR2
            , status_sylabusu IN VARCHAR2
            , guid IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_przedmiot_cyklu IN VARCHAR2
            -- DBG
            , dbg_subj_codes IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_map_proto_types IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_cdyd_kody IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_mapped IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , tpro_kod => tpro_kod
            , uczestnicy => uczestnicy
            , url => url
            , uwagi => uwagi
            , notes => notes
            , literatura => literatura
            , literatura_ang => literatura_ang
            , opis => opis
            , opis_ang => opis_ang
            , skrocony_opis => skrocony_opis
            , skrocony_opis_ang => skrocony_opis_ang
            , status_sylabusu => status_sylabusu
            , guid => guid
            -- KEY
            , job_uuid => job_uuid
            , pk_przedmiot_cyklu => pk_przedmiot_cyklu
            -- DBG
            , dbg_subj_codes => dbg_subj_codes
            , dbg_semester_codes => dbg_semester_codes
            , dbg_map_subj_codes => dbg_map_subj_codes
            , dbg_map_proto_types => dbg_map_proto_types
            , dbg_subj_credit_kinds => dbg_subj_credit_kinds
            , dbg_prz_kody => dbg_prz_kody
            , dbg_cdyd_kody => dbg_cdyd_kody
            , dbg_values_ok => dbg_values_ok
            , dbg_unique_match => dbg_unique_match
            , dbg_matched => dbg_matched
            , dbg_missing => dbg_missing
            , dbg_mapped => dbg_mapped
            -- CTL
            , change_type => change_type
            , safe_to_change => safe_to_change
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Przedmiot_Cyklu_t
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , uczestnicy IN VARCHAR2
            , url IN VARCHAR2
            , uwagi IN CLOB
            , notes IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , opis IN CLOB
            , opis_ang IN CLOB
            , skrocony_opis IN VARCHAR2
            , skrocony_opis_ang IN VARCHAR2
            , status_sylabusu IN VARCHAR2
            , guid IN VARCHAR2
            , job_uuid IN RAW
            , pk_przedmiot_cyklu IN VARCHAR2
            -- DBG
            , dbg_subj_codes IN NUMBER
            , dbg_semester_codes IN NUMBER
            , dbg_map_subj_codes IN NUMBER
            , dbg_map_proto_types IN NUMBER
            , dbg_subj_credit_kinds IN NUMBER
            , dbg_prz_kody IN NUMBER
            , dbg_cdyd_kody IN NUMBER
            , dbg_values_ok IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_mapped IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , tpro_kod => tpro_kod
            , uczestnicy => uczestnicy
            , url => url
            , uwagi => uwagi
            , notes => notes
            , literatura => literatura
            , literatura_ang => literatura_ang
            , opis => opis
            , opis_ang => opis_ang
            , skrocony_opis => skrocony_opis
            , skrocony_opis_ang => skrocony_opis_ang
            , status_sylabusu => status_sylabusu
            , guid => guid
            );
        -- KEY
        SELF.job_uuid := job_uuid;
        SELF.pk_przedmiot_cyklu := pk_przedmiot_cyklu;
        -- DBG
        SELF.dbg_subj_codes := dbg_subj_codes;
        SELF.dbg_semester_codes := dbg_semester_codes;
        SELF.dbg_map_subj_codes := dbg_map_subj_codes;
        SELF.dbg_map_proto_types := dbg_map_proto_types;
        SELF.dbg_subj_credit_kinds := dbg_subj_credit_kinds;
        SELF.dbg_prz_kody := dbg_prz_kody;
        SELF.dbg_cdyd_kody := dbg_cdyd_kody;
        SELF.dbg_values_ok := dbg_values_ok;
        SELF.dbg_unique_match := dbg_unique_match;
        SELF.dbg_matched := dbg_matched;
        SELF.dbg_missing := dbg_missing;
        SELF.dbg_mapped := dbg_mapped;
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
