CREATE OR REPLACE TYPE V2u_Dz_Program_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Program_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Program_t(
              SELF IN OUT NOCOPY V2u_Dz_Program_t
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
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Programy_t
    AS TABLE OF V2u_Dz_Program_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
