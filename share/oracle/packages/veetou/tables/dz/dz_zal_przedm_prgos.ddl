CREATE TABLE v2u_dz_zal_przedm_prgos
OF V2u_Dz_Zal_Przedm_Prgos_t
    (
          CONSTRAINT v2u_dz_zal_przedm_prgos_pk
            PRIMARY KEY (prgos_id, cdyd_kod, prz_kod)
        , utw_id DEFAULT USER
        , utw_data DEFAULT SYSDATE
        , mod_id DEFAULT USER
        , mod_data DEFAULT SYSDATE
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE OR REPLACE TRIGGER v2u_dz_zal_przedm_prgos_tr0
    BEFORE UPDATE ON v2u_dz_zal_przedm_prgos
    FOR EACH ROW
    BEGIN
        SELECT SYSDATE INTO :new.mod_data FROM dual;
    END;
/
-- vim: set ft=sql ts=4 sw=4 et:
