CREATE TABLE v2u_dz_terminy_protokolow
OF V2u_Dz_Termin_Protokolu_t
    (
          CONSTRAINT v2u_dz_terminy_protokolow_pk
            PRIMARY KEY (prot_id, nr)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
-- vim: set ft=sql ts=4 sw=4 et:
