CREATE TABLE v2u_dz_etapy_osob
OF V2u_Dz_Etap_Osoby_t
    (
          CONSTRAINT v2u_dz_etapy_osob_pk PRIMARY KEY (id)
        , CONSTRAINT v2u_dz_etapy_osob_f0 FOREIGN KEY (prgos_id) REFERENCES v2u_dz_programy_osob(id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_dz_etapy_osob_idx1 ON v2u_dz_etapy_osob(prg_kod, cdyd_kod, kolejnosc, prgos_id);
-- vim: set ft=sql ts=4 sw=4 et:
