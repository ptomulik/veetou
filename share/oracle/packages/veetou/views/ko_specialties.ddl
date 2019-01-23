CREATE MATERIALIZED VIEW v2u_ko_specialties
OF V2u_Ko_Specialty_t
BUILD DEFERRED
REFRESH COMPLETE
AS SELECT * FROM v2u_ko_specialties_dv;

-- vim: set ft=sql ts=4 sw=4 et:
