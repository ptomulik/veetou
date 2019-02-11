CREATE TABLE v2u_ux_etapy_osob
OF V2u_Ux_Etap_Osoby_t
    (
          CONSTRAINT v2u_ux_etapy_osob_pk PRIMARY KEY (id)
        , CONSTRAINT v2u_ux_etapy_osob_f0 FOREIGN KEY (prgos_id) REFERENCES v2u_ux_programy_osob(id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_ux_etapy_osob_idx1 ON v2u_ux_etapy_osob(prgos_id, cdyd_kod);
/
CREATE INDEX v2u_ux_etapy_osob_idx2 ON v2u_ux_etapy_osob(prgos_id, cdyd_kod, etp_kod);

-- vim: set ft=sql ts=4 sw=4 et:
