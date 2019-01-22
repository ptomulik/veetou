--CREATE OR REPLACE VIEW v2u_ko_reports_ov
--    ( job_uuid
--    , id
--    , report
--    , CONSTRAINT v2u_ko_reports_ov_pk PRIMARY KEY (job_uuid, id)
--        RELY DISABLE NOVALIDATE
--    , CONSTRAINT v2u_ko_reports_ov_fk0 FOREIGN KEY (job_uuid)
--        REFERENCES v2u_ko_jobs(job_uuid)
--        DISABLE NOVALIDATE
--    )
--AS SELECT
--      t.job_uuid job_uuid
--    , t.id id
--    , V2u_Ko_Report_t
--        ( id => t.id
--        , source => t.source
--        , datetime => t.datetime
--        , first_page => t.first_page
--        , sheets_parsed => t.sheets_parsed
--        , pages_parsed => t.pages_parsed
--        ) report
--FROM v2u_ko_reports t;
CREATE OR REPLACE VIEW v2u_ko_reports_ov
OF V2u_Ko_Report_t
WITH OBJECT IDENTIFIER (job_uuid, id)
AS SELECT t.job_uuid
        , t.id
        , t.source
        , t.datetime
        , t.first_page
        , t.sheets_parsed
        , t.pages_parsed
FROM v2u_ko_reports t;

-- vim: set ft=sql ts=4 sw=4 et:
