CREATE TABLE veetou_ko_exports(
    export_id NUMBER(38) NOT NULL
  , export_timpestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
  , export_user VARCHAR(32)
  , export_name VARCHAR(32)
  , CONSTRAINT veetou_ko_exports_pk PRIMARY KEY (export_id)
);

CREATE TABLE veetou_ko_footers (
    export_id NUMBER(38) NOT NULL
  , id NUMBER(38) NOT NULL
  , pagination VARCHAR(32 CHAR)
  , sheet_page_number NUMBER(16)
  , sheet_pages_total NUMBER(16)
  , generator_name VARCHAR(256 CHAR)
  , generator_home VARCHAR(256 CHAR)
  , CONSTRAINT veetou_ko_footers_pk PRIMARY KEY (export_id, id)
  , CONSTRAINT veetou_ko_footers_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
);

CREATE TABLE veetou_ko_headers (
    export_id NUMBER(38) NOT NULL
  , id NUMBER(38) NOT NULL
  , university VARCHAR(256 CHAR)
  , faculty VARCHAR(256 CHAR)
  , CONSTRAINT veetou_ko_header_pk PRIMARY KEY (export_id, id)
  , CONSTRAINT veetou_ko_header_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
);

CREATE TABLE veetou_ko_pages (
    export_id NUMBER(38) NOT NULL
  , id NUMBER(38) NOT NULL
  , page_number NUMBER(16)
  , parser_page_number NUMBER(16)
  , CONSTRAINT veetou_ko_pages_pk PRIMARY KEY (export_id, id)
  , CONSTRAINT veetou_ko_pages_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
);

CREATE TABLE veetou_ko_preambles (
    export_id NUMBER(38) NOT NULL
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
  , CONSTRAINT veetou_ko_preambles_pk PRIMARY KEY (export_id, id)
  , CONSTRAINT veetou_ko_preambles_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
);

CREATE TABLE veetou_ko_reports (
    export_id NUMBER(38) NOT NULL
  , id NUMBER(38) NOT NULL
  , source VARCHAR(512 CHAR)
  , datetime TIMESTAMP
  , first_page NUMBER(16)
  , sheets_parsed NUMBER(16)
  , pages_parsed NUMBER(16)
  , CONSTRAINT veetou_ko_reports_pk PRIMARY KEY (export_id, id)
  , CONSTRAINT veetou_ko_reports_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
);

CREATE TABLE veetou_ko_sheets (
    export_id NUMBER(38) NOT NULL
  , id NUMBER(38) NOT NULL
  , pages_parsed NUMBER(4)
  , first_page NUMBER(16)
  , ects_mandatory NUMBER(16)
  , ects_other NUMBER(16)
  , ects_total NUMBER(16)
  , ects_attained NUMBER(16)
  , CONSTRAINT veetou_ko_sheets_pk PRIMARY KEY (export_id, id)
  , CONSTRAINT veetou_ko_sheets_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
);

CREATE TABLE veetou_ko_tbodies (
    export_id NUMBER(38) NOT NULL
  , id NUMBER(38) NOT NULL
  , remark VARCHAR(256)
  , CONSTRAINTS veetou_ko_tbodies_pk PRIMARY KEY (export_id, id)
  , CONSTRAINTS veetou_ko_tbodies_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
);

CREATE TABLE veetou_ko_trs (
    export_id NUMBER(38) NOT NULL
  , id NUMBER(38) NOT NULL
  , subj_code VARCHAR(32 CHAR)
  , subj_name VARCHAR(256 CHAR)
  , subj_hours_w NUMBER(8)
  , subj_hours_c NUMBER(8)
  , subj_hours_l NUMBER(8)
  , subj_hours_p NUMBER(8)
  , subj_hours_s NUMBER(8)
  , subj_credit_kind VARCHAR(16)
  , subj_ects NUMBER(16)
  , subj_tutor VARCHAR(256)
  , subj_grade VARCHAR(32)
  , subj_grade_date DATE
  , CONSTRAINT veetou_ko_trs_pk PRIMARY KEY (export_id, id)
  , CONSTRAINT veetou_ko_trs_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
);

-- JUNCTION TABLES

CREATE TABLE veetou_ko_page_footer (
    export_id NUMBER(38) NOT NULL
  , ko_page_id NUMBER(38)
  , ko_footer_id NUMBER(38)
  , CONSTRAINT veetou_ko_page_footer_pk PRIMARY KEY (export_id, ko_page_id, ko_footer_id)
  , CONSTRAINT veetou_ko_page_footer_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
  , CONSTRAINT veetou_ko_page_footer_fk1 FOREIGN KEY (export_id, ko_page_id) REFERENCES veetou_ko_pages(export_id, id)
  , CONSTRAINT veetou_ko_page_footer_fk2 FOREIGN KEY (export_id, ko_footer_id) REFERENCES veetou_ko_footers(export_id, id)
);

CREATE TABLE veetou_ko_page_header (
    export_id NUMBER(38) NOT NULL
  , ko_page_id NUMBER(38)
  , ko_header_id NUMBER(38)
  , CONSTRAINT veetou_ko_page_header_pk PRIMARY KEY (export_id, ko_page_id, ko_header_id)
  , CONSTRAINT veetou_ko_page_header_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
  , CONSTRAINT veetou_ko_page_header_fk1 FOREIGN KEY (export_id, ko_page_id) REFERENCES veetou_ko_pages(export_id, id)
  , CONSTRAINT veetou_ko_page_header_fk2 FOREIGN KEY (export_id, ko_header_id) REFERENCES veetou_ko_headers(export_id, id)
);

CREATE TABLE veetou_ko_page_preamble (
    export_id NUMBER(38) NOT NULL
  , ko_page_id NUMBER(38)
  , ko_preamble_id NUMBER(38)
  , CONSTRAINT veetou_ko_page_preamble_pk PRIMARY KEY (export_id, ko_page_id, ko_preamble_id)
  , CONSTRAINT veetou_ko_page_preamble_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
  , CONSTRAINT veetou_ko_page_preamble_fk1 FOREIGN KEY (export_id, ko_page_id) REFERENCES veetou_ko_pages(export_id, id)
  , CONSTRAINT veetou_ko_page_preamble_fk2 FOREIGN KEY (export_id, ko_preamble_id) REFERENCES veetou_ko_preambles(export_id, id)
);

CREATE TABLE veetou_ko_page_tbody (
    export_id NUMBER(38) NOT NULL
  , ko_page_id NUMBER(38)
  , ko_tbody_id NUMBER(38)
  , CONSTRAINT veetou_ko_page_tbody_pk PRIMARY KEY (export_id, ko_page_id, ko_tbody_id)
  , CONSTRAINT veetou_ko_page_tbody_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
  , CONSTRAINT veetou_ko_page_tbody_fk1 FOREIGN KEY (export_id, ko_page_id) REFERENCES veetou_ko_pages(export_id, id)
  , CONSTRAINT veetou_ko_page_tbody_fk2 FOREIGN KEY (export_id, ko_tbody_id) REFERENCES veetou_ko_tbodies(export_id, id)
);

CREATE TABLE veetou_ko_report_sheets (
    export_id NUMBER(38) NOT NULL
  , ko_report_id NUMBER(38)
  , ko_sheet_id NUMBER(38)
  , CONSTRAINT veetou_ko_report_sheets_pk PRIMARY KEY (export_id, ko_report_id, ko_sheet_id)
  , CONSTRAINT veetou_ko_report_sheets_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
  , CONSTRAINT veetou_ko_report_sheets_fk1 FOREIGN KEY (export_id, ko_report_id) REFERENCES veetou_ko_reports(export_id, id)
  , CONSTRAINT veetou_ko_report_sheets_fk2 FOREIGN KEY (export_id, ko_sheet_id) REFERENCES veetou_ko_sheets(export_id, id)
);

CREATE TABLE veetou_ko_sheet_pages (
    export_id NUMBER(38) NOT NULL
  , ko_sheet_id NUMBER(38)
  , ko_page_id NUMBER(38)
  , CONSTRAINT veetou_ko_sheet_pages_pk PRIMARY KEY (export_id, ko_sheet_id, ko_page_id)
  , CONSTRAINT veetou_ko_sheet_pages_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
  , CONSTRAINT veetou_ko_sheet_pages_fk1 FOREIGN KEY (export_id, ko_sheet_id) REFERENCES veetou_ko_sheets(export_id, id)
  , CONSTRAINT veetou_ko_sheet_pages_fk2 FOREIGN KEY (export_id, ko_page_id) REFERENCES veetou_ko_pages(export_id, id)
);

CREATE TABLE veetou_ko_tbody_trs (
    export_id NUMBER(38) NOT NULL
  , ko_tbody_id NUMBER(38)
  , ko_tr_id NUMBER(38)
  , CONSTRAINT veetou_ko_tbody_trs_pk PRIMARY KEY (export_id, ko_tbody_id, ko_tr_id)
  , CONSTRAINT veetou_ko_tbody_trs_fk0 FOREIGN KEY (export_id) REFERENCES veetou_ko_exports(export_id)
  , CONSTRAINT veetou_ko_tbody_trs_fk1 FOREIGN KEY (export_id, ko_tbody_id) REFERENCES veetou_ko_tbodies(export_id, id)
  , CONSTRAINT veetou_ko_tbody_trs_fk2 FOREIGN KEY (export_id, ko_tr_id) REFERENCES veetou_ko_trs(export_id, id)
);

CREATE INDEX veetou_ko_headers_idx1
  ON veetou_ko_headers(export_id, faculty)
;
CREATE INDEX veetou_ko_preambles_idx1
  ON veetou_ko_preambles(export_id, student_index)
;
CREATE INDEX veetou_ko_preambles_idx2
  ON veetou_ko_preambles(export_id, studies_modetier)
;
CREATE INDEX veetou_ko_preambles_idx3
  ON veetou_ko_preambles(export_id, studies_field)
;
CREATE INDEX veetou_ko_preambles_idx4
  ON veetou_ko_preambles(export_id, studies_specialty)
;
CREATE INDEX veetou_ko_preambles_idx5
  ON veetou_ko_preambles(export_id, studies_modetier, studies_field, studies_specialty)
;
CREATE INDEX veetou_ko_trs_idx1
  ON veetou_ko_trs(export_id, subj_code)
;
CREATE INDEX veetou_ko_trs_idx2
  ON veetou_ko_trs(export_id, subj_grade_date)
;
