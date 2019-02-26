CREATE TABLE v2u_uu_przedmioty
OF V2u_Uu_Przedmiot_t
    (
          CONSTRAINT v2u_uu_przedmioty_pk PRIMARY KEY (pk_subject, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_uu_przedmioty_idx1
    ON v2u_uu_przedmioty(kod);

-- vim: set ft=sql ts=4 sw=4 et:
