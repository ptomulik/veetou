CREATE OR REPLACE TYPE BODY V2u_Dz_Zajecia_Cyklu_B_t AS
    CONSTRUCTOR FUNCTION V2u_Dz_Zajecia_Cyklu_B_t(
              SELF IN OUT NOCOPY V2u_Dz_Zajecia_Cyklu_B_t
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tzaj_kod IN VARCHAR2
            , liczba_godz IN NUMBER
            , limit_miejsc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , waga_pensum IN NUMBER
            , tpro_kod IN VARCHAR2
            , efekty_uczenia IN CLOB
            , efekty_uczenia_ang IN CLOB
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            , url IN VARCHAR2
            , zakres_tematow IN CLOB
            , zakres_tematow_ang IN CLOB
            , metody_dyd IN CLOB
            , metody_dyd_ang IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , czy_pokazywac_termin IN VARCHAR2
            ) RETURN SELF AS RESULT
    IS
    BEGIN
        SELF.init(
              id => id
            , prz_kod => prz_kod
            , cdyd_kod => cdyd_kod
            , tzaj_kod => tzaj_kod
            , liczba_godz => liczba_godz
            , limit_miejsc => limit_miejsc
            , utw_id => utw_id
            , utw_data => utw_data
            , mod_id => mod_id
            , mod_data => mod_data
            , waga_pensum => waga_pensum
            , tpro_kod => tpro_kod
            , efekty_uczenia => efekty_uczenia
            , efekty_uczenia_ang => efekty_uczenia_ang
            , kryteria_oceniania => kryteria_oceniania
            , kryteria_oceniania_ang => kryteria_oceniania_ang
            , url => url
            , zakres_tematow => zakres_tematow
            , zakres_tematow_ang => zakres_tematow_ang
            , metody_dyd => metody_dyd
            , metody_dyd_ang => metody_dyd_ang
            , literatura => literatura
            , literatura_ang => literatura_ang
            , czy_pokazywac_termin => czy_pokazywac_termin
            );
        RETURN;
    END;


    MEMBER PROCEDURE init(
              SELF IN OUT NOCOPY V2u_Dz_Zajecia_Cyklu_B_t
            , id IN NUMBER
            , prz_kod IN VARCHAR2
            , cdyd_kod IN VARCHAR2
            , tzaj_kod IN VARCHAR2
            , liczba_godz IN NUMBER
            , limit_miejsc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , waga_pensum IN NUMBER
            , tpro_kod IN VARCHAR2
            , efekty_uczenia IN CLOB
            , efekty_uczenia_ang IN CLOB
            , kryteria_oceniania IN CLOB
            , kryteria_oceniania_ang IN CLOB
            , url IN VARCHAR2
            , zakres_tematow IN CLOB
            , zakres_tematow_ang IN CLOB
            , metody_dyd IN CLOB
            , metody_dyd_ang IN CLOB
            , literatura IN CLOB
            , literatura_ang IN CLOB
            , czy_pokazywac_termin IN VARCHAR2
            )
    IS
    BEGIN
        SELF.id := id;
        SELF.prz_kod := prz_kod;
        SELF.cdyd_kod := cdyd_kod;
        SELF.tzaj_kod := tzaj_kod;
        SELF.liczba_godz := liczba_godz;
        SELF.limit_miejsc := limit_miejsc;
        SELF.utw_id := utw_id;
        SELF.utw_data := utw_data;
        SELF.mod_id := mod_id;
        SELF.mod_data := mod_data;
        SELF.waga_pensum := waga_pensum;
        SELF.tpro_kod := tpro_kod;
        SELF.efekty_uczenia := efekty_uczenia;
        SELF.efekty_uczenia_ang := efekty_uczenia_ang;
        SELF.kryteria_oceniania := kryteria_oceniania;
        SELF.kryteria_oceniania_ang := kryteria_oceniania_ang;
        SELF.url := url;
        SELF.zakres_tematow := zakres_tematow;
        SELF.zakres_tematow_ang := zakres_tematow_ang;
        SELF.metody_dyd := metody_dyd;
        SELF.metody_dyd_ang := metody_dyd_ang;
        SELF.literatura := literatura;
        SELF.literatura_ang := literatura_ang;
        SELF.czy_pokazywac_termin := czy_pokazywac_termin;
    END;
END;
/
-- vim: set ft=sql ts=4 sw=4 et:
