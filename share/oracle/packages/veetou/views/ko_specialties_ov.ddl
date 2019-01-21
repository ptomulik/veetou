CREATE OR REPLACE VIEW v2u_ko_specialties_ov
    (
      job_uuid
    , specialty
    , pages_count
    , sheets_count
    , CONSTRAINT v2u_ko_specialties_ov_fk0 FOREIGN KEY (job_uuid)
        REFERENCES v2u_ko_jobs(job_uuid)
        DISABLE NOVALIDATE
    )
AS WITH ungrouped AS
    (
        SELECT
              job_uuid
            , V2u_Ko_Specialty_t(v.header, v.preamble) specialty
            , distinct_page_ids_count
            , sheet_id
        FROM v2u_ko_x_sheets_ov v
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
