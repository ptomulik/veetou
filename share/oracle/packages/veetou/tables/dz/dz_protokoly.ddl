CREATE TABLE v2u_dz_protokoly
OF V2u_Dz_Protokol_t
    (
          CONSTRAINT v2u_dz_protokoly_pk
            PRIMARY KEY (id)
        , utw_id DEFAULT USER
        , utw_data DEFAULT SYSDATE
        , mod_id DEFAULT USER
        , mod_data DEFAULT SYSDATE
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_dz_protokoly_idx1
    ON v2u_dz_protokoly(prz_kod, cdyd_kod, tpro_kod);
/
CREATE INDEX v2u_dz_protokoly_idx2
    ON v2u_dz_protokoly(prz_kod, cdyd_kod, tpro_kod, zaj_cyk_id);
/
CREATE OR REPLACE TRIGGER v2u_dz_protokoly_tr0
    BEFORE UPDATE ON v2u_dz_protokoly
    FOR EACH ROW
    BEGIN
        SELECT SYSDATE INTO :new.mod_data FROM dual;
    END;
/
CREATE SEQUENCE v2u_dz_protokoly_sq1
    START WITH -1
    INCREMENT BY -1;
/
CREATE OR REPLACE TRIGGER v2u_dz_protokoly_tr1
    BEFORE INSERT ON v2u_dz_protokoly
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_dz_protokoly_sq1.NEXTVAL INTO :new.id FROM dual;
    END;
/

-- vim: set ft=sql ts=4 sw=4 et:
