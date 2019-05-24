CREATE OR REPLACE TYPE V2u_Dz_Pracownik_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(10)
    , os_id NUMBER(10)
    , pierwsze_zatr VARCHAR2(1 CHAR)
    , nr_akt NUMBER(10)
    , nr_karty VARCHAR2(100 CHAR)
    , telefon1 VARCHAR2(30 CHAR)
    , telefon2 VARCHAR2(30 CHAR)
    , badania_okresowe DATE
    , kons_do_zmiany VARCHAR2(1 CHAR)
    , konsultacje VARCHAR2(1000 CHAR)
    , zainteresowania VARCHAR2(1000 CHAR)
    , zainteresowania_ang VARCHAR2(1000 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , emerytura_data DATE
    , data_nadania_tytulu DATE
    , aktywny VARCHAR2(1 CHAR)
    , data_przeswietlenia DATE
    , sl_id NUMBER(10)
    , tytul_ddz_id NUMBER(10)
    , data_szkolenia_bhp DATE
    , tytul_szk_id NUMBER(10)

    , CONSTRUCTOR FUNCTION V2u_Dz_Pracownik_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Pracownik_B_t
            , id IN NUMBER
            , os_id IN NUMBER
            , pierwsze_zatr IN VARCHAR2
            , nr_akt IN NUMBER
            , nr_karty IN VARCHAR2
            , telefon1 IN VARCHAR2
            , telefon2 IN VARCHAR2
            , badania_okresowe IN DATE
            , kons_do_zmiany IN VARCHAR2
            , konsultacje IN VARCHAR2
            , zainteresowania IN VARCHAR2
            , zainteresowania_ang IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , emerytura_data IN DATE
            , data_nadania_tytulu IN DATE
            , aktywny IN VARCHAR2
            , data_przeswietlenia IN DATE
            , sl_id IN NUMBER
            , tytul_ddz_id IN NUMBER
            , data_szkolenia_bhp IN DATE
            , tytul_szk_id IN NUMBER
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Pracownik_B_t
            , id IN NUMBER
            , os_id IN NUMBER
            , pierwsze_zatr IN VARCHAR2
            , nr_akt IN NUMBER
            , nr_karty IN VARCHAR2
            , telefon1 IN VARCHAR2
            , telefon2 IN VARCHAR2
            , badania_okresowe IN DATE
            , kons_do_zmiany IN VARCHAR2
            , konsultacje IN VARCHAR2
            , zainteresowania IN VARCHAR2
            , zainteresowania_ang IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , emerytura_data IN DATE
            , data_nadania_tytulu IN DATE
            , aktywny IN VARCHAR2
            , data_przeswietlenia IN DATE
            , sl_id IN NUMBER
            , tytul_ddz_id IN NUMBER
            , data_szkolenia_bhp IN DATE
            , tytul_szk_id IN NUMBER
            )
    )
NOT INSTANTIABLE NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
