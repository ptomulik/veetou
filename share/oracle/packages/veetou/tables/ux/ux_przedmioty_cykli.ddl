CREATE TABLE v2u_ux_przedmioty_cykli
OF V2u_Ux_Przedmiot_Cyklu_t
    (
          CONSTRAINT v2u_ux_przedmioty_cykli_pk PRIMARY KEY (prz_kod, cdyd_kod)
        , CONSTRAINT v2u_ux_przedmioty_cykli_f1
            FOREIGN KEY (prz_kod)
            REFERENCES v2u_ux_przedmioty(kod)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_ux_przedmioty_cykli_idx1 ON v2u_ux_przedmioty_cykli(prz_kod);
/
CREATE INDEX v2u_ux_przedmioty_cykli_idx2 ON v2u_ux_przedmioty_cykli(cdyd_kod);
-- vim: set ft=sql ts=4 sw=4 et: