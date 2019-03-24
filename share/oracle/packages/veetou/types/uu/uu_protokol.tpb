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
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
