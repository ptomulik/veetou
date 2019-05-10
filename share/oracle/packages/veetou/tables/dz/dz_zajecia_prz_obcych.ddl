CREATE TABLE v2u_dz_zajecia_prz_obcych
OF V2u_Dz_Zajecia_Prz_Obcego_t
    (
         CONSTRAINT v2u_dz_zajecia_prz_obcych_pk
            PRIMARY KEY (przob_id, dec_id, tzaj_kod)
        , utw_id DEFAULT USER
        , utw_data DEFAULT SYSDATE
        , mod_id DEFAULT USER
        , mod_data DEFAULT SYSDATE
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE OR REPLACE TRIGGER v2u_dz_zajecia_prz_obcych_tr0
    BEFORE UPDATE ON v2u_dz_zajecia_prz_obcych
    FOR EACH ROW
    BEGIN
        SELECT SYSDATE INTO :new.mod_data FROM dual;
    END;
/
-- vim: set ft=sql ts=4 sw=4 et:
