CREATE OR REPLACE VIEW v2u_ko_preambles_ov
OF V2u_Ko_Preamble_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS SELECT t.job_uuid
        , t.id
        , t.studies_modetier
        , t.title
        , t.student_index
        , t.first_name
        , t.last_name
        , t.student_name
        , t.semester_code
        , t.studies_field
        , t.semester_number
        , t.studies_specialty
FROM v2u_ko_preambles t;

-- vim: set ft=sql ts=4 sw=4 et:
