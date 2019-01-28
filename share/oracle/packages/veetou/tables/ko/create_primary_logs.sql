CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_jobs
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_reports
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_sheets
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_pages
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_headers
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_preambles
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_tbodies
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_footers
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_trs
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;

CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_page_footer_j
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_page_header_j
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_page_preamble_j
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_page_tbody_j
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_report_sheets_j
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_sheet_pages_j
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;
CREATE MATERIALIZED VIEW LOG ON v2u_ko_ko_tbody_trs_j
    WITH PRIMARY KEY
    INCLUDING NEW VALUES;

-- vim: set ft=sql ts=4 sw=4 et:
