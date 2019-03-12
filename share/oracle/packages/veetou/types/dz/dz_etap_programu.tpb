CREATE OR REPLACE TYPE BODY V2u_Dz_Etap_Programu_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Etap_Programu_t(
              SELF IN OUT NOCOPY V2u_Dz_Etap_Programu_t
            , prg_kod IN VARCHAR2
            , etp_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , nr_roku IN NUMBER
            , pierwszy_etap IN VARCHAR2
            , tcdyd_kod IN VARCHAR2
            , liczba_war IN NUMBER
            , czy_wyswietlac IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              prg_kod => prg_kod
            , etp_kod => etp_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , nr_roku => nr_roku
            , pierwszy_etap => pierwszy_etap
            , tcdyd_kod => tcdyd_kod
            , liczba_war => liczba_war
            , czy_wyswietlac => czy_wyswietlac
            );
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
