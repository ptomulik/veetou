MERGE INTO v2u_ko_specialty_semesters_j tgt
USING
    (
        SELECT
              specialties.job_uuid job_uuid
            , specialties.id specialty_id
            , semesters.id semester_id
        FROM v2u_ko_specialties specialties
        INNER JOIN v2u_ko_specialty_sheets_j spc_sh_j
            ON  (
                        spc_sh_j.specialty_id = specialties.id
                    AND spc_sh_j.job_uuid = specialties.job_uuid
                )
        INNER JOIN v2u_ko_semester_sheets_j sem_sh_j
            ON  (
                        sem_sh_j.sheet_id = spc_sh_j.sheet_id
                    AND sem_sh_j.job_uuid = specialties.job_uuid
                )
        INNER JOIN v2u_ko_semesters semesters
            ON  (
                        semesters.id = sem_sh_j.semester_id
                    AND semesters.job_uuid = specialties.job_uuid
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
        , semester_id
        )
    VALUES
        ( src.job_uuid
        , src.specialty_id
        , src.semester_id
        )
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
