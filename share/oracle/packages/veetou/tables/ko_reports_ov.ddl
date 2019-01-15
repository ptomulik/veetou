CREATE VIEW veetou_ko_reports_ov
        ( job_uuid
        , id
        , report
        , CONSTRAINT veetou_ko_reports_ov_pk PRIMARY KEY (job_uuid, id)
            RELY DISABLE NOVALIDATE
        , CONSTRAINT veetou_ko_reports_ov_fk0 FOREIGN KEY (job_uuid)
            REFERENCES veetou_ko_jobs_ov(job_uuid)
            RELY DISABLE NOVALIDATE
        )
        AS SELECT
          t.job_uuid job_uuid
        , t.id id
        , Veetou_Ko_Report_Typ
            ( source => t.source
            , datetime => t.datetime
            , first_page => t.first_page
            , sheets_parsed => t.sheets_parsed
            , pages_parsed => t.pages_parsed
            ) report
        FROM veetou_ko_reports t;

-- vim: set ft=sql ts=4 sw=4 et:
