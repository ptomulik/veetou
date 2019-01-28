MERGE INTO v2u_ko_subject_map_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  VALUE(si).job_uuid job_uuid
                , si.id subject_issue_id
                , sm.id subject_map_id
                , V2U_Fit.Attributes(VALUE(sm), VALUE(si)) matching_score
            FROM v2u_ko_subject_issues si
            LEFT JOIN v2u_subject_map sm
            ON sm.subj_code = si.subj_code
        )
        SELECT * FROM u
        WHERE u.matching_score > 0
        ORDER BY subject_issue_id
    ) src
ON (tgt.subject_map_id = src.subject_map_id AND
    tgt.subject_issue_id = src.subject_issue_id AND
    tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     subject_issue_id,     subject_map_id,     matching_score)
    VALUES (src.job_uuid, src.subject_issue_id, src.subject_map_id, src.matching_score)
WHEN MATCHED THEN
    UPDATE SET tgt.matching_score = src.matching_score;

-- vim: set ft=sql ts=4 sw=4 et:
