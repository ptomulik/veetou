CREATE TABLE v2u_uu_zaliczenia_przedmiotow
OF V2u_Uu_Zalicz_Przedmiotu_t
    (
          CONSTRAINT v2u_uu_zalicz_przedmiotow_pk
            PRIMARY KEY (pk_zalicz_przedmiotu, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
;
/
CREATE INDEX v2u_uu_zalicz_przedmiotow_idx1
    ON v2u_uu_zaliczenia_przedmiotow(os_id, cdyd_kod, prz_kod);
/
-- vim: set ft=sql ts=4 sw=4 et:
