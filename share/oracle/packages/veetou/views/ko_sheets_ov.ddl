CREATE OR REPLACE VIEW v2u_ko_sheets_ov
    ( job_uuid
    , id
    , sheet
    , CONSTRAINT v2u_ko_sheets_ov_pk PRIMARY KEY (job_uuid, id)
        RELY DISABLE NOVALIDATE
    , CONSTRAINT v2u_ko_sheets_ov_fk0 FOREIGN KEY (job_uuid)
        REFERENCES v2u_ko_jobs(job_uuid)
        DISABLE NOVALIDATE
    )
AS SELECT
      t.job_uuid job_uuid
    , t.id id
    , V2u_Ko_Sheet_t
        ( id => t.id
        , pages_parsed => t.pages_parsed
        , first_page => t.first_page
        , ects_mandatory => t.ects_mandatory
        , ects_other => t.ects_other
        , ects_total => t.ects_total
        , ects_attained => t.ects_attained
        ) sheet
FROM v2u_ko_sheets t;

-- vim: set ft=sql ts=4 sw=4 et:
