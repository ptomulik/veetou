CREATE OR REPLACE VIEW v2u_uv_punkty_przedmiotow
OF V2u_Dz_Punkty_Przedmiotu_t
WITH OBJECT IDENTIFIER (id)
AS
    SELECT * FROM v2u_dz_punkty_przedmiotow
    UNION ALL
    SELECT * FROM v2u_xr_punkty_przedmiotow
;

-- vim: set ft=sql ts=4 sw=4 et:
