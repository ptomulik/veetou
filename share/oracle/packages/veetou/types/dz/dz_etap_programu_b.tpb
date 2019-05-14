CREATE OR REPLACE TYPE BODY V2u_Dz_Etap_Programu_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Etap_Programu_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Etap_Programu_B_t
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


    MEMBER PROCEDURE init(
          SELF IN OUT NOCOPY V2u_Dz_Etap_Programu_B_t
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
        )
    IS
    BEGIN
        SELF.prg_kod := prg_kod;
        SELF.etp_kod := etp_kod;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.nr_roku := nr_roku;
        SELF.pierwszy_etap := pierwszy_etap;
        SELF.tcdyd_kod := tcdyd_kod;
        SELF.liczba_war := liczba_war;
        SELF.czy_wyswietlac := czy_wyswietlac;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
