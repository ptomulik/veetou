CREATE TABLE v2u_ko_footers
OF V2u_Ko_Footer_t
    (
      CONSTRAINT v2u_ko_footers_pk PRIMARY KEY (job_uuid, id)
    , CONSTRAINT v2u_ko_footers_fk0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
    );

COMMENT ON TABLE v2u_ko_footers IS 'Stopki na Kartach Osiągnięć';
COMMENT ON COLUMN v2u_ko_footers.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN v2u_ko_footers.id IS 'Lokalny identyfikator stopki';
COMMENT ON COLUMN v2u_ko_footers.pagination IS 'Paginacja zapisana w stopce';
COMMENT ON COLUMN v2u_ko_footers.sheet_page_number IS 'Numer strony na arkuszu';
COMMENT ON COLUMN v2u_ko_footers.sheet_pages_total IS 'Całkowita liczba stron arkusza';
COMMENT ON COLUMN v2u_ko_footers.generator_name IS 'Nazwa programu, który wygenerował Kartę Osiągnięć';
COMMENT ON COLUMN v2u_ko_footers.generator_home IS 'Adres URL programu, który wygenerował Kartę Osiągnięć';

-- vim: set ft=sql ts=4 sw=4 et:
