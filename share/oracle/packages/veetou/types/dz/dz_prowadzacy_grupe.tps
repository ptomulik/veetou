CREATE OR REPLACE TYPE V2u_Dz_Prowadzacy_Grupe_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Prowadzacy_Grupe_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Prowadzacy_Grupe_t(
              SELF IN OUT NOCOPY V2u_Dz_Prowadzacy_Grupe_t
            , gr_nr IN NUMBER
            , zaj_cyk_id IN NUMBER
            , prac_id IN NUMBER
            , waga_pensum IN NUMBER
            , jedn_kod IN VARCHAR2
            , liczba_godz IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , liczba_godz_do_pensum IN NUMBER
            , liczba_osob IN NUMBER
            , czy_ankiety IN VARCHAR2
            , czy_protokoly IN VARCHAR2
            , liczba_godz_przen IN NUMBER
            , komentarz IN VARCHAR2
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Prowadzacy_Grup_t
    AS TABLE OF V2u_Dz_Prowadzacy_Grupe_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
