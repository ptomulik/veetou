MERGE INTO v2u_ko_matched_trmpro_j tgt
USING
    (
        SELECT
              ma_protos_j.job_uuid
            , ma_protos_j.semester_id
            , ma_protos_j.specialty_id
            , ma_protos_j.subject_id
            , ma_protos_j.classes_type
            , ma_protos_j.subject_map_id
            , ma_protos_j.classes_map_id
            , ma_protos_j.prz_kod
            , ma_protos_j.cdyd_kod
            , ma_protos_j.tpro_kod
            , ma_protos_j.prot_id
            , CAST(SET(CAST(
                COLLECT(g_j.subj_grade_date ORDER BY g_j.subj_grade_date)
                AS V2u_Dates_t
            )) AS V2u_20Dates_t) subj_grade_dates
            , COALESCE(g_j.subj_grade_date, semesters.end_date) proto_return_date
            , trmpro.nr nr
            , trmpro.data_zwrotu

        FROM v2u_ko_matched_protos_j ma_protos_j
        INNER JOIN v2u_ko_grades_j g_j
            ON  (
                        g_j.subject_id = ma_protos_j.subject_id
                    AND g_j.specialty_id = ma_protos_j.specialty_id
                    AND g_j.semester_id = ma_protos_j.semester_id
                    AND g_j.job_uuid = ma_protos_j.job_uuid
                    AND g_j.classes_type = ma_protos_j.classes_type
                )
        INNER JOIN v2u_semesters semesters
            ON  (
                        semesters.code = ma_protos_j.cdyd_kod
                )
        INNER JOIN v2u_dz_terminy_protokolow trmpro
            ON  (
                        trmpro.prot_id = ma_protos_j.prot_id
                    AND (
                                TO_CHAR(trmpro.data_zwrotu, 'YYYY-MM-DD')
                              = TO_CHAR(COALESCE(g_j.subj_grade_date, semesters.end_date), 'YYYY-MM-DD')
                            OR (
                                        -- fallback date ...
                                        TO_CHAR(trmpro.data_zwrotu, 'YYYY-MM-DD')
                                      = TO_CHAR(semesters.end_date, 'YYYY-MM-DD')
                                    AND NOT EXISTS (
                                        SELECT NULL
                                        FROM v2u_dz_terminy_protokolow t
                                        WHERE   t.prot_id = ma_protos_j.prot_id
                                            AND TO_CHAR(t.data_zwrotu, 'YYYY-MM-DD')
                                              = TO_CHAR(g_j.subj_grade_date, 'YYYY-MM-DD')
                                    )
                                )
                        )
                )
        GROUP BY
              ma_protos_j.job_uuid
            , ma_protos_j.semester_id
            , ma_protos_j.specialty_id
            , ma_protos_j.subject_id
            , ma_protos_j.classes_type
            , ma_protos_j.subject_map_id
            , ma_protos_j.classes_map_id
            , ma_protos_j.prz_kod
            , ma_protos_j.cdyd_kod
            , ma_protos_j.tpro_kod
            , ma_protos_j.prot_id
            --, g_j.subj_grade_date
            , COALESCE(g_j.subj_grade_date, semesters.end_date)
            , trmpro.nr
            , trmpro.data_zwrotu
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.classes_type = src.classes_type
        AND tgt.proto_return_date = src.proto_return_date
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
        , nr
        , subj_grade_dates
        , proto_return_date
        , data_zwrotu
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
        , src.nr
        , src.subj_grade_dates
        , src.proto_return_date
        , src.data_zwrotu
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.classes_map_id = src.classes_map_id
        , tgt.prz_kod = src.prz_kod
        , tgt.cdyd_kod = src.cdyd_kod
        , tgt.tpro_kod = src.tpro_kod
        , tgt.prot_id = src.prot_id
        , tgt.nr = src.nr
        , tgt.subj_grade_dates = src.subj_grade_dates
        , tgt.data_zwrotu = src.data_zwrotu
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
