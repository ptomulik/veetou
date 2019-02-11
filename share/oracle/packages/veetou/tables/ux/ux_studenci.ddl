CREATE TABLE v2u_ux_studenci
OF V2u_Ux_Student_t
    (
          CONSTRAINT v2u_ux_studenci_pk PRIMARY KEY (id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_ux_studenci_idx1 ON v2u_ux_studenci(indeks);

-- vim: set ft=sql ts=4 sw=4 et:
