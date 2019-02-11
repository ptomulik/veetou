CREATE TABLE v2u_ux_zaliczenia_przedmiotow
OF V2u_Ux_Zalicz_Przedmiotu_t
    (
          CONSTRAINT v2u_ux_zalicz_przedmiotow_pk
            PRIMARY KEY (os_id, prz_kod, cdyd_kod)
        , CONSTRAINT v2u_ux_zalicz_przedmiotow_f1
            FOREIGN KEY (prz_kod)
            REFERENCES v2u_ux_przedmioty(kod)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
;

-- vim: set ft=sql ts=4 sw=4 et:
