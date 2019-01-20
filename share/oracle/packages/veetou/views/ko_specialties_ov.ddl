CREATE OR REPLACE VIEW veetou_ko_specialties_ov
AS WITH ungrouped AS
    (
        SELECT
              job_uuid
            , Veetou_Ko_Specialty_Typ(v.header, v.preamble) specialty
            , distinct_page_ids_count
            , sheet_id
        FROM veetou_ko_xsheets_ov v
    )
SELECT
      job_uuid
    , specialty
    , SUM(u.distinct_page_ids_count) pages_count
    , COUNT(DISTINCT sheet_id) sheets_count
FROM ungrouped u
GROUP BY job_uuid, specialty
ORDER BY job_uuid, specialty;

-- vim: set ft=sql ts=4 sw=4 et:
