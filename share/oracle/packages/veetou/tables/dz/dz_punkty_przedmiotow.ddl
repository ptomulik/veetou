CREATE TABLE v2u_dz_punkty_przedmiotow
OF V2u_Dz_Punkty_Przedmiotu_t
    (
          CONSTRAINT v2u_dz_punkty_przedmiotow_pk PRIMARY KEY (id)
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
-- vim: set ft=sql ts=4 sw=4 et:
