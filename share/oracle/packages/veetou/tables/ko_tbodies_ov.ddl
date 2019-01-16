CREATE OR REPLACE VIEW veetou_ko_tbodies_ov
    ( job_uuid
    , id
    , tbody
    , CONSTRAINT veetou_ko_tbodies_ov_pk PRIMARY KEY (job_uuid, id)
        RELY DISABLE NOVALIDATE
    , CONSTRAINT veetou_ko_tbodies_ov_fk0 FOREIGN KEY (job_uuid)
        REFERENCES veetou_ko_jobs_ov(job_uuid)
        RELY DISABLE NOVALIDATE
    )
AS SELECT
      t.job_uuid job_uuid
    , t.id id
    , Veetou_Ko_Tbody_Typ
        ( remark => t.remark
        ) tbody
FROM veetou_ko_tbodies t;

-- vim: set ft=sql ts=4 sw=4 et:
