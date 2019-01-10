CREATE TABLE veetou_ko_page_footer
     ( job_uuid RAW(16) NOT NULL
     , ko_page_id NUMBER(38)
     , ko_footer_id NUMBER(38)
     , CONSTRAINT veetou_ko_page_footer_pk PRIMARY KEY (job_uuid, ko_page_id, ko_footer_id)
     , CONSTRAINT veetou_ko_page_footer_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
     , CONSTRAINT veetou_ko_page_footer_fk1 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id)
     , CONSTRAINT veetou_ko_page_footer_fk2 FOREIGN KEY (job_uuid, ko_footer_id) REFERENCES veetou_ko_footers(job_uuid, id));

-- vim: set ft=sql ts=4 sw=4 et:
