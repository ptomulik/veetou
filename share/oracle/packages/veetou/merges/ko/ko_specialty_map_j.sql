MERGE INTO v2u_ko_specialty_map_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  VALUE(si).job_uuid job_uuid
                , si.id specent_id
                , sm.id specmap_id
                , V2U_Fit.Attributes(VALUE(sm), VALUE(si)) matching_score
            FROM v2u_ko_specialty_entities si
            LEFT JOIN v2u_specialty_map sm
            ON (sm.university = si.university AND
                sm.faculty = si.faculty AND
                sm.studies_modetier = si.studies_modetier AND
                sm.studies_field = si.studies_field AND
                (sm.studies_specialty = si.studies_specialty OR
                (si.studies_specialty IS NULL AND sm.studies_specialty IS NULL)))
        )
        SELECT * FROM u
        WHERE u.matching_score > 0
        ORDER BY specent_id
    ) src
ON (tgt.specmap_id = src.specmap_id AND
    tgt.specent_id = src.specent_id AND
    tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     specent_id,     specmap_id,     matching_score)
    VALUES (src.job_uuid, src.specent_id, src.specmap_id, src.matching_score)
WHEN MATCHED THEN
    UPDATE SET tgt.matching_score = src.matching_score;

-- vim: set ft=sql ts=4 sw=4 et:
