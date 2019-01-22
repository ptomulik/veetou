CREATE OR REPLACE VIEW v2u_ko_sheets_ov
OF V2u_Ko_Sheet_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS SELECT t.job_uuid
        , t.id
        , t.pages_parsed
        , t.first_page
        , t.ects_mandatory
        , t.ects_other
        , t.ects_total
        , t.ects_attained
FROM v2u_ko_sheets t;

-- vim: set ft=sql ts=4 sw=4 et:
