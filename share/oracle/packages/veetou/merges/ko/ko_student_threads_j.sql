MERGE INTO v2u_ko_student_threads_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  j1.job_uuid job_uuid
                , j1.student_id student_id
                , j1.specialty_id specialty_id
                , j2.map_id specialty_map_id
                , V2U_To.Threads(CAST(COLLECT(VALUE(semesters)) AS V2u_Ko_Semesters_t)) threads
            FROM v2u_ko_student_semesters_j j1
            INNER JOIN v2u_ko_semesters semesters
                ON (semesters.id = j1.semester_id AND
                    semesters.job_uuid = j1.job_uuid)
            INNER JOIN v2u_ko_specialty_map_j j2
                ON (j2.specialty_id = j1.specialty_id AND
                    j2.semester_id = j1.semester_id AND
                    j2.job_uuid = j1.job_uuid)
            GROUP BY
                  j1.job_uuid
                , j1.student_id
                , j1.specialty_id
                , j2.map_id
        )
        SELECT
              u.job_uuid job_uuid
            , u.student_id student_id
            , u.specialty_id specialty_id
            , u.specialty_map_id specialty_map_id
            , ROW_NUMBER() OVER (
                PARTITION BY
                          job_uuid
                        , student_id
                        , specialty_id
                        , specialty_map_id
                ORDER BY 1
              ) thread_index
            , CAST(MULTISET(
                    SELECT s.id FROM TABLE(VALUE(t)) s ORDER BY VALUE(s)
              ) AS V2u_Ids_t) semester_ids
            , V2U_Util.Max_Admission_Semester(VALUE(t)) max_admission_semester
        FROM u u
        CROSS JOIN TABLE(u.threads) t
    ) src
ON (tgt.student_id = src.student_id AND
    tgt.specialty_id = src.specialty_id AND
    tgt.specialty_map_id = src.specialty_map_id AND
    tgt.thread_index = src.thread_index AND
    tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     student_id,     specialty_id,     specialty_map_id,     thread_index,     semester_ids,     max_admission_semester)
    VALUES (src.job_uuid, src.student_id, src.specialty_id, src.specialty_map_id, src.thread_index, src.semester_ids, src.max_admission_semester)
WHEN MATCHED THEN UPDATE SET tgt.semester_ids = src.semester_ids, tgt.max_admission_semester = src.max_admission_semester;

-- vim: set ft=sql ts=4 sw=4 et:
