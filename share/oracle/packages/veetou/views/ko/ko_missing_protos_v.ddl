CREATE OR REPLACE VIEW v2u_ko_missing_protos_v
OF V2u_Ko_Missing_Proto_V_t
WITH OBJECT IDENTIFIER  ( job_uuid
                        , subject_id
                        , specialty_id
                        , semester_id
                        , classes_type
                        , student_id
                        )
AS
    SELECT
          V2u_Ko_Missing_Proto_V_t(
              missing_proto_j => VALUE(mi_protos_j)
            , subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , student => VALUE(students)
        )
    FROM v2u_ko_missing_protos_j mi_protos_j
    INNER JOIN v2u_ko_subjects subjects
        ON  (
                    subjects.id = mi_protos_j.subject_id
               AND subjects.job_uuid = mi_protos_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = mi_protos_j.specialty_id
                AND specialties.job_uuid = mi_protos_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = mi_protos_j.semester_id
                AND semesters.job_uuid = mi_protos_j.job_uuid
            )
    INNER JOIN v2u_ko_students students
        ON  (
                    students.id = mi_protos_j.student_id
               AND students.job_uuid = mi_protos_j.job_uuid
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
