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
        SELF.kod := kod;
        SELF.nazwa := nazwa;
        SELF.jed_org_kod := jed_org_kod;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.tpro_kod := tpro_kod;
        SELF.czy_wielokrotne := czy_wielokrotne;
        SELF.name := name;
        SELF.skrocony_opis := skrocony_opis;
        SELF.short_description := short_description;
        SELF.jed_org_kod_biorca := jed_org_kod_biorca;
        SELF.jzk_kod := jzk_kod;
        SELF.kod_sok := kod_sok;
        SELF.opis := opis;
        SELF.description := description;
        SELF.literatura := literatura;
        SELF.bibliography := bibliography;
        SELF.efekty_uczenia := efekty_uczenia;
        SELF.efekty_uczenia_ang := efekty_uczenia_ang;
        SELF.kryteria_oceniania := kryteria_oceniania;
        SELF.kryteria_oceniania_ang := kryteria_oceniania_ang;
        SELF.praktyki_zawodowe := praktyki_zawodowe;
        SELF.praktyki_zawodowe_ang := praktyki_zawodowe_ang;
        SELF.url := url;
        SELF.kod_isced := kod_isced;
        SELF.nazwa_pol := nazwa_pol;
        SELF.guid := guid;
        SELF.pw_nazwa_supl := pw_nazwa_supl;
        SELF.pw_nazwa_supl_ang := pw_nazwa_supl_ang;
    END;
END;
-- vim: set ft=sql ts=4 sw=4 et: