MERGE INTO v2u_ux_przedmioty tgt
USING
    (
        WITH u AS
        (
            SELECT
                  ss_j.job_uuid
                , COALESCE(subject_map.map_subj_code, subjects.subj_code) kod
                , SET(CAST(
                        COLLECT(subjects.subj_code)
                        AS V2u_Vchars1024_t
                  )) subj_codes
                , SET(CAST(
                        COLLECT(subject_map.map_subj_code)
                        AS V2u_Vchars1024_t
                  )) map_subj_codes
                , SET(CAST(
                        COLLECT(subject_map.map_subj_lang)
                        AS V2u_Vchars1024_t
                  )) map_subj_languages
                , SET(CAST(
                        COLLECT(subject_map.map_org_unit)
                        AS V2u_Vchars1024_t
                  )) map_org_units
                , SET(CAST(
                        COLLECT(subject_map.map_org_unit_recipient)
                        AS V2u_Vchars1024_t
                  )) map_org_unit_recipients
                , SET(CAST(
                        COLLECT(faculties.code)
                        AS V2u_Vchars1024_t
                  )) faculty_codes
                , SET(CAST(
                        COLLECT(subjects.subj_name)
                        AS V2u_Vchars1024_t
                  )) subj_names
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
                ON (subjects.id = ss_j.subject_id AND
                    subjects.job_uuid = ss_j.job_uuid)
            INNER JOIN v2u_ko_specialties specialties
                ON (specialties.id = ss_j.specialty_id AND
                    specialties.job_uuid = ss_j.job_uuid)
            LEFT JOIN v2u_ko_matched_przedm_j ma_j
                ON (ma_j.subject_id = ss_j.subject_id AND
                    ma_j.specialty_id = ss_j.specialty_id AND
                    ma_j.semester_id = ss_j.semester_id AND
                    ma_j.job_uuid = ss_j.job_uuid)
            LEFT JOIN v2u_ko_missing_przedm_j mi_j
                ON (mi_j.subject_id = ss_j.subject_id AND
                    mi_j.specialty_id = ss_j.specialty_id AND
                    mi_j.semester_id = ss_j.semester_id AND
                    mi_j.job_uuid = ss_j.job_uuid)
            LEFT JOIN v2u_ko_subject_map_j sm_j
                ON (sm_j.subject_id = ss_j.subject_id AND
                    sm_j.specialty_id = ss_j.specialty_id AND
                    sm_j.semester_id = ss_j.semester_id AND
                    sm_j.job_uuid = ss_j.job_uuid AND
                    sm_j.selected = 1)
            LEFT JOIN v2u_subject_map subject_map
                ON (subject_map.id = sm_j.map_id)
            LEFT JOIN v2u_ko_grades_j grades
                ON (grades.subject_id = ss_j.subject_id AND
                    grades.specialty_id = ss_j.specialty_id AND
                    grades.semester_id = ss_j.semester_id AND
                    grades.job_uuid = ss_j.job_uuid)
            LEFT JOIN v2u_faculties faculties
                ON (faculties.abbriev = specialties.faculty)
            GROUP BY
                  ss_j.job_uuid
                , COALESCE(subject_map.map_subj_code, subjects.subj_code)
        ),
        v AS
        (
            SELECT
                  u.job_uuid
                , u.kod
                , ( SELECT
                        LISTAGG(VALUE(t), ', ')
                        WITHIN GROUP (ORDER BY VALUE(t))
                    FROM TABLE(u.subj_codes) t
                  ) opis

                -- select first element from each collection

                , ( SELECT SUBSTR(VALUE(t), 1, 3)
                    FROM TABLE(u.map_subj_languages) t
                    WHERE ROWNUM <= 1
                  ) map_subj_lang
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u.map_org_units) t
                    WHERE ROWNUM <= 1
                  ) map_org_unit
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u.map_org_unit_recipients) t
                    WHERE ROWNUM <= 1
                  ) map_org_unit_recipient
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u.faculty_codes) t
                    WHERE ROWNUM <= 1
                  ) faculty_code
                , ( SELECT SUBSTR(VALUE(t), 1, 200)
                    FROM TABLE(u.subj_names) t
                    WHERE ROWNUM <= 1
                  ) subj_name
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
                    FROM TABLE(u.map_subj_languages)
                  ) dbg_languages
                , ( SELECT COUNT(*)
                    FROM TABLE(u.map_org_units)
                  ) dbg_org_units
                , ( SELECT COUNT(*)
                    FROM TABLE(u.map_org_unit_recipients)
                  ) dbg_org_unit_recipients
                , ( SELECT COUNT(*)
                    FROM TABLE(u.faculty_codes)
                  ) dbg_faculty_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u.subj_names)
                  ) dbg_subj_names
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
            , v.kod
            , v.opis
            --, COALESCE(v.map_subj_code, v.subj_code) kod
            , v.subj_name nazwa
            , COALESCE(v.map_org_unit, v.faculty_code) jed_org_kod
            , V2u_Get.Tpro_Kod(
                      subj_credit_kind => v.subj_credit_kind
                    , subj_grades => v.subj_grades
              ) tpro_kod
            , COALESCE(v.map_org_unit_recipient, v.faculty_code) jed_org_kod_biorca
            , v.map_subj_lang jzk_kod

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
                    AND v.dbg_languages = 1
                    AND v.dbg_org_units <= 1
                    AND v.dbg_org_unit_recipients <= 1
                    AND v.dbg_faculty_codes = 1
                    AND v.dbg_subj_names = 1
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
            , v.dbg_languages
            , v.dbg_org_units
            , v.dbg_org_unit_recipients
            , v.dbg_faculty_codes
            , v.dbg_subj_names
            , v.dbg_subj_credit_kinds
            , v.dbg_matched
            , v.dbg_missing
            , v.dbg_mapped
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
        , jzk_kod
        , opis
        , dbg_subj_codes
        , dbg_map_subj_codes
        , dbg_languages
        , dbg_org_units
        , dbg_org_unit_recipients
        , dbg_faculty_codes
        , dbg_subj_names
        , dbg_subj_credit_kinds
        , dbg_matched
        , dbg_missing
        , dbg_mapped
        , safe_to_add
        )
    VALUES
        ( src.kod
        , src.job_uuid
        , src.nazwa
        , src.jed_org_kod
        , src.tpro_kod
        , src.jed_org_kod_biorca
        , src.jzk_kod
        , src.opis
        , src.dbg_subj_codes
        , src.dbg_map_subj_codes
        , src.dbg_languages
        , src.dbg_org_units
        , src.dbg_org_unit_recipients
        , src.dbg_faculty_codes
        , src.dbg_subj_names
        , src.dbg_subj_credit_kinds
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_mapped
        , src.safe_to_add
        )
WHEN MATCHED THEN UPDATE SET
          tgt.nazwa = src.nazwa
        , tgt.jed_org_kod = src.jed_org_kod
        , tgt.tpro_kod = src.tpro_kod
        , tgt.jed_org_kod_biorca = src.jed_org_kod_biorca
        , tgt.jzk_kod = src.jzk_kod
        , tgt.opis = src.opis
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_languages = src.dbg_languages
        , tgt.dbg_org_units = src.dbg_org_units
        , tgt.dbg_org_unit_recipients = src.dbg_org_unit_recipients
        , tgt.dbg_faculty_codes = src.dbg_faculty_codes
        , tgt.dbg_subj_names = src.dbg_subj_names
        , tgt.dbg_subj_credit_kinds = src.dbg_subj_credit_kinds
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_mapped = src.dbg_mapped
        , tgt.safe_to_add = src.safe_to_add
;

-- vim: set ft=sql ts=4 sw=4 et:
