CREATE OR REPLACE VIEW veetou_ko_specialty_instances_ov
AS WITH ungrouped AS
    (
        SELECT
              job_uuid
            , Veetou_Ko_Specialty_Typ(header, preamble) specialty
            , v.preamble.semester_code semester_code
            , distinct_page_ids_count
            , sheet_id
        FROM veetou_ko_x_sheets_ov v
    )
SELECT
      job_uuid
    , specialty
    , semester_code
    , SUM(u.distinct_page_ids_count) pages_count
    , COUNT(DISTINCT sheet_id) sheets_count
FROM ungrouped u
GROUP BY job_uuid, specialty, semester_code
ORDER BY job_uuid, specialty, semester_code;

-- vim: set ft=sql ts=4 sw=4 et: