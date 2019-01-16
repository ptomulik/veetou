CREATE OR REPLACE VIEW veetou_ko_preambles_ov
    ( job_uuid
    , id
    , preamble
    , CONSTRAINT veetou_ko_preambles_ov_pk PRIMARY KEY (job_uuid, id)
        RELY DISABLE NOVALIDATE
    , CONSTRAINT veetou_ko_preambles_ov_fk0 FOREIGN KEY (job_uuid)
        REFERENCES veetou_ko_jobs_ov(job_uuid)
        RELY DISABLE NOVALIDATE
    )
AS SELECT
      t.job_uuid job_uuid
    , t.id id
    , Veetou_Ko_Preamble_Typ
        ( studies_modetier => t.studies_modetier
        , title => t.title
        , student_index => t.student_index
        , first_name => t.first_name
        , last_name => t.last_name
        , student_name => t.student_name
        , semester_code => t.semester_code
        , studies_field => t.studies_field
        , semester_number => t.semester_number
        , studies_specialty => t.studies_specialty
        ) preamble
FROM veetou_ko_preambles t;

-- vim: set ft=sql ts=4 sw=4 et:
