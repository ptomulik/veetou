CREATE OR REPLACE VIEW v2u_ko_matched_protos_v
OF V2u_Ko_Matched_Proto_V_t
WITH OBJECT IDENTIFIER (  student_id
                        , classes_type
                        , subject_id
                        , specialty_id
                        , semester_id
                        , job_uuid)
AS
    SELECT
          V2u_Ko_Matched_Proto_V_t(
              matched_proto_j => VALUE(ma_protos_j)
            , student => VALUE(students)
            , subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , protokol => VALUE(protokoly)
        )
    FROM v2u_ko_matched_protos_j ma_protos_j
    INNER JOIN v2u_ko_students students
        ON  (
                    students.id = ma_protos_j.student_id
                AND students.job_uuid = ma_protos_j.job_uuid
            )
    INNER JOIN v2u_ko_subjects subjects
        ON  (
                    subjects.id = ma_protos_j.subject_id
                AND subjects.job_uuid = ma_protos_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = ma_protos_j.specialty_id
                AND specialties.job_uuid = ma_protos_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = ma_protos_j.semester_id
                AND semesters.job_uuid = ma_protos_j.job_uuid
            )
    INNER JOIN v2u_dz_protokoly protokoly
        ON  (
                protokoly.id = ma_protos_j.prot_id
            )
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
