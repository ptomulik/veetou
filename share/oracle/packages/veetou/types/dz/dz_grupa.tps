CREATE OR REPLACE TYPE V2u_Dz_Grupa_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Grupa_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Grupa_t(
              SELF IN OUT NOCOPY V2u_Dz_Grupa_t
            , nr IN NUMBER
            , zaj_cyk_id IN NUMBER
            , limit_miejsc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_data IN DATE
            , mod_id IN VARCHAR2
            , gr_nr IN NUMBER
            , gr_zaj_cyk_id IN NUMBER
            , opis IN VARCHAR2
            , waga_pensum IN NUMBER
            , zakres_tematow IN CLOB
            , zakres_tematow_ang IN CLOB
            , metody_dyd IN CLOB
            , metody_dyd_ang IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , url IN VARCHAR2
            , opis_ang IN VARCHAR2
            , dolny_limit_miejsc IN NUMBER
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Grupy_t
    AS TABLE OF V2u_Dz_Grupa_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
