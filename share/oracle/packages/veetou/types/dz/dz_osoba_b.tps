CREATE OR REPLACE TYPE V2u_Dz_Osoba_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( id NUMBER(10)
    , pesel VARCHAR2(11 CHAR)
    , imie VARCHAR2(40 CHAR)
    , imie2 VARCHAR2(40 CHAR)
    , nazwisko VARCHAR2(40 CHAR)
--    , data_ur DATE
--    , miasto_ur VARCHAR2(60 CHAR)
--    , imie_ojca VARCHAR2(40 CHAR)
--    , imie_matki VARCHAR2(40 CHAR)
--    , nazwisko_panien_matki VARCHAR2(40 CHAR)
--    , nazwisko_rodowe VARCHAR2(40 CHAR)
--    , szkola VARCHAR2(100 CHAR)
--    , sr_nr_dowodu VARCHAR2(20 CHAR)
--    , nip VARCHAR2(13 CHAR)
--    , wku_kod VARCHAR2(20 CHAR)
--    , kat_wojskowa VARCHAR2(1 CHAR)
--    , stosunek_wojskowy VARCHAR2(20 CHAR)
--    , uwagi VARCHAR2(2000 CHAR)
--    , www VARCHAR2(100 CHAR)
--    , email VARCHAR2(100 CHAR)
--    , ob_kod VARCHAR2(20 CHAR)
--    , nar_kod VARCHAR2(20 CHAR)
    , jed_org_kod VARCHAR2(20 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
--    , plec VARCHAR2(1 CHAR)
    , tytul_przed NUMBER(10)
    , tytul_po NUMBER(10)
--    , czy_polonia VARCHAR2(1 CHAR)
--    , zamiejscowa VARCHAR2(1 CHAR)
--    , gdzie_socjalne VARCHAR2(20 CHAR)
--    , us_id NUMBER(10)
--    , akad_czy_rezerwa VARCHAR2(1 CHAR)
--    , akad_wykroczenia VARCHAR2(1000 CHAR)
--    , akad_uwagi VARCHAR2(1000 CHAR)
--    , szk_id NUMBER(10)
--    , poziom_uprawnien VARCHAR2(1 CHAR)
--    , typ_dokumentu VARCHAR2(1 CHAR)
--    , nr_karty_bibl VARCHAR2(30 CHAR)
--    , bk_email VARCHAR2(100 CHAR)
--    , bk_czymigrowac NUMBER(2)
--    , kraj_urodzenia VARCHAR2(20 CHAR)
--    , dane_zew_status VARCHAR2(1 CHAR)
--    , osiagniecia CLOB
--    , osiagniecia_ang CLOB
--    , epuap_identyfikator VARCHAR2(64 CHAR)
--    , epuap_skrytka VARCHAR2(64 CHAR)
--    , czy_losy_absolwentow VARCHAR2(1 CHAR)
--    , czy_losy_abs_zgoda DATE
--    , czy_losy_abs_rezyg DATE
--    , bk_czy_migr_zgoda DATE
--    , bk_czy_migr_rezyg DATE
--    , kraj_dok_kod VARCHAR2(20 CHAR)
--    , data_waznosci_dowodu DATE
--    , pw_kraj_mat VARCHAR2(20 CHAR)
--    , czy_klub_abs VARCHAR2(1 CHAR)
--    , czy_klub_abs_zgoda DATE
--    , czy_klub_abs_rezyg DATE

    , CONSTRUCTOR FUNCTION V2u_Dz_Osoba_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Osoba_B_t
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

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Osoba_B_t
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
            )
    )
NOT INSTANTIABLE NOT FINAL;
/
-- vim: set ft=sql ts=4 sw=4 et:
