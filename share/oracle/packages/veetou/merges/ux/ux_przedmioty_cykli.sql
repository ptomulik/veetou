MERGE INTO v2u_ux_przedmioty_cykli tgt
USING
    (
        WITH u AS
        (
            SELECT
                  ss_j.job_uuid
                , COALESCE(subject_map.map_subj_code, subjects.subj_code) prz_kod
                , semesters.semester_code
                , SET(CAST(
                        COLLECT(subjects.subj_code)
                        AS V2u_Vchars1024_t
                  )) subj_codes
                , SET(CAST(
                        COLLECT(subject_map.map_subj_code)
                        AS V2u_Vchars1024_t
                  )) map_subj_codes
                , SET(CAST(
                        COLLECT(subjects.subj_credit_kind)
                        AS V2u_Vchars1024_t
                  )) subj_credit_kinds
                , SET(CAST(
                        COLLECT(grades.subj_grade)
                        AS V2u_Vchars1024_t
                  )) subj_grades
                , COUNT(ma_j.id) dbg_matched
                , COUNT(mi_j.id) dbg_missing
                , COUNT(sm_j.map_id) dbg_mapped

            FROM v2u_ko_subject_semesters_j ss_j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = ss_j.subject_id
                        AND subjects.job_uuid = ss_j.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = ss_j.semester_id
                        AND semesters.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_przcykl_j ma_j
                ON  (
                            ma_j.subject_id = ss_j.subject_id
                        AND ma_j.specialty_id = ss_j.specialty_id
                        AND ma_j.semester_id = ss_j.semester_id
                        AND ma_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_przcykl_j mi_j
                ON  (
                            mi_j.subject_id = ss_j.subject_id
                        AND mi_j.specialty_id = ss_j.specialty_id
                        AND mi_j.semester_id = ss_j.semester_id
                        AND mi_j.job_uuid = ss_j.job_uuid
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
            LEFT JOIN v2u_ko_grades_j grades
                ON  (
                            grades.subject_id = ss_j.subject_id
                        AND grades.specialty_id = ss_j.specialty_id
                        AND grades.semester_id = ss_j.semester_id
                        AND grades.job_uuid = ss_j.job_uuid
                    )
            GROUP BY
                  ss_j.job_uuid
                , COALESCE(subject_map.map_subj_code, subjects.subj_code)
                , semesters.semester_code
        ),
        v AS
        (
            SELECT
                  u.job_uuid
                , u.prz_kod
                , u.semester_code
                , ( SELECT SUBSTR(VALUE(t), 1, 16)
                    FROM TABLE(u.subj_credit_kinds) t
                    WHERE ROWNUM <= 1
                  ) subj_credit_kind
                , CAST(MULTISET(
                    SELECT SUBSTR(VALUE(t), 1, 10)
                    FROM TABLE(u.subj_grades) t
                  ) AS V2u_Subj_Grades_t) subj_grades

                -- columns used for debugging
                , ( SELECT COUNT(*)
                    FROM TABLE(u.subj_codes)
                  ) dbg_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u.map_subj_codes)
                  ) dbg_map_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u.subj_credit_kinds)
                  ) dbg_subj_credit_kinds

                , u.dbg_matched
                , u.dbg_missing
                , u.dbg_mapped
            FROM u u
        )
        SELECT
              v.job_uuid
            , v.prz_kod
            , v.semester_code cdyd_kod
            , V2u_Get.Utw_Id(v.job_uuid) utw_id
            , V2u_Get.Mod_Id(v.job_uuid) mod_id
            , V2u_Get.Tpro_Kod(
                      subj_credit_kind => v.subj_credit_kind
                    , subj_grades => v.subj_grades
              ) tpro_kod

            , CASE
                WHEN
                    -- ensure that
                    -- we have target subject code
                        v.dbg_map_subj_codes = 1
                    AND v.dbg_subj_codes > 0
                    -- maps for all instances existed but there were no
                    -- corresponding subject in target system
                    AND v.dbg_matched = 0
                    AND v.dbg_missing > 0
                    AND v.dbg_mapped = v.dbg_missing
                    -- all the instances were consistent
                    AND v.dbg_subj_credit_kinds = 1
                    -- and we have correct tpro_kod value
                    AND V2u_Get.Tpro_Kod(
                          subj_credit_kind => v.subj_credit_kind
                        , subj_grades => v.subj_grades
                        ) <> '?'
                THEN 1
                ELSE 0
                END safe_to_add

            , v.dbg_subj_codes
            , v.dbg_map_subj_codes
            , v.dbg_subj_credit_kinds
            , v.dbg_matched
            , v.dbg_missing
            , v.dbg_mapped
        FROM v v
    ) src
ON  (
            tgt.prz_kod = src.prz_kod
        AND tgt.cdyd_kod = src.cdyd_kod
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( prz_kod
        , cdyd_kod
        , utw_id
        , mod_id
        , job_uuid
        , tpro_kod
        , dbg_subj_codes
        , dbg_map_subj_codes
        , dbg_subj_credit_kinds
        , dbg_matched
        , dbg_missing
        , dbg_mapped
        , safe_to_add
        )
    VALUES
        ( src.prz_kod
        , src.cdyd_kod
        , src.utw_id
        , src.mod_id
        , src.job_uuid
        , src.tpro_kod
        , src.dbg_subj_codes
        , src.dbg_map_subj_codes
        , src.dbg_subj_credit_kinds
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_mapped
        , src.safe_to_add
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.utw_id = src.utw_id
        , tgt.mod_id = src.mod_id
        , tgt.tpro_kod = src.tpro_kod
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_subj_credit_kinds = src.dbg_subj_credit_kinds
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_mapped = src.dbg_mapped
        , tgt.safe_to_add = src.safe_to_add
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
