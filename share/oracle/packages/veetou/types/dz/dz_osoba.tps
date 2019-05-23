CREATE OR REPLACE TYPE V2u_Dz_Osoba_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Osoba_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Osoba_t(
              SELF IN OUT NOCOPY V2u_Dz_Osoba_t
            , id IN NUMBER
            , pesel IN VARCHAR2
            , imie IN VARCHAR2
            , imie2 IN VARCHAR2
            , nazwisko IN VARCHAR2
--            , data_ur IN DATE
--            , miasto_ur IN VARCHAR2
--            , imie_ojca IN VARCHAR2
--            , imie_matki IN VARCHAR2
--            , nazwisko_panien_matki IN VARCHAR2
--            , nazwisko_rodowe IN VARCHAR2
--            , szkola IN VARCHAR2
--            , sr_nr_dowodu IN VARCHAR2
--            , nip IN VARCHAR2
--            , wku_kod IN VARCHAR2
--            , kat_wojskowa IN VARCHAR2
--            , stosunek_wojskowy IN VARCHAR2
--            , uwagi IN VARCHAR2
--            , www IN VARCHAR2
--            , email IN VARCHAR2
--            , ob_kod IN VARCHAR2
--            , nar_kod IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
--            , plec IN VARCHAR2
            , tytul_przed IN NUMBER
            , tytul_po IN NUMBER
--            , czy_polonia IN VARCHAR2
--            , zamiejscowa IN VARCHAR2
--            , gdzie_socjalne IN VARCHAR2
--            , us_id IN NUMBER
--            , akad_czy_rezerwa IN VARCHAR2
--            , akad_wykroczenia IN VARCHAR2
--            , akad_uwagi IN VARCHAR2
--            , szk_id IN NUMBER
--            , poziom_uprawnien IN VARCHAR2
--            , typ_dokumentu IN VARCHAR2
--            , nr_karty_bibl IN VARCHAR2
--            , bk_email IN VARCHAR2
--            , bk_czymigrowac IN NUMBER
--            , kraj_urodzenia IN VARCHAR2
--            , dane_zew_status IN VARCHAR2
--            , osiagniecia IN CLOB
--            , osiagniecia_ang IN CLOB
--            , epuap_identyfikator IN VARCHAR2
--            , epuap_skrytka IN VARCHAR2
--            , czy_losy_absolwentow IN VARCHAR2
--            , czy_losy_abs_zgoda IN DATE
--            , czy_losy_abs_rezyg IN DATE
--            , bk_czy_migr_zgoda IN DATE
--            , bk_czy_migr_rezyg IN DATE
--            , kraj_dok_kod IN VARCHAR2
--            , data_waznosci_dowodu IN DATE
--            , pw_kraj_mat IN VARCHAR2
--            , czy_klub_abs IN VARCHAR2
--            , czy_klub_abs_zgoda IN DATE
--            , czy_klub_abs_rezyg IN DATE
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Osoby_t
    AS TABLE OF V2u_Dz_Osoba_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
