-- FIXME: It may appear, although rather shouldn't, that two subj_codes
-- are mapped into a single map_subj_code providing different class_hours
-- to a single mapped subject on semester. This is not currently detected.
MERGE INTO v2u_ux_zajecia_cykli tgt
USING
    (
        WITH u AS
        (
            SELECT
                  j1.job_uuid
                , j1.classes_type
                , j1.tried_map_subj_code
                , j1.tried_map_classes_type
                , j1.classes_hours
                , subjects.subj_code
                , semesters.semester_code
                , SET(CAST(COLLECT(subjects.subj_credit_kind) AS V2u_Vchars1024_t)) subj_credit_kinds
                , SET(CAST(COLLECT(grades.subj_grade) AS V2u_Vchars1024_t)) subj_grades
            FROM v2u_ko_missing_zajcykl_j j1
            INNER JOIN v2u_ko_subjects subjects
                ON (subjects.id = j1.subject_id AND
                    subjects.job_uuid = j1.job_uuid)
            INNER JOIN v2u_ko_semesters semesters
                ON (semesters.id = j1.semester_id AND
                    semesters.job_uuid = j1.job_uuid)
            LEFT JOIN v2u_ko_grades_j grades
                ON (grades.subject_id = j1.subject_id AND
                    grades.specialty_id = j1.specialty_id AND
                    grades.semester_id = j1.semester_id AND
                    grades.job_uuid = j1.job_uuid)
            GROUP BY
                  j1.job_uuid
                , j1.classes_type
                , j1.tried_map_subj_code
                , j1.tried_map_classes_type
                , j1.classes_hours
                , subjects.subj_code
                , semesters.semester_code
        ),
        v AS
        (
            SELECT
                  u.job_uuid
                , u.classes_type
                , u.classes_hours
                , u.subj_code
                , u.semester_code
                , u.tried_map_subj_code
                , u.tried_map_classes_type
                , ( SELECT COUNT(*)
                    FROM TABLE(u.subj_credit_kinds)
                  ) subj_credit_kinds_count
                , ( SELECT SUBSTR(VALUE(t), 1, 16)
                    FROM TABLE(u.subj_credit_kinds) t
                    WHERE ROWNUM <= 1
                  ) subj_credit_kind
                , CAST(MULTISET(
                    SELECT SUBSTR(VALUE(t), 1, 10)
                    FROM TABLE(u.subj_grades) t
                  ) AS V2u_Subj_Grades_t) subj_grades
            FROM u u
        )
        SELECT
              v.job_uuid
            , CASE
                WHEN
                        v.tried_map_subj_code IS NOT NULL
                    AND v.tried_map_classes_type IS NOT NULL
                    AND v.subj_credit_kinds_count = 1
                    AND V2u_Get.Tpro_Kod(
                          subj_credit_kind => v.subj_credit_kind
                        , subj_grades => v.subj_grades
                        ) <> '?'
                THEN 1
                ELSE 0
                END safe_to_add
            , COALESCE(v.tried_map_subj_code, v.subj_code) prz_kod
            , v.semester_code cdyd_kod
            , COALESCE(v.tried_map_classes_type, '???') tzaj_kod
            , v.classes_hours liczba_godz
            , V2u_Get.Tpro_Kod(
                      subj_credit_kind => v.subj_credit_kind
                    , subj_grades => v.subj_grades
              ) tpro_kod
        FROM v v
    ) src
ON  (tgt.prz_kod = src.prz_kod AND
     tgt.cdyd_kod = src.cdyd_kod AND
     tgt.tzaj_kod = src.tzaj_kod AND
     tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT
        ( prz_kod
        , cdyd_kod
        , tzaj_kod
        , job_uuid
        , liczba_godz
        , tpro_kod
        , safe_to_add
        )
    VALUES
        ( src.prz_kod
        , src.cdyd_kod
        , src.tzaj_kod
        , src.job_uuid
        , src.liczba_godz
        , src.tpro_kod
        , src.safe_to_add
        )
WHEN MATCHED THEN UPDATE SET
          tgt.liczba_godz = src.liczba_godz
        , tgt.tpro_kod = src.tpro_kod
        , tgt.safe_to_add = src.safe_to_add
;
-- vim: set ft=sql ts=4 sw=4 et:
