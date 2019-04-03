CREATE TABLE v2u_uu_terminy_protokolow
OF V2u_Uu_Termin_Protokolu_t
    (
          CONSTRAINT v2u_uu_terminy_protokolow_pk
            PRIMARY KEY (pk_termin_protokolu, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_uu_terminy_protokolow_idx1
    ON v2u_uu_terminy_protokolow(prot_id);
-- vim: set ft=sql ts=4 sw=4 et:
