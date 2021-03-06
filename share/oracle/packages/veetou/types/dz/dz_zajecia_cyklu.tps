CREATE OR REPLACE TYPE V2u_Dz_Zajecia_Cyklu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Zajecia_Cyklu_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Zajecia_Cyklu_t(
              SELF IN OUT NOCOPY V2u_Dz_Zajecia_Cyklu_t
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
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Zajecia_Cykli_t
    AS TABLE OF V2u_Dz_Zajecia_Cyklu_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
