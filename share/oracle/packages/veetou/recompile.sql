@@pkg.pkg;

BEGIN
    VEETOU_Pkg.Uninstall('KEEP');
END;
/
DROP PACKAGE VEETOU_Pkg;

--
-- PACKAGES
--
@@pkg/util.pkg
@@pkg/match.pkg

--
-- DATA TABLES
--

@@tables/ko_job.typ;
@@tables/ko_jobs_ov.ddl;
--
@@tables/ko_report.typ;
@@tables/ko_reports_ov.ddl;
--
@@tables/ko_sheet.typ;
@@tables/ko_sheets_ov.ddl;
--
@@tables/ko_page.typ;
@@tables/ko_pages_ov.ddl;
--
@@tables/ko_header.typ;
@@tables/ko_headers_ov.ddl;
--
@@tables/ko_preamble.typ;
@@tables/ko_preambles_ov.ddl;
--
@@tables/ko_tbody.typ;
@@tables/ko_tbodies_ov.ddl;
--
@@tables/ko_footer.typ;
@@tables/ko_footers_ov.ddl;
--
@@tables/ko_tr.typ;
@@tables/ko_trs_ov.ddl;
--
@@tables/program_mapping.typ;
@@tables/program_mappings_ov.ddl;
--

--
-- JUNCTION TABLES
--

--@@junctions/ko_page_footer.ddl;
--@@junctions/ko_page_header.ddl;
--@@junctions/ko_page_preamble.ddl;
--@@junctions/ko_page_tbody.ddl;
--@@junctions/ko_report_sheets.ddl;
--@@junctions/ko_sheet_pages.ddl;
--@@junctions/ko_tbody_trs.ddl;

--
-- VIEWS
--

@@views/ko_full.sql;
@@views/ko_refined.sql;
@@views/ko_subject_instances.sql;
@@views/ko_program_instances.sql;
@@views/ko_students.sql;
--

-- depends on others...
@@tables/subject_mapping.typ;
@@tables/subject_mappings_ov.ddl;
--
@@views/ko_mapped_subjects.sql;
@@views/ko_mapped_programs.sql;


-- vim: set ft=sql ts=4 sw=4 et:
