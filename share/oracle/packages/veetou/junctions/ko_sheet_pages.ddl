CREATE TABLE veetou_ko_sheet_pages
     ( job_uuid RAW(16) NOT NULL
     , ko_sheet_id NUMBER(38)
     , ko_page_id NUMBER(38)
     , CONSTRAINT veetou_ko_sheet_pages_pk PRIMARY KEY (job_uuid, ko_sheet_id, ko_page_id)
     , CONSTRAINT veetou_ko_sheet_pages_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
     , CONSTRAINT veetou_ko_sheet_pages_fk1 FOREIGN KEY (job_uuid, ko_sheet_id) REFERENCES veetou_ko_sheets(job_uuid, id)
     , CONSTRAINT veetou_ko_sheet_pages_fk2 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id));

-- vim: set ft=sql ts=4 sw=4 et:
