CREATE OR REPLACE TYPE BODY V2u_Uu_Student_t AS
    CONSTRUCTOR FUNCTION V2u_Uu_Student_t(
              SELF IN OUT NOCOPY V2u_Uu_Student_t
            , id IN NUMBER
            , indeks IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , typ_ind_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , os_id IN NUMBER
            , indeks_glowny IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_student IN VARCHAR2
            -- DBG
            , dbg_first_name IN VARCHAR2
            , dbg_last_name IN VARCHAR2
            , dbg_first_names IN NUMBER
            , dbg_last_names IN NUMBER
            , dbg_ids IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              id => id
            , indeks => indeks
            , jed_org_kod => jed_org_kod
            , typ_ind_kod => typ_ind_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , os_id => os_id
            , indeks_glowny => indeks_glowny
            -- KEY
            , job_uuid => job_uuid
            , pk_student => pk_student
            -- DBG
            , dbg_first_name => dbg_first_name
            , dbg_last_name => dbg_last_name
            , dbg_first_names => dbg_first_names
            , dbg_last_names => dbg_last_names
            , dbg_ids => dbg_ids
            , dbg_matched => dbg_matched
            , dbg_unique_match => dbg_unique_match
            , dbg_values_ok => dbg_values_ok
            -- CTL
            , change_type => change_type
            , safe_to_change => safe_to_change
            );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Uu_Student_t
            , id IN NUMBER
            , indeks IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , typ_ind_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , os_id IN NUMBER
            , indeks_glowny IN VARCHAR2
            -- KEY
            , job_uuid IN RAW
            , pk_student IN VARCHAR2
            -- DBG
            , dbg_first_name IN VARCHAR2
            , dbg_last_name IN VARCHAR2
            , dbg_first_names IN NUMBER
            , dbg_last_names IN NUMBER
            , dbg_ids IN NUMBER
            , dbg_matched IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
            )
    IS
    BEGIN
        SELF.init(
              id => id
            , indeks => indeks
            , jed_org_kod => jed_org_kod
            , typ_ind_kod => typ_ind_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , os_id => os_id
            , indeks_glowny => indeks_glowny
            );
        -- KEY
        SELF.job_uuid := job_uuid;
        SELF.pk_student := pk_student;
        -- DBG
        SELF.dbg_first_name := dbg_first_name;
        SELF.dbg_last_name := dbg_last_name;
        SELF.dbg_first_names := dbg_first_names;
        SELF.dbg_last_names := dbg_last_names;
        SELF.dbg_ids := dbg_ids;
        SELF.dbg_matched := dbg_matched;
        SELF.dbg_unique_match := dbg_unique_match;
        SELF.dbg_values_ok := dbg_values_ok;
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
