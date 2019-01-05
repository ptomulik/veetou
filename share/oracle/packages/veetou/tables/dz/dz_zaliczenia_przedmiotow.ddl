CREATE TABLE v2u_dz_zaliczenia_przedmiotow
OF V2u_Dz_Zalicz_Przedmiotu_t
    (
          CONSTRAINT v2u_dz_zalicz_przedmiotow_pk
            PRIMARY KEY (os_id, prz_kod, cdyd_kod)
        , CONSTRAINT v2u_dz_zalicz_przedmiotow_f1
            FOREIGN KEY (prz_kod)
            REFERENCES v2u_dz_przedmioty(kod)
        , utw_id DEFAULT USER
        , utw_data DEFAULT SYSDATE
        , mod_id DEFAULT USER
        , mod_data DEFAULT SYSDATE
    )
OBJECT IDENTIFIER IS PRIMARY KEY
;
/
CREATE OR REPLACE TRIGGER v2u_dz_zaliczenia_przedm_tr0
    BEFORE UPDATE ON v2u_dz_zaliczenia_przedmiotow
    FOR EACH ROW
    BEGIN
        SELECT SYSDATE INTO :new.mod_data FROM dual;
    END;
/
-- vim: set ft=sql ts=4 sw=4 et:
