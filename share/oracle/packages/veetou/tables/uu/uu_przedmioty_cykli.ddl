CREATE TABLE v2u_uu_przedmioty_cykli
OF V2u_Uu_Przedmiot_Cyklu_t
    (
          CONSTRAINT v2u_uu_przedmioty_cykli_pk
            PRIMARY KEY (pk_subject, pk_semester, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_uu_przedmioty_cykli_idx1
    ON v2u_uu_przedmioty_cykli(prz_kod);
/
CREATE INDEX v2u_uu_przedmioty_cykli_idx2
    ON v2u_uu_przedmioty_cykli(cdyd_kod);
/
-- vim: set ft=sql ts=4 sw=4 et:
