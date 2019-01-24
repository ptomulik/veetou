CREATE MATERIALIZED VIEW v2u_ko_x_trs
OF V2u_Ko_X_Tr_t
BUILD DEFERRED
REFRESH COMPLETE
AS SELECT * FROM v2u_ko_x_trs_dv;

ALTER TABLE v2u_ko_x_trs ADD (SCOPE FOR (tr) IS v2u_ko_trs);
ALTER TABLE v2u_ko_x_trs ADD (SCOPE FOR (page) IS v2u_ko_pages);
ALTER TABLE v2u_ko_x_trs ADD (SCOPE FOR (header) IS v2u_ko_headers);
ALTER TABLE v2u_ko_x_trs ADD (SCOPE FOR (preamble) IS v2u_ko_preambles);
ALTER TABLE v2u_ko_x_trs ADD (SCOPE FOR (tbody) IS v2u_ko_tbodies);
ALTER TABLE v2u_ko_x_trs ADD (SCOPE FOR (footer) IS v2u_ko_footers);
ALTER TABLE v2u_ko_x_trs ADD (SCOPE FOR (sheet) IS v2u_ko_sheets);
ALTER TABLE v2u_ko_x_trs ADD (SCOPE FOR (report) IS v2u_ko_reports);

-- vim: set ft=sql ts=4 sw=4 et:
