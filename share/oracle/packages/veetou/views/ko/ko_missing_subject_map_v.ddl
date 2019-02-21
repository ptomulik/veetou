CREATE OR REPLACE VIEW v2u_ko_missing_subject_map_v
OF V2u_Ko_Missing_Subject_Map_V_t
WITH OBJECT IDENTIFIER (job_uuid, subject_id, specialty_id, semester_id)
AS
    SELECT
          V2u_Ko_Missing_Subject_Map_V_t(
              subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
          )
    FROM v2u_ko_subject_semesters_j ss_j
    INNER JOIN v2u_ko_subjects subjects
        ON  (
                    subjects.id = ss_j.subject_id
                AND subjects.job_uuid = ss_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = ss_j.specialty_id
                AND specialties.job_uuid = ss_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = ss_j.semester_id
                AND semesters.job_uuid = ss_j.job_uuid
            )
    LEFT JOIN v2u_ko_subject_map_j sm_j
        ON  (
                    sm_j.subject_id = ss_j.subject_id
                AND sm_j.specialty_id = ss_j.specialty_id
                AND sm_j.semester_id = ss_j.semester_id
                AND sm_j.job_uuid = ss_j.job_uuid
                AND sm_j.selected = 1
            )
    WHERE sm_j.map_id IS NULL
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
