MERGE INTO v2u_ux_przedmioty tgt
USING
    (
        WITH u AS
        (
            SELECT
                  j1.job_uuid
                , subjects.subj_code
                , subject_map.map_subj_code
                , subject_map.map_subj_lang
                , subject_map.map_org_unit
                , subject_map.map_org_unit_recipient
                , faculties.code faculty_code
                , SET(CAST(COLLECT(subjects.subj_name) AS V2u_Vchars1024_t)) subj_names
                , CAST(COLLECT(DISTINCT j1.tried_map_subj_code) AS V2u_Vchars1024_t) tried_map_subj_codes
                , SET(CAST(COLLECT(subjects.subj_credit_kind) AS V2u_Vchars1024_t)) subj_credit_kinds
                , SET(CAST(COLLECT(grades.subj_grade) AS V2u_Vchars1024_t)) subj_grades
            FROM v2u_ko_missing_przedm_j j1
            INNER JOIN v2u_ko_subjects subjects
                ON (subjects.id = j1.subject_id AND
                    subjects.job_uuid = j1.job_uuid)
            INNER JOIN v2u_ko_specialties specialties
                ON (specialties.id = j1.specialty_id AND
                    specialties.job_uuid = j1.job_uuid)
            LEFT JOIN v2u_ko_subject_map_j j2
                ON (j2.subject_id = j1.subject_id AND
                    j2.specialty_id = j1.specialty_id AND
                    j2.semester_id = j1.semester_id AND
                    j2.job_uuid = j1.job_uuid AND
                    j2.selected = 1)
            LEFT JOIN v2u_subject_map subject_map
                ON (subject_map.id = j2.map_id)
            LEFT JOIN v2u_ko_grades_j grades
                ON (grades.subject_id = j1.subject_id AND
                    grades.specialty_id = j1.specialty_id AND
                    grades.semester_id = j1.semester_id AND
                    grades.job_uuid = j1.job_uuid)
            LEFT JOIN v2u_faculties faculties
                ON (faculties.abbriev = specialties.faculty)
            GROUP BY
                  j1.job_uuid
                , subjects.subj_code
                , subject_map.map_subj_code
                , subject_map.map_subj_lang
                , subject_map.map_org_unit
                , subject_map.map_org_unit_recipient
                , faculties.code
        ),
        v AS
        (
            SELECT
                  u.job_uuid
                , u.subj_code
                , u.map_subj_code
                , u.map_subj_lang
                , u.map_org_unit
                , u.map_org_unit_recipient
                , u.faculty_code
                , (SELECT COUNT(*) FROM TABLE(u.subj_names)) subj_names_count
                , (SELECT COUNT(*) FROM TABLE(u.tried_map_subj_codes)) tried_map_subj_codes_count
                , (SELECT COUNT(*) FROM TABLE(u.subj_credit_kinds)) subj_credit_kinds_count
                , (SELECT SUBSTR(VALUE(t), 1, 200) FROM TABLE(u.subj_names) t WHERE ROWNUM <= 1) subj_name
                , (SELECT SUBSTR(VALUE(t), 1, 16) FROM TABLE(u.subj_credit_kinds) t WHERE ROWNUM <= 1) subj_credit_kind
                , CAST(MULTISET(SELECT SUBSTR(VALUE(t), 1, 10) FROM TABLE(u.subj_grades) t WHERE ROWNUM <= 20) AS V2u_Subj_Grades_t) subj_grades
            FROM u u
        )
        SELECT
              v.job_uuid
            , CASE
                WHEN
                        v.map_subj_code IS NOT NULL
                    AND v.subj_names_count = 1
                    AND v.tried_map_subj_codes_count = 1
                    AND v.subj_credit_kinds_count = 1
                THEN 1
                ELSE 0
                END safe_to_add
            , COALESCE(v.map_subj_code, v.subj_code) kod
            , v.subj_name nazwa
            , COALESCE(v.map_org_unit, v.faculty_code) jed_org_kod
            , V2u_Get.Tpro_Kod(
                      subj_credit_kind => v.subj_credit_kind
                    , subj_grades => v.subj_grades
              ) tpro_kod
            , COALESCE(v.map_org_unit_recipient, v.faculty_code) jed_org_kod_biorca
            , v.map_subj_lang jzk_kod
        FROM v v
    ) src
ON  (tgt.kod = src.kod AND
     tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT
        ( kod
        , job_uuid
        , nazwa
        , jed_org_kod
        , tpro_kod
        , jed_org_kod_biorca
        , safe_to_add
        )
    VALUES
        ( src.kod
        , src.job_uuid
        , src.nazwa
        , src.jed_org_kod
        , src.tpro_kod
        , src.jed_org_kod_biorca
        , src.safe_to_add
        )
WHEN MATCHED THEN UPDATE SET
          tgt.nazwa = src.nazwa
        , tgt.jed_org_kod = src.jed_org_kod
        , tgt.tpro_kod = src.tpro_kod
        , tgt.jed_org_kod_biorca = src.jed_org_kod_biorca
        , tgt.safe_to_add = src.safe_to_add
;
-- vim: set ft=sql ts=4 sw=4 et:
