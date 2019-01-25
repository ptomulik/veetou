CREATE OR REPLACE VIEW v2u_ko_students_dv
OF V2u_Ko_Student_t
WITH OBJECT IDENTIFIER (job_uuid, id)
AS WITH u AS
    (
        SELECT
              job_uuid
            , student_index
            , student_name
            , first_name
            , last_name
            , CAST(COLLECT(p.id) AS V2u_Ko_Ids_t) preamble_ids
        FROM v2u_ko_preambles p
        GROUP BY student_index, student_name, first_name, last_name, job_uuid
        ORDER BY student_index, student_name, first_name, last_name, job_uuid
    )
SELECT
      job_uuid
    , NULL
    , student_index
    , student_name
    , first_name
    , last_name
    , preamble_ids
FROM u;

-- vim: set ft=sql ts=4 sw=4 et:
