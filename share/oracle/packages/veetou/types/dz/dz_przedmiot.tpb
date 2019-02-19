CREATE OR REPLACE TYPE BODY V2u_Dz_Przedmiot_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Przedmiot_t(
              SELF IN OUT NOCOPY V2u_Dz_Przedmiot_t
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
    IS
    BEGIN
        SELF.init(
              kod => kod
            , nazwa => nazwa
            , jed_org_kod => jed_org_kod
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , tpro_kod => tpro_kod
            , czy_wielokrotne => czy_wielokrotne
            , name => name
            , skrocony_opis => skrocony_opis
            , short_description => short_description
            , jed_org_kod_biorca => jed_org_kod_biorca
            , jzk_kod => jzk_kod
            , kod_sok => kod_sok
            , opis => opis
            , description => description
            , literatura => literatura
            , bibliography => bibliography
            , efekty_uczenia => efekty_uczenia
            , efekty_uczenia_ang => efekty_uczenia_ang
            , kryteria_oceniania => kryteria_oceniania
            , kryteria_oceniania_ang => kryteria_oceniania_ang
            , praktyki_zawodowe => praktyki_zawodowe
            , praktyki_zawodowe_ang => praktyki_zawodowe_ang
            , url => url
            , kod_isced => kod_isced
            , nazwa_pol => nazwa_pol
            , guid => guid
            , pw_nazwa_supl => pw_nazwa_supl
            , pw_nazwa_supl_ang => pw_nazwa_supl_ang
            );
        RETURN;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et:
