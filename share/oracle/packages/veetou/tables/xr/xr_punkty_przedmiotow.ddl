CREATE TABLE v2u_xr_punkty_przedmiotow
OF V2u_Dz_Punkty_Przedmiotu_t
    (
          CONSTRAINT v2u_xr_punkty_przedmiotow_pk PRIMARY KEY (id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE SEQUENCE v2u_xr_punkty_przedmiotow_sq1
        START WITH -1
        INCREMENT BY -1;
/
CREATE OR REPLACE TRIGGER v2u_xr_punkty_przedmiotow_tr1
    BEFORE INSERT ON v2u_xr_punkty_przedmiotow
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_xr_punkty_przedmiotow_sq1.NEXTVAL INTO :new.id FROM dual;
    END;
/
CREATE INDEX v2u_xr_punkty_przedmiotow_idx1
    ON v2u_xr_punkty_przedmiotow(prz_kod);
/
CREATE INDEX v2u_xr_punkty_przedmiotow_idx2
    ON v2u_xr_punkty_przedmiotow(prz_kod, cdyd_pocz, cdyd_kon);
/
CREATE INDEX v2u_xr_punkty_przedmiotow_idx3
    ON v2u_xr_punkty_przedmiotow(prz_kod, cdyd_pocz, cdyd_kon, tpkt_kod);
/
CREATE INDEX v2u_xr_punkty_przedmiotow_idx4
    ON v2u_xr_punkty_przedmiotow(prz_kod, prg_kod);
/
CREATE INDEX v2u_xr_punkty_przedmiotow_idx5
    ON v2u_xr_punkty_przedmiotow(prz_kod, prg_kod, cdyd_pocz, cdyd_kon);
/
CREATE INDEX v2u_xr_punkty_przedmiotow_idx6
    ON v2u_xr_punkty_przedmiotow(prz_kod, prg_kod, cdyd_pocz, cdyd_kon, tpkt_kod);
-- vim: set ft=sql ts=4 sw=4 et:
