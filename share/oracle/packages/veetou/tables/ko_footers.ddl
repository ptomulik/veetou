CREATE TABLE veetou_ko_footers
    ( job_uuid RAW(16) NOT NULL
    , id NUMBER(38) NOT NULL
    , pagination VARCHAR(32 CHAR) CHECK(pagination >= 0)
    , sheet_page_number NUMBER(2) CHECK(sheet_page_number >= 0)
    , sheet_pages_total NUMBER(2) CHECK(sheet_pages_total >= 0)
    , generator_name VARCHAR(256 CHAR)
    , generator_home VARCHAR(256 CHAR)
    , CONSTRAINT veetou_ko_footers_pk PRIMARY KEY (job_uuid, id)
    , CONSTRAINT veetou_ko_footers_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid));

COMMENT ON TABLE veetou_ko_footers IS 'Stopki na Kartach Osiągnięć';
COMMENT ON COLUMN veetou_ko_footers.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN veetou_ko_footers.id IS 'Lokalny identyfikator stopki';
COMMENT ON COLUMN veetou_ko_footers.pagination IS 'Paginacja zapisana w stopce';
COMMENT ON COLUMN veetou_ko_footers.sheet_page_number IS 'Numer strony na arkuszu';
COMMENT ON COLUMN veetou_ko_footers.sheet_pages_total IS 'Całkowita liczba stron arkusza';
COMMENT ON COLUMN veetou_ko_footers.generator_name IS 'Nazwa programu, który wygenerował Kartę Osiągnięć';
COMMENT ON COLUMN veetou_ko_footers.generator_home IS 'Adres URL programu, który wygenerował Kartę Osiągnięć';

-- vim: set ft=sql ts=4 sw=4 et:
