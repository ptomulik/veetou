CREATE OR REPLACE TYPE BODY V2u_Dz_Osoba_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Osoba_B_t(
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
    IS
    BEGIN
        SELF.init(
              id => id
            , pesel => pesel
            , imie => imie
            , imie2 => imie2
            , nazwisko => nazwisko
--            , data_ur => data_ur
--            , miasto_ur => miasto_ur
--            , imie_ojca => imie_ojca
--            , imie_matki => imie_matki
--            , nazwisko_panien_matki => nazwisko_panien_matki
--            , nazwisko_rodowe => nazwisko_rodowe
--            , szkola => szkola
--            , sr_nr_dowodu => sr_nr_dowodu
--            , nip => nip
--            , wku_kod => wku_kod
--            , kat_wojskowa => kat_wojskowa
--            , stosunek_wojskowy => stosunek_wojskowy
--            , uwagi => uwagi
--            , www => www
--            , email => email
--            , ob_kod => ob_kod
--            , nar_kod => nar_kod
            , jed_org_kod => jed_org_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
--            , plec => plec
            , tytul_przed => tytul_przed
            , tytul_po => tytul_po
--            , czy_polonia => czy_polonia
--            , zamiejscowa => zamiejscowa
--            , gdzie_socjalne => gdzie_socjalne
--            , us_id => us_id
--            , akad_czy_rezerwa => akad_czy_rezerwa
--            , akad_wykroczenia => akad_wykroczenia
--            , akad_uwagi => akad_uwagi
--            , szk_id => szk_id
--            , poziom_uprawnien => poziom_uprawnien
--            , typ_dokumentu => typ_dokumentu
--            , nr_karty_bibl => nr_karty_bibl
--            , bk_email => bk_email
--            , bk_czymigrowac => bk_czymigrowac
--            , kraj_urodzenia => kraj_urodzenia
--            , dane_zew_status => dane_zew_status
--            , osiagniecia => osiagniecia
--            , osiagniecia_ang => osiagniecia_ang
--            , epuap_identyfikator => epuap_identyfikator
--            , epuap_skrytka => epuap_skrytka
--            , czy_losy_absolwentow => czy_losy_absolwentow
--            , czy_losy_abs_zgoda => czy_losy_abs_zgoda
--            , czy_losy_abs_rezyg => czy_losy_abs_rezyg
--            , bk_czy_migr_zgoda => bk_czy_migr_zgoda
--            , bk_czy_migr_rezyg => bk_czy_migr_rezyg
--            , kraj_dok_kod => kraj_dok_kod
--            , data_waznosci_dowodu => data_waznosci_dowodu
--            , pw_kraj_mat => pw_kraj_mat
--            , czy_klub_abs => czy_klub_abs
--            , czy_klub_abs_zgoda => czy_klub_abs_zgoda
--            , czy_klub_abs_rezyg => czy_klub_abs_rezyg
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
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
    IS
    BEGIN
        SELF.id := id;
        SELF.pesel := pesel;
        SELF.imie := imie;
        SELF.imie2 := imie2;
        SELF.nazwisko := nazwisko;
--        SELF.data_ur := data_ur;
--        SELF.miasto_ur := miasto_ur;
--        SELF.imie_ojca := imie_ojca;
--        SELF.imie_matki := imie_matki;
--        SELF.nazwisko_panien_matki := nazwisko_panien_matki;
--        SELF.nazwisko_rodowe := nazwisko_rodowe;
--        SELF.szkola := szkola;
--        SELF.sr_nr_dowodu := sr_nr_dowodu;
--        SELF.nip := nip;
--        SELF.wku_kod := wku_kod;
--        SELF.kat_wojskowa := kat_wojskowa;
--        SELF.stosunek_wojskowy := stosunek_wojskowy;
--        SELF.uwagi := uwagi;
--        SELF.www := www;
--        SELF.email := email;
--        SELF.ob_kod := ob_kod;
--        SELF.nar_kod := nar_kod;
        SELF.jed_org_kod := jed_org_kod;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
--        SELF.plec := plec;
        SELF.tytul_przed := tytul_przed;
        SELF.tytul_po := tytul_po;
--        SELF.czy_polonia := czy_polonia;
--        SELF.zamiejscowa := zamiejscowa;
--        SELF.gdzie_socjalne := gdzie_socjalne;
--        SELF.us_id := us_id;
--        SELF.akad_czy_rezerwa := akad_czy_rezerwa;
--        SELF.akad_wykroczenia := akad_wykroczenia;
--        SELF.akad_uwagi := akad_uwagi;
--        SELF.szk_id := szk_id;
--        SELF.poziom_uprawnien := poziom_uprawnien;
--        SELF.typ_dokumentu := typ_dokumentu;
--        SELF.nr_karty_bibl := nr_karty_bibl;
--        SELF.bk_email := bk_email;
--        SELF.bk_czymigrowac := bk_czymigrowac;
--        SELF.kraj_urodzenia := kraj_urodzenia;
--        SELF.dane_zew_status := dane_zew_status;
--        SELF.osiagniecia := osiagniecia;
--        SELF.osiagniecia_ang := osiagniecia_ang;
--        SELF.epuap_identyfikator := epuap_identyfikator;
--        SELF.epuap_skrytka := epuap_skrytka;
--        SELF.czy_losy_absolwentow := czy_losy_absolwentow;
--        SELF.czy_losy_abs_zgoda := czy_losy_abs_zgoda;
--        SELF.czy_losy_abs_rezyg := czy_losy_abs_rezyg;
--        SELF.bk_czy_migr_zgoda := bk_czy_migr_zgoda;
--        SELF.bk_czy_migr_rezyg := bk_czy_migr_rezyg;
--        SELF.kraj_dok_kod := kraj_dok_kod;
--        SELF.data_waznosci_dowodu := data_waznosci_dowodu;
--        SELF.pw_kraj_mat := pw_kraj_mat;
--        SELF.czy_klub_abs := czy_klub_abs;
--        SELF.czy_klub_abs_zgoda := czy_klub_abs_zgoda;
--        SELF.czy_klub_abs_rezyg := czy_klub_abs_rezyg;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
