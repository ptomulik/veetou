CREATE TABLE v2u_dz_grupy
OF V2u_Dz_Grupa_t
    (
          CONSTRAINT v2u_dz_grupy_pk PRIMARY KEY (nr, zaj_cyk_id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/

-- vim: set ft=sql ts=4 sw=4 et:
