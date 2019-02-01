MERGE INTO v2u_ko_subject_map_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  j.job_uuid job_uuid
                , j.subject_id subject_id
                , j.specialty_id specialty_id
                , j.semester_id semester_id
                , subject_map.id map_id
                , V2U_Fit.Attributes(
                          VALUE(subject_map)
                        , VALUE(subjects)
                        , VALUE(specialties)
                        , VALUE(semesters)
                  ) matching_score
            FROM v2u_ko_subject_semesters_j j
            INNER JOIN v2u_ko_subjects subjects
                ON (subjects.id = j.subject_id AND
                    subjects.job_uuid = j.job_uuid)
            INNER JOIN v2u_ko_specialties specialties
                ON (specialties.id = j.specialty_id AND
                    specialties.job_uuid = j.job_uuid)
            INNER JOIN v2u_ko_semesters semesters
                ON (semesters.id = j.semester_id AND
                    semesters.job_uuid = j.job_uuid)
            LEFT JOIN v2u_subject_map subject_map
                ON (subject_map.subj_code = subjects.subj_code)
        )
        SELECT * FROM u
        WHERE u.matching_score > 0
    ) src
ON (tgt.subject_id = src.subject_id AND
    tgt.specialty_id = src.specialty_id AND
    tgt.semester_id = src.semester_id AND
    tgt.map_id = src.map_id AND
    tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     subject_id,     specialty_id,     semester_id,     map_id,     matching_score)
    VALUES (src.job_uuid, src.subject_id, src.specialty_id, src.semester_id, src.map_id, src.matching_score)
WHEN MATCHED THEN
    UPDATE SET tgt.matching_score = src.matching_score;

-- vim: set ft=sql ts=4 sw=4 et:
