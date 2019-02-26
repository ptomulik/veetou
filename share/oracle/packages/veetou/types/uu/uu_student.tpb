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
            , job_uuid IN RAW
            , is_missing IN INTEGER
            , safe_to_add IN NUMBER
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
            , job_uuid => job_uuid
            , is_missing => is_missing
            , safe_to_add => safe_to_add
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
            , job_uuid IN RAW
            , is_missing IN INTEGER
            , safe_to_add IN NUMBER
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
        SELF.job_uuid := job_uuid;
        SELF.is_missing := is_missing;
        SELF.safe_to_add := safe_to_add;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
