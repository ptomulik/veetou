CREATE MATERIALIZED VIEW v2u_ko_x_trs
OF V2u_Ko_X_Tr_t
BUILD DEFERRED
REFRESH COMPLETE
AS SELECT * FROM v2u_ko_x_trs_dv;

-- vim: set ft=sql ts=4 sw=4 et:
