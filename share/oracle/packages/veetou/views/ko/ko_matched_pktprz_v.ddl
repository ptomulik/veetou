CREATE OR REPLACE VIEW v2u_ko_matched_pktprz_v
OF V2u_Ko_Matched_Pktprz_V_t
WITH OBJECT IDENTIFIER (subject_id, specialty_id, semester_id, job_uuid)
AS
    SELECT
          V2u_Ko_Matched_Pktprz_V_t(
              subject => VALUE(subjects)
            , specialty => VALUE(specialties)
            , semester => VALUE(semesters)
            , subject_map_j => VALUE(subject_map_j)
            , matched_pktprz_j => VALUE(ma_pktprz_j)
            , punkty_przedmiotu => VALUE(pkt_prz)
        )
    FROM v2u_ko_matched_pktprz_j ma_pktprz_j
    INNER JOIN v2u_ko_subjects subjects
        ON  (
                    subjects.id = ma_pktprz_j.subject_id
                AND subjects.job_uuid = ma_pktprz_j.job_uuid
            )
    INNER JOIN v2u_ko_specialties specialties
        ON  (
                    specialties.id = ma_pktprz_j.specialty_id
                AND specialties.job_uuid = ma_pktprz_j.job_uuid
            )
    INNER JOIN v2u_ko_semesters semesters
        ON  (
                    semesters.id = ma_pktprz_j.semester_id
                AND semesters.job_uuid = ma_pktprz_j.job_uuid
            )
    INNER JOIN v2u_ko_subject_map_j subject_map_j
        ON  (
                    subject_map_j.subject_id = ma_pktprz_j.subject_id
                AND subject_map_j.specialty_id = ma_pktprz_j.specialty_id
                AND subject_map_j.semester_id = ma_pktprz_j.semester_id
                AND subject_map_j.map_id = ma_pktprz_j.subject_map_id
                AND subject_map_j.job_uuid = ma_pktprz_j.job_uuid
            )
    INNER JOIN v2u_uv_punkty_przedmiotow pkt_prz
        ON  (
                    pkt_prz.id = ma_pktprz_j.pktprz_id
            )
WITH READ ONLY
;

-- vim: set ft=sql ts=4 sw=4 et:
