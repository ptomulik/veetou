CREATE TABLE v2u_ko_page_header
    ( job_uuid RAW(16) NOT NULL
    , ko_page_id NUMBER(38)
    , ko_header_id NUMBER(38)
    , CONSTRAINT v2u_ko_page_header_pk PRIMARY KEY (ko_page_id, ko_header_id, job_uuid)
    , CONSTRAINT v2u_ko_page_header_uq1 UNIQUE (job_uuid, ko_page_id)
    , CONSTRAINT v2u_ko_page_header_fk0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
    , CONSTRAINT v2u_ko_page_header_fk1 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES v2u_ko_pages(job_uuid, id)
    , CONSTRAINT v2u_ko_page_header_fk2 FOREIGN KEY (job_uuid, ko_header_id) REFERENCES v2u_ko_headers(job_uuid, id));

-- vim: set ft=sql ts=4 sw=4 et:
