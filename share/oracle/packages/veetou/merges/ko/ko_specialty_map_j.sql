MERGE INTO v2u_ko_specialty_map_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  VALUE(ss).job_uuid job_uuid
                , ss.id specsem_id
                , sm.id specmap_id
                , V2U_Fit.Attributes(VALUE(sm), VALUE(ss)) matching_score
            FROM v2u_ko_specsems ss
            LEFT JOIN v2u_specialty_map sm
            ON (sm.university = ss.specialty.university AND
                sm.faculty = ss.specialty.faculty AND
                sm.studies_modetier = ss.specialty.studies_modetier AND
                sm.studies_field = ss.specialty.studies_field AND
                (sm.studies_specialty = ss.specialty.studies_specialty OR
                (ss.specialty.studies_specialty IS NULL AND sm.studies_specialty IS NULL)))
        )
        SELECT * FROM u
        WHERE u.matching_score > 0
        ORDER BY specsem_id
    ) src
ON (tgt.specmap_id = src.specmap_id AND
    tgt.specsem_id = src.specsem_id AND
    tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     specsem_id,     specmap_id,     matching_score)
    VALUES (src.job_uuid, src.specsem_id, src.specmap_id, src.matching_score)
WHEN MATCHED THEN
    UPDATE SET tgt.matching_score = src.matching_score;

-- vim: set ft=sql ts=4 sw=4 et:
