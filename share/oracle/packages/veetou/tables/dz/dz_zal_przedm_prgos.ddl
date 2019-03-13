CREATE TABLE v2u_dz_zal_przedm_prgos
OF V2u_Dz_Zal_Przedm_Prgos_t
    (
          CONSTRAINT v2u_dz_zal_przedm_prgos_pk
            PRIMARY KEY (prgos_id, cdyd_kod, prz_kod)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
-- vim: set ft=sql ts=4 sw=4 et:
