CREATE TABLE v2u_dz_przedmioty
OF V2u_Dz_Przedmiot_t
    (
          CONSTRAINT v2u_dz_przedmioty_pk PRIMARY KEY (kod)
        , utw_id DEFAULT USER
        , utw_data DEFAULT SYSDATE
        , mod_id DEFAULT USER
        , mod_data DEFAULT SYSDATE
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE OR REPLACE TRIGGER v2u_dz_przedmioty_tr0
    BEFORE UPDATE ON v2u_dz_przedmioty
    FOR EACH ROW
    BEGIN
        SELECT SYSDATE INTO :new.mod_data FROM dual;
    END;
/
-- vim: set ft=sql ts=4 sw=4 et:
