MERGE INTO v2u_ko_missing_przedm_j tgt
USING
    (
        WITH u AS
        ( -- select all unmatched entries
            SELECT
                  ss_j.job_uuid
                , ss_j.subject_id
                , ss_j.specialty_id
                , ss_j.semester_id
            FROM v2u_ko_subject_semesters_j ss_j
            MINUS
            SELECT
                  ma_j.job_uuid
                , ma_j.subject_id
                , ma_j.specialty_id
                , ma_j.semester_id
            FROM v2u_ko_matched_przedm_j ma_j
        ),
        v AS
        ( -- add extra fields
            SELECT
                  u.job_uuid
                , u.subject_id
                , u.specialty_id
                , u.semester_id
                , sm_j.map_id subject_map_id
                , subject_map.map_subj_code
                , CAST(MULTISET(
                    SELECT SUBSTR(t.kod, 1, 20)
                    FROM v2u_dz_przedmioty t
                    WHERE t.kod = subject_map.map_subj_code
                  ) AS V2u_Subj_Codes_t) istniejace_prz_kody
                , subjects.subj_code
                , semesters.semester_code
            FROM u u
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = u.subject_id
                        AND subjects.job_uuid = u.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = u.semester_id
                        AND semesters.job_uuid = u.job_uuid
                    )
            LEFT JOIN v2u_ko_subject_map_j sm_j
                ON  (
                            sm_j.subject_id = u.subject_id
                        AND sm_j.specialty_id = u.specialty_id
                        AND sm_j.semester_id = u.semester_id
                        AND sm_j.job_uuid = u.job_uuid
                        AND sm_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = sm_j.map_id
                    )
        )
        SELECT
              v.*
            , CASE
                WHEN v.subject_map_id IS NULL
                THEN 'no subject map for '
                     ||
                     v.subj_code
                     || ':' ||
                     v.semester_code
                WHEN v.map_subj_code IS NULL
                THEN 'map_subj_code IS NULL for '
                     ||
                     v.subj_code
                     || ':' ||
                     v.semester_code
                WHEN (SELECT COUNT(*)
                      FROM TABLE(v.istniejace_prz_kody)) < 1
                THEN v.map_subj_code
                     ||
                    ' not in dz_przedmioty'
                ELSE 'error (v2u_ko_matched_przedm_j out of sync?)'
                END reason
        FROM v v
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
        , subject_map_id
        , map_subj_code
        , reason
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.subject_map_id
        , src.map_subj_code
        , src.reason
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.map_subj_code = src.map_subj_code
        , tgt.reason = src.reason
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
