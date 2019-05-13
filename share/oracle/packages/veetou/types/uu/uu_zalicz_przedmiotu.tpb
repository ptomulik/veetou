CREATE OR REPLACE TYPE BODY V2u_Dz_Zalicz_Przedmiotu_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Zalicz_Przedmiotu_t(
              SELF IN OUT NOCOPY V2u_Dz_Zalicz_Przedmiotu_t
            , status_rej IN VARCHAR2
            , opis_statusu_rej IN VARCHAR2
            , status_zal IN VARCHAR2
            , opis_statusu_zal IN VARCHAR2
            , suma_ocen IN NUMBER
            , liczba_ocen IN NUMBER
            , os_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , utw_data IN DATE
            , utw_id IN VARCHAR2
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , nr_wyb IN NUMBER
            -- KEY
            , job_uuid IN RAW
            , pk_zalicz_przedmiotu IN VARCHAR2
            -- DBG
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
        ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              status_rej => status_rej
            , opis_statusu_rej => opis_statusu_rej
            , status_zal => status_zal
            , opis_statusu_zal => opis_statusu_zal
            , suma_ocen => suma_ocen
            , liczba_ocen => liczba_ocen
            , os_id => os_id
            , cdyd_kod => cdyd_kod
            , prz_kod => prz_kod
            , utw_data => utw_data
            , utw_id => utw_id
            , mod_id => mod_id
            , mod_data => mod_data
            , nr_wyb => nr_wyb
            -- KEY
            , job_uuid => job_uuid
            , pk_zalicz_przedmiotu => pk_zalicz_przedmiotu
            -- DBG
            , dbg_matched => dbg_matched
            , dbg_missing => dbg_missing
            , dbg_unique_match => dbg_unique_match
            , dbg_values_ok => dbg_values_ok
            -- CTL
            , change_type => change_type
            , safe_to_change => safe_to_change
        );
        RETURN;
    END;

    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Zalicz_Przedmiotu_t
            , status_rej IN VARCHAR2
            , opis_statusu_rej IN VARCHAR2
            , status_zal IN VARCHAR2
            , opis_statusu_zal IN VARCHAR2
            , suma_ocen IN NUMBER
            , liczba_ocen IN NUMBER
            , os_id IN NUMBER
            , cdyd_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , utw_data IN DATE
            , utw_id IN VARCHAR2
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , nr_wyb IN NUMBER
            -- KEY
            , job_uuid IN RAW
            , pk_zalicz_przedmiotu IN VARCHAR2
            -- DBG
            , dbg_matched IN NUMBER
            , dbg_missing IN NUMBER
            , dbg_unique_match IN NUMBER
            , dbg_values_ok IN NUMBER
            -- CTL
            , change_type IN VARCHAR2
            , safe_to_change IN NUMBER
        )
    IS
    BEGIN
        SELF.init(
              status_rej => status_rej
            , opis_statusu_rej => opis_statusu_rej
            , status_zal => status_zal
            , opis_statusu_zal => opis_statusu_zal
            , suma_ocen => suma_ocen
            , liczba_ocen => liczba_ocen
            , os_id => os_id
            , cdyd_kod => cdyd_kod
            , prz_kod => prz_kod
            , utw_data => utw_data
            , utw_id => utw_id
            , mod_id => mod_id
            , mod_data => mod_data
            , nr_wyb => nr_wyb
        );
        -- KEY
        SELF.job_uuid := job_uuid;
        SELF.pk_zalicz_przedmiotu := pk_zalicz_przedmiotu;
        -- DBG
        SELF.dbg_matched := dbg_matched;
        SELF.dbg_missing := dbg_missing;
        SELF.dbg_unique_match := dbg_unique_match;
        SELF.dbg_values_ok := dbg_values_ok;
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
