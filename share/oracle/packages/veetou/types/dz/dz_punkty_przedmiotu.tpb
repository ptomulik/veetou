CREATE OR REPLACE TYPE BODY V2u_Dz_Punkty_Przedmiotu_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Punkty_Przedmiotu_t(
              SELF IN OUT NOCOPY V2u_Dz_Punkty_Przedmiotu_t
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
            );
        RETURN;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
