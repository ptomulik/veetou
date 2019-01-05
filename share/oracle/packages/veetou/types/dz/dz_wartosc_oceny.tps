CREATE OR REPLACE TYPE V2u_Dz_Wartosc_Oceny_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Wartosc_Oceny_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Wartosc_Oceny_t(
              SELF IN OUT NOCOPY V2u_Dz_Wartosc_Oceny_t
            , kolejnosc IN NUMBER
            , toc_kod IN VARCHAR2
            , opis IN VARCHAR2
            , czy_zal IN VARCHAR2
            , wartosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , description IN VARCHAR2
            , opis_oceny IN VARCHAR2
            , czy_dwoja_reg IN VARCHAR2
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Wartosci_Ocen_t
    AS TABLE OF V2u_Dz_Wartosc_Oceny_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
