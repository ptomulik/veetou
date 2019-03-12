CREATE TABLE v2u_dz_etapy_programow
OF V2u_Dz_Etap_Programu_t
    (
          CONSTRAINT v2u_dz_etapy_programow_pk
                PRIMARY KEY (prg_kod, etp_kod)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_dz_etapy_programow_idx1
    ON v2u_dz_etapy_programow(prg_kod);
/
CREATE INDEX v2u_dz_etapy_programow_idx2
    ON v2u_dz_etapy_programow(etp_kod);
/
CREATE INDEX v2u_dz_etapy_programow_idx3
    ON v2u_dz_etapy_programow(prg_kod,nr_roku,tcdyd_kod);
-- vim: set ft=sql ts=4 sw=4 et:
