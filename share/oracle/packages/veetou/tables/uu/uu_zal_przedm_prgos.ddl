CREATE TABLE v2u_uu_zal_przedm_prgos
OF V2u_Uu_Zal_Przedm_Prgos_t
    (
          CONSTRAINT v2u_uu_zal_przedm_prgos_pk
            PRIMARY KEY (pk_zal_przedm_prgos, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
;
/
CREATE INDEX v2u_uu_zal_przedm_prgos_idx1
    ON v2u_uu_zal_przedm_prgos(os_id, cdyd_kod, prz_kod);
/
CREATE INDEX v2u_uu_zal_przedm_prgos_idx2
    ON v2u_uu_zal_przedm_prgos(os_id, cdyd_kod, prz_kod, prgos_id);
/
CREATE INDEX v2u_uu_zal_przedm_prgos_idx3
    ON v2u_uu_zal_przedm_prgos(os_id, cdyd_kod, prz_kod, prgos_id, etpos_id);
/

-- vim: set ft=sql ts=4 sw=4 et:
