CREATE TABLE v2u_ux_zajecia_cykli
OF V2u_Ux_Zajecia_Cyklu_t
    (
          CONSTRAINT v2u_ux_zajecia_cykli_pk PRIMARY KEY (id)
--        , CONSTRAINT v2u_ux_zajecia_cykli_f0
--            FOREIGN KEY (prz_kod)
--            REFERENCES v2u_ux_przedmioty(kod)
--        , CONSTRAINT v2u_ux_zajecia_cykli_f1
--            FOREIGN KEY (prz_kod, cdyd_kod)
--            REFERENCES v2u_ux_przedmioty_cykli(prz_kod, cdyd_kod)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_ux_zajecia_cykli_idx1
    ON v2u_ux_zajecia_cykli(prz_kod, cdyd_kod, tzaj_kod);

CREATE SEQUENCE v2u_ux_zajecia_cykli_sq1 START WITH 100000000;
/

CREATE OR REPLACE TRIGGER v2u_ux_zajecia_cykli_tr1
    BEFORE INSERT ON v2u_ux_zajecia_cykli
FOR EACH ROW
WHEN (new.id IS NULL)
BEGIN
    SELECT v2u_ux_zajecia_cykli_sq1.NEXTVAL
        INTO :new.id
    FROM dual;
END;
/

-- vim: set ft=sql ts=4 sw=4 et:
