CREATE OR REPLACE TYPE V2u_Dz_Prowadzacy_Grupe_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( gr_nr NUMBER(10)
    , zaj_cyk_id NUMBER(10)
    , prac_id NUMBER(10)
    , waga_pensum NUMBER(3,2)
    , jedn_kod VARCHAR2(20 CHAR)
    , liczba_godz NUMBER(12,2)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , liczba_godz_do_pensum NUMBER(12,2)
    , liczba_osob NUMBER(10)
    , czy_ankiety VARCHAR2(1 CHAR)
    , czy_protokoly VARCHAR2(1 CHAR)
    , liczba_godz_przen NUMBER(12,2)
    , komentarz VARCHAR2(3000 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Dz_Prowadzacy_Grupe_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Prowadzacy_Grupe_B_t
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

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Prowadzacy_Grupe_B_t
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
            )
    )
NOT INSTANTIABLE NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
