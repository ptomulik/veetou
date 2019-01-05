CREATE OR REPLACE TYPE V2u_Dz_Atrybut_Przedmiotu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Atrybut_Przedmiotu_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Atrybut_Przedmiotu_t(
              SELF IN OUT NOCOPY V2u_Dz_Atrybut_Przedmiotu_t
            , tatr_kod IN VARCHAR2
            , prz_kod IN VARCHAR2
            , wart_lst_id IN NUMBER
            , prz_kod_rel IN VARCHAR2
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , wartosc IN CLOB
            , wartosc_ang IN CLOB
            , id IN VARCHAR2
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Atrybuty_Przedmiotow_t
    AS TABLE OF V2u_Dz_Atrybut_Przedmiotu_t;
/
-- vim: set ft=sql ts=4 sw=4 et:
