CREATE OR REPLACE VIEW v2u_ko_matched_przcykl_v
OF V2u_Ko_Matched_Przcykl_V_t
WITH OBJECT IDENTIFIER (subject_id, specialty_id, semester_id, job_uuid)
AS
    SELECT
          V2u_Ko_Matched_Przcykl_V_t(
              matched_przcykl_j => VALUE(ma_przcykl_j)
            , subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , przedmiot_cyklu => VALUE(przedmioty_cykli)
        )
    FROM v2u_ko_matched_przcykl_j ma_przcykl_j
    INNER JOIN v2u_ko_subjects subjects
        ON  (
                    subjects.id = ma_przcykl_j.subject_id
                AND subjects.job_uuid = ma_przcykl_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = ma_przcykl_j.specialty_id
                AND specialties.job_uuid = ma_przcykl_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = ma_przcykl_j.semester_id
                AND semesters.job_uuid = ma_przcykl_j.job_uuid
            )
    INNER JOIN v2u_dz_przedmioty_cykli przedmioty_cykli
        ON  (
                    przedmioty_cykli.prz_kod = ma_przcykl_j.prz_kod
                AND przedmioty_cykli.cdyd_kod = ma_przcykl_j.cdyd_kod
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
