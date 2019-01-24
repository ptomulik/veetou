CREATE OR REPLACE VIEW v2u_ko_specialties
AS SELECT *
FROM v2u_ko_specialties_mv
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
