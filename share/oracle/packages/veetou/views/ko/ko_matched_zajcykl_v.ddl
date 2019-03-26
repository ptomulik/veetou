CREATE OR REPLACE VIEW v2u_ko_matched_zajcykl_v
OF V2u_Ko_Matched_Zajcykl_V_t
WITH OBJECT IDENTIFIER (classes_type, subject_id, specialty_id, semester_id, job_uuid)
AS
    SELECT
          V2u_Ko_Matched_Zajcykl_V_t(
              matched_zajcykl_j => VALUE(ma_zajcykl_j)
            , subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , zajecia_cyklu => VALUE(zajecia_cykli)
        )
    FROM v2u_ko_matched_zajcykl_j ma_zajcykl_j
    INNER JOIN v2u_ko_subjects subjects
        ON  (
                    subjects.id = ma_zajcykl_j.subject_id
                AND subjects.job_uuid = ma_zajcykl_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = ma_zajcykl_j.specialty_id
                AND specialties.job_uuid = ma_zajcykl_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = ma_zajcykl_j.semester_id
                AND semesters.job_uuid = ma_zajcykl_j.job_uuid
            )
    INNER JOIN v2u_dz_zajecia_cykli zajecia_cykli
        ON  (
                    zajecia_cykli.prz_kod = ma_zajcykl_j.prz_kod
                AND zajecia_cykli.cdyd_kod = ma_zajcykl_j.cdyd_kod
                AND zajecia_cykli.tzaj_kod = ma_zajcykl_j.tzaj_kod
            )
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
