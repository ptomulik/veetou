CREATE TABLE v2u_dz_zajecia_prz_obcych
OF V2u_Dz_Zajecia_Prz_Obcego_t
    (
         CONSTRAINT v2u_dz_zajecia_prz_obcych_pk
            PRIMARY KEY (przob_id, dec_id, tzaj_kod)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/

-- vim: set ft=sql ts=4 sw=4 et:
