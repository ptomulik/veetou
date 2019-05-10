CREATE TABLE v2u_dz_wartosci_ocen
OF V2u_Dz_Wartosc_Oceny_t
    (
          CONSTRAINT v2u_dz_wartosci_ocen_pk
            PRIMARY KEY (toc_kod, kolejnosc)
        , CONSTRAINT v2u_dz_wartosci_ocen_u1
            UNIQUE (toc_kod, opis)
        , utw_id DEFAULT USER
        , utw_data DEFAULT SYSDATE
        , mod_id DEFAULT USER
        , mod_data DEFAULT SYSDATE
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE OR REPLACE TRIGGER v2u_dz_wartosci_ocen_tr0
    BEFORE UPDATE ON v2u_dz_wartosci_ocen
    FOR EACH ROW
    BEGIN
        SELECT SYSDATE INTO :new.mod_data FROM dual;
    END;
/
-- vim: set ft=sql ts=4 sw=4 et:
