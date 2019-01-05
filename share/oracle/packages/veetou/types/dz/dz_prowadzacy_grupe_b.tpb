CREATE OR REPLACE TYPE BODY V2u_Dz_Prowadzacy_Grupe_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Prowadzacy_Grupe_B_t(
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
    IS
    BEGIN
        SELF.init(
              gr_nr => gr_nr
            , zaj_cyk_id => zaj_cyk_id
            , prac_id => prac_id
            , waga_pensum => waga_pensum
            , jedn_kod => jedn_kod
            , liczba_godz => liczba_godz
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , liczba_godz_do_pensum => liczba_godz_do_pensum
            , liczba_osob => liczba_osob
            , czy_ankiety => czy_ankiety
            , czy_protokoly => czy_protokoly
            , liczba_godz_przen => liczba_godz_przen
            , komentarz => komentarz
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
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
    IS
    BEGIN
        SELF.gr_nr := gr_nr;
        SELF.zaj_cyk_id := zaj_cyk_id;
        SELF.prac_id := prac_id;
        SELF.waga_pensum := waga_pensum;
        SELF.jedn_kod := jedn_kod;
        SELF.liczba_godz := liczba_godz;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.liczba_godz_do_pensum := liczba_godz_do_pensum;
        SELF.liczba_osob := liczba_osob;
        SELF.czy_ankiety := czy_ankiety;
        SELF.czy_protokoly := czy_protokoly;
        SELF.liczba_godz_przen := liczba_godz_przen;
        SELF.komentarz := komentarz;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
