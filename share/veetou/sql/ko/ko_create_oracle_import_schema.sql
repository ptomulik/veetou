CREATE TABLE veetou_ko_jobs(
    job_uuid RAW(16) NOT NULL
  , job_timestamp TIMESTAMP NOT NULL
  , job_host VARCHAR(32 CHAR)
  , job_user VARCHAR(32 CHAR)
  , job_name VARCHAR(32 CHAR)
  , CONSTRAINT veetou_ko_jobs_pk PRIMARY KEY (job_uuid)
);
COMMENT ON TABLE veetou_ko_jobs IS 'Uruchomiena programu VEETOU na Kartach Osiągnięć';
COMMENT ON COLUMN veetou_ko_jobs.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU';
COMMENT ON COLUMN veetou_ko_jobs.job_timestamp IS 'Chwila czasowa uruchomienia VEETOU';
COMMENT ON COLUMN veetou_ko_jobs.job_host IS 'Host, na którym uruchomiono VEETOU';
COMMENT ON COLUMN veetou_ko_jobs.job_user IS 'Użytkownik, który dokonał uruchomienia';
COMMENT ON COLUMN veetou_ko_jobs.job_name IS 'Symboliczna nazwa uruchomienia';

CREATE TABLE veetou_ko_footers (
    job_uuid RAW(16) NOT NULL
  , id NUMBER(38) NOT NULL
  , pagination VARCHAR(32 CHAR)
  , sheet_page_number NUMBER(16)
  , sheet_pages_total NUMBER(16)
  , generator_name VARCHAR(256 CHAR)
  , generator_home VARCHAR(256 CHAR)
  , CONSTRAINT veetou_ko_footers_pk PRIMARY KEY (job_uuid, id)
  , CONSTRAINT veetou_ko_footers_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
);
COMMENT ON TABLE veetou_ko_footers IS 'Stopki na Kartach Osiągnięć';
COMMENT ON COLUMN veetou_ko_footers.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN veetou_ko_footers.id IS 'Lokalny identyfikator stopki';
COMMENT ON COLUMN veetou_ko_footers.pagination IS 'Paginacja zapisana w stopce';
COMMENT ON COLUMN veetou_ko_footers.sheet_page_number IS 'Numer strony na arkuszu';
COMMENT ON COLUMN veetou_ko_footers.sheet_pages_total IS 'Całkowita liczba stron arkusza';
COMMENT ON COLUMN veetou_ko_footers.generator_name IS 'Nazwa programu, który wygenerował Kartę Osiągnięć';
COMMENT ON COLUMN veetou_ko_footers.generator_home IS 'Adres URL programu, który wygenerował Kartę Osiągnięć';

CREATE TABLE veetou_ko_headers (
    job_uuid RAW(16) NOT NULL
  , id NUMBER(38) NOT NULL
  , university VARCHAR(256 CHAR)
  , faculty VARCHAR(256 CHAR)
  , CONSTRAINT veetou_ko_header_pk PRIMARY KEY (job_uuid, id)
  , CONSTRAINT veetou_ko_header_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
);
COMMENT ON TABLE veetou_ko_headers IS 'Nagłówki na Kartach Osiągnięć';
COMMENT ON COLUMN veetou_ko_headers.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN veetou_ko_headers.id IS 'Lokalny identyfikator nagłówka';
COMMENT ON COLUMN veetou_ko_headers.university IS 'Nazwa uczelni zapisana w nagłówku';
COMMENT ON COLUMN veetou_ko_headers.faculty IS 'Nazwa wydziału zapisana w nagłówku';

CREATE TABLE veetou_ko_pages (
    job_uuid RAW(16) NOT NULL
  , id NUMBER(38) NOT NULL
  , page_number NUMBER(16)
  , parser_page_number NUMBER(16)
  , CONSTRAINT veetou_ko_pages_pk PRIMARY KEY (job_uuid, id)
  , CONSTRAINT veetou_ko_pages_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
);
COMMENT ON TABLE veetou_ko_pages IS 'Strony występujące na Kartach Osiągnięć';
COMMENT ON COLUMN veetou_ko_pages.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN veetou_ko_pages.id IS 'Lokalny identyfikator strony';
COMMENT ON COLUMN veetou_ko_pages.page_number IS 'Numer strony w przetworzonym dokumencie';
COMMENT ON COLUMN veetou_ko_pages.parser_page_number IS 'Numer strony wyliczony przez parser';

CREATE TABLE veetou_ko_preambles (
    job_uuid RAW(16) NOT NULL
  , id NUMBER(38) NOT NULL
  , studies_modetier VARCHAR(256 CHAR)
  , title VARCHAR(256 CHAR)
  , student_index VARCHAR(32 CHAR)
  , first_name VARCHAR(48 CHAR)
  , last_name VARCHAR(48 CHAR)
  , student_name VARCHAR(128 CHAR)
  , semester_code VARCHAR(32 CHAR)
  , studies_field VARCHAR(256 CHAR)
  , semester_number NUMBER(4)
  , studies_specialty VARCHAR(256 CHAR)
  , CONSTRAINT veetou_ko_preambles_pk PRIMARY KEY (job_uuid, id)
  , CONSTRAINT veetou_ko_preambles_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
);
COMMENT ON TABLE veetou_ko_preambles IS 'Preambuły występujące na Kartach Osiągnięć';
COMMENT ON COLUMN veetou_ko_preambles.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN veetou_ko_preambles.id IS 'Lokalny identyfikator preambuły';
COMMENT ON COLUMN veetou_ko_preambles.studies_modetier IS 'Tryb i poziom studiów odczytany z preambuły';
COMMENT ON COLUMN veetou_ko_preambles.title IS 'Tytuł arkusza raportu odczytany z preambuły';
COMMENT ON COLUMN veetou_ko_preambles.student_index IS 'Nr albumu studenta odczytany z preambuły';
COMMENT ON COLUMN veetou_ko_preambles.first_name IS 'Imię studenta odczytane z preambuły';
COMMENT ON COLUMN veetou_ko_preambles.last_name IS 'Nazwisko studenta odczytane z preambuły';
COMMENT ON COLUMN veetou_ko_preambles.student_name IS 'Imię i nazwisko studenta odczytane z preambuły';
COMMENT ON COLUMN veetou_ko_preambles.semester_code IS 'Kod semestru akademickiego którego dotyczy arkusz raportu';
COMMENT ON COLUMN veetou_ko_preambles.studies_field IS 'Kierunek studiów odczytany z preambuły';
COMMENT ON COLUMN veetou_ko_preambles.semester_number IS 'Numer semestru studiów studenta odczytany z preambuły';
COMMENT ON COLUMN veetou_ko_preambles.studies_spefialty IS 'Specjalność studiów odczytana z preambuły';

CREATE TABLE veetou_ko_reports (
    job_uuid RAW(16) NOT NULL
  , id NUMBER(38) NOT NULL
  , source VARCHAR(512 CHAR)
  , datetime TIMESTAMP
  , first_page NUMBER(16)
  , sheets_parsed NUMBER(16)
  , pages_parsed NUMBER(16)
  , CONSTRAINT veetou_ko_reports_pk PRIMARY KEY (job_uuid, id)
  , CONSTRAINT veetou_ko_reports_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
);
COMMENT ON TABLE veetou_ko_reports IS 'Dokumenty typu Karta Osiągnięć przetworzone w ramach uruchomienia VEETOU';
COMMENT ON COLUMN veetou_ko_reports.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN veetou_ko_reports.id IS 'Lokalny identyfikator dokumentu';
COMMENT ON COLUMN veetou_ko_reports.source IS 'Nazwa pliku źródłowego dokumentu';
COMMENT ON COLUMN veetou_ko_reports.datetime IS 'Data i czas otwarcia dokumentu do odczytu';
COMMENT ON COLUMN veetou_ko_reports.first_page IS 'Nr pierwszej wczytanej strony dokumentu';
COMMENT ON COLUMN veetou_ko_reports.sheets_parsed IS 'Liczba arkuszy Kart Osiągnięć wczytanych z dokumentu';
COMMENT ON COLUMN veetou_ko_reports.pages_parsed IS 'Liczba przetworzonych stron dokumentu';

CREATE TABLE veetou_ko_sheets (
    job_uuid RAW(16) NOT NULL
  , id NUMBER(38) NOT NULL
  , pages_parsed NUMBER(4)
  , first_page NUMBER(16)
  , ects_mandatory NUMBER(16)
  , ects_other NUMBER(16)
  , ects_total NUMBER(16)
  , ects_attained NUMBER(16)
  , CONSTRAINT veetou_ko_sheets_pk PRIMARY KEY (job_uuid, id)
  , CONSTRAINT veetou_ko_sheets_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
);
COMMENT ON TABLE veetou_ko_sheets IS 'Arkusze Kart Osiągnięć wczytane w ramach uruchomienia VEETOU';
COMMENT ON COLUMN veetou_ko_sheets.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN veetou_ko_sheets.id IS 'Lokalny identyfikator arkusza';
COMMENT ON COLUMN veetou_ko_sheets.pages_parsed IS 'Liczba przetworzonych stron arkusza';
COMMENT ON COLUMN veetou_ko_sheets.first_page IS 'Number stony dokumentu na której rozpoczyna się arkusz';
COMMENT ON COLUMN veetou_ko_sheets.ects_mandatory IS 'Liczba wymaganych punktów ECTS określona w arkuszu';
COMMENT ON COLUMN veetou_ko_sheets.ects_other IS 'Liczba pozostałych punktów ECTS określona w arkuszu';
COMMENT ON COLUMN veetou_ko_sheets.ects_total IS 'Całkowita liczba punktów ECTS określona w arkuszu';
COMMENT ON COLUMN veetou_ko_sheets.ects_attained IS 'Liczba zdobytycg punktów ECTS określona w arkuszu';

CREATE TABLE veetou_ko_tbodies (
    job_uuid RAW(16) NOT NULL
  , id NUMBER(38) NOT NULL
  , remark VARCHAR(256)
  , CONSTRAINTS veetou_ko_tbodies_pk PRIMARY KEY (job_uuid, id)
  , CONSTRAINTS veetou_ko_tbodies_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
);
COMMENT ON TABLE veetou_ko_tboties IS 'Ciała tabel znajdujących sie Kartach Osiągnięć';
COMMENT ON COLUMN veetou_ko_tboties.job_uuid IS 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord';
COMMENT ON COLUMN veetou_ko_tbodies.id IS 'Lokalny identyfikator ciała tabeli';
COMMENT ON COLUMN veetou_ko_tbodies.remark IS 'Uwagi zapisane w obszarze ciała tabeli';

CREATE TABLE veetou_ko_trs (
    job_uuid RAW(16) NOT NULL
  , id NUMBER(38) NOT NULL
  , subj_code VARCHAR(32 CHAR)
  , subj_name VARCHAR(256 CHAR)
  , subj_hours_w NUMBER(8)
  , subj_hours_c NUMBER(8)
  , subj_hours_l NUMBER(8)
  , subj_hours_p NUMBER(8)
  , subj_hours_s NUMBER(8)
  , subj_credit_kind VARCHAR(16 CHAR)
  , subj_ects NUMBER(16)
  , subj_tutor VARCHAR(256 CHAR)
  , subj_grade VARCHAR(32 CHAR)
  , subj_grade_date DATE
  , CONSTRAINT veetou_ko_trs_pk PRIMARY KEY (job_uuid, id)
  , CONSTRAINT veetou_ko_trs_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
);
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

-- JUNCTION TABLES

CREATE TABLE veetou_ko_page_footer (
    job_uuid RAW(16) NOT NULL
  , ko_page_id NUMBER(38)
  , ko_footer_id NUMBER(38)
  , CONSTRAINT veetou_ko_page_footer_pk PRIMARY KEY (job_uuid, ko_page_id, ko_footer_id)
  , CONSTRAINT veetou_ko_page_footer_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
  , CONSTRAINT veetou_ko_page_footer_fk1 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id)
  , CONSTRAINT veetou_ko_page_footer_fk2 FOREIGN KEY (job_uuid, ko_footer_id) REFERENCES veetou_ko_footers(job_uuid, id)
);

CREATE TABLE veetou_ko_page_header (
    job_uuid RAW(16) NOT NULL
  , ko_page_id NUMBER(38)
  , ko_header_id NUMBER(38)
  , CONSTRAINT veetou_ko_page_header_pk PRIMARY KEY (job_uuid, ko_page_id, ko_header_id)
  , CONSTRAINT veetou_ko_page_header_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
  , CONSTRAINT veetou_ko_page_header_fk1 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id)
  , CONSTRAINT veetou_ko_page_header_fk2 FOREIGN KEY (job_uuid, ko_header_id) REFERENCES veetou_ko_headers(job_uuid, id)
);

CREATE TABLE veetou_ko_page_preamble (
    job_uuid RAW(16) NOT NULL
  , ko_page_id NUMBER(38)
  , ko_preamble_id NUMBER(38)
  , CONSTRAINT veetou_ko_page_preamble_pk PRIMARY KEY (job_uuid, ko_page_id, ko_preamble_id)
  , CONSTRAINT veetou_ko_page_preamble_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
  , CONSTRAINT veetou_ko_page_preamble_fk1 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id)
  , CONSTRAINT veetou_ko_page_preamble_fk2 FOREIGN KEY (job_uuid, ko_preamble_id) REFERENCES veetou_ko_preambles(job_uuid, id)
);

CREATE TABLE veetou_ko_page_tbody (
    job_uuid RAW(16) NOT NULL
  , ko_page_id NUMBER(38)
  , ko_tbody_id NUMBER(38)
  , CONSTRAINT veetou_ko_page_tbody_pk PRIMARY KEY (job_uuid, ko_page_id, ko_tbody_id)
  , CONSTRAINT veetou_ko_page_tbody_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
  , CONSTRAINT veetou_ko_page_tbody_fk1 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id)
  , CONSTRAINT veetou_ko_page_tbody_fk2 FOREIGN KEY (job_uuid, ko_tbody_id) REFERENCES veetou_ko_tbodies(job_uuid, id)
);

CREATE TABLE veetou_ko_report_sheets (
    job_uuid RAW(16) NOT NULL
  , ko_report_id NUMBER(38)
  , ko_sheet_id NUMBER(38)
  , CONSTRAINT veetou_ko_report_sheets_pk PRIMARY KEY (job_uuid, ko_report_id, ko_sheet_id)
  , CONSTRAINT veetou_ko_report_sheets_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
  , CONSTRAINT veetou_ko_report_sheets_fk1 FOREIGN KEY (job_uuid, ko_report_id) REFERENCES veetou_ko_reports(job_uuid, id)
  , CONSTRAINT veetou_ko_report_sheets_fk2 FOREIGN KEY (job_uuid, ko_sheet_id) REFERENCES veetou_ko_sheets(job_uuid, id)
);

CREATE TABLE veetou_ko_sheet_pages (
    job_uuid RAW(16) NOT NULL
  , ko_sheet_id NUMBER(38)
  , ko_page_id NUMBER(38)
  , CONSTRAINT veetou_ko_sheet_pages_pk PRIMARY KEY (job_uuid, ko_sheet_id, ko_page_id)
  , CONSTRAINT veetou_ko_sheet_pages_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
  , CONSTRAINT veetou_ko_sheet_pages_fk1 FOREIGN KEY (job_uuid, ko_sheet_id) REFERENCES veetou_ko_sheets(job_uuid, id)
  , CONSTRAINT veetou_ko_sheet_pages_fk2 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id)
);

CREATE TABLE veetou_ko_tbody_trs (
    job_uuid RAW(16) NOT NULL
  , ko_tbody_id NUMBER(38)
  , ko_tr_id NUMBER(38)
  , CONSTRAINT veetou_ko_tbody_trs_pk PRIMARY KEY (job_uuid, ko_tbody_id, ko_tr_id)
  , CONSTRAINT veetou_ko_tbody_trs_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
  , CONSTRAINT veetou_ko_tbody_trs_fk1 FOREIGN KEY (job_uuid, ko_tbody_id) REFERENCES veetou_ko_tbodies(job_uuid, id)
  , CONSTRAINT veetou_ko_tbody_trs_fk2 FOREIGN KEY (job_uuid, ko_tr_id) REFERENCES veetou_ko_trs(job_uuid, id)
);

CREATE INDEX veetou_ko_headers_idx1
  ON veetou_ko_headers(job_uuid, faculty)
;
CREATE INDEX veetou_ko_preambles_idx1
  ON veetou_ko_preambles(job_uuid, student_index)
;
CREATE INDEX veetou_ko_preambles_idx2
  ON veetou_ko_preambles(job_uuid, studies_modetier)
;
CREATE INDEX veetou_ko_preambles_idx3
  ON veetou_ko_preambles(job_uuid, studies_field)
;
CREATE INDEX veetou_ko_preambles_idx4
  ON veetou_ko_preambles(job_uuid, studies_specialty)
;
CREATE INDEX veetou_ko_preambles_idx5
  ON veetou_ko_preambles(job_uuid, studies_modetier, studies_field, studies_specialty)
;
CREATE INDEX veetou_ko_trs_idx1
  ON veetou_ko_trs(job_uuid, subj_code)
;
CREATE INDEX veetou_ko_trs_idx2
  ON veetou_ko_trs(job_uuid, subj_grade_date)
;
