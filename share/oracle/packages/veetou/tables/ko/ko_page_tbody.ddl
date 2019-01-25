CREATE TABLE v2u_ko_page_tbody
    ( job_uuid RAW(16) NOT NULL
    , ko_page_id NUMBER(38)
    , ko_tbody_id NUMBER(38)
    , CONSTRAINT v2u_ko_page_tbody_pk PRIMARY KEY (ko_page_id, ko_tbody_id, job_uuid)
    , CONSTRAINT v2u_ko_page_tbody_uq1 UNIQUE (job_uuid, ko_page_id)
    , CONSTRAINT v2u_ko_page_tbody_uq2 UNIQUE (job_uuid, ko_tbody_id)
    , CONSTRAINT v2u_ko_page_tbody_fk0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
    , CONSTRAINT v2u_ko_page_tbody_fk1 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES v2u_ko_pages(job_uuid, id)
    , CONSTRAINT v2u_ko_page_tbody_fk2 FOREIGN KEY (job_uuid, ko_tbody_id) REFERENCES v2u_ko_tbodies(job_uuid, id));

-- vim: set ft=sql ts=4 sw=4 et:
