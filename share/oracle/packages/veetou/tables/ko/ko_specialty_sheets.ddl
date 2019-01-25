CREATE TABLE v2u_ko_specialty_sheets
    (
          job_uuid RAW(16)
        , specialty_id NUMBER(38)
        , sheet_id NUMBER(38)
        , CONSTRAINT v2u_ko_specialty_sheets_pk PRIMARY KEY (sheet_id, specialty_id, job_uuid)
        , CONSTRAINT v2u_ko_specialty_sheets_uq1 UNIQUE (sheet_id, job_uuid)
        , CONSTRAINT v2u_ko_specialty_sheets_fk0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_specialty_sheets_fk1 FOREIGN KEY (sheet_id, job_uuid) REFERENCES v2u_ko_sheets(id, job_uuid)
        , CONSTRAINT v2u_ko_specialty_sheets_fk2 FOREIGN KEY (specialty_id, job_uuid) REFERENCES v2u_ko_specialties(id, job_uuid)
    );

MERGE INTO v2u_ko_specialty_sheets tgt
USING
    (
        WITH u AS
        (
            SELECT job_uuid, id, sheet_ids
            FROM v2u_ko_specialties
        )
        SELECT
              u.job_uuid job_uuid
            , u.id specialty_id
            , VALUE(t) sheet_id
        FROM u u
        CROSS JOIN TABLE(u.sheet_ids) t
    ) src
ON (tgt.sheet_id = src.sheet_id AND
    tgt.specialty_id = src.specialty_id AND
    tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT (job_uuid, specialty_id, sheet_id)
    VALUES (src.job_uuid, src.specialty_id, src.sheet_id);


-- vim: set ft=sql ts=4 sw=4 et:
