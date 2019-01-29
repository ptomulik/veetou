MERGE INTO v2u_ko_specialty_sheets_j tgt
USING
    (
        WITH u AS
        (
            SELECT job_uuid, id, sheet_ids
            FROM v2u_ko_specialty_entities
        )
        SELECT
              u.job_uuid job_uuid
            , u.id specent_id
            , VALUE(t) sheet_id
        FROM u u
        CROSS JOIN TABLE(u.sheet_ids) t
    ) src
ON (tgt.sheet_id = src.sheet_id AND
    tgt.specent_id = src.specent_id AND
    tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     specent_id,     sheet_id)
    VALUES (src.job_uuid, src.specent_id, src.sheet_id);

-- vim: set ft=sql ts=4 sw=4 et:
