MERGE INTO v2u_ko_student_specialties_j tgt
USING
    (
        SELECT
              j1.job_uuid job_uuid
            , j1.specent_id specent_id
            , j2.student_id student_id
            , j2.sheet_id sheet_id
        FROM v2u_ko_specent_sheets_j j1
        INNER JOIN v2u_ko_student_sheets_j j2
        ON (j1.sheet_id = j2.sheet_id AND j1.job_uuid = j2.job_uuid)
    ) src
ON (tgt.job_uuid = src.job_uuid AND
    tgt.specent_id = src.specent_id AND
    tgt.student_id = src.student_id AND
    tgt.sheet_id = src.sheet_id)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     student_id,     specent_id,     sheet_id)
    VALUES (src.job_uuid, src.student_id, src.specent_id, src.sheet_id);
--WHEN MATCHED THEN UPDATE SET tgt.sheet_id = src.sheet_id;

-- vim: set ft=sql ts=4 sw=4 et:
