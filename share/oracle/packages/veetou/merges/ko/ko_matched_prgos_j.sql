MERGE INTO v2u_ko_matched_prgos_j tgt
USING
    (
        SELECT
              j.job_uuid
            , j.student_id student_id
            , j.specialty_id specialty_id
            , e.prgos_id prgos_id
            , CAST(COLLECT(j.semester_id) AS V2u_Ids_t) semester_ids
        FROM v2u_ko_matched_etpos_j j
        INNER JOIN v2u_dz_etapy_osob e
            ON (e.id = j.etpos_id)
        GROUP BY
              j.job_uuid
            , j.student_id
            , j.specialty_id
            , e.prgos_id
    ) src
ON  (tgt.job_uuid = src.job_uuid AND
     tgt.student_id = src.student_id AND
     tgt.specialty_id = src.specialty_id AND
     tgt.prgos_id = src.prgos_id)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     student_id,     specialty_id,     prgos_id,     semester_ids)
    VALUES (src.job_uuid, src.student_id, src.specialty_id, src.prgos_id, src.semester_ids)
WHEN MATCHED THEN UPDATE SET tgt.semester_ids = src.semester_ids;

-- vim: set ft=sql ts=4 sw=4 et:
