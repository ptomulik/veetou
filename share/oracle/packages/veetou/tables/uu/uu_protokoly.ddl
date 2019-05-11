CREATE TABLE v2u_uu_protokoly
OF V2u_Uu_Protokol_t
    (
          CONSTRAINT v2u_uu_protokoly_pk PRIMARY KEY (pk_protokol, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_uu_protokoly_idx1
    ON v2u_uu_protokoly(id);
/
-- vim: set ft=sql ts=4 sw=4 et:
