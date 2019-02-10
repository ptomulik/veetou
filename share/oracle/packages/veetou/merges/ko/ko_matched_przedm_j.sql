MERGE INTO v2u_ko_matched_przedm_j tgt
USING
    (
        SELECT
              u.job_uuid job_uuid
            , u.subject_id subject_id
            , u.specialty_id specialty_id
            , u.semester_id semester_id
            , u.map_id subject_map_id
            , u.matching_score matching_score
            , m.map_subj_code prz_kod
        FROM v2u_ko_subject_map_j u
        INNER JOIN v2u_subject_map m
            ON (m.id = u.map_id AND m.map_subj_code IS NOT NULL)
        INNER JOIN v2u_dz_przedmioty p
            ON (p.kod = m.map_subj_code)
        WHERE u.selected = 1
    ) src
ON  ( tgt.job_uuid = src.job_uuid AND
      tgt.subject_id = src.subject_id AND
      tgt.specialty_id = src.specialty_id AND
      tgt.semester_id = src.semester_id )
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     subject_id,     specialty_id,     semester_id,     subject_map_id,     matching_score,     prz_kod)
    VALUES (src.job_uuid, src.subject_id, src.specialty_id, src.semester_id, src.subject_map_id, src.matching_score, src.prz_kod)
WHEN MATCHED THEN UPDATE SET
      tgt.subject_map_id = src.subject_map_id
    , tgt.matching_score = src.matching_score
    , tgt.prz_kod = src.prz_kod
;
-- vim: set ft=sql ts=4 sw=4 et:
