CREATE TABLE v2u_uu_zajecia_cykli
OF V2u_Uu_Zajecia_Cyklu_t
    (
          CONSTRAINT v2u_uu_zajecia_cykli_pk
                PRIMARY KEY (pk_zajecia_cyklu, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_uu_zajecia_cykli_idx1
    ON v2u_uu_zajecia_cykli(prz_kod, cdyd_kod, tzaj_kod);
/
-- vim: set ft=sql ts=4 sw=4 et:
