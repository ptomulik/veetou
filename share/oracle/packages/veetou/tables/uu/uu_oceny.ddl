CREATE TABLE v2u_uu_oceny
OF V2u_Uu_Ocena_t
    (
          CONSTRAINT v2u_uu_oceny_pk PRIMARY KEY (pk_ocena, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_uu_oceny_idx1
    ON v2u_uu_oceny(os_id, prot_id, term_prot_nr);
/
-- vim: set ft=sql ts=4 sw=4 et:
