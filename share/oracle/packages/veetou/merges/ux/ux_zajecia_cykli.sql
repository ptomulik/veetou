MERGE INTO v2u_ux_zajecia_cykli tgt
USING
    (
        WITH u AS
        (
            SELECT
                  cs_j.job_uuid
                , COALESCE(subject_map.map_subj_code, subjects.subj_code) prz_kod
                , semesters.semester_code cdyd_kod
                , classes_map.map_classes_type tzaj_kod
                , SET(CAST(
                        COLLECT(COALESCE(ma_j.classes_hours, mi_j.classes_hours))
                        AS V2u_Integers_t
                  )) classes_hours_set
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
                , COUNT(ma_j.job_uuid) dbg_matched -- count non-null mappings
                , COUNT(mi_j.job_uuid) dbg_missing -- count non-null mappings
                , COUNT(sm_j.map_id) dbg_subject_mapped
                , COUNT(cm_j.map_id) dbg_classes_mapped

            FROM v2u_ko_classes_semesters_j cs_j
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = cs_j.subject_id
                        AND subjects.job_uuid = cs_j.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = cs_j.semester_id
                        AND semesters.job_uuid = cs_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_zajcykl_j ma_j
                ON  (
                            ma_j.subject_id = cs_j.subject_id
                        AND ma_j.specialty_id = cs_j.specialty_id
                        AND ma_j.semester_id = cs_j.semester_id
                        AND ma_j.job_uuid = cs_j.job_uuid
                        AND ma_j.classes_type = cs_j.classes_type
                    )
            LEFT JOIN v2u_ko_missing_zajcykl_j mi_j
                ON  (
                            mi_j.subject_id = cs_j.subject_id
                        AND mi_j.specialty_id = cs_j.specialty_id
                        AND mi_j.semester_id = cs_j.semester_id
                        AND mi_j.job_uuid = cs_j.job_uuid
                        AND mi_j.classes_type = cs_j.classes_type
                    )
            LEFT JOIN v2u_ko_classes_map_j cm_j
                ON  (
                            cm_j.subject_id = cs_j.subject_id
                        AND cm_j.specialty_id = cs_j.specialty_id
                        AND cm_j.semester_id = cs_j.semester_id
                        AND cm_j.job_uuid = cs_j.job_uuid
                        AND cm_j.classes_type = cs_j.classes_type
                        AND cm_j.selected = 1
                    )
            LEFT JOIN v2u_classes_map classes_map
                ON  (
                            classes_map.id = cm_j.map_id
                    )
            LEFT JOIN v2u_ko_subject_map_j sm_j
                ON  (
                            sm_j.subject_id = cs_j.subject_id
                        AND sm_j.specialty_id = cs_j.specialty_id
                        AND sm_j.semester_id = cs_j.semester_id
                        AND sm_j.job_uuid = cs_j.job_uuid
                        AND sm_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = sm_j.map_id
                    )
            LEFT JOIN v2u_ko_grades_j grades
                ON  (
                            grades.subject_id = cs_j.subject_id
                        AND grades.specialty_id = cs_j.specialty_id
                        AND grades.semester_id = cs_j.semester_id
                        AND grades.job_uuid = cs_j.job_uuid
                    )
            GROUP BY
                  cs_j.job_uuid
                , COALESCE(subject_map.map_subj_code, subjects.subj_code)
                , semesters.semester_code
                , classes_map.map_classes_type
        ),
        v AS
        (
            SELECT
                  u.job_uuid
                , u.prz_kod
                , u.cdyd_kod
                , u.tzaj_kod
                , ( SELECT SUBSTR(VALUE(t), 1, 16)
                    FROM TABLE(u.classes_hours_set) t
                    WHERE ROWNUM <= 1
                  ) classes_hours
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
                    FROM TABLE(u.classes_hours_set)
                  ) dbg_classes_hours
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
                , u.dbg_subject_mapped
                , u.dbg_classes_mapped
            FROM u u
        )
        SELECT
              v.job_uuid
            , v.prz_kod
            , v.cdyd_kod
            , v.tzaj_kod
            , v.classes_hours liczba_godz
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
                    AND v.dbg_subject_mapped = v.dbg_missing
                    AND v.dbg_classes_mapped = v.dbg_missing
                    -- all the instances were consistent
                    AND v.dbg_classes_hours = 1
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
            , v.dbg_classes_hours
            , v.dbg_subj_credit_kinds
            , v.dbg_matched
            , v.dbg_missing
            , v.dbg_subject_mapped
            , v.dbg_classes_mapped
        FROM v v
    ) src
ON  (
            tgt.prz_kod = src.prz_kod
        AND tgt.cdyd_kod = src.cdyd_kod
        AND tgt.tzaj_kod = src.tzaj_kod
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( prz_kod
        , cdyd_kod
        , tzaj_kod
        , job_uuid
        , liczba_godz
        , tpro_kod
        , dbg_subj_codes
        , dbg_map_subj_codes
        , dbg_classes_hours
        , dbg_subj_credit_kinds
        , dbg_matched
        , dbg_missing
        , dbg_subject_mapped
        , dbg_classes_mapped
        , safe_to_add
        )
    VALUES
        ( src.prz_kod
        , src.cdyd_kod
        , src.tzaj_kod
        , src.job_uuid
        , src.liczba_godz
        , src.tpro_kod
        , src.dbg_subj_codes
        , src.dbg_map_subj_codes
        , src.dbg_classes_hours
        , src.dbg_subj_credit_kinds
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_subject_mapped
        , src.dbg_classes_mapped
        , src.safe_to_add
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.liczba_godz = src.liczba_godz
        , tgt.tpro_kod = src.tpro_kod
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_classes_hours = src.dbg_classes_hours
        , tgt.dbg_subj_credit_kinds = src.dbg_subj_credit_kinds
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_subject_mapped = src.dbg_subject_mapped
        , tgt.dbg_classes_mapped = src.dbg_classes_mapped
        , tgt.safe_to_add = src.safe_to_add
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
