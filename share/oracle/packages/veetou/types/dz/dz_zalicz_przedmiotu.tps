CREATE OR REPLACE TYPE V2u_Dz_Zalicz_Przedmiotu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Zalicz_Przedmiotu_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Zalicz_Przedmiotu_t(
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
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Zalicz_Przedmiotow_t
    AS TABLE OF V2u_Dz_Zalicz_Przedmiotu_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
