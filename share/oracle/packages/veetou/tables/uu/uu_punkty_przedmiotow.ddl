CREATE TABLE v2u_uu_punkty_przedmiotow
OF V2u_Uu_Punkty_Przedmiotu_t
    (
          CONSTRAINT v2u_uu_punkty_przedmiotow_pk
            PRIMARY KEY (pk_punkty_przedmiotu, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_uu_punkty_przedmiotow_idx1
    ON v2u_uu_punkty_przedmiotow(prz_kod);
/
CREATE INDEX v2u_uu_punkty_przedmiotow_idx2
    ON v2u_uu_punkty_przedmiotow(prz_kod, ilosc);
/
CREATE INDEX v2u_uu_punkty_przedmiotow_idx3
    ON v2u_uu_punkty_przedmiotow(prz_kod, prg_kod);
/
-- vim: set ft=sql ts=4 sw=4 et:
