CREATE TABLE veetou_ko_pages
     ( job_uuid RAW(16) NOT NULL
     , id NUMBER(38) NOT NULL
     , page_number NUMBER(16)
     , parser_page_number NUMBER(16)
     , CONSTRAINT veetou_ko_pages_pk PRIMARY KEY (job_uuid, id)
     , CONSTRAINT veetou_ko_pages_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid));

COMMENT ON TABLE veetou_ko_pages IS 'Strony występujące na Kartach Osiągnięć';
COMMENT ON COLUMN veetou_ko_pages.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN veetou_ko_pages.id IS 'Lokalny identyfikator strony';
COMMENT ON COLUMN veetou_ko_pages.page_number IS 'Numer strony w przetworzonym dokumencie';
COMMENT ON COLUMN veetou_ko_pages.parser_page_number IS 'Numer strony wyliczony przez parser';

-- vim: set ft=sql ts=4 sw=4 et: