MERGE INTO v2u_ko_students tgt
USING
    (
        WITH u AS
        (
            SELECT
                  V2u_To.Ko_Student(
                        job_uuid => s.job_uuid,
                        preamble => s.preamble
                  ) student
                , s.sheet.id s_id
            FROM v2u_ko_sh_hdr_preamb_h s
        )
        SELECT
            u.student.dup(CAST(COLLECT(u.s_id) AS V2u_Ids_t)) student
        FROM u u
        GROUP BY u.student
    ) src
ON
    (
        -- We should actually use DECODE(...) here, but it doesn't seem to work well in the ON clause
            ((src.student.student_index = tgt.student_index) OR (src.student.student_index IS NULL AND tgt.student_index IS NULL))
        AND ((src.student.student_name = tgt.student_name) OR (src.student.student_name IS NULL AND tgt.student_name IS NULL))
        AND ((src.student.first_name = tgt.first_name) OR (src.student.first_name IS NULL AND tgt.first_name IS NULL))
        AND ((src.student.last_name = tgt.last_name) OR (src.student.last_name IS NULL AND tgt.last_name IS NULL))
        AND ((src.student.job_uuid = tgt.job_uuid) OR (src.student.job_uuid IS NULL AND tgt.job_uuid IS NULL))
    )
WHEN NOT MATCHED THEN INSERT VALUES(src.student)
WHEN MATCHED THEN UPDATE SET tgt.sheet_ids = src.student.sheet_ids;

-- vim: set ft=sql ts=4 sw=4 et:
