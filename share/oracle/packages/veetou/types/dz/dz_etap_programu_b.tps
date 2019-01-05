CREATE OR REPLACE TYPE V2u_Dz_Etap_Programu_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( prg_kod VARCHAR2(20 CHAR)
    , etp_kod VARCHAR2(20 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , nr_roku NUMBER(2)
    , pierwszy_etap VARCHAR2(1 CHAR)
    , tcdyd_kod VARCHAR2(20 CHAR)
    , liczba_war NUMBER(10)
    , czy_wyswietlac VARCHAR2(1 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Dz_Etap_Programu_B_t(
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

    , MEMBER PROCEDURE init(
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
    )
NOT INSTANTIABLE NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
