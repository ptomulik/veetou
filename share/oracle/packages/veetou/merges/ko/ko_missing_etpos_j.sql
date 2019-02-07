MERGE INTO v2u_ko_missing_etpos_j tgt
USING
    (
        SELECT
              j1.job_uuid job_uuid
            , j1.student_id student_id
            , j1.specialty_id specialty_id
            , j1.semester_id semester_id
            , CAST(COLLECT(DISTINCT j4.map_id) AS V2u_Ids_t) specialty_map_ids
            , CAST(COLLECT(DISTINCT j3.prgos_id) AS V2u_Dz_Ids_t) prgos_ids
        FROM v2u_ko_student_semesters_j j1
        LEFT JOIN v2u_ko_etapy_osob_j j2
            ON (j2.job_uuid = j1.job_uuid AND
                j2.student_id = j1.student_id AND
                j2.specialty_id = j1.specialty_id AND
                j2.semester_id = j1.semester_id)
        LEFT JOIN v2u_ko_programy_osob_j j3
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
    ) src
ON  (tgt.job_uuid = src.job_uuid AND
     tgt.student_id = src.student_id AND
     tgt.specialty_id = src.specialty_id AND
     tgt.semester_id = src.semester_id)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     student_id,     specialty_id,     semester_id,     specialty_map_ids,     prgos_ids)
    VALUES (src.job_uuid, src.student_id, src.specialty_id, src.semester_id, src.specialty_map_ids, src.prgos_ids)
WHEN MATCHED THEN UPDATE SET
      tgt.specialty_map_ids = src.specialty_map_ids
    , tgt.prgos_ids = src.prgos_ids
;
-- vim: set ft=sql ts=4 sw=4 et:
