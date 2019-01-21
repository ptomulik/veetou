CREATE TABLE v2u_ko_headers
    ( job_uuid RAW(16) NOT NULL
    , id NUMBER(38) NOT NULL
    , university VARCHAR(100 CHAR) CHECK('|' NOT IN university)
    , faculty VARCHAR(100 CHAR) CHECK('|' NOT IN faculty)
    , CONSTRAINT v2u_ko_header_pk PRIMARY KEY (job_uuid, id)
    , CONSTRAINT v2u_ko_header_fk0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid));

COMMENT ON TABLE v2u_ko_headers IS 'Nagłówki na Kartach Osiągnięć';
COMMENT ON COLUMN v2u_ko_headers.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN v2u_ko_headers.id IS 'Lokalny identyfikator nagłówka';
COMMENT ON COLUMN v2u_ko_headers.university IS 'Nazwa uczelni zapisana w nagłówku';
COMMENT ON COLUMN v2u_ko_headers.faculty IS 'Nazwa wydziału zapisana w nagłówku';

-- INDEXES

CREATE INDEX v2u_ko_headers_idx1 ON v2u_ko_headers(job_uuid, faculty);

-- vim: set ft=sql ts=4 sw=4 et:
