CREATE OR REPLACE VIEW v2u_ko_x_sheets
AS SELECT
      v.job_uuid job_uuid
    , v.id id
    , v.sheet.job_uuid sheet_job_uuid
    , v.sheet.id sheet_id
    , v.sheet.pages_parsed sheet_pages_parsed
    , v.sheet.first_page sheet_first_page
    , v.sheet.ects_mandatory sheet_ects_mandatory
    , v.sheet.ects_other sheet_ects_other
    , v.sheet.ects_total sheet_ects_total
    , v.sheet.ects_attained sheet_ects_attained

    , (
        SELECT LISTAGG(VALUE(t).id, ',')
        WITHIN GROUP (ORDER BY VALUE(t))
        FROM TABLE(pages) t
        GROUP BY 1
      ) page_ids
    , (
        SELECT LISTAGG(VALUE(t).page_number, ',')
        WITHIN GROUP (ORDER BY VALUE(t))
        FROM TABLE(pages) t
        GROUP BY 1
      ) page_page_numbers
    , (
        SELECT LISTAGG(VALUE(t).parser_page_number, ',')
        WITHIN GROUP (ORDER BY VALUE(t))
        FROM TABLE(pages) t
        GROUP BY 1
      ) page_parser_page_numbers

    , v.header.id header_id
    , v.header.university header_university
    , v.header.faculty header_faculty

    , v.preamble.id preamble_id
    , v.preamble.studies_modetier preamble_studies_modetier
    , v.preamble.title preamble_title
    , v.preamble.student_index preamble_student_index
    , v.preamble.first_name preamble_first_name
    , v.preamble.last_name preamble_last_name
    , v.preamble.student_name preamble_student_name
    , v.preamble.semester_code preamble_semester_code
    , v.preamble.studies_field preamble_studies_field
    , v.preamble.semester_number preamble_semester_number
    , v.preamble.studies_specialty preamble_studies_specialty

    , v.report.id report_id
    , v.report.source report_source
    , v.report.datetime report_datetime
    , v.report.first_page report_first_page
    , v.report.sheets_parsed report_sheets_parsed
    , v.report.pages_parsed report_pages_parsed

    , v.distinct_headers_count  distinct_headers_count
    , v.distinct_preambles_count distinct_preambles_count
    , v.distinct_reports_count distinct_reports_count
FROM v2u_ko_x_sheets_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
