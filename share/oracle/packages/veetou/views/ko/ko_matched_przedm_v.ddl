CREATE OR REPLACE VIEW v2u_ko_matched_przedm_v
OF V2u_Ko_Matched_Przedm_V_t
WITH OBJECT IDENTIFIER (subject_id, specialty_id, semester_id, job_uuid)
AS
    SELECT
          V2u_Ko_Matched_Przedm_V_t(
              matched_przedm_j => VALUE(ma_przedm_j)
            , subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , przedmiot => VALUE(przedmioty)
        )
    FROM v2u_ko_matched_przedm_j ma_przedm_j
    INNER JOIN v2u_ko_subjects subjects
        ON  (
                    subjects.id = ma_przedm_j.subject_id
                AND subjects.job_uuid = ma_przedm_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = ma_przedm_j.specialty_id
                AND specialties.job_uuid = ma_przedm_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = ma_przedm_j.semester_id
                AND semesters.job_uuid = ma_przedm_j.job_uuid
            )
    INNER JOIN v2u_dz_przedmioty przedmioty
        ON  (
                    przedmioty.kod = ma_przedm_j.prz_kod
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
