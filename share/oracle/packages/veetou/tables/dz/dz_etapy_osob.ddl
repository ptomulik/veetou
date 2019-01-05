CREATE TABLE v2u_dz_etapy_osob
OF V2u_Dz_Etap_Osoby_t
    (
          CONSTRAINT v2u_dz_etapy_osob_pk
            PRIMARY KEY (id)
        , CONSTRAINT v2u_dz_etapy_osob_f0
            FOREIGN KEY (prgos_id) REFERENCES v2u_dz_programy_osob(id)
        , utw_id DEFAULT USER
        , utw_data DEFAULT SYSDATE
        , mod_id DEFAULT USER
        , mod_data DEFAULT SYSDATE
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_dz_etapy_osob_idx1 ON v2u_dz_etapy_osob(prgos_id, cdyd_kod);
/
CREATE INDEX v2u_dz_etapy_osob_idx2 ON v2u_dz_etapy_osob(prgos_id, cdyd_kod, etp_kod);
/
CREATE OR REPLACE TRIGGER v2u_dz_etapy_osob_tr0
    BEFORE UPDATE ON v2u_dz_etapy_osob
    FOR EACH ROW
    BEGIN
        SELECT SYSDATE INTO :new.mod_data FROM dual;
    END;
/
-- vim: set ft=sql ts=4 sw=4 et:
