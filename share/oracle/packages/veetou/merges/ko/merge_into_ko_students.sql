MERGE INTO v2u_ko_students tgt
USING
    (
        WITH u AS
        (
            SELECT
                V2u_Ko_Student_t(
                      job_uuid => p.job_uuid
                    , student_index => p.student_index
                    , student_name => p.student_name
                    , first_name => p.first_name
                    , last_name => p.last_name
                ) student
                , p.id p_id
            FROM v2u_ko_preambles p
        )
        SELECT
            u.student.dup_with(
                  new_id_seq => 'v2u_ko_students_sq1'
                , new_preamble_ids => CAST(COLLECT(u.p_id) AS V2u_Ids_t)
            ) student
        FROM u u
        GROUP BY u.student
        ORDER BY u.student
    ) src
ON
    (
            DECODE(src.student.student_index, tgt.student_index, 1, 0) = 1
        AND DECODE(src.student.job_uuid, tgt.job_uuid, 1, 0) = 1
        AND DECODE(src.student.student_name, tgt.student_name, 1, 0) = 1
        AND DECODE(src.student.first_name, tgt.first_name, 1, 0) = 1
        AND DECODE(src.student.last_name, tgt.last_name, 1, 0) = 1
    )
WHEN NOT MATCHED THEN INSERT VALUES(src.student);

-- vim: set ft=sql ts=4 sw=4 et:
