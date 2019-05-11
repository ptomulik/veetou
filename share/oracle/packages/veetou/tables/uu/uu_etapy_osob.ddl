CREATE TABLE v2u_uu_etapy_osob
OF V2u_Uu_Etap_Osoby_t
    (
          CONSTRAINT v2u_uu_etapy_osob_pk
            PRIMARY KEY (pk_student, pk_etap_osoby, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_uu_etapy_osob_idx1 ON v2u_uu_etapy_osob(id);
/
CREATE INDEX v2u_uu_etapy_osob_idx2 ON v2u_uu_etapy_osob(prgos_id, cdyd_kod);
/
CREATE INDEX v2u_uu_etapy_osob_idx3 ON v2u_uu_etapy_osob(prgos_id, cdyd_kod, etp_kod);
/
-- vim: set ft=sql ts=4 sw=4 et:
