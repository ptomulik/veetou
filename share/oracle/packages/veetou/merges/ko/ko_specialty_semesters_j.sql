MERGE INTO v2u_ko_specialty_semesters_j tgt
USING
    (
        SELECT
              specialties.job_uuid job_uuid
            , specialties.id specialty_id
            , semesters.id semester_id
        FROM v2u_ko_specialties specialties
        INNER JOIN v2u_ko_specialty_sheets_j spcsh_j
            ON  (
                        specialties.id = spcsh_j.specialty_id
                    AND specialties.job_uuid = spcsh_j.job_uuid
                )
        INNER JOIN v2u_ko_semester_sheets_j semsh_j
            ON  (
                        spcsh_j.sheet_id = semsh_j.sheet_id
                    AND spcsh_j.job_uuid = semsh_j.job_uuid
                )
        INNER JOIN v2u_ko_semesters semesters
            ON  (
                        semesters.id = semsh_j.semester_id
                    AND semesters.job_uuid = semsh_j.job_uuid
                )
        GROUP BY
              specialties.job_uuid
            , specialties.id
            , semesters.id
    ) src
ON  (
            src.specialty_id = tgt.specialty_id
        AND src.semester_id = tgt.semester_id
        AND src.job_uuid = tgt.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , specialty_id
        , semester_id)
    VALUES
        ( src.job_uuid
        , src.specialty_id
        , src.semester_id
        )
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
