MERGE INTO v2u_ux_programy_osob tgt
USING
    (
        WITH u AS
        (
            SELECT
                  ss_j.job_uuid
                , students.student_index
                , COALESCE(
                      ma_prgos_j.prg_kod
                    , V2u_Get.Alt_Prg_Code(VALUE(specialties))
                  ) coalesced_program_code
                , SET(CAST(
                    COLLECT(specialty_map.map_program_code)
                    AS V2u_Vchars1K_t
                  )) map_program_codes
                , COUNT(ma_prgos_j.job_uuid) dbg_matched
                , COUNT(mi_prgos_j.job_uuid) dbg_missing
                , COUNT(sm_j.job_uuid) dbg_mapped
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
            INNER JOIN v2u_ko_semesters semesters
                ON  (
                            semesters.id = ss_j.semester_id
                        AND semesters.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_matched_prgos_j ma_prgos_j
                ON  (
                            ma_prgos_j.student_id = ss_j.student_id
                        AND ma_prgos_j.specialty_id = ss_j.specialty_id
                        AND ma_prgos_j.semester_id = ss_j.semester_id
                        AND ma_prgos_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_missing_prgos_j mi_prgos_j
                ON  (
                            mi_prgos_j.student_id = ss_j.student_id
                        AND mi_prgos_j.specialty_id = ss_j.specialty_id
                        AND mi_prgos_j.semester_id = ss_j.semester_id
                        AND mi_prgos_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_ko_specialty_map_j sm_j
                ON  (
                            sm_j.specialty_id = ss_j.specialty_id
                        AND sm_j.semester_id = ss_j.semester_id
                        AND sm_j.job_uuid = ss_j.job_uuid
                    )
            LEFT JOIN v2u_specialty_map specialty_map
                ON  (
                            specialty_map.id = sm_j.map_id
                    )
            GROUP BY
                  ss_j.job_uuid
                , students.student_index
                , COALESCE(
                      ma_prgos_j.prg_kod
                    , V2u_Get.Alt_Prg_Code(VALUE(specialties))
                  )
        ),
        v AS
        (
            SELECT
                  u.job_uuid
                , u.student_index
                , u.coalesced_program_code
                , CAST(MULTISET(
                    SELECT SUBSTR(VALUE(t), 1, 20)
                    FROM TABLE(u.map_
            FROM u u
        )
    )
ON  (
    )
WHEN NOT MATCHED THEN
    INSERT
        (
        )
    VALUES
        (
        )
WHEN MATCHED THEN
    UPDATE SET
        tgt.xxx = src.xxx
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
