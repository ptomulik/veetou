CREATE TABLE veetou_ko_page_preamble
     ( job_uuid RAW(16) NOT NULL
     , ko_page_id NUMBER(38)
     , ko_preamble_id NUMBER(38)
     , CONSTRAINT veetou_ko_page_preamble_pk PRIMARY KEY (job_uuid, ko_page_id, ko_preamble_id)
     , CONSTRAINT veetou_ko_page_preamble_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
     , CONSTRAINT veetou_ko_page_preamble_fk1 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id)
     , CONSTRAINT veetou_ko_page_preamble_fk2 FOREIGN KEY (job_uuid, ko_preamble_id) REFERENCES veetou_ko_preambles(job_uuid, id));

-- vim: set ft=sql ts=4 sw=4 et:
