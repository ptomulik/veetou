CREATE TABLE v2u_ko_sheet_pages_j
    ( job_uuid RAW(16) NOT NULL
    , ko_sheet_id NUMBER(38)
    , ko_page_id NUMBER(38)
    , CONSTRAINT v2u_ko_sheet_pages_j_pk PRIMARY KEY (ko_page_id, ko_sheet_id, job_uuid)
    , CONSTRAINT v2u_ko_sheet_pages_j_u1 UNIQUE (job_uuid, ko_page_id)
    , CONSTRAINT v2u_ko_sheet_pages_j_f0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
    , CONSTRAINT v2u_ko_sheet_pages_j_f1 FOREIGN KEY (job_uuid, ko_sheet_id) REFERENCES v2u_ko_sheets(job_uuid, id)
    , CONSTRAINT v2u_ko_sheet_pages_j_f2 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES v2u_ko_pages(job_uuid, id));

-- vim: set ft=sql ts=4 sw=4 et:
