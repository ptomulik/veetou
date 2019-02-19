CREATE TABLE v2u_dz_atrybuty_przedmiotow
OF V2u_Dz_Atrybut_Przedmiotu_t
    (
          CONSTRAINT v2u_dz_atrybuty_przedm_pk PRIMARY KEY (id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_dz_atrybuty_przedm_idx1
    ON v2u_dz_atrybuty_przedmiotow(prz_kod);
/
CREATE INDEX v2u_dz_atrybuty_przedm_idx2
    ON v2u_dz_atrybuty_przedmiotow(prz_kod, tatr_kod);
-- vim: set ft=sql ts=4 sw=4 et:
