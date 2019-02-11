CREATE OR REPLACE TYPE V2u_Dz_Przedmiot_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Przedmiot_B_t
    ( );
/
CREATE OR REPLACE TYPE V2u_Dz_Przedmioty_t
    AS TABLE OF V2u_Dz_Przedmiot_t;

-- vim: set ft=sql ts=4 sw=4 et:
