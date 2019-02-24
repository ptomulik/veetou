MERGE INTO v2u_ux_programy_osob tgt
USING
    (
        WITH u AS
        (
            SELECT
                  ss_j.job_uuid
                , ss_j.student_id
                , ss_j.specialty_id
                , ss_j.semester_id
                , students.student_index
                , V2U_Get.Faculty(specialties.faculty).code faculty_code
                , SUBSTR(
                    specialties.studies_specialty
                    || ':' ||
                    specialties.studies_field
                    || ':' ||
                    specialties.studies_modetier
                    || ':' ||
                    specialties.faculty
                    || ':' ||
                    specialties.university
                  , 1, 128
                  ) specialty_string
            FROM v2u_ko_student_semesters_j ss_j
            INNER JOIN v2u_ko_students students
                ON  (
                            students.id = ss_j.student_id
                        AND students.job_uuid = ss_j.job_uuid
                    )
            INNER JOIN v2u_ko_specialties specialties
                ON  (
                            specialties.id = ss_j.specialty_id
                        AND specialties.job_uuid = ss_j.job_uuid
                    )
        ),
        v AS
        (
            SELECT
                  u.job_uuid
                , u.student_index student_index
                , COALESCE(
                      ma_prgos_j.prg_kod
                    , specialty_map.map_program_code
                    , u.specialty_string
                  ) coalesced_program_code
                , SET(CAST(
                    COLLECT(specialty_map.map_program_code)
                    AS V2u_Vchars1K_t
                  )) map_program_codes
                , SET(CAST(
                    COLLECT(u.faculty_code)
                    AS V2u_Vchars1K_t
                  )) faculty_codes
                , SET(CAST(
                    COLLECT(ma_prgos_j.prgos_id)
                    AS V2u_Dz_Ids_t
                  )) matched_ids
                , SET(CAST(
                    COLLECT(ma_prgos_j.prg_kod)
                    AS V2u_Vchars1K_t
                  )) matched_prg_kody
                , SET(CAST(
                    COLLECT(ma_prgos_j.st_id)
                    AS V2u_Dz_Ids_t
                  )) matched_st_ids
                , SET(CAST(
                    COLLECT(ma_prgos_j.os_id)
                    AS V2u_Dz_Ids_t
                  )) matched_os_ids
                , SET(CAST(
                    COLLECT(sk_progs_j.prg_kod)
                    AS V2u_Vchars1K_t
                  )) skipped_prg_kody
                , COUNT(DISTINCT specialty_map.map_program_code) dbg_map_program_codes
                , COUNT(DISTINCT u.faculty_code) dbg_faculty_codes
                , COUNT(DISTINCT ma_prgos_j.prgos_id) dbg_matched_ids
                , COUNT(DISTINCT ma_prgos_j.prg_kod) dbg_matched_prg_kody
                , COUNT(DISTINCT ma_prgos_j.st_id) dbg_matched_st_ids
                , COUNT(DISTINCT ma_prgos_j.os_id) dbg_matched_os_ids
                , COUNT(DISTINCT sk_progs_j.prg_kod) dbg_skipped_prg_kody
                , COUNT(ma_prgos_j.job_uuid) dbg_matched
                , COUNT(mi_prgos_j.job_uuid) dbg_missing
                , COUNT(sm_j.job_uuid) dbg_mapped
            FROM u u
            LEFT JOIN v2u_ko_matched_prgos_j ma_prgos_j
                ON  (
                            ma_prgos_j.student_id = u.student_id
                        AND ma_prgos_j.specialty_id = u.specialty_id
                        AND ma_prgos_j.semester_id = u.semester_id
                        AND ma_prgos_j.job_uuid = u.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_prgos_j mi_prgos_j
                ON  (
                            mi_prgos_j.student_id = u.student_id
                        AND mi_prgos_j.specialty_id = u.specialty_id
                        AND mi_prgos_j.semester_id = u.semester_id
                        AND mi_prgos_j.job_uuid = u.job_uuid
                    )
            LEFT JOIN v2u_ko_skipped_programs_j sk_progs_j
                ON  (
                            sk_progs_j.specialty_id =  u.specialty_id
                        AND sk_progs_j.semester_id = u.semester_id
                        AND sk_progs_j.job_uuid = u.job_uuid
                    )
            LEFT JOIN v2u_ko_specialty_map_j sm_j
                ON  (
                            sm_j.specialty_id = u.specialty_id
                        AND sm_j.semester_id = u.semester_id
                        AND sm_j.job_uuid = u.job_uuid
                    )
            LEFT JOIN v2u_specialty_map specialty_map
                ON  (
                            specialty_map.id = sm_j.map_id
                    )
            GROUP BY
                  u.job_uuid
                , u.student_index
                , COALESCE(
                      ma_prgos_j.prg_kod
                    , specialty_map.map_program_code
                    , u.specialty_string
                  )
        ),
        w AS
        (
            SELECT
                  v.job_uuid
                , v.student_index
                , v.coalesced_program_code
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(v.map_program_codes) t
                    WHERE ROWNUM <= 1
                  ) map_program_code
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(v.faculty_codes) t
                    WHERE ROWNUM <= 1
                  ) faculty_code
                , ( SELECT VALUE(t)
                    FROM TABLE(v.matched_ids) t
                    WHERE ROWNUM <= 1
                  ) matched_id
                , ( SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(v.matched_prg_kody) t
                    WHERE ROWNUM <= 1
                  ) matched_prg_kod
                , ( SELECT VALUE(t)
                    FROM TABLE(v.matched_st_ids) t
                    WHERE ROWNUM <= 1
                  ) matched_st_id
                , ( SELECT VALUE(t)
                    FROM TABLE(v.matched_os_ids) t
                    WHERE ROWNUM <= 1
                  ) matched_os_id
                , v.dbg_map_program_codes
                , v.dbg_faculty_codes
                , v.dbg_matched_ids
                , v.dbg_matched_prg_kody
                , v.dbg_matched_st_ids
                , v.dbg_matched_os_ids
                , v.dbg_skipped_prg_kody
                , v.dbg_matched
                , v.dbg_missing
                , v.dbg_mapped
                , studenci.id new_st_id
                , studenci.os_id new_os_id
                , CASE
                    WHEN
                            v.dbg_matched > 0
                        AND v.dbg_mapped = v.dbg_matched
                        AND v.dbg_missing = 0
                        AND v.dbg_matched_ids = 1
                    THEN 1
                    ELSE 0
                  END dbg_unique_match
            FROM v v
            LEFT JOIN v2u_dz_studenci studenci
                ON  (
                            studenci.indeks = v.student_index
                    )
        )
        SELECT
              w.*
            , DECODE(w.dbg_unique_match, 1, w.matched_os_id, w.new_os_id) os_id
            , DECODE(w.dbg_unique_match, 1, w.matched_prg_kod, w.map_program_code) prg_kod
            , DECODE(w.dbg_unique_match, 1, NULL, V2U_Get.Utw_Id(w.job_uuid)) utw_id
            , DECODE(w.dbg_unique_match, 1, NULL, V2U_Get.Mod_Id(w.job_uuid)) mod_id
            , DECODE(w.dbg_unique_match, 1, w.matched_st_id, w.new_st_id) st_id
            , DECODE(w.dbg_unique_match, 1, w.matched_id, NULL) id
            , DECODE(w.dbg_unique_match, 1, NULL, w.faculty_code) jed_org_kod
            , w.student_index pk_student_index
            , w.coalesced_program_code pk_program_code
            , CASE
                WHEN
                        w.map_program_code IS NOT NULL
                    AND w.dbg_map_program_codes = 1
                    -- maps for all instances existed but there were no
                    -- corresponding prgoses in target system
                    AND w.dbg_matched = 0
                    AND w.dbg_missing > 0
                    AND w.dbg_mapped = w.dbg_missing
                    -- ensure that there are no other propositions
                    AND w.dbg_matched_prg_kody <= 1
                    AND w.dbg_skipped_prg_kody = 0
                    -- ensure we found target entry for the student
                    AND w.new_os_id IS NOT NULL
                    AND w.new_st_id IS NOT NULL
                    --
                    AND w.faculty_code IS NOT NULL
                    AND w.dbg_faculty_codes = 1
                THEN 1
                ELSE 0
             END safe_to_add
        FROM w w
    ) src
ON  (
            tgt.pk_student_index = src.pk_student_index
        AND tgt.pk_program_code = src.pk_program_code
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( os_id
        , prg_kod
        , utw_id
        , mod_id
        , st_id
        , id
        , jed_org_kod
        , job_uuid
        , pk_student_index
        , pk_program_code
        , dbg_unique_match
        , dbg_map_program_codes
        , dbg_faculty_codes
        , dbg_matched_ids
        , dbg_matched_prg_kody
        , dbg_matched_st_ids
        , dbg_matched_os_ids
        , dbg_skipped_prg_kody
        , dbg_matched
        , dbg_missing
        , dbg_mapped
        , safe_to_add
        )
    VALUES
        ( src.os_id
        , src.prg_kod
        , src.utw_id
        , src.mod_id
        , src.st_id
        , src.id
        , src.jed_org_kod
        , src.job_uuid
        , src.pk_student_index
        , src.pk_program_code
        , src.dbg_unique_match
        , src.dbg_map_program_codes
        , src.dbg_faculty_codes
        , src.dbg_matched_ids
        , src.dbg_matched_prg_kody
        , src.dbg_matched_st_ids
        , src.dbg_matched_os_ids
        , src.dbg_skipped_prg_kody
        , src.dbg_matched
        , src.dbg_missing
        , src.dbg_mapped
        , src.safe_to_add
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.os_id = src.os_id
        , tgt.prg_kod = src.prg_kod
        , tgt.utw_id = src.utw_id
        , tgt.mod_id = src.mod_id
        , tgt.st_id = src.st_id
        , tgt.id = src.id
        , tgt.jed_org_kod = src.jed_org_kod
        , tgt.dbg_unique_match = src.dbg_unique_match
        , tgt.dbg_map_program_codes = src.dbg_map_program_codes
        , tgt.dbg_faculty_codes = src.dbg_faculty_codes
        , tgt.dbg_matched_ids = src.dbg_matched_ids
        , tgt.dbg_matched_prg_kody = src.dbg_matched_prg_kody
        , tgt.dbg_matched_st_ids = src.dbg_matched_st_ids
        , tgt.dbg_matched_os_ids = src.dbg_matched_os_ids
        , tgt.dbg_skipped_prg_kody = src.dbg_skipped_prg_kody
        , tgt.dbg_matched = src.dbg_matched
        , tgt.dbg_missing = src.dbg_missing
        , tgt.dbg_mapped = src.dbg_mapped
        , tgt.safe_to_add = src.safe_to_add
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
