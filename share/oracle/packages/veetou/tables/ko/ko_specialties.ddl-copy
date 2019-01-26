CREATE SEQUENCE v2u_ko_specialties_sq1 START WITH 1;
/
CREATE TABLE v2u_ko_specialties
OF V2u_Ko_Specialty_t
    (
          CONSTRAINT v2u_ko_specialties_pk PRIMARY KEY (id, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
NESTED TABLE sheet_ids STORE AS v2u_ko_specialty_sheets_nt
AS WITH u AS
    (
        SELECT VALUE(sheets) sheet
             , VALUE(preambles) preamble
             , MIN(VALUE(headers)) KEEP (DENSE_RANK FIRST ORDER BY VALUE(headers)) header
        FROM v2u_ko_sheet_pages sheet_pages
        INNER JOIN v2u_ko_sheets sheets
            ON (sheet_pages.ko_sheet_id = sheets.id AND
                sheet_pages.job_uuid = sheets.job_uuid)
        INNER JOIN v2u_ko_pages pages
            ON (sheet_pages.ko_page_id = pages.id AND
                sheet_pages.job_uuid = pages.job_uuid)
        INNER JOIN v2u_ko_page_preamble page_preamble
            ON (page_preamble.ko_page_id = pages.id AND
                page_preamble.job_uuid = pages.job_uuid)
        INNER JOIN v2u_ko_preambles preambles
            ON (page_preamble.ko_preamble_id = preambles.id AND
                page_preamble.job_uuid = preambles.job_uuid)
        INNER JOIN v2u_ko_page_header page_header
            ON (page_header.ko_page_id = pages.id AND
                page_header.job_uuid = pages.job_uuid)
        INNER JOIN v2u_ko_headers headers
            ON (page_header.ko_header_id = headers.id AND
                page_header.job_uuid = headers.job_uuid)
        GROUP BY VALUE(sheets), VALUE(preambles)
    ),
    v AS
    (
        SELECT V2u_To.Ko_Specialty(u.sheet.job_uuid, NULL, header, preamble) specialty
            , u.sheet.id sheet_id
        FROM u u
    ),
    w AS
    (
        SELECT specialty, CAST(COLLECT(sheet_id) AS V2u_Ko_Ids_t) sheet_ids
        FROM v
        GROUP BY specialty
        ORDER BY specialty
    )
SELECT
      w.specialty.job_uuid
    , V2U_Util.Next_Val('v2u_ko_specialties_sq1')
    , w.specialty.university
    , w.specialty.faculty
    , w.specialty.studies_modetier
    , w.specialty.studies_field
    , w.specialty.studies_specialty
    , w.sheet_ids
FROM w w;

CREATE OR REPLACE TRIGGER v2u_ko_specialties_tr1
    BEFORE INSERT ON v2u_ko_specialties
    FOR EACH ROW
    WHEN (new.id IS NULL)
    BEGIN
        SELECT v2u_ko_specialties_sq1.NEXTVAL INTO :new.id FROM dual;
    END;
/

-- vim: set ft=sql ts=4 sw=4 et:
