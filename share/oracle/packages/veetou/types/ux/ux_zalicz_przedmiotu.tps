CREATE OR REPLACE TYPE V2u_Ux_Zalicz_Przedmiotu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Zalicz_Przedmiotu_B_t
    ( );
/
CREATE OR REPLACE TYPE V2u_Ux_Zalicz_Przedmiotow_t
    AS TABLE OF V2u_Ux_Zalicz_Przedmiotu_t;

-- vim: set ft=sql ts=4 sw=4 et:
