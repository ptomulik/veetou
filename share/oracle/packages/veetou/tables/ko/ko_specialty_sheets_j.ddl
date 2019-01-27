CREATE TABLE v2u_ko_specialty_sheets_j
    (
          job_uuid RAW(16)
        , specialty_id NUMBER(38)
        , sheet_id NUMBER(38)
        , CONSTRAINT v2u_ko_specialty_sheets_j_pk
            PRIMARY KEY (sheet_id, specialty_id, job_uuid)
        , CONSTRAINT v2u_ko_specialty_sheets_j_u1
            UNIQUE (sheet_id, job_uuid)
        , CONSTRAINT v2u_ko_specialty_sheets_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_specialty_sheets_j_f1
            FOREIGN KEY (sheet_id, job_uuid)
            REFERENCES v2u_ko_sheets(id, job_uuid)
        , CONSTRAINT v2u_ko_specialty_sheets_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialty_issues(id, job_uuid)
    );

-- vim: set ft=sql ts=4 sw=4 et:
