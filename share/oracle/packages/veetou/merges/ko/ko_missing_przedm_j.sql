MERGE INTO v2u_ko_missing_przedm_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  j1.job_uuid job_uuid
                , j1.subject_id subject_id
                , j1.specialty_id specialty_id
                , j1.semester_id semester_id
                , COUNT(DISTINCT j3.map_id) subject_maps_count
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
            FROM v2u_ko_subject_semesters_j j1
            INNER JOIN v2u_ko_subjects subjects
                ON (subjects.id = j1.subject_id AND
                    subjects.job_uuid = j1.job_uuid)
            INNER JOIN v2u_ko_semesters semesters
                ON (semesters.id = j1.subject_id AND
                    semesters.job_uuid = j1.job_uuid)
            LEFT JOIN v2u_ko_matched_przedm_j j2
                ON (j2.subject_id = j1.subject_id AND
                    j2.specialty_id = j1.specialty_id AND
                    j2.semester_id = j1.semester_id AND
                    j2.job_uuid = j1.job_uuid)
            LEFT JOIN v2u_ko_subject_map_j j3
                ON (j3.subject_id = j1.subject_id AND
                    j3.specialty_id = j1.specialty_id AND
                    j3.semester_id = j1.semester_id AND
                    j3.job_uuid = j1.job_uuid AND
                    j3.selected = 1)
            LEFT JOIN v2u_subject_map subject_map
                ON (subject_map.id = j3.map_id)
            -- join dz_przedmioty again to find whether we really can't find
            -- such a przedmiot
            LEFT JOIN v2u_dz_przedmioty przedmioty
                ON (przedmioty.kod = subject_map.map_subj_code)
            WHERE j2.id IS NULL
            GROUP BY
                  j1.job_uuid
                , j1.subject_id
                , j1.specialty_id
                , j1.semester_id
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
                     ' not in v2u_dz_przedmioty'
                ELSE 'error (v2u_ko_matched_przedm_j out of sync?)'
                END reason
            , u.tried_map_subj_code tried_map_subj_code
        FROM u u
    ) src
ON  (tgt.job_uuid = src.job_uuid AND
     tgt.subject_id = src.subject_id AND
     tgt.specialty_id = src.specialty_id AND
     tgt.semester_id = src.semester_id)
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
WHEN MATCHED THEN UPDATE SET
      tgt.reason = src.reason
    , tgt.tried_map_subj_code = src.tried_map_subj_code
;
-- vim: set ft=sql ts=4 sw=4 et:
