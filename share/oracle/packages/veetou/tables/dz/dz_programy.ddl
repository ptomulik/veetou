CREATE TABLE v2u_dz_programy
OF V2u_Dz_Program_t
    (
          CONSTRAINT v2u_dz_programy_pk PRIMARY KEY (kod)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_dz_programy_idx1
    ON v2u_dz_programy(jed_org_kod_podst);
/
CREATE INDEX v2u_dz_programy_idx2
    ON v2u_dz_programy(tryb_studiow);
/
CREATE INDEX v2u_dz_programy_idx3
    ON v2u_dz_programy(rodzaj_studiow);
/
CREATE INDEX v2u_dz_programy_idx4
    ON v2u_dz_programy(opis, tryb_studiow, rodzaj_studiow, jed_org_kod_podst);
/
-- vim: set ft=sql ts=4 sw=4 et:
