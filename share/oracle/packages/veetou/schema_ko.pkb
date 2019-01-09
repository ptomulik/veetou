CREATE OR REPLACE PACKAGE BODY VEETOU_Schema_KO AS
    PROCEDURE Create_Ko_Jobs IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_jobs',
          '( job_uuid RAW(16) NOT NULL
           , job_timestamp TIMESTAMP NOT NULL
           , job_host VARCHAR(32 CHAR)
           , job_user VARCHAR(32 CHAR)
           , job_name VARCHAR(32 CHAR)
           , CONSTRAINT veetou_ko_jobs_pk PRIMARY KEY (job_uuid) )'
        );
        VEETOU_Util.Comment_On_Table('veetou_ko_jobs', 'Uruchomiena programu VEETOU na Kartach Osiągnięć');
        VEETOU_Util.Comment_On_Column('veetou_ko_jobs.job_uuid', 'Unikalny identyfikator uruchomienia VEETOU');
        VEETOU_Util.Comment_On_Column('veetou_ko_jobs.job_timestamp', 'Chwila czasowa uruchomienia VEETOU');
        VEETOU_Util.Comment_On_Column('veetou_ko_jobs.job_host', 'Host, na którym uruchomiono VEETOU');
        VEETOU_Util.Comment_On_Column('veetou_ko_jobs.job_user', 'Użytkownik, który dokonał uruchomienia');
        VEETOU_Util.Comment_On_Column('veetou_ko_jobs.job_name', 'Symboliczna nazwa uruchomienia');
    END;


    PROCEDURE Create_Ko_Footers IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_footers',
            '( job_uuid RAW(16) NOT NULL
             , id NUMBER(38) NOT NULL
             , pagination VARCHAR(32 CHAR)
             , sheet_page_number NUMBER(16)
             , sheet_pages_total NUMBER(16)
             , generator_name VARCHAR(256 CHAR)
             , generator_home VARCHAR(256 CHAR)
             , CONSTRAINT veetou_ko_footers_pk PRIMARY KEY (job_uuid, id)
             , CONSTRAINT veetou_ko_footers_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid))'
        );
        VEETOU_Util.Comment_On_Table('veetou_ko_footers', 'Stopki na Kartach Osiągnięć');
        VEETOU_Util.Comment_On_Column('veetou_ko_footers.job_uuid', 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord');
        VEETOU_Util.Comment_On_Column('veetou_ko_footers.id', 'Lokalny identyfikator stopki');
        VEETOU_Util.Comment_On_Column('veetou_ko_footers.pagination', 'Paginacja zapisana w stopce');
        VEETOU_Util.Comment_On_Column('veetou_ko_footers.sheet_page_number', 'Numer strony na arkuszu');
        VEETOU_Util.Comment_On_Column('veetou_ko_footers.sheet_pages_total', 'Całkowita liczba stron arkusza');
        VEETOU_Util.Comment_On_Column('veetou_ko_footers.generator_name', 'Nazwa programu, który wygenerował Kartę Osiągnięć');
        VEETOU_Util.Comment_On_Column('veetou_ko_footers.generator_home', 'Adres URL programu, który wygenerował Kartę Osiągnięć');
    END;


    PROCEDURE Create_Ko_Headers IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_headers',
           '( job_uuid RAW(16) NOT NULL
            , id NUMBER(38) NOT NULL
            , university VARCHAR(256 CHAR)
            , faculty VARCHAR(256 CHAR)
            , CONSTRAINT veetou_ko_header_pk PRIMARY KEY (job_uuid, id)
            , CONSTRAINT veetou_ko_header_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid))'
        );
        VEETOU_Util.Comment_On_Table('veetou_ko_headers', 'Nagłówki na Kartach Osiągnięć');
        VEETOU_Util.Comment_On_Column('veetou_ko_headers.job_uuid', 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord');
        VEETOU_Util.Comment_On_Column('veetou_ko_headers.id', 'Lokalny identyfikator nagłówka');
        VEETOU_Util.Comment_On_Column('veetou_ko_headers.university', 'Nazwa uczelni zapisana w nagłówku');
        VEETOU_Util.Comment_On_Column('veetou_ko_headers.faculty', 'Nazwa wydziału zapisana w nagłówku');
    END;


    PROCEDURE Create_Ko_Pages IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_pages',
            '( job_uuid RAW(16) NOT NULL
             , id NUMBER(38) NOT NULL
             , page_number NUMBER(16)
             , parser_page_number NUMBER(16)
             , CONSTRAINT veetou_ko_pages_pk PRIMARY KEY (job_uuid, id)
             , CONSTRAINT veetou_ko_pages_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid))'
        );
        VEETOU_Util.Comment_On_Table('veetou_ko_pages', 'Strony występujące na Kartach Osiągnięć');
        VEETOU_Util.Comment_On_Column('veetou_ko_pages.job_uuid', 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord');
        VEETOU_Util.Comment_On_Column('veetou_ko_pages.id', 'Lokalny identyfikator strony');
        VEETOU_Util.Comment_On_Column('veetou_ko_pages.page_number', 'Numer strony w przetworzonym dokumencie');
        VEETOU_Util.Comment_On_Column('veetou_ko_pages.parser_page_number', 'Numer strony wyliczony przez parser');
    END;


    PROCEDURE Create_Ko_Preambles IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_preambles',
            '( job_uuid RAW(16) NOT NULL
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
             , CONSTRAINT veetou_ko_preambles_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid))'
        );
        VEETOU_Util.Comment_On_Table('veetou_ko_preambles', 'Preambuły występujące na Kartach Osiągnięć');
        VEETOU_Util.Comment_On_Column('veetou_ko_preambles.job_uuid', 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord');
        VEETOU_Util.Comment_On_Column('veetou_ko_preambles.id', 'Lokalny identyfikator preambuły');
        VEETOU_Util.Comment_On_Column('veetou_ko_preambles.studies_modetier', 'Tryb i poziom studiów odczytany z preambuły');
        VEETOU_Util.Comment_On_Column('veetou_ko_preambles.title', 'Tytuł arkusza raportu odczytany z preambuły');
        VEETOU_Util.Comment_On_Column('veetou_ko_preambles.student_index', 'Nr albumu studenta odczytany z preambuły');
        VEETOU_Util.Comment_On_Column('veetou_ko_preambles.first_name', 'Imię studenta odczytane z preambuły');
        VEETOU_Util.Comment_On_Column('veetou_ko_preambles.last_name', 'Nazwisko studenta odczytane z preambuły');
        VEETOU_Util.Comment_On_Column('veetou_ko_preambles.student_name', 'Imię i nazwisko studenta odczytane z preambuły');
        VEETOU_Util.Comment_On_Column('veetou_ko_preambles.semester_code', 'Kod semestru akademickiego którego dotyczy arkusz raportu');
        VEETOU_Util.Comment_On_Column('veetou_ko_preambles.studies_field', 'Kierunek studiów odczytany z preambuły');
        VEETOU_Util.Comment_On_Column('veetou_ko_preambles.semester_number', 'Numer semestru studiów studenta odczytany z preambuły');
        VEETOU_Util.Comment_On_Column('veetou_ko_preambles.studies_specialty', 'Specjalność studiów odczytana z preambuły');
    END;


    PROCEDURE Create_Ko_Reports IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_reports',
            '( job_uuid RAW(16) NOT NULL
             , id NUMBER(38) NOT NULL
             , source VARCHAR(512 CHAR)
             , datetime TIMESTAMP
             , first_page NUMBER(16)
             , sheets_parsed NUMBER(16)
             , pages_parsed NUMBER(16)
             , CONSTRAINT veetou_ko_reports_pk PRIMARY KEY (job_uuid, id)
             , CONSTRAINT veetou_ko_reports_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid))'
        );
        VEETOU_Util.Comment_On_Table('veetou_ko_reports', 'Dokumenty typu Karta Osiągnięć przetworzone w ramach uruchomienia VEETOU');
        VEETOU_Util.Comment_On_Column('veetou_ko_reports.job_uuid', 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord');
        VEETOU_Util.Comment_On_Column('veetou_ko_reports.id', 'Lokalny identyfikator dokumentu');
        VEETOU_Util.Comment_On_Column('veetou_ko_reports.source', 'Nazwa pliku źródłowego dokumentu');
        VEETOU_Util.Comment_On_Column('veetou_ko_reports.datetime', 'Data i czas otwarcia dokumentu do odczytu');
        VEETOU_Util.Comment_On_Column('veetou_ko_reports.first_page', 'Nr pierwszej wczytanej strony dokumentu');
        VEETOU_Util.Comment_On_Column('veetou_ko_reports.sheets_parsed', 'Liczba arkuszy Kart Osiągnięć wczytanych z dokumentu');
        VEETOU_Util.Comment_On_Column('veetou_ko_reports.pages_parsed', 'Liczba przetworzonych stron dokumentu');
    END;


    PROCEDURE Create_Ko_Sheets IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_sheets',
            '( job_uuid RAW(16) NOT NULL
             , id NUMBER(38) NOT NULL
             , pages_parsed NUMBER(4)
             , first_page NUMBER(16)
             , ects_mandatory NUMBER(16)
             , ects_other NUMBER(16)
             , ects_total NUMBER(16)
             , ects_attained NUMBER(16)
             , CONSTRAINT veetou_ko_sheets_pk PRIMARY KEY (job_uuid, id)
             , CONSTRAINT veetou_ko_sheets_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid))'
        );
        VEETOU_Util.Comment_On_Table('veetou_ko_sheets', 'Arkusze Kart Osiągnięć wczytane w ramach uruchomienia VEETOU');
        VEETOU_Util.Comment_On_Column('veetou_ko_sheets.job_uuid', 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord');
        VEETOU_Util.Comment_On_Column('veetou_ko_sheets.id', 'Lokalny identyfikator arkusza');
        VEETOU_Util.Comment_On_Column('veetou_ko_sheets.pages_parsed', 'Liczba przetworzonych stron arkusza');
        VEETOU_Util.Comment_On_Column('veetou_ko_sheets.first_page', 'Number stony dokumentu na której rozpoczyna się arkusz');
        VEETOU_Util.Comment_On_Column('veetou_ko_sheets.ects_mandatory', 'Liczba wymaganych punktów ECTS określona w arkuszu');
        VEETOU_Util.Comment_On_Column('veetou_ko_sheets.ects_other', 'Liczba pozostałych punktów ECTS określona w arkuszu');
        VEETOU_Util.Comment_On_Column('veetou_ko_sheets.ects_total', 'Całkowita liczba punktów ECTS określona w arkuszu');
        VEETOU_Util.Comment_On_Column('veetou_ko_sheets.ects_attained', 'Liczba zdobytycg punktów ECTS określona w arkuszu');
    END;


    PROCEDURE Create_Ko_Tbodies IS
    BEGIN
    VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_tbodies',
        '( job_uuid RAW(16) NOT NULL
         , id NUMBER(38) NOT NULL
         , remark VARCHAR(256)
         , CONSTRAINTS veetou_ko_tbodies_pk PRIMARY KEY (job_uuid, id)
         , CONSTRAINTS veetou_ko_tbodies_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid))'
    );
    VEETOU_Util.Comment_On_Table('veetou_ko_tbodies', 'Ciała tabel znajdujących sie Kartach Osiągnięć');
    VEETOU_Util.Comment_On_Column('veetou_ko_tbodies.job_uuid', 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord');
    VEETOU_Util.Comment_On_Column('veetou_ko_tbodies.id', 'Lokalny identyfikator ciała tabeli');
    VEETOU_Util.Comment_On_Column('veetou_ko_tbodies.remark', 'Uwagi zapisane w obszarze ciała tabeli');
    END;


    PROCEDURE Create_Ko_Trs IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_trs',
            '( job_uuid RAW(16) NOT NULL
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
             , CONSTRAINT veetou_ko_trs_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid))'
        );
        VEETOU_Util.Comment_On_Table('veetou_ko_trs', 'Wiersze tabel znajdujących się na Kartach Osiągnięć');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.job_uuid', 'Unikalny identyfikator uruchomienia VEETOU z którego pochodzi rekord');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.id', 'Lokalny identyfikator wiersza tabeli');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.subj_code', 'Kod przedmiotu odczytany z wiersza tabeli');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.subj_name', 'Nazwa przedmiotu odczytana z wiersza tabeli');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.subj_hours_w', 'Liczba godzin wykładu w semestrze odczytana z wiersza tabeli');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.subj_hours_c', 'Liczba godzin ćwiczeń w semestrze odczytana z wiersza tabeli');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.subj_hours_l', 'Liczba godzin laboratorium w semestrze odczytana z wiersza tabeli');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.subj_hours_p', 'Liczba godzin projektu w semestrze odczytana z wiersza tabeli');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.subj_hours_s', 'Liczba godzin seminarium odczytana z wiersza tabeli');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.subj_credit_kind', 'Rodzaj zaliczenia odczytany z wiersza tabeli');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.subj_ects', 'Liczba punktów ECTS za przedmiot odczytana z wiersza tabeli');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.subj_tutor', 'Imię i nazwisko kierownika przedmiotu odczytane z wiersza tabeli');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.subj_grade', 'Ocena z przedmiotu odczytana z wiersza tabeli');
        VEETOU_Util.Comment_On_Column('veetou_ko_trs.subj_grade_date', 'Data wystawienia oceny odczytana z wiersza tabeli');
    END;


    --
    -- JUNCTION TABLES
    --


    PROCEDURE Create_Ko_Page_Footer IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_page_footer',
            '( job_uuid RAW(16) NOT NULL
             , ko_page_id NUMBER(38)
             , ko_footer_id NUMBER(38)
             , CONSTRAINT veetou_ko_page_footer_pk PRIMARY KEY (job_uuid, ko_page_id, ko_footer_id)
             , CONSTRAINT veetou_ko_page_footer_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
             , CONSTRAINT veetou_ko_page_footer_fk1 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id)
             , CONSTRAINT veetou_ko_page_footer_fk2 FOREIGN KEY (job_uuid, ko_footer_id) REFERENCES veetou_ko_footers(job_uuid, id))'
        );
    END;


    PROCEDURE Create_Ko_Page_Header IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_page_header',
            '( job_uuid RAW(16) NOT NULL
             , ko_page_id NUMBER(38)
             , ko_header_id NUMBER(38)
             , CONSTRAINT veetou_ko_page_header_pk PRIMARY KEY (job_uuid, ko_page_id, ko_header_id)
             , CONSTRAINT veetou_ko_page_header_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
             , CONSTRAINT veetou_ko_page_header_fk1 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id)
             , CONSTRAINT veetou_ko_page_header_fk2 FOREIGN KEY (job_uuid, ko_header_id) REFERENCES veetou_ko_headers(job_uuid, id))'
        );
    END;


    PROCEDURE Create_Ko_Page_Preamble IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_page_preamble',
            '( job_uuid RAW(16) NOT NULL
             , ko_page_id NUMBER(38)
             , ko_preamble_id NUMBER(38)
             , CONSTRAINT veetou_ko_page_preamble_pk PRIMARY KEY (job_uuid, ko_page_id, ko_preamble_id)
             , CONSTRAINT veetou_ko_page_preamble_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
             , CONSTRAINT veetou_ko_page_preamble_fk1 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id)
             , CONSTRAINT veetou_ko_page_preamble_fk2 FOREIGN KEY (job_uuid, ko_preamble_id) REFERENCES veetou_ko_preambles(job_uuid, id))'
        );
    END;


    PROCEDURE Create_Ko_Page_Tbody IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_page_tbody',
            '( job_uuid RAW(16) NOT NULL
             , ko_page_id NUMBER(38)
             , ko_tbody_id NUMBER(38)
             , CONSTRAINT veetou_ko_page_tbody_pk PRIMARY KEY (job_uuid, ko_page_id, ko_tbody_id)
             , CONSTRAINT veetou_ko_page_tbody_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
             , CONSTRAINT veetou_ko_page_tbody_fk1 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id)
             , CONSTRAINT veetou_ko_page_tbody_fk2 FOREIGN KEY (job_uuid, ko_tbody_id) REFERENCES veetou_ko_tbodies(job_uuid, id))'
        );
    END;


    PROCEDURE Create_Ko_Report_Sheets IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_report_sheets',
            '( job_uuid RAW(16) NOT NULL
             , ko_report_id NUMBER(38)
             , ko_sheet_id NUMBER(38)
             , CONSTRAINT veetou_ko_report_sheets_pk PRIMARY KEY (job_uuid, ko_report_id, ko_sheet_id)
             , CONSTRAINT veetou_ko_report_sheets_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
             , CONSTRAINT veetou_ko_report_sheets_fk1 FOREIGN KEY (job_uuid, ko_report_id) REFERENCES veetou_ko_reports(job_uuid, id)
             , CONSTRAINT veetou_ko_report_sheets_fk2 FOREIGN KEY (job_uuid, ko_sheet_id) REFERENCES veetou_ko_sheets(job_uuid, id))'
        );
    END;


    PROCEDURE Create_Ko_Sheet_Pages IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_sheet_pages',
            '( job_uuid RAW(16) NOT NULL
             , ko_sheet_id NUMBER(38)
             , ko_page_id NUMBER(38)
             , CONSTRAINT veetou_ko_sheet_pages_pk PRIMARY KEY (job_uuid, ko_sheet_id, ko_page_id)
             , CONSTRAINT veetou_ko_sheet_pages_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
             , CONSTRAINT veetou_ko_sheet_pages_fk1 FOREIGN KEY (job_uuid, ko_sheet_id) REFERENCES veetou_ko_sheets(job_uuid, id)
             , CONSTRAINT veetou_ko_sheet_pages_fk2 FOREIGN KEY (job_uuid, ko_page_id) REFERENCES veetou_ko_pages(job_uuid, id))'
        );
    END;


    PROCEDURE Create_Ko_Tbody_Trs IS
    BEGIN
        VEETOU_Util.Create_Table_If_Not_Exists('veetou_ko_tbody_trs',
            '( job_uuid RAW(16) NOT NULL
             , ko_tbody_id NUMBER(38)
             , ko_tr_id NUMBER(38)
             , CONSTRAINT veetou_ko_tbody_trs_pk PRIMARY KEY (job_uuid, ko_tbody_id, ko_tr_id)
             , CONSTRAINT veetou_ko_tbody_trs_fk0 FOREIGN KEY (job_uuid) REFERENCES veetou_ko_jobs(job_uuid)
             , CONSTRAINT veetou_ko_tbody_trs_fk1 FOREIGN KEY (job_uuid, ko_tbody_id) REFERENCES veetou_ko_tbodies(job_uuid, id)
             , CONSTRAINT veetou_ko_tbody_trs_fk2 FOREIGN KEY (job_uuid, ko_tr_id) REFERENCES veetou_ko_trs(job_uuid, id))'
        );
    END;


    PROCEDURE Create_Tables IS
    BEGIN
      Create_Ko_Jobs;
      Create_Ko_Footers;
      Create_Ko_Headers;
      Create_Ko_Pages;
      Create_Ko_Preambles;
      Create_Ko_Reports;
      Create_Ko_Sheets;
      Create_Ko_Tbodies;
      Create_Ko_Trs;
      Create_Ko_Page_Footer;
      Create_Ko_Page_Header;
      Create_Ko_Page_Preamble;
      Create_Ko_Page_Tbody;
      Create_Ko_Report_Sheets;
      Create_Ko_Sheet_Pages;
      Create_Ko_Tbody_Trs;
    END;


    PROCEDURE Create_Indexes IS
    BEGIN
        VEETOU_Util.Create_Index_If_Not_Exists('veetou_ko_headers_idx1',
            'ON veetou_ko_headers(job_uuid, faculty)'
        );
        VEETOU_Util.Create_Index_If_Not_Exists('veetou_ko_preambles_idx1',
            'ON veetou_ko_preambles(job_uuid, student_index)'
        );
        VEETOU_Util.Create_Index_If_Not_Exists('veetou_ko_preambles_idx2',
            'ON veetou_ko_preambles(job_uuid, studies_modetier)'
        );
        VEETOU_Util.Create_Index_If_Not_Exists('veetou_ko_preambles_idx3',
            'ON veetou_ko_preambles(job_uuid, studies_field)'
        );
        VEETOU_Util.Create_Index_If_Not_Exists('veetou_ko_preambles_idx4',
            'ON veetou_ko_preambles(job_uuid, studies_specialty)'
        );
        VEETOU_Util.Create_Index_If_Not_Exists('veetou_ko_preambles_idx5',
            'ON veetou_ko_preambles(job_uuid, studies_modetier, studies_field, studies_specialty)'
        );
        VEETOU_Util.Create_Index_If_Not_Exists('veetou_ko_trs_idx1',
            'ON veetou_ko_trs(job_uuid, subj_code)'
        );
        VEETOU_Util.Create_Index_If_Not_Exists('veetou_ko_trs_idx2',
            'ON veetou_ko_trs(job_uuid, subj_grade_date)'
        );
    END;


    --
    -- VIEWS
    --


    PROCEDURE Create_Ko_Full IS
    BEGIN
        VEETOU_Util.Create_View_If_Not_Exists('veetou_ko_full', 'AS
        SELECT
            veetou_ko_trs.job_uuid AS job_uuid
          , veetou_ko_trs.id AS tr_id
          , veetou_ko_trs.subj_code AS tr_subj_code
          , veetou_ko_trs.subj_name AS tr_subj_name
          , veetou_ko_trs.subj_hours_w AS tr_subj_hours_w
          , veetou_ko_trs.subj_hours_c AS tr_subj_hours_c
          , veetou_ko_trs.subj_hours_l AS tr_subj_hours_l
          , veetou_ko_trs.subj_hours_p AS tr_subj_hours_p
          , veetou_ko_trs.subj_hours_s AS tr_subj_hours_s
          , veetou_ko_trs.subj_credit_kind AS tr_subj_credit_kind
          , veetou_ko_trs.subj_ects AS tr_subj_ects
          , veetou_ko_trs.subj_tutor AS tr_subj_tutor
          , veetou_ko_trs.subj_grade AS tr_subj_grade
          , veetou_ko_trs.subj_grade_date AS tr_subj_grade_date
          , veetou_ko_tbodies.id AS tbody_id
          , veetou_ko_tbodies.remark AS tbody_remark
          , veetou_ko_pages.id AS page_id
          , veetou_ko_pages.page_number AS page_page_number
          , veetou_ko_pages.parser_page_number AS page_parser_page_number
          , veetou_ko_sheets.id AS sheet_id
          , veetou_ko_sheets.pages_parsed AS sheet_pages_parsed
          , veetou_ko_sheets.first_page AS sheet_first_page
          , veetou_ko_sheets.ects_mandatory AS sheet_ects_mandatory
          , veetou_ko_sheets.ects_other AS sheet_ects_other
          , veetou_ko_sheets.ects_total AS sheet_ects_total
          , veetou_ko_sheets.ects_attained AS sheet_ects_attained
          , veetou_ko_reports.id AS report_id
          , veetou_ko_reports.source AS report_source
          , veetou_ko_reports.datetime AS report_datetime
          , veetou_ko_reports.first_page AS report_first_page
          , veetou_ko_reports.sheets_parsed AS report_sheets_parsed
          , veetou_ko_reports.pages_parsed AS report_pages_parsed
          , veetou_ko_preambles.id AS preamble_id
          , veetou_ko_preambles.studies_modetier AS preamble_studies_modetier
          , veetou_ko_preambles.title AS preamble_title
          , veetou_ko_preambles.student_index AS preamble_student_index
          , veetou_ko_preambles.first_name AS preamble_first_name
          , veetou_ko_preambles.last_name AS preamble_last_name
          , veetou_ko_preambles.student_name AS preamble_student_name
          , veetou_ko_preambles.semester_code AS preamble_semester_code
          , veetou_ko_preambles.studies_field AS preamble_studies_field
          , veetou_ko_preambles.semester_number AS preamble_semester_number
          , veetou_ko_preambles.studies_specialty AS preamble_studies_specialty
          , veetou_ko_headers.id AS header_id
          , veetou_ko_headers.university AS header_university
          , veetou_ko_headers.faculty AS header_faculty
          , veetou_ko_footers.id AS footer_id
          , veetou_ko_footers.pagination AS footer_pagination
          , veetou_ko_footers.sheet_page_number AS footer_sheet_page_number
          , veetou_ko_footers.sheet_pages_total AS footer_sheet_pages_total
          , veetou_ko_footers.generator_name AS footer_generator_name
          , veetou_ko_footers.generator_home AS footer_generator_home
        FROM veetou_ko_trs
        INNER JOIN veetou_ko_tbody_trs
              ON (veetou_ko_tbody_trs.job_uuid = veetou_ko_trs.job_uuid AND
                  veetou_ko_tbody_trs.ko_tr_id = veetou_ko_trs.id)
        INNER JOIN veetou_ko_tbodies
              ON (veetou_ko_tbody_trs.job_uuid = veetou_ko_tbodies.job_uuid AND
                  veetou_ko_tbody_trs.ko_tbody_id = veetou_ko_tbodies.id)
        INNER JOIN veetou_ko_page_tbody
              ON (veetou_ko_page_tbody.job_uuid = veetou_ko_tbodies.job_uuid AND
                  veetou_ko_page_tbody.ko_tbody_id = veetou_ko_tbodies.id)
        INNER JOIN veetou_ko_pages
              ON (veetou_ko_page_tbody.job_uuid = veetou_ko_pages.job_uuid AND
                  veetou_ko_page_tbody.ko_page_id = veetou_ko_pages.id)
        INNER JOIN veetou_ko_sheet_pages
              ON (veetou_ko_sheet_pages.job_uuid = veetou_ko_pages.job_uuid AND
                  veetou_ko_sheet_pages.ko_page_id = veetou_ko_pages.id)
        INNER JOIN veetou_ko_sheets
              ON (veetou_ko_sheet_pages.job_uuid = veetou_ko_sheets.job_uuid AND
                  veetou_ko_sheet_pages.ko_sheet_id = veetou_ko_sheets.id)
        INNER JOIN veetou_ko_report_sheets
              ON (veetou_ko_report_sheets.job_uuid = veetou_ko_sheets.job_uuid AND
                  veetou_ko_report_sheets.ko_sheet_id = veetou_ko_sheets.id)
        INNER JOIN veetou_ko_reports
              ON (veetou_ko_report_sheets.job_uuid = veetou_ko_reports.job_uuid AND
                  veetou_ko_report_sheets.ko_report_id = veetou_ko_reports.id)
        INNER JOIN veetou_ko_page_preamble
              ON (veetou_ko_page_preamble.job_uuid = veetou_ko_pages.job_uuid AND
                  veetou_ko_page_preamble.ko_page_id = veetou_ko_pages.id)
        INNER JOIN veetou_ko_preambles
              ON (veetou_ko_page_preamble.job_uuid = veetou_ko_preambles.job_uuid AND
                  veetou_ko_page_preamble.ko_preamble_id = veetou_ko_preambles.id)
        INNER JOIN veetou_ko_page_header
              ON (veetou_ko_page_header.job_uuid = veetou_ko_pages.job_uuid AND
                  veetou_ko_page_header.ko_page_id = veetou_ko_pages.id)
        INNER JOIN veetou_ko_headers
              ON (veetou_ko_page_header.job_uuid = veetou_ko_headers.job_uuid AND
                  veetou_ko_page_header.ko_header_id = veetou_ko_headers.id)
        INNER JOIN veetou_ko_page_footer
              ON (veetou_ko_page_footer.job_uuid = veetou_ko_pages.job_uuid AND
                  veetou_ko_page_footer.ko_page_id = veetou_ko_pages.id)
        INNER JOIN veetou_ko_footers
              ON (veetou_ko_page_footer.job_uuid = veetou_ko_footers.job_uuid AND
                  veetou_ko_page_footer.ko_footer_id = veetou_ko_footers.id)'
        );
    END;


    PROCEDURE Create_Ko_Refined IS
    BEGIN
        VEETOU_Util.Create_View_If_Not_Exists('veetou_ko_refined', 'AS
        SELECT
            veetou_ko_full.job_uuid AS job_uuid
          , veetou_ko_full.tr_id AS tr_id
          , veetou_ko_full.tr_subj_code AS subj_code
          , veetou_ko_full.tr_subj_name AS subj_name
          , veetou_ko_full.preamble_student_index AS student_index
          , veetou_ko_full.preamble_first_name AS first_name
          , veetou_ko_full.preamble_last_name AS last_name
          , veetou_ko_full.preamble_student_name AS student_name
          , veetou_ko_full.tr_subj_grade AS subj_grade
          , veetou_ko_full.tr_subj_grade_date AS subj_grade_date
          , veetou_ko_full.header_university AS university
          , veetou_ko_full.header_faculty AS faculty
          , veetou_ko_full.preamble_studies_modetier AS studies_modetier
          , veetou_ko_full.preamble_studies_field AS studies_field
          , veetou_ko_full.preamble_studies_specialty AS studies_specialty
          , veetou_ko_full.preamble_semester_code AS semester_code
          , veetou_ko_full.preamble_semester_number AS semester_number
          , veetou_ko_full.tr_subj_tutor AS subj_tutor
          , veetou_ko_full.tr_subj_hours_w AS subj_hours_w
          , veetou_ko_full.tr_subj_hours_c AS subj_hours_c
          , veetou_ko_full.tr_subj_hours_l AS subj_hours_l
          , veetou_ko_full.tr_subj_hours_p AS subj_hours_p
          , veetou_ko_full.tr_subj_hours_s AS subj_hours_s
          , veetou_ko_full.tr_subj_credit_kind AS subj_credit_kind
          , veetou_ko_full.tr_subj_ects AS subj_ects
          , veetou_ko_full.sheet_ects_mandatory AS ects_mandatory
          , veetou_ko_full.sheet_ects_other AS ects_other
          , veetou_ko_full.sheet_ects_total AS ects_total
          , veetou_ko_full.sheet_ects_attained AS ects_attained
          , veetou_ko_full.preamble_title AS preamble_title
          , veetou_ko_full.report_source AS report_source
          , veetou_ko_full.report_datetime AS report_open_datetime
          , veetou_ko_full.report_sheets_parsed AS report_sheets_parsed
          , veetou_ko_full.report_pages_parsed AS report_pages_parsed
          , veetou_ko_full.page_page_number AS page_number
          , veetou_ko_full.sheet_first_page AS sheet_first_page
          , veetou_ko_full.sheet_pages_parsed AS sheet_pages_parsed
        FROM veetou_ko_full'
        );
    END;

    PROCEDURE Create_Ko_Conducted_Subjects IS
    BEGIN
        VEETOU_Util.Create_View_If_Not_Exists('veetou_ko_conducted_subjects', 'AS
        SELECT DISTINCT
              subj_code
            , subj_name
            , university
            , faculty
            , studies_modetier
            , studies_field
            , studies_specialty
            , semester_code
            , subj_tutor
            , subj_hours_w
            , subj_hours_c
            , subj_hours_l
            , subj_hours_p
            , subj_hours_s
            , subj_credit_kind
            , subj_ects
        FROM veetou_ko_refined
        ORDER BY subj_code');
    END;


    PROCEDURE Create_Views AS
    BEGIN
        Create_Ko_Full;
        Create_Ko_Refined;
        Create_Ko_Conducted_Subjects;
    END;


    PROCEDURE Create_Schema AS
    BEGIN

      --
      -- NOTE: the order is important here!
      --

      Create_Tables;
      Create_Indexes;
      Create_Views;
    END;


    PROCEDURE Drop_Schema(purge IN BOOLEAN := FALSE) AS
      how VARCHAR(100);
    BEGIN

      --
      -- NOTE: the order is important here!
      --

      -- DROP VIEWS

      VEETOU_Util.Drop_View_If_Exists('veetou_ko_conducted_subjects');
      VEETOU_Util.Drop_View_If_Exists('veetou_ko_refined');
      VEETOU_Util.Drop_View_If_Exists('veetou_ko_full');

      -- DROP INDEXES

      VEETOU_Util.Drop_Index_If_Exists('veetou_ko_headers_idx1');
      VEETOU_Util.Drop_Index_If_Exists('veetou_ko_preambles_idx1');
      VEETOU_Util.Drop_Index_If_Exists('veetou_ko_preambles_idx2');
      VEETOU_Util.Drop_Index_If_Exists('veetou_ko_preambles_idx3');
      VEETOU_Util.Drop_Index_If_Exists('veetou_ko_preambles_idx4');
      VEETOU_Util.Drop_Index_If_Exists('veetou_ko_preambles_idx5');
      VEETOU_Util.Drop_Index_If_Exists('veetou_ko_trs_idx1');
      VEETOU_Util.Drop_Index_If_Exists('veetou_ko_trs_idx2');

      if purge THEN
        how := 'PURGE';
      ELSE
        how := '';
      END IF;

      -- DELETE JUNCTION TABLES

      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_page_footer', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_page_header', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_page_preamble', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_page_tbody', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_report_sheets', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_sheet_pages', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_tbody_trs', how);


      -- DELETE DATA TABLES

      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_footers', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_headers', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_pages', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_preambles', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_reports', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_sheets', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_tbodies', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_trs', how);
      VEETOU_Util.Drop_Table_If_Exists('veetou_ko_jobs', how);
    END;
END VEETOU_Schema_KO;
-- vim: ft=sql ts=4 sw=4 et:
