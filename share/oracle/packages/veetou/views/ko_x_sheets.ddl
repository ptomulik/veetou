CREATE OR REPLACE VIEW veetou_ko_x_sheets
AS SELECT
      v.job_uuid job_uuid
    , v.header_id header_id
    , v.preamble_id preamble_id
    , v.sheet_id sheet_id
    , v.page_id_list page_id_list
    , v.distinct_page_ids_count  distinct_page_ids_count
    , (
        SELECT LISTAGG(page_number, ',')
        WITHIN GROUP (ORDER BY page_number)
        FROM TABLE(pages)
        GROUP BY 1
      ) page_numbers
    , (
        SELECT LISTAGG(parser_page_number, ',')
        WITHIN GROUP (ORDER BY parser_page_number)
        FROM TABLE(pages) GROUP BY 1
      ) parser_page_numbers
    , v.header_id_list header_id_list
    , v.distinct_header_ids_count  distinct_header_ids_count
    , v.preamble_id_list preamble_id_list
    , v.distinct_preamble_ids_count  distinct_preamble_ids_count
    , v.header.university university
    , v.header.faculty faculty
    , v.preamble.studies_modetier studies_modetier
    , v.preamble.title title
    , v.preamble.student_index student_index
    , v.preamble.first_name first_name
    , v.preamble.last_name last_name
    , v.preamble.student_name student_name
    , v.preamble.semester_code semester_code
    , v.preamble.studies_field studies_field
    , v.preamble.semester_number semester_number
    , v.preamble.studies_specialty studies_specialty
    , v.sheet.pages_parsed pages_parsed
    , v.sheet.first_page first_page
    , v.sheet.ects_mandatory ects_mandatory
    , v.sheet.ects_other ects_other
    , v.sheet.ects_total ects_total
    , v.sheet.ects_attained ects_attained
FROM veetou_ko_x_sheets_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
