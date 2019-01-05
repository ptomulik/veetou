CREATE TABLE v2u_dz_osoby_grup
OF V2u_Dz_Osoba_Grupy_t
    (
          CONSTRAINT v2u_dz_osoby_grup_pk PRIMARY KEY (gr_nr, os_id, zaj_cyk_id)
        , utw_id DEFAULT USER
        , utw_data DEFAULT SYSDATE
        , mod_id DEFAULT USER
        , mod_data DEFAULT SYSDATE
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE OR REPLACE TRIGGER v2u_dz_osoby_grup_tr0
    BEFORE UPDATE ON v2u_dz_osoby_grup
    FOR EACH ROW
    BEGIN
        SELECT SYSDATE INTO :new.mod_data FROM dual;
    END;
/

-- vim: set ft=sql ts=4 sw=4 et:
