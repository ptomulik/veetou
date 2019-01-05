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
              v.job_uuid
            , v.student_id
            , spc_sh_j.specialty_id
            , sem_sh_j.semester_id
            , sheets.ects_attained
        FROM v v
        INNER JOIN v2u_ko_specialty_sheets_j spc_sh_j
            ON  (
                        spc_sh_j.sheet_id = v.sheet_id
                    AND spc_sh_j.job_uuid = v.job_uuid
                )
        INNER JOIN v2u_ko_semester_sheets_j sem_sh_j
            ON  (
                        sem_sh_j.sheet_id = v.sheet_id
                    AND sem_sh_j.job_uuid = v.job_uuid
                )
        INNER JOIN v2u_ko_sheets sheets
            ON  (
                        sheets.id = v.sheet_id
                    AND sheets.job_uuid = v.job_uuid
                )
        GROUP BY
              v.job_uuid
            , v.student_id
            , spc_sh_j.specialty_id
            , sem_sh_j.semester_id
            , sheets.ects_attained
    ) src
ON  (
            tgt.student_id = src.student_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , semester_id
        , specialty_id
        , student_id
        , ects_attained
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.student_id
        , src.ects_attained
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.ects_attained = src.ects_attained
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
