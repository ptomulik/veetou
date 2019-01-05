CREATE TABLE veetou_exports(
    uuid RAW(32) NOT NULL
  , export_timpestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
  , export_user VARCHAR(32)
  , export_name VARCHAR(32)
);
CREATE TABLE veetou_ko_footers (
    export_uuid RAW(32) NOT NULL
  , id INTEGER NOT NULL
  , pagination VARCHAR(32 CHAR)
  , sheet_page_number INTEGER
  , sheet_pages_total INTEGER
  , generator_name VARCHAR(256 CHAR)
  , generator_home VARCHAR(256 CHAR)
  , PRIMARY KEY (export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_headers (
    export_uuid RAW(32) NOT NULL
  , id INTEGER NOT NULL
  , university VARCHAR(256 CHAR)
  , faculty VARCHAR(256 CHAR)
  , PRIMARY KEY (export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_page_footer (
    export_uuid RAW(32) NOT NULL
  , ko_page_id INTEGER
  , ko_footer_id INTEGER
  , CONSTRAINT veetou_ko_page_footer_pk PRIMARY KEY (export_uuid, ko_page_id, ko_footer_id)
  , FOREIGN KEY (export_uuid, ko_page_id) REFERENCES veetou_ko_pages(export_uuid, id)
  , FOREIGN KEY (export_uuid, ko_footer_id) REFERENCES veetou_ko_footers(export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_page_header (
    export_uuid RAW(32) NOT NULL
  , ko_page_id INTEGER
  , ko_header_id INTEGER
  , CONSTRAINT veetou_ko_page_header_pk PRIMARY KEY (export_uuid, ko_page_id, ko_header_id)
  , FOREIGN KEY (export_uuid, ko_page_id) REFERENCES veetou_ko_pages(export_uuid, id)
  , FOREIGN KEY (export_uuid, ko_header_id) REFERENCES veetou_ko_headers(export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_page_preamble (
    export_uuid RAW(32) NOT NULL
  , ko_page_id INTEGER
  , ko_preamble_id INTEGER
  , CONSTRAINT veetou_ko_page_preamble_pk PRIMARY KEY (export_uuid, ko_page_id, ko_preamble_id)
  , FOREIGN KEY (export_uuid, ko_page_id) REFERENCES veetou_ko_pages(export_uuid, id)
  , FOREIGN KEY (export_uuid, ko_preamble_id) REFERENCES veetou_ko_preambles(export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_page_tbody (
    export_uuid RAW(32) NOT NULL
  , ko_page_id INTEGER
  , ko_tbody_id INTEGER
  , CONSTRAINT veetou_ko_page_tbody_pk PRIMARY KEY (export_uuid, ko_page_id, ko_tbody_id)
  , FOREIGN KEY (export_uuid, ko_page_id) REFERENCES veetou_ko_pages(export_uuid, id)
  , FOREIGN KEY (export_uuid, ko_tbody_id) REFERENCES veetou_ko_tbodies(export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_pages (
    export_uuid RAW(32) NOT NULL
  , id INTEGER NOT NULL
  , page_number INTEGER
  , parser_page_number INTEGER
  , PRIMARY KEY (export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_preambles (
    export_uuid RAW(32) NOT NULL
  , id INTEGER NOT NULL
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
  , PRIMARY KEY (export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_report_sheets (
    export_uuid RAW(32) NOT NULL
  , ko_report_id INTEGER
  , ko_sheet_id INTEGER
  , CONSTRAINT veetou_ko_report_sheets_pk PRIMARY KEY (export_uuid, ko_report_id, ko_sheet_id)
  , FOREIGN KEY (export_uuid, ko_report_id) REFERENCES veetou_ko_reports(export_uuid, id)
  , FOREIGN KEY (export_uuid, ko_sheet_id) REFERENCES veetou_ko_sheets(export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_reports (
    export_uuid RAW(32) NOT NULL
  , id INTEGER NOT NULL
  , source TEXT
  , datetime TEXT
  , first_page NUMBER(16)
  , sheets_parsed NUMBER(16)
  , pages_parsed NUMBER(16)
  , PRIMARY KEY (export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_sheet_pages (
    export_uuid RAW(32) NOT NULL
  , ko_sheet_id INTEGER
  , ko_page_id INTEGER
  , CONSTRAINT veetou_ko_sheet_pages_pk PRIMARY KEY (export_uuid, ko_sheet_id, ko_page_id)
  , FOREIGN KEY (export_uuid, ko_sheet_id) REFERENCES veetou_ko_sheets(export_uuid, id)
  , FOREIGN KEY (export_uuid, ko_page_id) REFERENCES veetou_ko_pages(export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_sheets (
    export_uuid RAW(32) NOT NULL
  , id INTEGER NOT NULL
  , pages_parsed NUMBER(4)
  , first_page NUMBER(16)
  , ects_mandatory NUMBER(16)
  , ects_other NUMBER(16)
  , ects_total NUMBER(16)
  , ects_attained NUMBER(16)
  , PRIMARY KEY (export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_tbodies (
    export_uuid RAW(32) NOT NULL
  , id INTEGER NOT NULL
  , remark VARCHAR(256)
  , PRIMARY KEY (export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_tbody_trs (
    export_uuid RAW(32) NOT NULL
  , ko_tbody_id INTEGER
  , ko_tr_id INTEGER
  , CONSTRAINT veetou_ko_tbody_trs_pk PRIMARY KEY (export_uuid, ko_tbody_id, ko_tr_id)
  , FOREIGN KEY (export_uuid, ko_tbody_id) REFERENCES veetou_ko_tbodies(export_uuid, id)
  , FOREIGN KEY (export_uuid, ko_tr_id) REFERENCES veetou_ko_trs(export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);
CREATE TABLE veetou_ko_trs (
    export_uuid RAW(32) NOT NULL
  , id INTEGER NOT NULL
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
  , PRIMARY KEY (export_uuid, id)
  , FOREIGN KEY (export_uuid) REFERENCES veetou_exports(uuid)
);

CREATE INDEX veetou_ko_headers_idx1
  ON veetou_ko_headers(export_uuid, faculty)
;
CREATE INDEX veetou_ko_preambles_idx1
  ON ko_preambles(export_uuid, student_index)
;
CREATE INDEX veetou_ko_preambles_idx2
  ON ko_preambles(export_uuid, studies_modetier)
;
CREATE INDEX veetou_ko_preambles_idx3
  ON ko_preambles(export_uuid, studies_field)
;
CREATE INDEX veetou_ko_preambles_idx4
  ON ko_preambles(export_uuid, studies_specialty)
;
CREATE INDEX veetou_ko_preambles_idx5
  ON ko_preambles(export_uuid, studies_modetier, studies_field, studies_specialty)
;
CREATE INDEX veetou_ko_trs_idx1
  ON ko_trs(export_uuid, subj_code)
;
CREATE INDEX veetou_ko_trs_idx2
  ON ko_trs(export_uuid, subj_grade_date)
;
