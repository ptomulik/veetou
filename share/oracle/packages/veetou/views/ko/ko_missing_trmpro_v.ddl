CREATE OR REPLACE VIEW v2u_ko_missing_trmpro_v
OF V2u_Ko_Missing_Trmpro_V_t
WITH OBJECT IDENTIFIER (job_uuid, subject_id, specialty_id, semester_id, classes_type)
AS
    SELECT
          V2u_Ko_Missing_Trmpro_V_t(
              missing_trmpro_j => VALUE(mi_trmpro_j)
            , subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
        )
    FROM v2u_ko_missing_trmpro_j mi_trmpro_j
    INNER JOIN v2u_ko_subjects subjects
        ON  (
                    subjects.id = mi_trmpro_j.subject_id
               AND subjects.job_uuid = mi_trmpro_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = mi_trmpro_j.specialty_id
                AND specialties.job_uuid = mi_trmpro_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = mi_trmpro_j.semester_id
                AND semesters.job_uuid = mi_trmpro_j.job_uuid
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
