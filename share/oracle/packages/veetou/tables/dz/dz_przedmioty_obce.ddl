CREATE TABLE v2u_dz_przedmioty_obce
OF V2u_Dz_Przedmiot_Obcy_t
    (
          CONSTRAINT v2u_dz_przedmioty_obce_pk
            PRIMARY KEY (id, dec_id)
        , utw_id DEFAULT USER
        , utw_data DEFAULT SYSDATE
        , mod_id DEFAULT USER
        , mod_data DEFAULT SYSDATE
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE OR REPLACE TRIGGER v2u_dz_przedmioty_obce_tr0
    BEFORE UPDATE ON v2u_dz_przedmioty_obce
    FOR EACH ROW
    BEGIN
        SELECT SYSDATE INTO :new.mod_data FROM dual;
    END;
/
-- vim: set ft=sql ts=4 sw=4 et:
