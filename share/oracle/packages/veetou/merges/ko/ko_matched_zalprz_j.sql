MERGE INTO v2u_ko_matched_zalprz_j tgt
USING
    (
        SELECT
              g_j.job_uuid
            , g_j.semester_id
            , g_j.specialty_id
            , g_j.subject_id
            , g_j.student_id
            , subject_map.id subject_map_id
            , studenci.id st_id
            , zaliczenia_przedmiotow.os_id
            , zaliczenia_przedmiotow.cdyd_kod
            , zaliczenia_przedmiotow.prz_kod

        FROM v2u_ko_grades_j g_j
        INNER JOIN v2u_ko_semesters semesters
            ON  (
                        semesters.id = g_j.semester_id
                    AND semesters.job_uuid = g_j.job_uuid
                )
        INNER JOIN v2u_ko_students students
            ON  (
                        students.id = g_j.student_id
                    AND students.job_uuid = g_j.job_uuid
                )
        INNER JOIN v2u_dz_studenci studenci
            ON  (
                        studenci.indeks = students.student_index
                )
        INNER JOIN v2u_ko_subject_map_j sm_j
            ON  (
                        sm_j.subject_id = g_j.subject_id
                    AND sm_j.specialty_id = g_j.specialty_id
                    AND sm_j.semester_id = g_j.semester_id
                    AND sm_j.job_uuid = g_j.job_uuid
                    AND sm_j.selected = 1
                )
        INNER JOIN v2u_subject_map subject_map
            ON  (
                        subject_map.id = sm_j.map_id
                    AND subject_map.map_subj_code IS NOT NULL
                )
        INNER JOIN v2u_dz_zaliczenia_przedmiotow zaliczenia_przedmiotow
            ON  (
                        zaliczenia_przedmiotow.os_id = studenci.os_id
                    AND zaliczenia_przedmiotow.prz_kod = subject_map.map_subj_code
                    AND zaliczenia_przedmiotow.cdyd_kod = semesters.semester_code
                )
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.student_id = src.student_id
        AND tgt.os_id = src.os_id
        AND tgt.cdyd_kod = src.cdyd_kod
        AND tgt.prz_kod = src.prz_kod
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , semester_id
        , specialty_id
        , subject_id
        , student_id
        , subject_map_id
        , st_id
        , os_id
        , cdyd_kod
        , prz_kod
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.subject_id
        , src.student_id
        , src.subject_map_id
        , src.st_id
        , src.os_id
        , src.cdyd_kod
        , src.prz_kod
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.st_id = src.st_id
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
