CREATE OR REPLACE TYPE V2u_Dz_Punkty_Przedmiotu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Punkty_Przedmiotu_B_t
    ( CONSTRUCTOR FUNCTION V2u_Dz_Punkty_Przedmiotu_t(
              SELF IN OUT NOCOPY V2u_Dz_Punkty_Przedmiotu_t
            , prz_kod IN VARCHAR2
            , prg_kod IN VARCHAR2
            , tpkt_kod IN VARCHAR2
            , ilosc IN NUMBER
            , utw_id IN VARCHAR2
            , utw_data IN DATE
            , mod_id IN VARCHAR2
            , mod_data IN DATE
            , id IN NUMBER
            , cdyd_pocz IN VARCHAR2
            , cdyd_kon IN VARCHAR2
            ) RETURN SELF AS RESULT
    );
/
CREATE OR REPLACE TYPE V2u_Dz_Punkty_Przedmiotow_t
    AS TABLE OF V2u_Dz_Punkty_Przedmiotu_t;

-- vim: set ft=sql ts=4 sw=4 et:
