CREATE TABLE v2u_ko_trs
OF V2u_Ko_Tr_t
    (
      CONSTRAINT v2u_ko_trs_pk PRIMARY KEY (id, job_uuid)
    , CONSTRAINT v2u_ko_trs_f0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
COMMENT ON TABLE v2u_ko_trs IS 'Wiersze tabel znajdujących się na Kartach Osiągnięć';
COMMENT ON COLUMN v2u_ko_trs.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN v2u_ko_trs.id IS 'Lokalny identyfikator wiersza tabeli';
COMMENT ON COLUMN v2u_ko_trs.subj_code IS 'Kod przedmiotu odczytany z wiersza tabeli';
COMMENT ON COLUMN v2u_ko_trs.subj_name IS 'Nazwa przedmiotu odczytana z wiersza tabeli';
COMMENT ON COLUMN v2u_ko_trs.subj_hours_w IS 'Liczba godzin wykładu w semestrze odczytana z wiersza tabeli';
COMMENT ON COLUMN v2u_ko_trs.subj_hours_c IS 'Liczba godzin ćwiczeń w semestrze odczytana z wiersza tabeli';
COMMENT ON COLUMN v2u_ko_trs.subj_hours_l IS 'Liczba godzin laboratorium w semestrze odczytana z wiersza tabeli';
COMMENT ON COLUMN v2u_ko_trs.subj_hours_p IS 'Liczba godzin projektu w semestrze odczytana z wiersza tabeli';
COMMENT ON COLUMN v2u_ko_trs.subj_hours_s IS 'Liczba godzin seminarium odczytana z wiersza tabeli';
COMMENT ON COLUMN v2u_ko_trs.subj_credit_kind IS 'Rodzaj zaliczenia odczytany z wiersza tabeli';
COMMENT ON COLUMN v2u_ko_trs.subj_ects IS 'Liczba punktów ECTS za przedmiot odczytana z wiersza tabeli';
COMMENT ON COLUMN v2u_ko_trs.subj_tutor IS 'Imię i nazwisko kierownika przedmiotu odczytane z wiersza tabeli';
COMMENT ON COLUMN v2u_ko_trs.subj_grade IS 'Ocena z przedmiotu odczytana z wiersza tabeli';
COMMENT ON COLUMN v2u_ko_trs.subj_grade_date IS 'Data wystawienia oceny odczytana z wiersza tabeli';


-- INDEXES


CREATE INDEX v2u_ko_trs_idx1 ON v2u_ko_trs(job_uuid, subj_code);
/
CREATE INDEX v2u_ko_trs_idx2 ON v2u_ko_trs(job_uuid, subj_grade_date);
/
-- vim: set ft=sql ts=4 sw=4 et:
