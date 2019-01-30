MERGE INTO v2u_ko_specialty_semesters_j tgt
USING
    (
        SELECT
              specialties.job_uuid job_uuid
            , specialties.id specialty_id
            , semesters.id semester_id
        FROM v2u_ko_specialties specialties
        INNER JOIN v2u_ko_specialty_sheets_j j1
            ON (specialties.id = j1.specialty_id AND specialties.job_uuid = j1.job_uuid)
        INNER JOIN v2u_ko_semester_sheets_j j2
            ON (j1.sheet_id = j2.sheet_id AND j1.job_uuid = j2.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = j2.semester_id AND semesters.job_uuid = j2.job_uuid)
        GROUP BY specialties.job_uuid, specialties.id, semesters.id
    ) src
ON  (src.specialty_id = tgt.specialty_id AND
     src.semester_id = tgt.semester_id AND
     src.job_uuid = tgt.job_uuid)
WHEN NOT MATCHED THEN INSERT  (    job_uuid,     specialty_id,     semester_id)
                        VALUES(src.job_uuid, src.specialty_id, src.semester_id);

-- vim: set ft=sql ts=4 sw=4 et:
