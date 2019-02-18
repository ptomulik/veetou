MERGE INTO v2u_ko_missing_przedm_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  ss_j.job_uuid job_uuid
                , ss_j.subject_id subject_id
                , ss_j.specialty_id specialty_id
                , ss_j.semester_id semester_id
                , COUNT(DISTINCT sm_j.map_id) subject_maps_count
                , COUNT(DISTINCT subject_map.map_subj_code) map_subj_codes_count
                , MIN(subjects.subj_code) KEEP (
                        DENSE_RANK FIRST ORDER BY subjects.subj_code
                  ) subj_code
                , MIN(semesters.semester_code) KEEP (
                        DENSE_RANK FIRST ORDER BY semesters.semester_code
                  ) semester_code
                , MIN(subject_map.map_subj_code) KEEP (
                        DENSE_RANK FIRST ORDER BY subject_map.map_subj_code
                  ) tried_map_subj_code
                , COUNT(DISTINCT przedmioty.kod) istniejacy_prz_kod_count
            FROM v2u_ko_subject_semesters_j ss_j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = ss_j.subject_id
                        AND subjects.job_uuid = ss_j.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = ss_j.subject_id
                        AND semesters.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_przedm_j ma_przedm_j
                ON  (
                            ma_przedm_j.subject_id = ss_j.subject_id
                        AND ma_przedm_j.specialty_id = ss_j.specialty_id
                        AND ma_przedm_j.semester_id = ss_j.semester_id
                        AND ma_przedm_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_subject_map_j sm_j
                ON  (
                            sm_j.subject_id = ss_j.subject_id
                        AND sm_j.specialty_id = ss_j.specialty_id
                        AND sm_j.semester_id = ss_j.semester_id
                        AND sm_j.job_uuid = ss_j.job_uuid
                        AND sm_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = sm_j.map_id
                    )
            -- join dz_przedmioty again to find whether we really can't find
            -- such a przedmiot
            LEFT JOIN dz_przedmioty przedmioty
                ON  (
                            przedmioty.kod = subject_map.map_subj_code
                    )
            WHERE ma_przedm_j.id IS NULL
            GROUP BY
                  ss_j.job_uuid
                , ss_j.subject_id
                , ss_j.specialty_id
                , ss_j.semester_id
        )
        SELECT
              u.job_uuid job_uuid
            , u.subject_id subject_id
            , u.specialty_id specialty_id
            , u.semester_id semester_id
            , CASE
                WHEN u.subject_maps_count <> 1
                THEN TO_CHAR(u.subject_maps_count)
                     ||
                     ' suitable subject map(s) for '
                     ||
                     u.subj_code
                     || ':' ||
                     u.semester_code
                WHEN u.map_subj_codes_count <> 1
                THEN TO_CHAR(u.map_subj_codes_count)
                     ||
                     ' non-null map_subj_code(s) for '
                     ||
                     u.subj_code
                     || ':' ||
                     u.semester_code
                WHEN u.istniejacy_prz_kod_count < 1
                THEN u.tried_map_subj_code
                     ||
                     ' not in dz_przedmioty'
                ELSE 'error (v2u_ko_matched_przedm_j out of sync?)'
                END reason
            , u.tried_map_subj_code tried_map_subj_code
        FROM u u
    ) src
ON  (       tgt.job_uuid = src.job_uuid
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , subject_id
        , specialty_id
        , semester_id
        , reason
        , tried_map_subj_code
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.reason
        , src.tried_map_subj_code
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.reason = src.reason
        , tgt.tried_map_subj_code = src.tried_map_subj_code
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
