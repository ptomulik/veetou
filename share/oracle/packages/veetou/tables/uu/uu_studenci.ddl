CREATE TABLE v2u_uu_studenci
OF V2u_Uu_Student_t
    (
          CONSTRAINT v2u_uu_studenci_pk PRIMARY KEY (id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_uu_studenci_idx1 ON v2u_uu_studenci(indeks);

-- vim: set ft=sql ts=4 sw=4 et:
