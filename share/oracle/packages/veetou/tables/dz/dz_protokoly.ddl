CREATE TABLE v2u_dz_protokoly
OF V2u_Dz_Protokol_t
    (
          CONSTRAINT v2u_dz_protokoly_pk
            PRIMARY KEY (id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_dz_protokoly_idx1
    ON v2u_dz_protokoly(prz_kod);
/
CREATE INDEX v2u_dz_protokoly_idx2
    ON v2u_dz_protokoly(prz_kod, cdyd_kod);
/
CREATE INDEX v2u_dz_protokoly_idx3
    ON v2u_dz_protokoly(zaj_cyk_id);
/
CREATE INDEX v2u_dz_protokoly_idx4
    ON v2u_dz_protokoly(prz_kod, cdyd_kod, zaj_cyk_id);
-- vim: set ft=sql ts=4 sw=4 et:
