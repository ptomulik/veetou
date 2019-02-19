CREATE TABLE v2u_ux_przedmioty
OF V2u_Ux_Przedmiot_t
    (
          CONSTRAINT v2u_ux_przedmioty_pk PRIMARY KEY (coalesced_subj_code)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_ux_przedmioty_idx1
    ON v2u_ux_przedmioty(kod);

-- vim: set ft=sql ts=4 sw=4 et:
