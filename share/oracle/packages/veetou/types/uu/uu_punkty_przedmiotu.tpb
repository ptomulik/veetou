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
        -- CTL
        SELF.change_type := change_type;
        SELF.safe_to_change := safe_to_change;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
