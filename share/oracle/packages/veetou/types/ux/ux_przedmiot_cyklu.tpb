CREATE OR REPLACE TYPE BODY V2u_Ux_Przedmiot_Cyklu_t AS
    CONSTRUCTOR FUNCTION V2u_Ux_Przedmiot_Cyklu_t(
              SELF IN OUT NOCOPY V2u_Ux_Przedmiot_Cyklu_t
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
            , dbg_map_subj_codes IN INTEGER
            , dbg_subj_credit_kinds IN INTEGER
            , dbg_matched IN INTEGER
            , dbg_missing IN INTEGER
            , dbg_mapped IN INTEGER
            , safe_to_add INTEGER
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
            , job_uuid => job_uuid
            , dbg_map_subj_codes => dbg_map_subj_codes
            , dbg_subj_credit_kinds => dbg_subj_credit_kinds
            , dbg_matched => dbg_matched
            , dbg_missing => dbg_missing
            , dbg_mapped => dbg_mapped
            , safe_to_add => safe_to_add
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ux_Przedmiot_Cyklu_t
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
            , dbg_map_subj_codes IN INTEGER
            , dbg_subj_credit_kinds IN INTEGER
            , dbg_matched IN INTEGER
            , dbg_missing IN INTEGER
            , dbg_mapped IN INTEGER
            , safe_to_add INTEGER
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
        SELF.job_uuid := job_uuid;
        SELF.dbg_map_subj_codes := dbg_map_subj_codes;
        SELF.dbg_subj_credit_kinds := dbg_subj_credit_kinds;
        SELF.dbg_matched := dbg_matched;
        SELF.dbg_missing := dbg_missing;
        SELF.dbg_mapped := dbg_mapped;
        SELF.safe_to_add := safe_to_add;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
