CREATE TABLE v2u_dz_zajecia_cykli
OF V2u_Dz_Zajecia_Cyklu_t
    (
          CONSTRAINT v2u_dz_zajecia_cykli_pk PRIMARY KEY (id)
        , CONSTRAINT v2u_dz_zajecia_cykli_f0
            FOREIGN KEY (prz_kod)
            REFERENCES v2u_dz_przedmioty(kod)
        , CONSTRAINT v2u_dz_zajecia_cykli_f1
            FOREIGN KEY (prz_kod, cdyd_kod)
            REFERENCES v2u_dz_przedmioty_cykli(prz_kod, cdyd_kod)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_dz_zajecia_cykli_idx1
    ON v2u_dz_zajecia_cykli(prz_kod, cdyd_kod, tzaj_kod);

-- vim: set ft=sql ts=4 sw=4 et:
