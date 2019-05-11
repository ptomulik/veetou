CREATE TABLE v2u_uu_atrybuty_przedmiotow
OF V2u_Uu_Atrybut_Przedmiotu_t
    (
          CONSTRAINT v2u_uu_atrybuty_przedm_pk
            PRIMARY KEY (pk_attribute, pk_subject, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_uu_atrybuty_przedm_idx1
    ON v2u_uu_atrybuty_przedmiotow(prz_kod);
/
CREATE INDEX v2u_uu_atrybuty_przedm_idx2
    ON v2u_uu_atrybuty_przedmiotow(prz_kod, tatr_kod);
/
-- vim: set ft=sql ts=4 sw=4 et:
