CREATE OR REPLACE TYPE V2u_Dz_Przedmiot_B_t
    FORCE AUTHID CURRENT_USER AS OBJECT
    ( kod VARCHAR2(20 CHAR)
    , nazwa VARCHAR2(200 CHAR)
    , jed_org_kod VARCHAR2(20 CHAR)
    , utw_id VARCHAR2(30 CHAR)
    , utw_data DATE
    , mod_id VARCHAR2(30 CHAR)
    , mod_data DATE
    , tpro_kod VARCHAR2(20 CHAR)
    , czy_wielokrotne NUMBER(1)
    , name VARCHAR2(200 CHAR)
    , skrocony_opis VARCHAR2(1000 CHAR)
    , short_description VARCHAR2(1000 CHAR)
    , jed_org_kod_biorca VARCHAR2(20 CHAR)
    , jzk_kod VARCHAR2(3 CHAR)
    , kod_sok VARCHAR2(5 CHAR)
    , opis CLOB
    , description CLOB
    , literatura CLOB
    , bibliography CLOB
    , efekty_uczenia CLOB
    , efekty_uczenia_ang CLOB
    , kryteria_oceniania CLOB
    , kryteria_oceniania_ang CLOB
    , praktyki_zawodowe VARCHAR2(1000 CHAR)
    , praktyki_zawodowe_ang VARCHAR2(1000 CHAR)
    , url VARCHAR2(500 CHAR)
    , kod_isced VARCHAR2(5 CHAR)
    , nazwa_pol VARCHAR2(200 CHAR)
    , guid VARCHAR2(32 CHAR)
    , pw_nazwa_supl VARCHAR2(200 CHAR)
    , pw_nazwa_supl_ang VARCHAR2(200 CHAR)

    , CONSTRUCTOR FUNCTION V2u_Dz_Przedmiot_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Przedmiot_B_t
            , kod IN VARCHAR2
            , nazwa IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , czy_wielokrotne IN NUMBER
            , name IN VARCHAR2
            , skrocony_opis IN VARCHAR2
            , short_description IN VARCHAR2
            , jed_org_kod_biorca IN VARCHAR2
            , jzk_kod IN VARCHAR2
            , kod_sok IN VARCHAR2
            , opis IN CLOB
            , description IN CLOB
            , literatura IN CLOB
            , bibliography IN CLOB
            , efekty_uczenia IN CLOB
            , efekty_uczenia_ang IN CLOB
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            , praktyki_zawodowe IN VARCHAR2
            , praktyki_zawodowe_ang IN VARCHAR2
            , url IN VARCHAR2
            , kod_isced IN VARCHAR2
            , nazwa_pol IN VARCHAR2
            , guid IN VARCHAR2
            , pw_nazwa_supl IN VARCHAR2
            , pw_nazwa_supl_ang IN VARCHAR2
            ) RETURN SELF AS RESULT

    , MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Przedmiot_B_t
            , kod IN VARCHAR2
            , nazwa IN VARCHAR2
            , jed_org_kod IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , tpro_kod IN VARCHAR2
            , czy_wielokrotne IN NUMBER
            , name IN VARCHAR2
            , skrocony_opis IN VARCHAR2
            , short_description IN VARCHAR2
            , jed_org_kod_biorca IN VARCHAR2
            , jzk_kod IN VARCHAR2
            , kod_sok IN VARCHAR2
            , opis IN CLOB
            , description IN CLOB
            , literatura IN CLOB
            , bibliography IN CLOB
            , efekty_uczenia IN CLOB
            , efekty_uczenia_ang IN CLOB
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            , praktyki_zawodowe IN VARCHAR2
            , praktyki_zawodowe_ang IN VARCHAR2
            , url IN VARCHAR2
            , kod_isced IN VARCHAR2
            , nazwa_pol IN VARCHAR2
            , guid IN VARCHAR2
            , pw_nazwa_supl IN VARCHAR2
            , pw_nazwa_supl_ang IN VARCHAR2
            )
    )
NOT INSTANTIABLE NOT FINAL;

-- vim: set ft=sql ts=4 sw=4 et:
