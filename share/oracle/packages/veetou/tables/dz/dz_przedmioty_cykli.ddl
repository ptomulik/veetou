CREATE TABLE v2u_dz_przedmioty_cykli
OF V2u_Dz_Przedmiot_Cyklu_t
    (
          CONSTRAINT v2u_dz_przedmioty_cykli_pk PRIMARY KEY (prz_kod, cdyd_kod)
        , utw_id DEFAULT USER
        , utw_data DEFAULT SYSDATE
        , mod_id DEFAULT USER
        , mod_data DEFAULT SYSDATE
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_dz_przedmioty_cykli_idx1 ON v2u_dz_przedmioty_cykli(prz_kod);
/
CREATE INDEX v2u_dz_przedmioty_cykli_idx2 ON v2u_dz_przedmioty_cykli(cdyd_kod);
/
CREATE OR REPLACE TRIGGER v2u_dz_przedmioty_cykli_tr0
    BEFORE UPDATE ON v2u_dz_przedmioty_cykli
    FOR EACH ROW
    BEGIN
        SELECT SYSDATE INTO :new.mod_data FROM dual;
    END;
/
-- vim: set ft=sql ts=4 sw=4 et:
