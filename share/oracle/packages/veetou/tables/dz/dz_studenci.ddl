CREATE TABLE v2u_dz_studenci
OF V2u_Dz_Student_t
    (
          CONSTRAINT v2u_dz_studenci_pk PRIMARY KEY (id)
        , utw_id DEFAULT USER
        , utw_data DEFAULT SYSDATE
        , mod_id DEFAULT USER
        , mod_data DEFAULT SYSDATE
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_dz_studenci_idx1 ON v2u_dz_studenci(indeks);
/
CREATE OR REPLACE TRIGGER v2u_dz_studenci_tr0
    BEFORE UPDATE ON v2u_dz_studenci
    FOR EACH ROW
    BEGIN
        SELECT SYSDATE INTO :new.mod_data FROM dual;
    END;
/
-- vim: set ft=sql ts=4 sw=4 et:
