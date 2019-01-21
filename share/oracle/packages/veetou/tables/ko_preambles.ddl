CREATE TABLE v2u_ko_preambles
     ( job_uuid RAW(16) NOT NULL
     , id NUMBER(38) NOT NULL
     , studies_modetier VARCHAR(256 CHAR)
     , title VARCHAR(256 CHAR)
     , student_index VARCHAR(32 CHAR)
     , first_name VARCHAR(48 CHAR)
     , last_name VARCHAR(48 CHAR)
     , student_name VARCHAR(128 CHAR)
     , semester_code VARCHAR(5 CHAR)
     , studies_field VARCHAR(256 CHAR)
     , semester_number NUMBER(2) CHECK(semester_number > 0)
     , studies_specialty VARCHAR(256 CHAR)
     , CONSTRAINT v2u_ko_preambles_pk PRIMARY KEY (job_uuid, id)
     , CONSTRAINT v2u_ko_preambles_fk0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid));

COMMENT ON TABLE v2u_ko_preambles IS 'Preambuły występujące na Kartach Osiągnięć';
COMMENT ON COLUMN v2u_ko_preambles.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN v2u_ko_preambles.id IS 'Lokalny identyfikator preambuły';
COMMENT ON COLUMN v2u_ko_preambles.studies_modetier IS 'Tryb i poziom studiów odczytany z preambuły';
COMMENT ON COLUMN v2u_ko_preambles.title IS 'Tytuł arkusza raportu odczytany z preambuły';
COMMENT ON COLUMN v2u_ko_preambles.student_index IS 'Nr albumu studenta odczytany z preambuły';
COMMENT ON COLUMN v2u_ko_preambles.first_name IS 'Imię studenta odczytane z preambuły';
COMMENT ON COLUMN v2u_ko_preambles.last_name IS 'Nazwisko studenta odczytane z preambuły';
COMMENT ON COLUMN v2u_ko_preambles.student_name IS 'Imię i nazwisko studenta odczytane z preambuły';
COMMENT ON COLUMN v2u_ko_preambles.semester_code IS 'Kod semestru akademickiego którego dotyczy arkusz raportu';
COMMENT ON COLUMN v2u_ko_preambles.studies_field IS 'Kierunek studiów odczytany z preambuły';
COMMENT ON COLUMN v2u_ko_preambles.semester_number IS 'Numer semestru studiów studenta odczytany z preambuły';
COMMENT ON COLUMN v2u_ko_preambles.studies_specialty IS 'Specjalność studiów odczytana z preambuły';

-- INDEXES

CREATE INDEX v2u_ko_preambles_idx1 ON v2u_ko_preambles(job_uuid, student_index);
CREATE INDEX v2u_ko_preambles_idx2 ON v2u_ko_preambles(job_uuid, studies_modetier);
CREATE INDEX v2u_ko_preambles_idx3 ON v2u_ko_preambles(job_uuid, studies_field);
CREATE INDEX v2u_ko_preambles_idx4 ON v2u_ko_preambles(job_uuid, studies_specialty);
CREATE INDEX v2u_ko_preambles_idx5 ON v2u_ko_preambles(job_uuid, studies_modetier, studies_field, studies_specialty);

-- vim: set ft=sql ts=4 sw=4 et:
