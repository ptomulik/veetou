CREATE OR REPLACE TYPE V2u_Ko_Skipped_Program_V_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Ko_Specialty_Semester_V_t
    ( where_tryb_studiow VARCHAR2(100 CHAR)
    , where_rodzaj_studiow VARCHAR2(100 CHAR)
    , where_jed_org_kod_podst VARCHAR2(32 CHAR)
    , where_opis_like VARCHAR(200 CHAR)
    , prg_kod VARCHAR2(20 CHAR)
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

    , CONSTRUCTOR FUNCTION V2u_Ko_Skipped_Program_V_t(
              SELF IN OUT NOCOPY V2u_Ko_Skipped_Program_V_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , where_tryb_studiow IN VARCHAR2
            , where_rodzaj_studiow IN VARCHAR2
            , where_jed_org_kod_podst IN VARCHAR2
            , where_opis_like IN VARCHAR2
            , program IN V2u_Dz_Program_B_t
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Ko_Skipped_Program_V_t
            , specialty IN V2u_Ko_Specialty_t
            , semester IN V2u_Ko_Semester_t
            , where_tryb_studiow IN VARCHAR2
            , where_rodzaj_studiow IN VARCHAR2
            , where_jed_org_kod_podst IN VARCHAR2
            , where_opis_like IN VARCHAR2
            , program IN V2u_Dz_Program_B_t
            )
    );
/
CREATE OR REPLACE TYPE V2u_Ko_Skipped_Programs_V_t
    AS TABLE OF V2u_Ko_Skipped_Program_V_t;

-- vim: set ft=sql ts=4 sw=4 et:
