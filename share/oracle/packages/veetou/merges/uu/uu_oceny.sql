MERGE INTO v2u_uu_oceny tgt
USING
    (
        WITH u_00 AS
        (
            SELECT
                  g_j.job_uuid
                , CASE
                    -- FIXME: COALESCE(ma_etpos_j.os_id, studenci.os_id) ?
                    WHEN    ma_etpos_j.os_id IS NOT NULL
                        AND ma_trmpro_j.job_uuid IS NOT NULL
                    THEN
                      '{os_id: '
                        -- FIXME: COALESCE(ma_etpos_j.os_id, studenci.os_id) ?
                        || ma_etpos_j.os_id ||
                      ', prot_id: '
                        || ma_trmpro_j.prot_id ||
                      ', term_prot_nr: '
                        || ma_trmpro_j.nr ||
                      '}'
                    ELSE
                      '{student: "'
                        || students.student_index ||
                      '", subject: "'
                        || COALESCE( subject_map.map_subj_code
                                   , subjects.subj_code) ||
                      '", semester: "'
                        || semesters.semester_code ||
                      '", proto: "'
                        || mi_trmpro_j.coalesced_proto_type ||
                      '", classes: "'
                        || COALESCE( classes_map.map_classes_type
                                   , g_j.classes_type ) ||
                      '", date: "'
                        || g_j.subj_grade_date ||
                      '"}'
                  END pk_ocena

                , subject_map.map_subj_code
                , subject_map.map_proto_type
                , classes_map.map_classes_type
                , subjects.subj_code
                , subjects.subj_credit_kind
                , semesters.semester_code
                , g_j.classes_type
                , g_j.subj_grade
                , g_j.subj_grade_date
                -- FIXME: COALESCE(ma_etpos_j.os_id, studenci.os_id)?
                , oceny.toc_kod ma_toc_kod
                , oceny.wart_oc_kolejnosc ma_wart_oc_kolejnosc
                , ma_etpos_j.os_id
                , ma_trmpro_j.prot_id
                , mi_etpos_j.job_uuid mi_etpos_job_uuid
                , ma_trmpro_j.nr term_prot_nr
                , ma_trmpro_j.prz_kod
                , mi_trmpro_j.job_uuid mi_trmpro_job_uuid
                , sm_j.map_id subject_map_id
                , cm_j.map_id classes_map_id

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
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = g_j.semester_id
                        AND semesters.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_etpos_j ma_etpos_j
                ON  (
                            ma_etpos_j.student_id = g_j.student_id
                        AND ma_etpos_j.specialty_id = g_j.specialty_id
                        AND ma_etpos_j.semester_id = g_j.semester_id
                        AND ma_etpos_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_etpos_j mi_etpos_j
                ON  (
                            mi_etpos_j.student_id = g_j.student_id
                        AND mi_etpos_j.specialty_id = g_j.specialty_id
                        AND mi_etpos_j.semester_id = g_j.semester_id
                        AND mi_etpos_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_trmpro_j ma_trmpro_j
                ON  (
                            ma_trmpro_j.subject_id = g_j.subject_id
                        AND ma_trmpro_j.specialty_id = g_j.specialty_id
                        AND ma_trmpro_j.semester_id = g_j.semester_id
                        AND ma_trmpro_j.classes_type = g_j.classes_type
                        AND ma_trmpro_j.subj_grade_date = g_j.subj_grade_date
                        AND ma_trmpro_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_trmpro_j mi_trmpro_j
                ON  (
                            mi_trmpro_j.subject_id = g_j.subject_id
                        AND mi_trmpro_j.specialty_id = g_j.specialty_id
                        AND mi_trmpro_j.semester_id = g_j.semester_id
                        AND mi_trmpro_j.classes_type = g_j.classes_type
                        AND mi_trmpro_j.subj_grade_date = g_j.subj_grade_date
                        AND mi_trmpro_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_subject_map_j sm_j
                ON  (
                            sm_j.subject_id = g_j.subject_id
                        AND sm_j.specialty_id = g_j.specialty_id
                        AND sm_j.semester_id = g_j.semester_id
                        AND sm_j.job_uuid = g_j.job_uuid
                        AND sm_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = sm_j.map_id
                    )
            LEFT JOIN v2u_ko_classes_map_j cm_j
                ON  (
                            cm_j.subject_id = g_j.subject_id
                        AND cm_j.specialty_id = g_j.specialty_id
                        AND cm_j.semester_id = g_j.semester_id
                        AND cm_j.classes_type = g_j.classes_type
                        AND cm_j.job_uuid = g_j.job_uuid
                        AND cm_j.selected = 1
                    )
            LEFT JOIN v2u_classes_map classes_map
                ON  (
                            classes_map.id = cm_j.map_id
                    )
            LEFT JOIN v2u_dz_oceny oceny
                ON  (
                            -- FIXME: COALESCE(ma_etpos_j.os_id, studenci.os_id)?
                            oceny.os_id = ma_etpos_j.os_id
                        AND oceny.prot_id = ma_trmpro_j.prot_id
                        AND oceny.term_prot_nr = ma_trmpro_j.nr
                    )
            WHERE g_j.subj_grade IS NOT NULL
        ),
        u_0 AS
        (
            -- determine what to use as a single output row;
            SELECT
                  u_00.job_uuid
                , u_00.pk_ocena

                , SET(CAST(
                        COLLECT(u_00.map_subj_code)
                        AS V2u_Vchars1K_t
                  )) map_subj_codes1k
                , SET(CAST(
                        COLLECT(u_00.map_proto_type)
                        AS V2u_Vchars1K_t
                  )) map_proto_types1k
                , SET(CAST(
                        COLLECT(u_00.map_classes_type)
                        AS V2u_Vchars1K_t
                  )) map_classes_types1k
                , SET(CAST(
                        COLLECT(u_00.subj_code)
                        AS V2u_Vchars1K_t
                  )) subj_codes1k
                , SET(CAST(
                        COLLECT(u_00.classes_type)
                        AS V2u_Chars1_t
                  )) classes_types
                , SET(CAST(
                        COLLECT(u_00.subj_credit_kind)
                        AS V2u_Vchars1K_t
                  )) subj_credit_kinds1k
                , SET(CAST(
                        COLLECT(u_00.subj_grade ORDER BY u_00.subj_grade)
                        AS V2u_Vchars1K_t
                  )) subj_grades1k
                , SET(CAST(
                        COLLECT(u_00.os_id)
                        AS V2u_Dz_Ids_t
                  )) os_ids
                , SET(CAST(
                        COLLECT(u_00.prot_id)
                        AS V2u_Dz_Ids_t
                  )) prot_ids
                , SET(CAST(
                        COLLECT(u_00.term_prot_nr)
                        AS V2u_Ints10_t
                  )) term_prot_nrs
                , SET(CAST(
                        COLLECT(u_00.subj_grade_date ORDER BY u_00.subj_grade_date)
                        AS V2u_Dates_t
                  )) subj_grade_dates


                /* The ".. + 0" seems to be a workaround the following bug:
                 *
                 * BUG: The values of dbg_matched and dbg_subject_mapped get
                 * mixed randomly in this query. */
                , COUNT(u_00.ma_toc_kod) dbg_matched
                , COUNT(u_00.mi_etpos_job_uuid) dbg_missing_etpos
                , COUNT(u_00.mi_trmpro_job_uuid) dbg_missing_trmpro
                , COUNT(u_00.subject_map_id + 0) dbg_subject_mapped
                , COUNT(u_00.classes_map_id + 0) dbg_classes_mapped
                , COUNT(u_00.os_id + 0) dbg_student_mapped

            FROM u_00 u_00
            GROUP BY
                  u_00.job_uuid
                , u_00.pk_ocena
        ),
        u AS
        ( -- make necessary adjustments to the raw values selected i u_0
            SELECT
                  u_0.job_uuid
                , u_0.pk_ocena

                -- select first element from each collection
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) map_subj_code
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_proto_types1k) t
                    WHERE ROWNUM <= 1
                  ) map_proto_type
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_classes_types1k) t
                    WHERE ROWNUM <= 1
                  ) map_classes_type
                , ( SELECT SUBSTR(VALUE(t), 1, 16)
                    FROM TABLE(u_0.subj_credit_kinds1k) t
                    WHERE ROWNUM <= 1
                  ) subj_credit_kind
                , ( SELECT SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u_0.subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) subj_code
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.classes_types) t
                    WHERE ROWNUM <= 1
                  ) classes_type
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.os_ids) t
                    WHERE ROWNUM <= 1
                  ) os_id
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.prot_ids) t
                    WHERE ROWNUM <= 1
                  ) prot_id
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.term_prot_nrs) t
                    WHERE ROWNUM <= 1
                  ) term_prot_nr

                , ( SELECT
                    CASE
                        WHEN REGEXP_INSTR(VALUE(t), '[2-5]([,.](0|5))?$') = 1
                        THEN 'STD'
                        WHEN UPPER(VALUE(t)) IN ('NZAL', 'ZAL', 'ZW')
                        THEN 'ZAL'
                        ELSE '?'
                    END
                    FROM TABLE(u_0.subj_grades1k) t
                    WHERE ROWNUM <= 1
                  ) toc_kod
                , ( SELECT
                    REGEXP_REPLACE(UPPER(VALUE(t)), '([2-5]),0', '\1')
                    FROM TABLE(u_0.subj_grades1k) t
                    WHERE ROWNUM <= 1
                  ) opis

                , ( SELECT SUBSTR(VALUE(t), 1, 10)
                    FROM TABLE(u_0.subj_grades1k) t
                    WHERE ROWNUM <= 1
                  ) subj_grade

                -- columns used for debugging
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_codes1k)
                  ) dbg_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.classes_types)
                  ) dbg_classes_types
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_subj_codes1k)
                  ) dbg_map_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_proto_types1k)
                  ) dbg_map_proto_types
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_classes_types1k)
                  ) dbg_map_classes_types
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_credit_kinds1k)
                  ) dbg_subj_credit_kinds
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.os_ids)
                  ) dbg_os_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.prot_ids)
                  ) dbg_prot_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.term_prot_nrs)
                  ) dbg_term_prot_nrs
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_grades1k)
                  ) dbg_subj_grades
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_grade_dates)
                  ) dbg_subj_grade_dates

                , u_0.dbg_matched
                , u_0.dbg_missing_etpos
                , u_0.dbg_missing_trmpro
                , u_0.dbg_subject_mapped
                , u_0.dbg_classes_mapped
                , u_0.dbg_student_mapped
            FROM u_0 u_0
        ),
        v AS
        ( -- determine our (v$*) values for certain fields
            SELECT
                  u.*

                , u.os_id v$os_id
                , u.prot_id v$prot_id
                , u.term_prot_nr v$term_prot_nr
                , u.toc_kod v$toc_kod
                , wartosci_ocen.kolejnosc v$wart_oc_kolejnosc

                , V2u_Get.Utw_Id(u.job_uuid) v$utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v$mod_id

                -- did we find unique row in the target table?
                , CASE
                    WHEN    u.dbg_matched > 0
                        AND u.dbg_subject_mapped = u.dbg_matched
                        AND (
                                        u.classes_type = '-'
                                    AND u.dbg_classes_mapped = 0
                                OR
                                        u.classes_type <> '-'
                                    AND u.dbg_classes_mapped = u.dbg_matched
                            )
                        AND u.dbg_student_mapped = u.dbg_matched
                        AND u.dbg_missing_trmpro = 0
                        AND u.dbg_prot_ids = 1 AND u.prot_id IS NOT NULL
                        AND u.dbg_missing_etpos = 0
                        AND u.dbg_os_ids = 1 AND u.os_id IS NOT NULL
                        AND u.dbg_term_prot_nrs = 1 AND u.term_prot_nr IS NOT NULL
                    THEN 1
                    ELSE 0
                  END dbg_unique_match

                -- examine values we gonna propose
                , CASE
                    WHEN
                        -- all the instances were consistent
                            u.dbg_subj_grades = 1
                        AND u.subj_grade IS NOT NULL
                        AND u.toc_kod IN ('STD', 'ZAL')
                        AND u.opis IN ( 'ZAL', 'NZAL', 'ZW',
                                        '2', '3', '3,5', '4', '4,5', '5')
                    THEN 1
                    ELSE 0
                  END dbg_values_ok
            FROM u u
            LEFT JOIN v2u_dz_wartosci_ocen wartosci_ocen
                ON  (
                            wartosci_ocen.toc_kod = u.toc_kod
                        AND wartosci_ocen.opis = u.opis
                    )
        ),
        w AS
        ( -- provide our values (v$*) and original ones (u$*)
            SELECT
                  v.*
                , t.os_id u$os_id
                , t.komentarz_pub u$komentarz_pub
                , t.komentarz_pryw u$komentarz_pryw
                , t.toc_kod u$toc_kod
                , t.wart_oc_kolejnosc u$wart_oc_kolejnosc
                , t.utw_id u$utw_id
                , t.utw_data u$utw_data
                , t.mod_id u$mod_id
                , t.mod_data u$mod_data
                , t.prot_id u$prot_id
                , t.term_prot_nr u$term_prot_nr
                , t.zmiana_os_id u$zmiana_os_id
                , t.zmiana_data u$zmiana_data
                , t.pos_komi_id u$pos_komi_id

                -- is it insert, update or nothing?

                , DECODE( v.dbg_unique_match, 1
                        , (CASE
                            WHEN    -- do we introduce any modification?
                                    DECODE(v.v$toc_kod, t.toc_kod, 1, 0) = 1
                                AND DECODE(v.v$wart_oc_kolejnosc, t.wart_oc_kolejnosc, 1, 0) = 1
                            THEN '-'
                            ELSE 'U'
                          END)
                        , 'I'
                  ) change_type

                , CASE
                    WHEN
                        -- ensure that
                        -- maps for all instances existed but there were no
                        -- corresponding "ocena" in the target system
                            v.dbg_matched = 0
                        AND v.dbg_subject_mapped = v.dbg_missing
                        AND (
                                        v.classes_type = '-'
                                    AND v.dbg_classes_mapped = 0
                                OR
                                        v.classes_type <> '-'
                                    AND v.dbg_classes_mapped = v.dbg_missing
                            )
                        AND v.dbg_student_mapped = v.dbg_missing
                        AND v.dbg_os_ids = 1
                        AND v.dbg_os_id IS NOT NULL
                        AND v.dbg_prot_ids = 1
                        AND v.prot_id IS NOT NULL
                        AND v.dbg_term_prot_nrs = 1
                        AND v.term_prot_nr IS NOT NULL
                        -- values passed basic tests
                        AND v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_insert

                , CASE
                    WHEN
                        -- ensure that
                        -- values passed basic tests
                            v.dbg_values_ok = 1
                    THEN 1
                    ELSE 0
                  END safe_to_update

            FROM v v
            LEFT JOIN v2u_dz_oceny t
                ON  (
                            v.dbg_unique_match = 1
                        AND t.os_id = v.os_id
                        AND t.prot_id = v.prot_id
                        AND t.term_prot_nr = v.term_prot_nr
                    )
        )
--        SELECT
--              w.job_uuid
--            , w.pk_ocena
--
--            , w.v$prot_id prot_id
--            , w.v$nr nr
--            , w.v$status status
--
--            , DECODE(w.change_type, 'I', w.v$utw_id, w.u$utw_id) utw_id
--            , DECODE(w.change_type, 'I', NULL, w.u$utw_data) utw_data
--
--            , w.v$opis opis
--            , w.v$data_zwrotu data_zwrotu
--
--            , DECODE(w.change_type, 'U', w.v$mod_id, w.u$mod_id) mod_id
--            , DECODE(w.change_type, 'U', NULL, w.u$mod_data) mod_data
--
--            , w.v$egzamin_komisyjny egzamin_komisyjny
--
--            , w.dbg_subj_codes
--            , w.dbg_classes_types
--            , w.dbg_map_subj_codes
--            , w.dbg_map_proto_types
--            , w.dbg_map_classes_types
--            , w.dbg_subj_credit_kinds
--            , w.dbg_prot_ids
--            , w.dbg_nrs
--            , w.dbg_statusy
--            , w.dbg_opisy
--            , w.dbg_daty_zwrotu
--            , w.dbg_egzaminy_komisyjne
--            , w.dbg_subj_grades
--            , w.dbg_subj_grade_dates
--            , w.dbg_mi_prot_ids
--            , w.dbg_max_istniejace_nry
--            , w.dbg_subj_grade_date_ranks
--            , w.dbg_matched
--            , w.dbg_missing
--            , w.dbg_subject_mapped
--            , w.dbg_classes_mapped
--            , w.dbg_unique_match
--            , w.dbg_values_ok
--
--            , w.change_type
--            , DECODE(w.change_type, 'I', w.safe_to_insert
--                                  , 'U', w.safe_to_update
--                                  ,  0
--            ) safe_to_change
--        FROM w w
    ) src
ON  (
            tgt.pk_ocena = src.pk_ocena
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
    ()
    VALUES
    ()
WHEN MATCHED THEN
    UPDATE SET
        -- KEY
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_ocena = src.pk_ocena
        -- DBG
        -- CTL
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
