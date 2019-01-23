CREATE TABLE v2u_ko_reports
OF V2u_Ko_Report_t
    (
      CONSTRAINT v2u_ko_reports_pk PRIMARY KEY (id, job_uuid)
    , CONSTRAINT v2u_ko_reports_fk0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;

COMMENT ON TABLE v2u_ko_reports IS 'Dokumenty typu Karta Osiągnięć przetworzone w ramach uruchomienia VEETOU';
COMMENT ON COLUMN v2u_ko_reports.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN v2u_ko_reports.id IS 'Lokalny identyfikator dokumentu';
COMMENT ON COLUMN v2u_ko_reports.source IS 'Nazwa pliku źródłowego dokumentu';
COMMENT ON COLUMN v2u_ko_reports.datetime IS 'Data i czas otwarcia dokumentu do odczytu';
COMMENT ON COLUMN v2u_ko_reports.first_page IS 'Nr pierwszej wczytanej strony dokumentu';
COMMENT ON COLUMN v2u_ko_reports.sheets_parsed IS 'Liczba arkuszy Kart Osiągnięć wczytanych z dokumentu';
COMMENT ON COLUMN v2u_ko_reports.pages_parsed IS 'Liczba przetworzonych stron dokumentu';

-- vim: set ft=sql ts=4 sw=4 et:
