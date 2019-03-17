MERGE INTO v2u_ko_matched_pktprz_j tgt
USING
    (
        WITH u AS
        (   -- identify all matching entries in v2u_dz_punkty_przedmiotow
            SELECT DISTINCT
                  subj_m_j.job_uuid
                , subj_m_j.subject_id
                , subj_m_j.specialty_id
                , subj_m_j.semester_id
                , subj_m_j.map_id subject_map_id
                , pkt_prz.prz_kod
                , pkt_prz.id pktprz_id
                , pkt_prz.prg_kod
                , pkt_prz.cdyd_pocz
                , pkt_prz.cdyd_kon
                , CASE
                    WHEN pkt_prz.ilosc = subjects.subj_ects
                    THEN NULL
                    ELSE TO_CHAR(pkt_prz.ilosc, 'FM9999')
                         || ' <> ' ||
                         TO_CHAR(subjects.subj_ects, 'FM9999')
                  END ilosc_missmatch
                , (
                        V2U_Get.Semester(code => pkt_prz.cdyd_kon).id
                    -   V2U_Get.Semester(code => pkt_prz.cdyd_pocz).id
                  ) cdyd_diff
            FROM v2u_ko_subject_map_j subj_m_j
            INNER JOIN v2u_ko_specialty_map_j spec_m_j
                ON  (
                            spec_m_j.specialty_id = subj_m_j.specialty_id
                        AND spec_m_j.semester_id = subj_m_j.semester_id
                        AND spec_m_j.job_uuid = subj_m_j.job_uuid
                    )
            INNER JOIN v2u_subject_map subject_map
                ON  (
                            subject_map.id = subj_m_j.map_id
                        AND subject_map.map_subj_code IS NOT NULL
                    )
            INNER JOIN v2u_specialty_map specialty_map
                ON  (
                            specialty_map.id = spec_m_j.map_id
                    )
            INNER JOIN v2u_ko_subjects subjects
                ON  (
                            subjects.id = subj_m_j.subject_id
                        AND subjects.job_uuid = subj_m_j.job_uuid
                    )
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = subj_m_j.semester_id
                        AND semesters.job_uuid = subj_m_j.job_uuid
                    )
            INNER JOIN v2u_dz_punkty_przedmiotow pkt_prz
                ON  (
                            pkt_prz.prz_kod = subject_map.map_subj_code
                        AND (
                                    pkt_prz.prg_kod = specialty_map.map_program_code
                                OR  pkt_prz.prg_kod IS NULL
                            )
                        AND (
                                semesters.semester_code
                                    BETWEEN
                                pkt_prz.cdyd_pocz
                                    AND
                                COALESCE(pkt_prz.cdyd_kon, '9999Z')
                            )
                    )
            WHERE subj_m_j.selected = 1
        ),
        v AS
        (   -- eliminate redundant matches (pktprz_ids) as follows
            --  * prefer narrower semester ranges over wider ones, and
            --  * prefer non-NULL prg_kod over NULL ones
            SELECT
                  u.job_uuid
                , u.subject_id
                , u.specialty_id
                , u.semester_id
                , CAST(
                    COLLECT(u.subject_map_id
                            ORDER BY u.prz_kod, u.cdyd_diff, u.prg_kod)
                    AS V2u_Ids_t
                  ) subject_map_ids
                , CAST(
                    COLLECT(u.prz_kod
                            ORDER BY u.prz_kod, u.cdyd_diff, u.prg_kod)
                    AS V2u_Vchars1K_t
                  ) prz_kody1k
                , CAST(
                    COLLECT(u.pktprz_id
                            ORDER BY u.prz_kod, u.cdyd_diff, u.prg_kod)
                    AS V2u_Dz_Ids_t
                  ) pktprz_ids
                , CAST(
                    COLLECT(u.prg_kod
                            ORDER BY u.prz_kod, u.cdyd_diff, u.prg_kod)
                    AS V2u_Vchars1K_t
                  ) prg_kody1k
                , CAST(
                    COLLECT(u.cdyd_pocz
                            ORDER BY u.prz_kod, u.cdyd_diff, u.prg_kod)
                    AS V2u_Vchars1K_t
                  ) cdyd_pocz1k
                , CAST(
                    COLLECT(u.cdyd_kon
                            ORDER BY u.prz_kod, u.cdyd_diff, u.prg_kod)
                    AS V2u_Vchars1K_t
                  ) cdyd_kon1k
                , CAST(
                    COLLECT(u.ilosc_missmatch
                            ORDER BY u.prz_kod, u.cdyd_diff, u.prg_kod)
                    AS V2u_Vchars1K_t
                  ) ilosc_missmatch1k
            FROM u u
            GROUP BY
                  u.job_uuid
                , u.subject_id
                , u.specialty_id
                , u.semester_id
        )
        SELECT
              v.job_uuid
            , v.subject_id
            , v.specialty_id
            , v.semester_id
            , ( SELECT VALUE(t)
                FROM TABLE(v.subject_map_ids) t
                WHERE ROWNUM <= 1
              ) subject_map_id
            , ( SELECT SUBSTR(VALUE(t), 1, 20)
                FROM TABLE(v.prz_kody1k) t
                WHERE ROWNUM <= 1
              ) prz_kod
            , ( SELECT VALUE(t)
                FROM TABLE(v.pktprz_ids) t
                WHERE ROWNUM <= 1
              ) pktprz_id
            , ( SELECT SUBSTR(VALUE(t), 1, 20)
                FROM TABLE(v.prg_kody1k) t
                WHERE ROWNUM <= 1
              ) prg_kod
            , ( SELECT SUBSTR(VALUE(t), 1, 20)
                FROM TABLE(v.cdyd_pocz1k) t
                WHERE ROWNUM <= 1
              ) cdyd_pocz
            , ( SELECT SUBSTR(VALUE(t), 1, 20)
                FROM TABLE(v.cdyd_kon1k) t
                WHERE ROWNUM <= 1
              ) cdyd_kon
            , ( SELECT SUBSTR(VALUE(t), 1, 20)
                FROM TABLE(v.ilosc_missmatch1k) t
                WHERE ROWNUM <= 1
              ) ilosc_missmatch
        FROM v v
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
        , prz_kod
        , pktprz_id
        , prg_kod
        , cdyd_pocz
        , cdyd_kon
        , ilosc_missmatch
        )
    VALUES
        ( src.job_uuid
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.subject_map_id
        , src.prz_kod
        , src.pktprz_id
        , src.prg_kod
        , src.cdyd_pocz
        , src.cdyd_kon
        , src.ilosc_missmatch
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subject_map_id = src.subject_map_id
        , tgt.prz_kod = src.prz_kod
        , tgt.pktprz_id = src.pktprz_id
        , tgt.prg_kod = src.prg_kod
        , tgt.cdyd_pocz = src.cdyd_pocz
        , tgt.cdyd_kon = src.cdyd_kon
        , tgt.ilosc_missmatch = src.ilosc_missmatch
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
