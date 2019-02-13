MERGE INTO v2u_ko_student_semesters_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  students.job_uuid job_uuid
                , students.id student_id
                , students.sheet_ids sheet_ids
            FROM v2u_ko_students students
        ),
        v AS
        (
            SELECT
                  u.job_uuid job_uuid
                , u.student_id student_id
                , VALUE(sheet_ids) sheet_id
            FROM u u
            CROSS JOIN TABLE(u.sheet_ids) sheet_ids
        )
        SELECT
              v.job_uuid job_uuid
            , v.student_id student_id
            , j1.specialty_id specialty_id
            , j2.semester_id semester_id
            , sheets.ects_attained ects_attained
        FROM v v
        INNER JOIN v2u_ko_specialty_sheets_j j1
            ON (j1.sheet_id = v.sheet_id AND j1.job_uuid = v.job_uuid)
        INNER JOIN v2u_ko_semester_sheets_j j2
            ON (j2.sheet_id = v.sheet_id AND j1.job_uuid = v.job_uuid)
        INNER JOIN v2u_ko_sheets sheets
            ON (sheets.id = v.sheet_id AND sheets.job_uuid = v.job_uuid)
    ) src
ON (tgt.student_id = src.student_id AND
    tgt.specialty_id = src.specialty_id AND
    tgt.semester_id = src.semester_id AND
    tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     student_id,     specialty_id,     semester_id,     ects_attained)
    VALUES (src.job_uuid, src.student_id, src.specialty_id, src.semester_id, src.ects_attained)
WHEN MATCHED THEN UPDATE SET tgt.ects_attained = src.ects_attained;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
