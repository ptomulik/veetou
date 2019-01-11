--
-- DATA TABLES
--

@@tables/ko_jobs.ddl;
@@tables/ko_job.typ;
@@tables/ko_reports.ddl;
@@tables/ko_report.typ;
@@tables/ko_sheets.ddl;
@@tables/ko_sheet.typ;
@@tables/ko_pages.ddl;
@@tables/ko_page.typ;
@@tables/ko_headers.ddl;
@@tables/ko_header.typ;
@@tables/ko_preambles.ddl;
@@tables/ko_preamble.typ;
@@tables/ko_tbodies.ddl;
@@tables/ko_tbody.typ;
@@tables/ko_footers.ddl;
@@tables/ko_footer.typ;
@@tables/ko_trs.ddl;
@@tables/ko_tr.typ;
@@tables/subject_matchers.ddl;
@@tables/subject_matcher.typ;
@@tables/subject_mappings.ddl;
@@tables/subject_mapping.typ;

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

@@views/ko_full.ddl;
@@views/ko_full.typ;
@@views/ko_refined.ddl;
@@views/ko_refined.typ;
@@views/ko_subject_instances.ddl;
@@views/ko_subject_instance.typ;

-- vim: set ft=sql ts=4 sw=4 et:
