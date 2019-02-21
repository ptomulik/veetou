CREATE OR REPLACE TYPE BODY V2u_Dz_Program_Osoby_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Program_Osoby_t(
              SELF IN OUT NOCOPY V2u_Dz_Program_Osoby_t
            , kod IN VARCHAR2
            , opis IN VARCHAR2
            , data_od IN DATE
            , data_do IN DATE
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tryb_studiow IN VARCHAR2
            , rodzaj_studiow IN VARCHAR2
            , czas_trwania IN VARCHAR2
            , description IN VARCHAR2
            , dalsze_studia IN VARCHAR2
            , dalsze_studia_ang IN VARCHAR2
            , rodzaj_studiow_ang IN VARCHAR2
            , czas_trwania_ang IN VARCHAR2
            , tryb_studiow_ang IN VARCHAR2
            , tcdyd_kod IN VARCHAR2
            , liczba_jedn IN NUMBER
            , czy_wyswietlac IN VARCHAR2
            , uprawnienia_zawodowe IN CLOB
            , uprawnienia_zawodowe_ang IN CLOB
            , opis_nie IN VARCHAR2
            , opis_ros IN VARCHAR2
            , opis_his IN VARCHAR2
            , opis_fra IN VARCHAR2
            , konf_sr_kod IN VARCHAR2
            , prow_kier_id IN NUMBER
            , profil IN VARCHAR2
            , czy_studia_miedzyobszarowe IN VARCHAR2
            , czy_bezplatny_ustawa IN VARCHAR2
            , limit_ects IN NUMBER
            , dodatkowe_ects_ustawa IN NUMBER
            , dodatkowe_ects_uczelnia IN NUMBER
            , czynniki_szkodliwe IN VARCHAR2
            , zakres IN VARCHAR2
            , zakres_ang IN VARCHAR2
            , jed_org_kod_podst IN VARCHAR2
            , kod_polon_ism IN VARCHAR2
            , kod_polon_dr IN VARCHAR2
            , kod_isced IN VARCHAR2
            , kod_polon_rekrutacja IN VARCHAR2
            , jed_org_kod_prow IN VARCHAR2
            , ustal_date_konca_studiow IN VARCHAR2
            , pw_data_od_rekr IN DATE
            , pw_data_do_rekr IN DATE
            , pw_ects_obowiazkowe IN NUMBER
            , pw_ects_obieralne IN NUMBER
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              kod => kod
            , opis => opis
            , data_od => data_od
            , data_do => data_do
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , tryb_studiow => tryb_studiow
            , rodzaj_studiow => rodzaj_studiow
            , czas_trwania => czas_trwania
            , description => description
            , dalsze_studia => dalsze_studia
            , dalsze_studia_ang => dalsze_studia_ang
            , rodzaj_studiow_ang => rodzaj_studiow_ang
            , czas_trwania_ang => czas_trwania_ang
            , tryb_studiow_ang => tryb_studiow_ang
            , tcdyd_kod => tcdyd_kod
            , liczba_jedn => liczba_jedn
            , czy_wyswietlac => czy_wyswietlac
            , uprawnienia_zawodowe => uprawnienia_zawodowe
            , uprawnienia_zawodowe_ang => uprawnienia_zawodowe_ang
            , opis_nie => opis_nie
            , opis_ros => opis_ros
            , opis_his => opis_his
            , opis_fra => opis_fra
            , konf_sr_kod => konf_sr_kod
            , prow_kier_id => prow_kier_id
            , profil => profil
            , czy_studia_miedzyobszarowe => czy_studia_miedzyobszarowe
            , czy_bezplatny_ustawa => czy_bezplatny_ustawa
            , limit_ects => limit_ects
            , dodatkowe_ects_ustawa => dodatkowe_ects_ustawa
            , dodatkowe_ects_uczelnia => dodatkowe_ects_uczelnia
            , czynniki_szkodliwe => czynniki_szkodliwe
            , zakres => zakres
            , zakres_ang => zakres_ang
            , jed_org_kod_podst => jed_org_kod_podst
            , kod_polon_ism => kod_polon_ism
            , kod_polon_dr => kod_polon_dr
            , kod_isced => kod_isced
            , kod_polon_rekrutacja => kod_polon_rekrutacja
            , jed_org_kod_prow => jed_org_kod_prow
            , ustal_date_konca_studiow => ustal_date_konca_studiow
            , pw_data_od_rekr => pw_data_od_rekr
            , pw_data_do_rekr => pw_data_do_rekr
            , pw_ects_obowiazkowe => pw_ects_obowiazkowe
            , pw_ects_obieralne => pw_ects_obieralne
            );
        RETURN;
    END;
END;

-- vim: set ft=sql ts=4 sw=4 et:
