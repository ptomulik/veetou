CREATE TABLE v2u_dz_osoby_grup
OF V2u_Dz_Osoba_Grupy_t
    (
          CONSTRAINT v2u_dz_osoby_grup_pk PRIMARY KEY (gr_nr, os_id, zaj_cyk_id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/

-- vim: set ft=sql ts=4 sw=4 et:
