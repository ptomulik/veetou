MERGE INTO v2u_ko_missing_pktprz_j tgt
USING
    (
        WITH u AS
        ( -- select all unmatched entries
            SELECT
                  ss_j.job_uuid
                , ss_j.subject_id
                , ss_j.specialty_id
                , ss_j.semester_id
            FROM v2u_ko_subject_semesters_j ss_j
            MINUS
            SELECT
                  ma_j.job_uuid
                , ma_j.subject_id
                , ma_j.specialty_id
                , ma_j.semester_id
            FROM v2u_ko_matched_pktprz_j ma_j
        ),
        v AS
        ( -- determine specialty mappings
            SELECT
                  u.job_uuid
                , u.subject_id
                , u.specialty_id
                , u.semester_id
                , CAST(COLLECT(spec_map_j.map_id
                                ORDER BY spec_map_j.map_id)
                    AS V2u_20Ids_t
                  ) specialty_map_ids
                , CAST(COLLECT(specialty_map.map_program_code
                                ORDER BY spec_map_j.map_id)
                    AS V2u_Vchars1K_t
                  ) map_program_codes1k
                , LISTAGG(specialty_map.map_program_code, '|')
                  WITHIN GROUP (ORDER BY spec_map_j.map_id)
                  map_program_codes_list
            FROM u u
            LEFT JOIN v2u_ko_specialty_map_j spec_map_j
                ON  (
                            spec_map_j.specialty_id = u.specialty_id
                        AND spec_map_j.semester_id = u.semester_id
                        AND spec_map_j.job_uuid = u.job_uuid
                    )
            LEFT JOIN v2u_specialty_map specialty_map
                ON  (
                            specialty_map.id = spec_map_j.map_id
                    )
            GROUP BY
                  u.job_uuid
                , u.subject_id
                , u.specialty_id
                , u.semester_id
        ),
        w AS
        ( -- determine subject mapping and add some fields
            SELECT
                  v.job_uuid
                , v.subject_id
                , v.specialty_id
                , v.semester_id
                , v.specialty_map_ids
                , v.map_program_codes_list
                , CAST(MULTISET(
                        SELECT SUBSTR(VALUE(t), 1, 20)
                        FROM TABLE(v.map_program_codes1k) t
                    ) AS V2u_Program_20Codes_t
                  ) map_program_codes
                , subj_map_j.map_id subject_map_id
                , subject_map.map_subj_code
                , subjects.subj_code
                , semesters.semester_code
                , SUBSTR( specialties.university
                    || ':' ||
                    specialties.faculty
                    || ':' ||
                    V2U_Get.Studies_Tier(specialties.studies_modetier)
                    || ':' ||
                    V2U_Get.Studies_Mode(specialties.studies_modetier)
                    || ':' ||
                    V2U_Get.Acronym(specialties.studies_field)
                    || ':' ||
                    V2U_Get.Acronym(specialties.studies_specialty)
                  , 1, 128
                  ) specialty_string
            FROM v v
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = v.subject_id
                        AND subjects.job_uuid = v.job_uuid
                    )
            INNER JOIN v2u_ko_specialties specialties
                ON  (
                            specialties.id = v.specialty_id
                        AND specialties.job_uuid = v.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = v.semester_id
                        AND semesters.job_uuid = v.job_uuid
                    )
            LEFT JOIN v2u_ko_subject_map_j subj_map_j
                ON  (
                            subj_map_j.subject_id = v.subject_id
                        AND subj_map_j.specialty_id = v.specialty_id
                        AND subj_map_j.semester_id = v.semester_id
                        AND subj_map_j.job_uuid = v.job_uuid
                        AND subj_map_j.selected = 1
                    )
            LEFT JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = subj_map_j.map_id
                    )
        ),
        x AS
        ( -- find out possibly matching punkty_przedmiotow and add some fields
            SELECT
                  w.*
                , CAST(MULTISET(
                        SELECT t.id
                        FROM v2u_dz_punkty_przedmiotow t
                        WHERE
                                t.prz_kod = w.map_subj_code
                            AND (
                                    (
                                        t.prg_kod IN
                                        (
                                            SELECT VALUE(s)
                                            FROM TABLE(w.map_program_codes) s
                                        )
                                    )
                                    OR
                                    t.prg_kod IS NULL
                                )
                            AND (
                                    w.semester_code BETWEEN
                                        t.cdyd_pocz
                                        AND
                                        COALESCE(t.cdyd_kon, '9999Z')
                                )
                            AND t.tpkt_kod = 'ECTS'
                    ) AS V2u_Dz_20Ids_t
                  ) istniejace_pkt_prz_ids
                , ( w.subj_code
                    || ':' ||
                    w.specialty_string
                    || ':' ||
                    w.semester_code
                  ) id1_string
                , ( w.map_subj_code
                    || ':{' ||
                    w.map_program_codes_list
                    || '}:' ||
                    w.semester_code
                  ) id2_string
            FROM w w
        )
        SELECT
              x.*
            , CASE
                WHEN x.subject_map_id IS NULL
                THEN 'no subject map for ' || x.id1_string
                WHEN x.map_subj_code IS NULL
                THEN 'map_subj_code IS NULL for ' || x.id1_string
                WHEN (SELECT COUNT(*) FROM TABLE(x.specialty_map_ids)) < 1
                THEN 'no specialty maps for ' || x.id1_string
                WHEN (SELECT COUNT(*) FROM TABLE(x.istniejace_pkt_prz_ids)) < 1
                THEN 'no matching dz_punkty_przedmiotow for ' || x.id2_string
                ELSE 'error (v2u_ko_matched_pktprz_j out of sync?)'
                END reason
        FROM x x
    ) src
ON  (
            tgt.job_uuid = src.job_uuid
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , subject_id
        , specialty_id
        , semester_id
        , subject_map_id
        , map_subj_code
        , specialty_map_ids
        , map_program_codes
        , istniejace_pkt_prz_ids
        , reason
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.subject_map_id
        , src.map_subj_code
        , src.specialty_map_ids
        , src.map_program_codes
        , src.istniejace_pkt_prz_ids
        , src.reason
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.map_subj_code = src.map_subj_code
        , tgt.specialty_map_ids = src.specialty_map_ids
        , tgt.map_program_codes = src.map_program_codes
        , tgt.istniejace_pkt_prz_ids = src.istniejace_pkt_prz_ids
        , tgt.reason = src.reason
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
