CREATE TABLE v2u_dz_przedmioty_obce
OF V2u_Dz_Przedmiot_Obcy_t
    (
          CONSTRAINT v2u_dz_przedmioty_obce_pk
            PRIMARY KEY (id, dec_id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/

-- vim: set ft=sql ts=4 sw=4 et:
