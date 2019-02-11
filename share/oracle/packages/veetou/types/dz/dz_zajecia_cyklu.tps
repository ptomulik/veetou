CREATE OR REPLACE TYPE V2u_Dz_Zajecia_Cyklu_t
    FORCE AUTHID CURRENT_USER UNDER V2u_Dz_Zajecia_Cyklu_B_t
    ( );
/
CREATE OR REPLACE TYPE V2u_Dz_Zajecia_Cykli_t
    AS TABLE OF V2u_Dz_Zajecia_Cyklu_t;

-- vim: set ft=sql ts=4 sw=4 et:
