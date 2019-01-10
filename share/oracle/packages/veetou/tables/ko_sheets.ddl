CREATE TABLE veetou_ko_sheets
     ( job_uuid RAW(16) NOT NULL
     , id NUMBER(38) NOT NULL
     , pages_parsed NUMBER(4)
     , first_page NUMBER(16)
     , ects_mandatory NUMBER(16)
     , ects_other NUMBER(16)
     , ects_total NUMBER(16)
     , ects_attained NUMBER(16)
     , CONSTRAINT veetou_ko_sheets_pk PRIMARY KEY (job_uuid, id)
     , CONSTRAINT veetou_ko_sheets_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid));

COMMENT ON TABLE veetou_ko_sheets IS 'Arkusze Kart Osiągnięć wczytane w ramach uruchomienia VEETOU';
COMMENT ON COLUMN veetou_ko_sheets.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN veetou_ko_sheets.id IS 'Lokalny identyfikator arkusza';
COMMENT ON COLUMN veetou_ko_sheets.pages_parsed IS 'Liczba przetworzonych stron arkusza';
COMMENT ON COLUMN veetou_ko_sheets.first_page IS 'Number stony dokumentu na której rozpoczyna się arkusz';
COMMENT ON COLUMN veetou_ko_sheets.ects_mandatory IS 'Liczba wymaganych punktów ECTS określona w arkuszu';
COMMENT ON COLUMN veetou_ko_sheets.ects_other IS 'Liczba pozostałych punktów ECTS określona w arkuszu';
COMMENT ON COLUMN veetou_ko_sheets.ects_total IS 'Całkowita liczba punktów ECTS określona w arkuszu';
COMMENT ON COLUMN veetou_ko_sheets.ects_attained IS 'Liczba zdobytycg punktów ECTS określona w arkuszu';

-- vim: set ft=sql ts=4 sw=4 et:
