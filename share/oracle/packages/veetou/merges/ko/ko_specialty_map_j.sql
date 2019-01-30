MERGE INTO v2u_ko_specialty_map_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  j.job_uuid job_uuid
                , j.specialty_id specialty_id
                , j.semester_id semester_id
                , specialty_map.id map_id
                , V2U_Fit.Attributes(VALUE(specialty_map), VALUE(semesters)) matching_score
            FROM v2u_ko_specialty_semesters_j j
            INNER JOIN v2u_ko_specialties specialties
                ON (specialties.id = j.specialty_id AND
                    specialties.job_uuid = j.job_uuid)
            INNER JOIN v2u_ko_semesters semesters
                ON (semesters.id = j.semester_id AND
                    semesters.job_uuid = j.job_uuid)
            LEFT JOIN v2u_specialty_map specialty_map
            ON (specialty_map.university = specialties.university AND
                specialty_map.faculty = specialties.faculty AND
                specialty_map.studies_modetier = specialties.studies_modetier AND
                specialty_map.studies_field = specialties.studies_field AND
                (specialty_map.studies_specialty = specialties.studies_specialty OR
                (specialties.studies_specialty IS NULL AND specialty_map.studies_specialty IS NULL)))
        )
        SELECT * FROM u
        WHERE u.matching_score > 0
    ) src
ON (tgt.specialty_id = src.specialty_id AND
    tgt.semester_id = src.semester_id AND
    tgt.map_id = src.map_id AND
    tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     specialty_id,     semester_id,     map_id,     matching_score)
    VALUES (src.job_uuid, src.specialty_id, src.semester_id, src.map_id, src.matching_score)
WHEN MATCHED THEN
    UPDATE SET tgt.matching_score = src.matching_score;

-- vim: set ft=sql ts=4 sw=4 et:
