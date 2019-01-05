CREATE OR REPLACE VIEW v2u_ko_classes_semesters_v
OF V2u_Ko_Classes_Semester_V_t
WITH OBJECT IDENTIFIER (job_uuid, semester_id, specialty_id, subject_id, classes_type)
AS
    SELECT
        V2u_Ko_Classes_Semester_V_t(
              subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , classes_type => j.classes_type
            , classes_hours => j.classes_hours
        ) spec_sem
    FROM v2u_ko_subjects subjects
    INNER JOIN v2u_ko_classes_semesters_j j
        ON  (
                    j.subject_id = subjects.id
                AND j.job_uuid = subjects.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = j.specialty_id
                AND specialties.job_uuid = subjects.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = j.semester_id
                AND semesters.job_uuid = subjects.job_uuid
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
