CREATE MATERIALIZED VIEW v2u_ko_x_sheets_mv
OF V2u_Ko_X_Sheet_t
    VARRAY page_ids STORE AS LOB (ENABLE STORAGE IN ROW)
    VARRAY footer_ids STORE AS LOB (ENABLE STORAGE IN ROW)
BUILD DEFERRED
REFRESH COMPLETE
AS SELECT * FROM v2u_ko_x_sheets_dv;

ALTER TABLE v2u_ko_x_sheets_mv ADD (SCOPE FOR (sheet) IS v2u_ko_sheets);
ALTER TABLE v2u_ko_x_sheets_mv ADD (SCOPE FOR (header) IS v2u_ko_headers);
ALTER TABLE v2u_ko_x_sheets_mv ADD (SCOPE FOR (preamble) IS v2u_ko_preambles);
ALTER TABLE v2u_ko_x_sheets_mv ADD (SCOPE FOR (report) IS v2u_ko_reports);

BEGIN
DBMS_MVIEW.REFRESH('v2u_ko_x_sheets_mv');
END;

-- vim: set ft=sql ts=4 sw=4 et:
