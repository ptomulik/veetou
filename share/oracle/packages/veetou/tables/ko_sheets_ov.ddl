CREATE VIEW veetou_ko_sheets_ov
        ( job_uuid
        , id
        , sheet
        , CONSTRAINT veetou_ko_sheets_ov_pk PRIMARY KEY (job_uuid, id)
            RELY DISABLE NOVALIDATE
        , CONSTRAINT veetou_ko_sheets_ov_fk0 FOREIGN KEY (job_uuid)
            REFERENCES veetou_ko_jobs_ov(job_uuid)
            RELY DISABLE NOVALIDATE
        )
        AS SELECT
          t.job_uuid job_uuid
        , t.id id
        , Veetou_Ko_Sheet_Typ
            ( pages_parsed => t.pages_parsed
            , first_page => t.first_page
            , ects_mandatory => t.ects_mandatory
            , ects_other => t.ects_other
            , ects_total => t.ects_total
            , ects_attained => t.ects_attained
            ) sheet
        FROM veetou_ko_sheets t;

-- vim: set ft=sql ts=4 sw=4 et: