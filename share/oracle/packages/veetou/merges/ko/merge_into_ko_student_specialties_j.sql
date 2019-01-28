MERGE INTO v2u_ko_student_specialties_j tgt
USING
    (
        SELECT
              jsp.job_uuid job_uuid
            , jsp.specialty_id specialty_id
            , jst.student_id student_id
        FROM v2u_ko_specialty_sheets_j jsp
        INNER JOIN v2u_ko_student_sheets_j jst
        ON (jsp.sheet_id = jst.sheet_id AND jsp.job_uuid = jst.job_uuid)
    ) src
ON (tgt.job_uuid = src.job_uuid AND
    tgt.specialty_id = src.specialty_id AND
    tgt.student_id = src.student_id)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     student_id,     specialty_id)
    VALUES (src.job_uuid, src.student_id, src.specialty_id);

-- vim: set ft=sql ts=4 sw=4 et:
