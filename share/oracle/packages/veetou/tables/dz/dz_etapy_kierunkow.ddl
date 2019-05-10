CREATE TABLE v2u_dz_etapy_kierunkow
OF V2u_Dz_Etap_Kierunku_t
    (
          CONSTRAINT v2u_dz_etapy_kierunkow_pk
                PRIMARY KEY (krstd_kod, etp_kod)
        , utw_id DEFAULT USER
        , utw_data DEFAULT SYSDATE
        , mod_id DEFAULT USER
        , mod_data DEFAULT SYSDATE
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_dz_etapy_kierunkow_idx1
    ON v2u_dz_etapy_kierunkow(krstd_kod);
/
CREATE INDEX v2u_dz_etapy_kierunkow_idx2
    ON v2u_dz_etapy_kierunkow(etp_kod);
/
CREATE OR REPLACE TRIGGER v2u_dz_etapy_kierunkow_tr0
    BEFORE UPDATE ON v2u_dz_etapy_kierunkow
    FOR EACH ROW
    BEGIN
        SELECT SYSDATE INTO :new.mod_data FROM dual;
    END;
/
-- vim: set ft=sql ts=4 sw=4 et:
