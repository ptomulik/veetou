CREATE TABLE v2u_dz_oceny
OF V2u_Dz_Ocena_t
    (
          CONSTRAINT v2u_dz_oceny_pk
            PRIMARY KEY (os_id, prot_id, term_prot_nr)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
-- vim: set ft=sql ts=4 sw=4 et:
