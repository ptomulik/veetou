CREATE TABLE veetou_ko_trs
     ( job_uuid RAW(16) NOT NULL
     , id NUMBER(38) NOT NULL
     , subj_code VARCHAR(32 CHAR)
     , subj_name VARCHAR(256 CHAR)
     , subj_hours_w NUMBER(8)
     , subj_hours_c NUMBER(8)
     , subj_hours_l NUMBER(8)
     , subj_hours_p NUMBER(8)
     , subj_hours_s NUMBER(8)
     , subj_credit_kind VARCHAR(16 CHAR)
     , subj_ects NUMBER(4)
     , subj_tutor VARCHAR(256 CHAR)
     , subj_grade VARCHAR(32 CHAR)
     , subj_grade_date DATE
     , CONSTRAINT veetou_ko_trs_pk PRIMARY KEY (job_uuid, id)
     , CONSTRAINT veetou_ko_trs_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid));

COMMENT ON TABLE veetou_ko_trs IS 'Wiersze tabel znajdujących się na Kartach Osiągnięć';
COMMENT ON COLUMN veetou_ko_trs.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN veetou_ko_trs.id IS 'Lokalny identyfikator wiersza tabeli';
COMMENT ON COLUMN veetou_ko_trs.subj_code IS 'Kod przedmiotu odczytany z wiersza tabeli';
COMMENT ON COLUMN veetou_ko_trs.subj_name IS 'Nazwa przedmiotu odczytana z wiersza tabeli';
COMMENT ON COLUMN veetou_ko_trs.subj_hours_w IS 'Liczba godzin wykładu w semestrze odczytana z wiersza tabeli';
COMMENT ON COLUMN veetou_ko_trs.subj_hours_c IS 'Liczba godzin ćwiczeń w semestrze odczytana z wiersza tabeli';
COMMENT ON COLUMN veetou_ko_trs.subj_hours_l IS 'Liczba godzin laboratorium w semestrze odczytana z wiersza tabeli';
COMMENT ON COLUMN veetou_ko_trs.subj_hours_p IS 'Liczba godzin projektu w semestrze odczytana z wiersza tabeli';
COMMENT ON COLUMN veetou_ko_trs.subj_hours_s IS 'Liczba godzin seminarium odczytana z wiersza tabeli';
COMMENT ON COLUMN veetou_ko_trs.subj_credit_kind IS 'Rodzaj zaliczenia odczytany z wiersza tabeli';
COMMENT ON COLUMN veetou_ko_trs.subj_ects IS 'Liczba punktów ECTS za przedmiot odczytana z wiersza tabeli';
COMMENT ON COLUMN veetou_ko_trs.subj_tutor IS 'Imię i nazwisko kierownika przedmiotu odczytane z wiersza tabeli';
COMMENT ON COLUMN veetou_ko_trs.subj_grade IS 'Ocena z przedmiotu odczytana z wiersza tabeli';
COMMENT ON COLUMN veetou_ko_trs.subj_grade_date IS 'Data wystawienia oceny odczytana z wiersza tabeli';


-- INDEXES


CREATE INDEX veetou_ko_trs_idx1 ON veetou_ko_trs(job_uuid, subj_code);
CREATE INDEX veetou_ko_trs_idx2 ON veetou_ko_trs(job_uuid, subj_grade_date);

-- vim: set ft=sql ts=4 sw=4 et:
