MERGE INTO v2u_ko_missing_zalprz_j tgt
USING
    (
        SELECT
              g_j.job_uuid
            , g_j.semester_id
            , g_j.specialty_id
            , g_j.subject_id
            , g_j.student_id
            , sm_j.map_id subject_map_id
            , semesters.semester_code
            , subject_map.map_subj_code
            , studenci.os_id
            , CASE
                WHEN sm_j.map_id IS NULL
                THEN 'no subject_map for {subject: "' ||
                        subjects.subj_code
                    || '", semester: "' ||
                       semesters.semester_code
                    || '"}'
                WHEN subject_map.map_subj_code IS NULL
                THEN 'map_subj_code IS NULL for {subject: "' ||
                        subjects.subj_code
                    || '", semester: "' ||
                        semesters.semester_code
                    || '"}'
                WHEN studenci.os_id IS NULL
                THEN  '{student: "' ||
                        students.student_index
                    || '"} not in v2u_dz_studenci'
                WHEN zaliczenia_przedmiotow.prz_kod IS NULL
                THEN '{student: "' ||
                        students.student_index
                    || '", subject: "' ||
                        subject_map.map_subj_code
                    || '", semester: "' ||
                        semesters.semester_code
                    || '"} not in v2u_dz_zaliczenia_przedmiotow'
                ELSE 'error (v2u_ko_matched_zalprz_j out of sync?)'
              END reason
        FROM v2u_ko_grades_j g_j
        INNER JOIN v2u_ko_semesters semesters
            ON  (
                        semesters.id = g_j.semester_id
                    AND semesters.job_uuid = g_j.job_uuid
                )
        INNER JOIN v2u_ko_subjects subjects
            ON  (
                        subjects.id = g_j.subject_id
                    AND subjects.job_uuid = g_j.job_uuid
                )
        INNER JOIN v2u_ko_students students
            ON  (
                        students.id = g_j.student_id
                    AND students.job_uuid = g_j.job_uuid
                )
        LEFT JOIN v2u_dz_studenci studenci
            ON  (
                        studenci.indeks = students.student_index
                )
        LEFT JOIN v2u_ko_matched_zalprz_j ma_zalprz_j
            ON  (
                        ma_zalprz_j.student_id = g_j.student_id
                    AND ma_zalprz_j.subject_id = g_j.subject_id
                    AND ma_zalprz_j.specialty_id = g_j.specialty_id
                    AND ma_zalprz_j.semester_id = g_j.semester_id
                    AND ma_zalprz_j.job_uuid = g_j.job_uuid
                )
        LEFT JOIN v2u_ko_subject_map_j sm_j
            ON  (
                        sm_j.subject_id = g_j.subject_id
                    AND sm_j.specialty_id = g_j.specialty_id
                    AND sm_j.semester_id = g_j.semester_id
                    AND sm_j.job_uuid = g_j.job_uuid
                    AND sm_j.selected = 1
                )
        LEFT JOIN v2u_subject_map subject_map
            ON  (
                        subject_map.id = sm_j.map_id
                )
        LEFT JOIN v2u_dz_zaliczenia_przedmiotow zaliczenia_przedmiotow
            ON  (
                        zaliczenia_przedmiotow.os_id = studenci.os_id
                    AND zaliczenia_przedmiotow.cdyd_kod = semesters.semester_code
                    AND zaliczenia_przedmiotow.prz_kod = subject_map.map_subj_code
                )
        WHERE ma_zalprz_j.job_uuid IS NULL
    ) src
ON  (
            tgt.student_id = src.student_id
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , semester_id
        , specialty_id
        , subject_id
        , student_id
        , subject_map_id
        , semester_code
        , map_subj_code
        , os_id
        , reason
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.subject_id
        , src.student_id
        , src.subject_map_id
        , src.semester_code
        , src.map_subj_code
        , src.os_id
        , src.reason
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.semester_code = src.semester_code
        , tgt.map_subj_code = src.map_subj_code
        , tgt.os_id = src.os_id
        , tgt.reason = src.reason
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
