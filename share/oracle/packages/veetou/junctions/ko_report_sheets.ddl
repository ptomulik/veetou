CREATE TABLE veetou_ko_report_sheets
     ( job_uuid RAW(16) NOT NULL
     , ko_report_id NUMBER(38)
     , ko_sheet_id NUMBER(38)
     , CONSTRAINT veetou_ko_report_sheets_pk PRIMARY KEY (job_uuid, ko_report_id, ko_sheet_id)
     , CONSTRAINT veetou_ko_report_sheets_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
     , CONSTRAINT veetou_ko_report_sheets_fk1 FOREIGN KEY (job_uuid, ko_report_id) REFERENCES veetou_ko_reports(job_uuid, id)
     , CONSTRAINT veetou_ko_report_sheets_fk2 FOREIGN KEY (job_uuid, ko_sheet_id) REFERENCES veetou_ko_sheets(job_uuid, id));

-- vim: set ft=sql ts=4 sw=4 et: