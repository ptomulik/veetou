CREATE TABLE v2u_ko_pages
OF V2u_Ko_Page_t
    (
      CONSTRAINT v2u_ko_pages_pk PRIMARY KEY (id, job_uuid)
    , CONSTRAINT v2u_ko_pages_fk0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;

COMMENT ON TABLE v2u_ko_pages IS 'Strony występujące na Kartach Osiągnięć';
COMMENT ON COLUMN v2u_ko_pages.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN v2u_ko_pages.id IS 'Lokalny identyfikator strony';
COMMENT ON COLUMN v2u_ko_pages.page_number IS 'Numer strony w przetworzonym dokumencie';
COMMENT ON COLUMN v2u_ko_pages.parser_page_number IS 'Numer strony wyliczony przez parser';

-- vim: set ft=sql ts=4 sw=4 et:
