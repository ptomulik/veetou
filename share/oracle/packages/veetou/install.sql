--
-- DATA TABLES
--

@@tables/ko_jobs.sql;
@@tables/ko_reports.sql;
@@tables/ko_sheets.sql;
@@tables/ko_pages.sql;
@@tables/ko_headers.sql;
@@tables/ko_preambles.sql;
@@tables/ko_tbodies.sql;
@@tables/ko_footers.sql;
@@tables/ko_trs.sql;

--
-- JUNCTION TABLES
--

@@junctions/ko_page_footer.ddl;
@@junctions/ko_page_header.ddl;
@@junctions/ko_page_preamble.ddl;
@@junctions/ko_page_tbody.ddl;
@@junctions/ko_report_sheets.ddl;
@@junctions/ko_sheet_pages.ddl;
@@junctions/ko_tbody_trs.ddl;

--
-- VIEWS
--

@@views/ko_full.sql;
@@views/ko_refined.sql;
@@views/ko_subject_instances.sql;
--

--
-- PACKAGES
--
@@pkg/match.pkg

-- depends on others...
@@tables/subject_mappings.sql;


-- vim: set ft=sql ts=4 sw=4 et:
