CREATE TABLE v2u_dz_wartosci_ocen
OF V2u_Dz_Wartosc_Oceny_t
    (
          CONSTRAINT v2u_dz_wartosci_ocen_pk
            PRIMARY KEY (toc_kod, kolejnosc)
        , CONSTRAINT v2u_dz_wartosci_ocen_u1
            UNIQUE (toc_kod, opis)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
-- vim: set ft=sql ts=4 sw=4 et:
