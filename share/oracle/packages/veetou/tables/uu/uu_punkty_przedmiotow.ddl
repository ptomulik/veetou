CREATE TABLE v2u_uu_punkty_przedmiotow
OF V2u_Uu_Punkty_Przedmiotu_t
    (
          CONSTRAINT v2u_uu_punkty_przedmiotow_pk
            PRIMARY KEY (pk_punkty_przedmiotu, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;

-- vim: set ft=sql ts=4 sw=4 et:
