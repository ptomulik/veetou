MERGE INTO v2u_ko_skipped_programs_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  ss_j.job_uuid
                , ss_j.specialty_id
                , ss_j.semester_id
                , V2u_Get.Studies_Mode(specialties.studies_modetier) where_tryb_studiow
                , V2u_Get.Studies_Tier(specialties.studies_modetier) where_rodzaj_studiow
                , V2u_Get.Faculty(specialties.faculty).code faculty_code
                , LOWER(specialties.studies_field) || '%') where_opis_like
            FROM v2u_ko_specialty_semesters_j ss_j
            INNER JOIN v2u_ko_specialties specialties
                ON  (
                            specialties.id = ss_j.specialty_id
                        AND specialties.job_uuid = ss_j.job_uuid
                    )
        )
        SELECT
              u.job_uuid
            , u.specialty_id
            , u.semester_id
            , programy.kod prg_kod
            , u.where_tryb_studiow
            , u.where_rodzaj_studiow
            , u.where_jed_org_kod_podst
            , u.where_opis_like
        FROM u u
        INNER JOIN v2u_dz_programy programy
            ON  (
                        programy.jed_org_kod_podst = u.where_jed_org_kod_podst
                    AND programy.tryb_studiow = u.where_tryb_studiow
                    AND programy.rodzaj_studiow = u.where_rodzaj_studiow
                    AND LOWER(programy.opis) LIKE u.where_opis_like
                )
        LEFT JOIN v2u_ko_specialty_map_j sm_j
            ON  (
                        sm_j.specialty_id = u.specialty_id
                    AND sm_j.semester_id = u.semester_id
                    AND sm_j.job_uuid = u.job_uuid
                )
        LEFT JOIN v2u_specialty_map specialty_map
            ON  (
                        specialty_map.id = sm_j.map_id
                    AND specialty_map.map_program_code = programy.kod
                )
        GROUP BY
              u.job_uuid
            , u.specialty_id
            , u.semester_id
            , programy.kod
            , u.studies_mode
            , u.studies_tier
            , u.faculty_code
            , u.where_opis_like
        HAVING COUNT(specialty_map.id) = 0
    ) src
ON  (
            src.specialty_id = tgt.specialty_id
        AND src.semester_id = tgt.semester_id
        AND src.job_uuid = tgt.job_uuid
        AND src.prg_kod = tgt.prg_kod
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , specialty_id
        , semester_id
        , prg_kod
        , where_tryb_studiow
        , where_rodzaj_studiow
        , where_jed_org_kod_podst
        , where_opis_like
        )
    VALUES
        ( src.job_uuid
        , src.specialty_id
        , src.semester_id
        , src.prg_kod
        , src.where_tryb_studiow
        , src.where_rodzaj_studiow
        , src.where_jed_org_kod_podst
        , src.where_opis_like
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.where_tryb_studiow = src.where_tryb_studiow
        , tgt.where_rodzaj_studiow = src.where_rodzaj_studiow
        , tgt.where_jed_org_kod_podst = src.where_jed_org_kod_podst
        , tgt.where_opis_like = src.where_opis_like
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
