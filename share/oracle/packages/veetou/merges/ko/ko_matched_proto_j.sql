MERGE INTO v2u_ko_matched_proto_j tgt
USING
    (
        WITH classes_types AS
        (
            SELECT VALUE(t) classes_type
            FROM TABLE(V2u_Chars1_t('-', 'W', 'C', 'L', 'P', 'S')) t
        ),
        u AS
        (
            SELECT
                  sm_j.job_uuid
                , sm_j.subject_id
                , sm_j.specialty_id
                , sm_j.semester_id
                , sm_j.map_id subject_map_id
                , classes_types.classes_type
                , ma_zajcykl_j.zaj_cyk_id
                , ma_zajcykl_j.classes_map_id
                , SET(CAST(
                        COLLECT(g_j.subj_grade ORDER BY g_j.subj_grade)
                        AS V2u_Vchars1K_t
                  )) subj_grades1k
            FROM v2u_ko_subject_map_j sm_j
            CROSS JOIN classes_types
            INNER JOIN v2u_ko_grades_j g_j
                ON  (
                            g_j.subject_id = sm_j.subject_id
                        AND g_j.specialty_id = sm_j.specialty_id
                        AND g_j.semester_id = sm_j.semester_id
                        AND g_j.classes_type = classes_types.classes_type
                        AND g_j.job_uuid = sm_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_zajcykl_j ma_zajcykl_j
                ON  (
                            ma_zajcykl_j.subject_id = sm_j.subject_id
                        AND ma_zajcykl_j.specialty_id = sm_j.specialty_id
                        AND ma_zajcykl_j.semester_id = sm_j.semester_id
                        AND ma_zajcykl_j.classes_type = classes_types.classes_type
                        AND ma_zajcykl_j.job_uuid = sm_j.job_uuid
                    )
            WHERE sm_j.selected = 1
            GROUP BY
                  sm_j.job_uuid
                , sm_j.subject_id
                , sm_j.specialty_id
                , sm_j.semester_id
                , sm_j.map_id
                , classes_types.classes_type
                , ma_zajcykl_j.zaj_cyk_id
                , ma_zajcykl_j.classes_map_id
            HAVING COUNT(g_j.subj_grade) > 0
        )
        SELECT
              u.*
            , protokoly.prz_kod
            , protokoly.cdyd_kod
            , protokoly.tpro_kod
            , protokoly.id prot_id
        FROM u u
        INNER JOIN v2u_subject_map subject_map
            ON  (
                        subject_map.id = u.subject_map_id
                    AND subject_map.map_subj_code IS NOT NULL
                )
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
        INNER JOIN v2u_dz_protokoly protokoly
            ON  (
                        protokoly.prz_kod = subject_map.map_subj_code
                    AND protokoly.cdyd_kod = semesters.semester_code
                    AND protokoly.tpro_kod = COALESCE(
                          subject_map.map_proto_type
                        , V2u_Get.Tpro_Kod(
                                  subj_credit_kind => subjects.subj_credit_kind
                                , subj_grades => CAST(MULTISET(
                                        SELECT SUBSTR(VALUE(t), 1, 10)
                                        FROM TABLE(u.subj_grades1k) t
                                  ) AS V2u_Subj_Grades_t)
                          )
                        )
                    AND (
                                protokoly.zaj_cyk_id = u.zaj_cyk_id
                            OR  (u.classes_type = '-' AND protokoly.zaj_cyk_id IS NULL)
                        )
                )
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.classes_type = src.classes_type
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , semester_id
        , specialty_id
        , subject_id
        , classes_type
        , subject_map_id
        , classes_map_id
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
        , src.classes_type
        , src.subject_map_id
        , src.classes_map_id
        , src.prz_kod
        , src.cdyd_kod
        , src.tpro_kod
        , src.prot_id
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.classes_map_id = src.classes_map_id
        , tgt.prz_kod = src.prz_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.tpro_kod = src.tpro_kod
        , tgt.prot_id = src.prot_id
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
