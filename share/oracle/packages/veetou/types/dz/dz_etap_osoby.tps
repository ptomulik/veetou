CREATE OR REPLACE TYPE V2u_Dz_Etap_Osoby_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Etap_Osoby_B_t
    ( );
/
CREATE OR REPLACE TYPE V2u_Dz_Etapy_Osob_t
    AS TABLE OF V2u_Dz_Etap_Osoby_t;

-- vim: set ft=sql ts=4 sw=4 et:
