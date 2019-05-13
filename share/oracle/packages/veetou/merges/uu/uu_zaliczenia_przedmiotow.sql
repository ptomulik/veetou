MERGE INTO v2u_uu_zaliczenia_przedmiotow tgt
USING
    (
        WITH u_00 AS
        (
            SELECT
                  g_j.job_uuid
                , g_j.student_id
                , g_j.subject_id
                , g_j.specialty_id
                , g_j.semester_id
                , COALESCE(ma_zalprz_j.os_id, mi_zalprz_j.os_id) os_id
                , COALESCE(ma_zalprz_j.cdyd_kod, mi_zalprz_j.semester_code) cdyd_kod
                , COALESCE(ma_zalprz_j.prz_kod, mi_zalprz_j.map_subj_code) prz_kod
                , COALESCE(ma_zalprz_j.subject_map_id, mi_zalprz_j.subject_map_id) subject_map_id
                , ma_zalprz_j.student_id ma_student_id
                , mi_zalprz_j.student_id mi_student_id
                , CASE
                    WHEN ma_zalprz_j.student_id IS NOT NULL
                    THEN '{os_id: "' ||
                        ma_zalprz_j.os_id
                        || '", cdyd_kod: "' ||
                        ma_zalprz_j.cdyd_kod
                        || '", prz_kod: "' ||
                        ma_zalprz_j.prz_kod
                        || '"}'
                    WHEN mi_zalprz_j.student_id IS NOT NULL
                    THEN '{student: "' ||
                        students.student_index
                        || '", subject: "' ||
                        COALESCE(mi_zalprz_j.map_subj_code, subjects.subj_code)
                        || '", semester: "' ||
                        mi_zalprz_j.semester_code
                        || '"}'
                    ELSE
                  END pk_zalicz_przedmiotu


            FROM v2u_ko_grades_j g_j
            INNER JOIN v2u_ko_students students
                ON  (
                            students.id = g_j.student_id
                        AND students.job_uuid = g_j.job_uuid
                    )
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = g_j.subject_id
                        AND subjects.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_zalprz_j ma_zalprz_j
                ON (
                            ma_zalprz_j.student_id = g_j.student_id
                        AND ma_zalprz_j.subject_id = g_j.subject_id
                        AND ma_zalprz_j.specialty_id = g_j.specialty_id
                        AND ma_zalprz_j.semester_id = g_j.semester_id
                        AND ma_zalprz_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_zalprz_j mi_zalprz_j
                ON  (
                            mi_zalprz_j.student_id = g_j.student_id
                        AND mi_zalprz_j.subject_id = g_j.subject_id
                        AND mi_zalprz_j.specialty_id = g_j.specialty_id
                        AND mi_zalprz_j.semester_id = g_j.semester_id
                        AND mi_zalprz_j.job_uuid = g_j.job_uuid
                    )
    --        INNER JOIN v2u_ko_matched_przcykl_j ma_przcykl_j
    --            ON (ma_przcykl_j.subject_id = g_j.subject_id AND
    --                ma_przcykl_j.specialty_id = g_j.specialty_id AND
    --                ma_przcykl_j.semester_id = g_j.semester_id AND
    --                ma_przcykl_j.job_uuid = g_j.job_uuid)
        ),
        u_0 AS
        (
            -- determine what to use as a single output row...
            SELECT
                  u_00.job_uuid
                , u_00.pk_zalicz_przedmiotu
                , SET(CAST(COLLECT(u_00.os_id) AS V2u_Dz_Ids_t)) os_ids
                , SET(CAST(COLLECT(u_00.cdyd_kod) AS V2u_Vchars1K_t)) cdyd_kody1k
                , SET(CAST(COLLECT(u_00.prz_kod) AS V2u_Vchars1K_t)) prz_kody1k

                -- DBG
                  -- "+ 0" trick is used to workaround oracle bug
                , COUNT(u_0.ma_student_id + 0) dbg_matched
                , COUNT(u_0.mi_student_id + 0) dbg_missing
            FROM u_00 u_00
            GROUP BY
                  u_00.job_uuid
                , u_00.pk_zalicz_przedmiotu
        ),
        u AS
        (
            SELECT
                  u_0.job_uuid
                , u_0.pk_zalicz_przedmiotu
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.os_ids)
                    WHERE ROWNUM <= 1
                  ) os_id
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.cdyd_kody1k) t
                    WHERE ROWNUM <= 1
                  ) cdyd_kod
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.prz_kody1k) t
                    WHERE ROWNUM <= 1
                  ) prz_kod

                -- DBG

                , u_0.dbg_matched
                , u_0.dbg_missing
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.os_ids)
                  ) dbg_os_id
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.cdyd_kody1k)
                  ) dbg_cdyd_kod
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.prz_kody1k)
                  ) dbg_prz_kod
            FROM u_0 u_0
        )

        SELECT
            , 'X' status_rej
            , 'X' status_zal
            , ma_przcykl_j.cdyd_kod
            , ma_przcykl_j.prz_kod
            , COUNT(ma_przcykl_j.student_id + 0) dbg_matched
            , COUNT(mi_przcykl_j.student_id + 0) dbg_missing

        FROM v2u_ko_grades_j g_j
    ) src
ON  (
        tgt.pk_zalicz_przedmiotu = src.pk_zalicz_przedmiotu
    )
WHEN NOT MATCHED THEN
    INSERT
        ( status_rej
--        , opis_statusu_rej
        , status_zal
 --       , opis_statusu_zal
--        , suma_ocen
--        , liczba_ocen
        , os_id
        , cdyd_kod
        , prz_kod
--        , utw_data
--        , utw_id
--        , mod_id
--        , mod_data
--        , nr_wyb
        )
    VALUES
        ( src.status_rej
--        , src.opis_statusu_rej
        , src.status_zal
--        , src.opis_statusu_zal
--        , src.suma_ocen
--        , src.liczba_ocen
        , src.os_id
        , src.cdyd_kod
        , src.prz_kod
--        , src.utw_data
--        , src.utw_id
--        , src.mod_id
--        , src.mod_data
--        , src.nr_wyb
        )
WHEN MATCHED THEN UPDATE SET
          tgt.status_rej = src.status_rej
--        , tgt.opis_statusu_rej = src.opis_statusu_rej
        , tgt.status_zal = src.status_zal
--        , tgt.opis_statusu_zal = src.opis_statusu_zal
--        , tgt.suma_ocen = src.suma_ocen
--        , tgt.liczba_ocen = src.liczba_ocen
--        , tgt.utw_data = src.utw_data
--        , tgt.utw_id = src.utw_id
--        , tgt.mod_id = src.mod_id
--        , tgt.mod_data = src.mod_data
--        , tgt.nr_wyb = src.nr_wyb
;

-- COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
