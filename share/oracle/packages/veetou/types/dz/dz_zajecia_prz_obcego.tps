CREATE OR REPLACE TYPE V2u_Dz_Zajecia_Prz_Obcego_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Zajecia_Prz_Obcego_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Zajecia_Prz_Obcego_t(
              SELF IN OUT NOCOPY V2u_Dz_Zajecia_Prz_Obcego_t
            , przob_id IN NUMBER
            , dec_id IN NUMBER
            , tzaj_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , ocena IN VARCHAR2
            , liczba_godzin IN NUMBER
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Zajecia_Prz_Obcych_t
    AS TABLE OF V2u_Dz_Zajecia_Prz_Obcego_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
