CREATE TABLE v2u_ux_atrybuty_przedmiotow
OF V2u_Ux_Atrybut_Przedmiotu_t
    (
          CONSTRAINT v2u_ux_atrybuty_przedm_pk PRIMARY KEY (id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_ux_atrybuty_przedm_idx1
    ON v2u_ux_atrybuty_przedmiotow(prz_kod);
/
CREATE INDEX v2u_ux_atrybuty_przedm_idx2
    ON v2u_ux_atrybuty_przedmiotow(prz_kod, tatr_kod);
/
CREATE OR REPLACE TRIGGER v2u_ux_atrybuty_przedm_tr1
    BEFORE INSERT ON v2u_ux_atrybuty_przedmiotow
FOR EACH ROW
WHEN (new.id IS NULL)
BEGIN
    -- UUID-like
    SELECT RAWTOHEX(DBMS_CRYPTO.RANDOMBYTES(16))
        INTO :new.id
    FROM dual;
END;
/

-- vim: set ft=sql ts=4 sw=4 et:
