CREATE TABLE v2u_ko_headers
OF V2u_Ko_Header_t
    (
      CONSTRAINT v2u_ko_header_pk PRIMARY KEY (id, job_uuid)
    , CONSTRAINT v2u_ko_header_f0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
COMMENT ON TABLE v2u_ko_headers IS 'Nagłówki na Kartach Osiągnięć';
COMMENT ON COLUMN v2u_ko_headers.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN v2u_ko_headers.id IS 'Lokalny identyfikator nagłówka';
COMMENT ON COLUMN v2u_ko_headers.university IS 'Nazwa uczelni zapisana w nagłówku';
COMMENT ON COLUMN v2u_ko_headers.faculty IS 'Nazwa wydziału zapisana w nagłówku';

-- INDEXES

CREATE INDEX v2u_ko_headers_idx1 ON v2u_ko_headers(job_uuid, faculty);
/
-- vim: set ft=sql ts=4 sw=4 et:
