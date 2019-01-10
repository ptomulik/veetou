CREATE TABLE veetou_ko_page_header
     ( job_uuid RAW(16) NOT NULL
     , ko_page_id NUMBER(38)
     , ko_header_id NUMBER(38)
     , CONSTRAINT veetou_ko_page_header_pk PRIMARY KEY (job_uuid, ko_page_id, ko_header_id)
     , CONSTRAINT veetou_ko_page_header_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
     , CONSTRAINT veetou_ko_page_header_fk1 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id)
     , CONSTRAINT veetou_ko_page_header_fk2 FOREIGN KEY (job_uuid, ko_header_id) REFERENCES veetou_ko_headers(job_uuid, id));

-- vim: set ft=sql ts=4 sw=4 et:
