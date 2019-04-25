MERGE INTO v2u_uu_oceny tgt
USING
    (
        WITH u_00 AS
        (
            SELECT
                  g_j.job_uuid
                , CASE
                    WHEN  ma_oceny_j.job_uuid IS NOT NULL
                    THEN
                      '{os_id: '
                        || TO_CHAR(ma_oceny_j.os_id) ||
                      ', prot_id: '
                        || TO_CHAR(ma_oceny_j.prot_id) ||
                      ', term_prot_nr: '
                        || TO_CHAR(ma_oceny_j.term_prot_nr) ||
                      '}'
                    ELSE
                      '{student: "'
                        || students.student_index ||
                      '", subject: "'
                        || COALESCE( subject_map.map_subj_code
                                   , subjects.subj_code) ||
                      '", semester: "'
                        || semesters.semester_code ||
                      '", classes: "'
                        || COALESCE( classes_map.map_classes_type
                                   , g_j.classes_type ) ||
                      '", date: "'
                        || TO_CHAR(g_j.subj_grade_date, 'YYYY-MM-DD') ||
                      '"}'
                  END pk_ocena

                -- for the verification of pk_ocena (when dbg_unique_match=1)
                , CASE
                    WHEN ma_oceny_j.job_uuid IS NOT NULL
                    THEN ma_oceny_j.os_id
                    ELSE mi_oceny_j.os_id
                  END os_id
                , CASE
                    WHEN ma_oceny_j.job_uuid IS NOT NULL
                    THEN ma_oceny_j.prot_id
                    ELSE mi_oceny_j.prot_id
                  END prot_id
                , CASE
                    WHEN ma_oceny_j.job_uuid IS NOT NULL
                    THEN ma_oceny_j.term_prot_nr
                    ELSE mi_oceny_j.term_prot_nr
                  END term_prot_nr
                -- for the verification of pk_ocena (when dbg_unique_match=0)
                , students.student_index
                , subject_map.map_subj_code
                , subjects.subj_code
                , semesters.semester_code
                , classes_map.map_classes_type
                , g_j.classes_type
                , g_j.subj_grade_date
                -- values to be set
                , g_j.toc_kod
                , g_j.opis
                , wartosci_ocen.kolejnosc wart_oc_kolejnosc
                -- for debugging
                , mi_oceny_j.student_id mi_student_id
                , ma_oceny_j.student_id ma_student_id
                , subject_map.id subject_map_id
                , classes_map.id classes_map_id

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
            LEFT JOIN v2u_ko_matched_oceny_j ma_oceny_j
                ON  (
                            ma_oceny_j.student_id = g_j.student_id
                        AND ma_oceny_j.classes_type = g_j.classes_type
                        AND ma_oceny_j.subj_grade_date = g_j.subj_grade_date
                        AND ma_oceny_j.subject_id = g_j.subject_id
                        AND ma_oceny_j.specialty_id = g_j.specialty_id
                        AND ma_oceny_j.semester_id = g_j.semester_id
                        AND ma_oceny_j.job_uuid = g_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_oceny_j mi_oceny_j
                ON  (
                            mi_oceny_j.student_id = g_j.student_id
                        AND mi_oceny_j.classes_type = g_j.classes_type
                        AND mi_oceny_j.subj_grade_date = g_j.subj_grade_date
                        AND mi_oceny_j.subject_id = g_j.subject_id
                        AND mi_oceny_j.specialty_id = g_j.specialty_id
                        AND mi_oceny_j.semester_id = g_j.semester_id
                        AND mi_oceny_j.job_uuid = g_j.job_uuid
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
                            oceny.os_id = ma_oceny_j.os_id
                        AND oceny.prot_id = ma_oceny_j.prot_id
                        AND oceny.term_prot_nr = ma_oceny_j.term_prot_nr
                    )
            LEFT JOIN v2u_dz_wartosci_ocen wartosci_ocen
                ON  (
                            wartosci_ocen.toc_kod = g_j.toc_kod
                        AND wartosci_ocen.opis = g_j.opis
                    )
            WHERE g_j.subj_grade_date IS NOT NULL
        ),
        u_0 AS
        (
            -- determine what to use as a single output row;
            SELECT
                  u_00.job_uuid
                , u_00.pk_ocena

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
                  )) term_prot_nry

                , SET(CAST(
                        COLLECT(u_00.student_index)
                        AS V2u_Vchars1K_t
                  )) student_indices1k
                , SET(CAST(
                        COLLECT(u_00.map_subj_code)
                        AS V2u_Vchars1K_t
                  )) map_subj_codes1k
                , SET(CAST(
                        COLLECT(u_00.subj_code)
                        AS V2u_Vchars1K_t
                  )) subj_codes1k
                , SET(CAST(
                        COLLECT(u_00.semester_code)
                        AS V2u_Vchars1K_t
                  )) semester_codes1k
                , SET(CAST(
                        COLLECT(u_00.map_classes_type)
                        AS V2u_Vchars1K_t
                  )) map_classes_types1k
                , SET(CAST(
                        COLLECT(u_00.classes_type)
                        AS V2u_Chars1_t
                  )) classes_types
                , SET(CAST(
                        COLLECT(u_00.subj_grade_date ORDER BY u_00.subj_grade_date)
                        AS V2u_Dates_t
                  )) subj_grade_dates

                , SET(CAST(
                        COLLECT(u_00.toc_kod)
                        AS V2u_Vchars1K_t
                  )) toc_kody1k
                , SET(CAST(
                        COLLECT(u_00.opis)
                        AS V2u_Vchars1K_t
                  )) opisy1k
                , SET(CAST(
                        COLLECT(u_00.wart_oc_kolejnosc)
                        AS V2u_Ints10_t
                  )) wart_oc_kolejnosci


                /* The ".. + 0" seems to be a workaround the following bug:
                 *
                 * BUG: The values of dbg_matched and dbg_subject_mapped get
                 * mixed randomly in this query. */
                , COUNT(u_00.ma_student_id + 0) dbg_matched
                , COUNT(u_00.mi_student_id + 0) dbg_missing
                , COUNT(u_00.subject_map_id + 0) dbg_subject_mapped
                , COUNT(u_00.classes_map_id + 0) dbg_classes_mapped

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
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.os_ids) t
                    WHERE ROWNUM <= 1
                  ) os_id
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.prot_ids) t
                    WHERE ROWNUM <= 1
                  ) prot_id
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.term_prot_nry) t
                    WHERE ROWNUM <= 1
                  ) term_prot_nr

                , ( SELECT SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u_0.student_indices1k) t
                    WHERE ROWNUM <= 1
                  ) student_index
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) map_subj_code
                , ( SELECT SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u_0.subj_codes1k) t
                    WHERE ROWNUM <= 1
                  ) subj_code
                , ( SELECT SUBSTR(VALUE(t), 1, 32)
                    FROM TABLE(u_0.semester_codes1k) t
                    WHERE ROWNUM <= 1
                  ) semester_code
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.map_classes_types1k) t
                    WHERE ROWNUM <= 1
                  ) map_classes_type
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.classes_types) t
                    WHERE ROWNUM <= 1
                  ) classes_type
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.subj_grade_dates) t
                    WHERE ROWNUM <= 1
                  ) subj_grade_date

                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u_0.toc_kody1k) t
                    WHERE ROWNUM <= 1
                  ) toc_kod
                , ( SELECT SUBSTR(VALUE(t), 1, 100)
                    FROM TABLE(u_0.opisy1k) t
                    WHERE ROWNUM <= 1
                  ) opis
                , ( SELECT VALUE(t)
                    FROM TABLE(u_0.wart_oc_kolejnosci) t
                    WHERE ROWNUM <= 1
                  ) wart_oc_kolejnosc

                -- columns used for debugging
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.os_ids)
                  ) dbg_os_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.prot_ids)
                  ) dbg_prot_ids
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.term_prot_nry)
                  ) dbg_term_prot_nry

                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.student_indices1k)
                  ) dbg_student_indices
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_subj_codes1k)
                  ) dbg_map_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_codes1k)
                  ) dbg_subj_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.semester_codes1k)
                  ) dbg_semester_codes
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.map_classes_types1k)
                  ) dbg_map_classes_types
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.classes_types)
                  ) dbg_classes_types
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.subj_grade_dates)
                  ) dbg_subj_grade_dates

                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.toc_kody1k)
                  ) dbg_toc_kody
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.opisy1k)
                  ) dbg_opisy
                , ( SELECT COUNT(*)
                    FROM TABLE(u_0.wart_oc_kolejnosci)
                  ) dbg_wart_oc_kolejnosci

                , u_0.dbg_matched
                , u_0.dbg_missing
                , u_0.dbg_subject_mapped
                , u_0.dbg_classes_mapped
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
                , u.wart_oc_kolejnosc v$wart_oc_kolejnosc

                , V2u_Get.Utw_Id(u.job_uuid) v$utw_id
                , V2u_Get.Mod_Id(u.job_uuid) v$mod_id

                -- did we find unique row in the target table?
                , CASE
                    WHEN    u.dbg_matched > 0
                        AND u.dbg_missing = 0
                        AND u.dbg_subject_mapped = u.dbg_matched
                        AND (
                                        u.classes_type = '-'
                                    AND u.dbg_classes_mapped = 0
                                OR
                                        u.classes_type <> '-'
                                    AND u.dbg_classes_mapped = u.dbg_matched
                            )
                        AND u.dbg_os_ids = 1 AND u.os_id IS NOT NULL
                        AND u.dbg_prot_ids = 1 AND u.prot_id IS NOT NULL
                        AND u.dbg_term_prot_nry = 1 AND u.term_prot_nr IS NOT NULL
                    THEN 1
                    ELSE 0
                  END dbg_unique_match

                -- examine values we gonna propose
                , CASE
                    WHEN
                        -- all the instances were consistent
                            u.dbg_toc_kody = 1
                        AND u.toc_kod IN ('STD', 'ZAL')
                        AND u.dbg_opisy = 1
                        AND u.opis IN ( 'ZAL', 'NZAL', 'ZW',
                                        '2', '3', '3,5', '4', '4,5', '5')
                        AND u.dbg_wart_oc_kolejnosci = 1
                        AND u.wart_oc_kolejnosc BETWEEN 1 AND 6
                    THEN 1
                    ELSE 0
                  END dbg_values_ok
            FROM u u
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
                        AND v.dbg_missing > 0
                        AND v.dbg_subject_mapped = v.dbg_missing
                        AND (
                                        v.classes_type = '-'
                                    AND v.dbg_classes_mapped = 0
                                OR
                                        v.classes_type <> '-'
                                    AND v.dbg_classes_mapped = v.dbg_missing
                            )
                        AND v.dbg_os_ids = 1
                        AND v.os_id IS NOT NULL
                        AND v.dbg_prot_ids = 1
                        AND v.prot_id IS NOT NULL
                        AND v.dbg_term_prot_nry = 1
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
        SELECT
              w.job_uuid
            , w.pk_ocena

            , w.v$os_id os_id
            , DECODE(w.change_type, 'I', NULL, w.u$komentarz_pub) komentarz_pub
            , DECODE(w.change_type, 'I', NULL, w.u$komentarz_pryw) komentarz_pryw
            , w.v$toc_kod toc_kod
            , w.v$wart_oc_kolejnosc wart_oc_kolejnosc

            , DECODE(w.change_type, 'I', w.v$utw_id, w.u$utw_id) utw_id
            , DECODE(w.change_type, 'I', NULL, w.u$utw_data) utw_data
            , DECODE(w.change_type, 'U', w.v$mod_id, w.u$mod_id) mod_id
            , DECODE(w.change_type, 'U', NULL, w.u$mod_data) mod_data

            , w.v$prot_id prot_id
            , w.v$term_prot_nr term_prot_nr
            , DECODE(w.change_type, 'I', NULL, w.u$zmiana_os_id) zmiana_os_id
            , DECODE(w.change_type, 'I', NULL, w.u$zmiana_data) zmiana_data
            , DECODE(w.change_type, 'I', NULL, w.u$pos_komi_id) pos_komi_id

            , w.dbg_os_ids
            , w.dbg_prot_ids
            , w.dbg_term_prot_nry
            , w.dbg_student_indices
            , w.dbg_map_subj_codes
            , w.dbg_subj_codes
            , w.dbg_semester_codes
            , w.dbg_map_classes_types
            , w.dbg_classes_types
            , w.dbg_subj_grade_dates
            , w.dbg_toc_kody
            , w.dbg_opisy
            , w.dbg_wart_oc_kolejnosci
            , w.dbg_matched
            , w.dbg_missing
            , w.dbg_subject_mapped
            , w.dbg_classes_mapped
            , w.dbg_unique_match
            , w.dbg_values_ok

            , w.change_type
            , DECODE(w.change_type, 'I', w.safe_to_insert
                                  , 'U', w.safe_to_update
                                  ,  0
            ) safe_to_change
        FROM w w
    ) src
ON  (
            tgt.pk_ocena = src.pk_ocena
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( os_id
        , komentarz_pub
        , komentarz_pryw
        , toc_kod
        , wart_oc_kolejnosc
        , utw_id
        , utw_data
        , mod_id
        , mod_data
        , prot_id
        , term_prot_nr
        , zmiana_os_id
        , zmiana_data
        , pos_komi_id
        -- KEY
        , job_uuid
        , pk_ocena
        -- DBG
        , dbg_os_ids
        , dbg_prot_ids
        , dbg_term_prot_nry
        , dbg_student_indices
        , dbg_map_subj_codes
        , dbg_subj_codes
        , dbg_semester_codes
        , dbg_map_classes_types
        , dbg_classes_types
        , dbg_subj_grade_dates
        , dbg_toc_kody
        , dbg_opisy
        , dbg_wart_oc_kolejnosci
        , dbg_matched
        , dbg_missing
        , dbg_subject_mapped
        , dbg_classes_mapped
        , dbg_unique_match
        , dbg_values_ok
        -- CTL
        , change_type
        , safe_to_change
        )
    VALUES
        ( os_id
        , src.komentarz_pub
        , src.komentarz_pryw
        , src.toc_kod
        , src.wart_oc_kolejnosc
        , src.utw_id
        , src.utw_data
        , src.mod_id
        , src.mod_data
        , src.prot_id
        , src.term_prot_nr
        , src.zmiana_os_id
        , src.zmiana_data
        , src.pos_komi_id
        -- KEY
        , src.job_uuid
        , src.pk_ocena
        -- DBG
        , src.dbg_os_ids
        , src.dbg_prot_ids
        , src.dbg_term_prot_nry
        , src.dbg_student_indices
        , src.dbg_map_subj_codes
        , src.dbg_subj_codes
        , src.dbg_semester_codes
        , src.dbg_map_classes_types
        , src.dbg_classes_types
        , src.dbg_subj_grade_dates
        , src.dbg_toc_kody
        , src.dbg_opisy
        , src.dbg_wart_oc_kolejnosci
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_subject_mapped
        , src.dbg_classes_mapped
        , src.dbg_unique_match
        , src.dbg_values_ok
        -- CTL
        , src.change_type
        , src.safe_to_change
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.os_id = src.os_id
        , tgt.komentarz_pub = src.komentarz_pub
        , tgt.komentarz_pryw = src.komentarz_pryw
        , tgt.toc_kod = src.toc_kod
        , tgt.wart_oc_kolejnosc = src.wart_oc_kolejnosc
        , tgt.utw_id = src.utw_id
        , tgt.utw_data = src.utw_data
        , tgt.mod_id = src.mod_id
        , tgt.mod_data = src.mod_data
        , tgt.prot_id = src.prot_id
        , tgt.term_prot_nr = src.term_prot_nr
        , tgt.zmiana_os_id = src.zmiana_os_id
        , tgt.zmiana_data = src.zmiana_data
        , tgt.pos_komi_id = src.pos_komi_id
        -- KEY
--        , tgt.job_uuid = src.job_uuid
--        , tgt.pk_ocena = src.pk_ocena
        -- DBG
        , tgt.dbg_os_ids = src.dbg_os_ids
        , tgt.dbg_prot_ids = src.dbg_prot_ids
        , tgt.dbg_term_prot_nry = src.dbg_term_prot_nry
        , tgt.dbg_student_indices = src.dbg_student_indices
        , tgt.dbg_map_subj_codes = src.dbg_map_subj_codes
        , tgt.dbg_subj_codes = src.dbg_subj_codes
        , tgt.dbg_semester_codes = src.dbg_semester_codes
        , tgt.dbg_map_classes_types = src.dbg_map_classes_types
        , tgt.dbg_classes_types = src.dbg_classes_types
        , tgt.dbg_subj_grade_dates = src.dbg_subj_grade_dates
        , tgt.dbg_toc_kody = src.dbg_toc_kody
        , tgt.dbg_opisy = src.dbg_opisy
        , tgt.dbg_wart_oc_kolejnosci = src.dbg_wart_oc_kolejnosci
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_subject_mapped = src.dbg_subject_mapped
        , tgt.dbg_classes_mapped = src.dbg_classes_mapped
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_values_ok = src.dbg_values_ok
        -- CTL
        , tgt.change_type = src.change_type
        , tgt.safe_to_change = src.safe_to_change
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
