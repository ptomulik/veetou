MERGE INTO v2u_ko_matched_proto_j tgt
USING
    (
        SELECT
              sm_j.job_uuid
            , sm_j.subject_id
            , sm_j.specialty_id
            , sm_j.semester_id
            , sm_j.map_id subject_map_id
            , sm_j.matching_score subject_matching_score
            , subject_map.map_subj_code
            , semesters.semester_code
            , protokoly.prz_kod
            , protokoly.cdyd_kod
            , protokoly.tpro_kod
            , protokoly.id prot_id
        FROM v2u_ko_subject_map_j sm_j
        INNER JOIN v2u_subject_map subject_map
            ON  (
                        subject_map.id = sm_j.map_id
                    AND subject_map.map_subj_code IS NOT NULL
                )
        INNER JOIN v2u_ko_subjects subjects
            ON  (
                        subjects.id = sm_j.subject_id
                    AND subjects.job_uuid = sm_j.job_uuid
                )
        INNER JOIN v2u_ko_semesters semesters
            ON  (
                        semesters.id = sm_j.semester_id
                    AND semesters.job_uuid = sm_j.job_uuid
                )
        INNER JOIN v2u_dz_protokoly protokoly
            ON  (
                        protokoly.prz_kod = subject_map.map_subj_code
                    AND protokoly.cdyd_kod = semesters.semester_code
                    AND protokoly.tpro_kod = COALESCE(
                          subject_map.map_proto_type
                        , V2u_Get.Tpro_Kod(
                                  subj_credit_kind => subjects.subj_credit_kind
                                , subj_grades => CAST(MULTISET(
                                    SELECT DISTINCT g_j.subj_grade
                                    FROM v2u_ko_grades_j g_j
                                    WHERE   g_j.subject_id = sm_j.subject_id
                                        AND g_j.specialty_id = sm_j.specialty_id
                                        AND g_j.semester_id = sm_j.semester_id
                                        AND g_j.job_uuid = sm_j.job_uuid
                                    ORDER BY g_j.subj_grade
                                  ) AS V2u_Subj_Grades_t)
                          )
                      )
                )
        WHERE sm_j.selected = 1
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
        , semester_id
        , specialty_id
        , subject_id
        , subject_map_id
        , subject_matching_score
        , prz_kod
        , cdyd_kod
        , tpro_kod
        , prot_id
        )
    VALUES
        ( src.job_uuid
        , src.semester_id
        , src.specialty_id
        , src.subject_id
        , src.subject_map_id
        , src.subject_matching_score
        , src.prz_kod
        , src.cdyd_kod
        , src.tpro_kod
        , src.prot_id
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.subject_matching_score = src.subject_matching_score
        , tgt.prz_kod = src.prz_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.tpro_kod = src.tpro_kod
        , tgt.prot_id = src.prot_id
;

COMMIT;
-- vim: set ft=sql ts=4 sw=4 et:
