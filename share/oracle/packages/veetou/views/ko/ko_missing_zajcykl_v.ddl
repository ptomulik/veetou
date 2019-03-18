CREATE OR REPLACE VIEW v2u_ko_missing_zajcykl_v
OF V2u_Ko_Missing_Zajcykl_V_t
WITH OBJECT IDENTIFIER (job_uuid, subject_id, specialty_id, semester_id)
AS
    SELECT
          V2u_Ko_Missing_Zajcykl_V_t(
              subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , classes_type => mi_zajcykl_j.classes_type
            , classes_hours => mi_zajcykl_j.classes_hours
            , subject_map_id => mi_zajcykl_j.subject_map_id
            , map_subj_code => mi_zajcykl_j.map_subj_code
            , classes_map_id => mi_zajcykl_j.classes_map_id
            , map_classes_type => mi_zajcykl_j.map_classes_type
            , reason => mi_zajcykl_j.reason
            , istniejace_tzaj_kody => mi_zajcykl_j.istniejace_tzaj_kody
        )
    FROM v2u_ko_missing_zajcykl_j mi_zajcykl_j
    INNER JOIN v2u_ko_subjects subjects
        ON  (
                    subjects.id = mi_zajcykl_j.subject_id
               AND subjects.job_uuid = mi_zajcykl_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = mi_zajcykl_j.specialty_id
                AND specialties.job_uuid = mi_zajcykl_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = mi_zajcykl_j.semester_id
                AND semesters.job_uuid = mi_zajcykl_j.job_uuid
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
