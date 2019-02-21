MERGE INTO v2u_ko_missing_przcykl_j tgt
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
                , CAST(COLLECT(przedmioty_cykli.cdyd_kod) AS V2u_Vchars1K_t) istniejace_cdyd_kody
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
            LEFT JOIN v2u_ko_matched_przcykl_j ma_przcykl_j
                ON  (
                            ma_przcykl_j.subject_id = ss_j.subject_id
                        AND ma_przcykl_j.specialty_id = ss_j.specialty_id
                        AND ma_przcykl_j.semester_id = ss_j.semester_id
                        AND ma_przcykl_j.job_uuid = ss_j.job_uuid
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
            -- join v2u_dz_przedmioty cykli without semester to find out what other
            -- semesters we have reached at the destination
            LEFT JOIN v2u_dz_przedmioty_cykli przedmioty_cykli
                ON  (
                            przedmioty_cykli.prz_kod = subject_map.map_subj_code
                    )
            WHERE ma_przcykl_j.id IS NULL
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
                WHEN (SELECT COUNT(*) FROM TABLE(u.istniejace_cdyd_kody)) < 1
                THEN u.tried_map_subj_code
                     || ':*' ||
                    ' not in dz_przedmioty_cykli'
                WHEN (SELECT COUNT(*)
                      FROM TABLE(u.istniejace_cdyd_kody) t
                      WHERE VALUE(t) = u.semester_code) < 1
                THEN
                     u.tried_map_subj_code
                     || ':' ||
                     u.semester_code
                     ||
                     ' not in dz_przedmioty_cykli'
                ELSE 'error (v2u_ko_matched_przcykl_j out of sync?)'
                END reason
            , u.tried_map_subj_code tried_map_subj_code
            , CAST(MULTISET(
                    SELECT DISTINCT SUBSTR(VALUE(t), 1, 5)
                    FROM TABLE(u.istniejace_cdyd_kody) t
              ) AS V2u_Semester_Codes_t) istniejace_cdyd_kody
        FROM u u
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
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
        , istniejace_cdyd_kody
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.reason
        , src.tried_map_subj_code
        , src.istniejace_cdyd_kody
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.reason = src.reason
        , tgt.tried_map_subj_code = src.tried_map_subj_code
        , tgt.istniejace_cdyd_kody = src.istniejace_cdyd_kody
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
