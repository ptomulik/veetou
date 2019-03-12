CREATE TABLE v2u_dz_etapy_kierunkow
OF V2u_Dz_Etap_Kierunku_t
    (
          CONSTRAINT v2u_dz_etapy_kierunkow_pk
                PRIMARY KEY (krstd_kod, etp_kod)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_dz_etapy_kierunkow_idx1
    ON v2u_dz_etapy_kierunkow(krstd_kod);
/
CREATE INDEX v2u_dz_etapy_kierunkow_idx2
    ON v2u_dz_etapy_kierunkow(etp_kod);
-- vim: set ft=sql ts=4 sw=4 et:
