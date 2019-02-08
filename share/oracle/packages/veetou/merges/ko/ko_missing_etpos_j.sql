MERGE INTO v2u_ko_missing_etpos_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  j1.job_uuid job_uuid
                , j1.student_id student_id
                , j1.specialty_id specialty_id
                , j1.semester_id semester_id
                , CAST(COLLECT(DISTINCT j4.map_id) AS V2u_5Ids_t) tried_specialty_map_ids
                , CAST(COLLECT(DISTINCT j3.prgos_id) AS V2u_Dz_5Ids_t) prgos_ids_all_semesters
            FROM v2u_ko_student_semesters_j j1
            LEFT JOIN v2u_ko_matched_etpos_j j2
                ON (j2.job_uuid = j1.job_uuid AND
                    j2.student_id = j1.student_id AND
                    j2.specialty_id = j1.specialty_id AND
                    j2.semester_id = j1.semester_id)
            LEFT JOIN v2u_ko_matched_prgos_j j3
                ON (j3.job_uuid = j1.job_uuid AND
                    j3.student_id = j1.student_id AND
                    j3.specialty_id = j1.specialty_id)
            LEFT JOIN v2u_ko_specialty_map_j j4
                ON (j4.specialty_id = j1.specialty_id AND
                    j4.semester_id = j1.semester_id AND
                    j4.job_uuid = j1.job_uuid)
            WHERE j2.id IS NULL
            GROUP BY
                  j1.job_uuid
                , j1.student_id
                , j1.specialty_id
                , j1.semester_id
        ),
        v AS
        (
            SELECT
                  u.*
                , VALUE(students) ko_student
                , VALUE(semesters) ko_semester
                , VALUE(studenci) dz_student
                , CAST(MULTISET(
                        -- find this semester in all other programs
                        SELECT VALUE(eo)
                        FROM v2u_dz_programy_osob po
                        INNER JOIN v2u_dz_etapy_osob eo
                            ON (eo.prgos_id = po.id)
                        WHERE (po.os_id = studenci.os_id AND
                               po.st_id = studenci.id AND
                               eo.cdyd_kod = semesters.semester_code)
                ) AS V2u_Dz_Etapy_Osob_t) all_etposes_for_semester
                , CAST(MULTISET(
                        SELECT VALUE(sm)
                        FROM v2u_specialty_map sm
                        WHERE sm.id IN (SELECT * FROM TABLE(u.tried_specialty_map_ids))
                  ) AS V2u_Specialty_Maps_t) tried_specialty_maps
            FROM u u
            LEFT JOIN v2u_ko_students students
                ON (students.id = u.student_id AND
                    students.job_uuid = u.job_uuid)
            LEFT JOIN v2u_ko_semesters semesters
                ON (semesters.id = u.semester_id AND
                    semesters.job_uuid = u.job_uuid)
            LEFT JOIN v2u_dz_studenci studenci
                ON (studenci.indeks = students.student_index)
        )
        SELECT
              v.job_uuid job_uuid
            , v.student_id student_id
            , v.specialty_id specialty_id
            , v.semester_id semester_id
            , v.tried_specialty_map_ids tried_specialty_map_ids
            , v.prgos_ids_all_semesters prgos_ids_all_semesters
            , CAST(MULTISET(
                    SELECT id
                    FROM TABLE(v.all_etposes_for_semester) eo
              ) AS V2u_Dz_5Ids_t) all_etpos_ids_for_semester
            , CAST(MULTISET(
                    SELECT map_program_code
                    FROM TABLE(v.tried_specialty_maps)
              ) AS V2u_Program_5Codes_t) tried_program_codes
            , CAST(MULTISET(
                    SELECT prg_kod
                    FROM TABLE(v.all_etposes_for_semester)
              ) AS V2u_Program_5Codes_t) all_etpos_progs_for_semester
        FROM v v
    ) src
ON  (tgt.job_uuid = src.job_uuid AND
     tgt.student_id = src.student_id AND
     tgt.specialty_id = src.specialty_id AND
     tgt.semester_id = src.semester_id)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     student_id,     specialty_id,     semester_id,     tried_specialty_map_ids,     prgos_ids_all_semesters,     all_etpos_ids_for_semester,     tried_program_codes,     all_etpos_progs_for_semester)
    VALUES (src.job_uuid, src.student_id, src.specialty_id, src.semester_id, src.tried_specialty_map_ids, src.prgos_ids_all_semesters, src.all_etpos_ids_for_semester, src.tried_program_codes, src.all_etpos_progs_for_semester)
WHEN MATCHED THEN UPDATE SET
      tgt.tried_specialty_map_ids = src.tried_specialty_map_ids
    , tgt.prgos_ids_all_semesters = src.prgos_ids_all_semesters
    , tgt.all_etpos_ids_for_semester = src.all_etpos_ids_for_semester
    , tgt.tried_program_codes = src.tried_program_codes
    , tgt.all_etpos_progs_for_semester = src.all_etpos_progs_for_semester
;
-- vim: set ft=sql ts=4 sw=4 et:
