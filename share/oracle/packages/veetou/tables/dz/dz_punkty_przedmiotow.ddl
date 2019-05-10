CREATE TABLE v2u_dz_punkty_przedmiotow
OF V2u_Dz_Punkty_Przedmiotu_t
    (
          CONSTRAINT v2u_dz_punkty_przedmiotow_pk PRIMARY KEY (id)
        , utw_id DEFAULT USER
        , utw_data DEFAULT SYSDATE
        , mod_id DEFAULT USER
        , mod_data DEFAULT SYSDATE
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_dz_punkty_przedmiotow_idx1
    ON v2u_dz_punkty_przedmiotow(prz_kod);
/
CREATE INDEX v2u_dz_punkty_przedmiotow_idx2
    ON v2u_dz_punkty_przedmiotow(prz_kod, cdyd_pocz, cdyd_kon);
/
CREATE INDEX v2u_dz_punkty_przedmiotow_idx3
    ON v2u_dz_punkty_przedmiotow(prz_kod, cdyd_pocz, cdyd_kon, tpkt_kod);
/
CREATE INDEX v2u_dz_punkty_przedmiotow_idx4
    ON v2u_dz_punkty_przedmiotow(prz_kod, prg_kod);
/
CREATE INDEX v2u_dz_punkty_przedmiotow_idx5
    ON v2u_dz_punkty_przedmiotow(prz_kod, prg_kod, cdyd_pocz, cdyd_kon);
/
CREATE INDEX v2u_dz_punkty_przedmiotow_idx6
    ON v2u_dz_punkty_przedmiotow(prz_kod, prg_kod, cdyd_pocz, cdyd_kon, tpkt_kod);
/
CREATE OR REPLACE TRIGGER v2u_dz_punkty_przedmiotow_tr0
    BEFORE UPDATE ON v2u_dz_punkty_przedmiotow
    FOR EACH ROW
    BEGIN
        SELECT SYSDATE INTO :new.mod_data FROM dual;
    END;
/
-- vim: set ft=sql ts=4 sw=4 et:
