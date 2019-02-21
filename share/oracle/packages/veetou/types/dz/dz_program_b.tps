CREATE OR REPLACE TYPE V2u_Dz_Program_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( kod VARCHAR2(20 CHAR)
    , opis VARCHAR2(200 CHAR)
    , data_od DATE
    , data_do DATE
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , tryb_studiow VARCHAR2(100 CHAR)
    , rodzaj_studiow VARCHAR2(100 CHAR)
    , czas_trwania VARCHAR2(100 CHAR)
    , description VARCHAR2(200 CHAR)
    , dalsze_studia VARCHAR2(200 CHAR)
    , dalsze_studia_ang VARCHAR2(200 CHAR)
    , rodzaj_studiow_ang VARCHAR2(100 CHAR)
    , czas_trwania_ang VARCHAR2(100 CHAR)
    , tryb_studiow_ang VARCHAR2(100 CHAR)
    , tcdyd_kod VARCHAR2(20 CHAR)
    , liczba_jedn NUMBER(10)
    , czy_wyswietlac VARCHAR2(1 CHAR)
    , uprawnienia_zawodowe CLOB
    , uprawnienia_zawodowe_ang CLOB
    , opis_nie VARCHAR2(200 CHAR)
    , opis_ros VARCHAR2(200 CHAR)
    , opis_his VARCHAR2(200 CHAR)
    , opis_fra VARCHAR2(200 CHAR)
    , konf_sr_kod VARCHAR2(20 CHAR)
    , prow_kier_id NUMBER(10)
    , profil VARCHAR2(1 CHAR)
    , czy_studia_miedzyobszarowe VARCHAR2(1 CHAR)
    , czy_bezplatny_ustawa VARCHAR2(1 CHAR)
    , limit_ects NUMBER(15,2)
    , dodatkowe_ects_ustawa NUMBER(15,2)
    , dodatkowe_ects_uczelnia NUMBER(15,2)
    , czynniki_szkodliwe VARCHAR2(4000 CHAR)
    , zakres VARCHAR2(500 CHAR)
    , zakres_ang VARCHAR2(500 CHAR)
    , jed_org_kod_podst VARCHAR2(20 CHAR)
    , kod_polon_ism VARCHAR2(20 CHAR)
    , kod_polon_dr VARCHAR2(20 CHAR)
    , kod_isced VARCHAR2(5 CHAR)
    , kod_polon_rekrutacja VARCHAR2(20 CHAR)
    , jed_org_kod_prow VARCHAR2(20 CHAR)
    , ustal_date_konca_studiow VARCHAR2(1 CHAR)
    , pw_data_od_rekr DATE
    , pw_data_do_rekr DATE
    , pw_ects_obowiazkowe NUMBER(15,2)
    , pw_ects_obieralne NUMBER(15,2)

    , CONSTRUCTOR FUNCTION V2u_Dz_Program_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Program_B_t
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

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Program_B_t
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
            )
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
