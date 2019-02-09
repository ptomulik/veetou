CREATE OR REPLACE VIEW v2u_ko_matched_przedm_v
OF V2u_Ko_Matched_Przedm_V_t
WITH OBJECT IDENTIFIER (id)
AS WITH u AS
    (
        SELECT
              V2u_Ko_Matched_Przedm_V_t(
                  id => j.id
                , subject => VALUE(subjects)
                , specialty => VALUE(specialties)
                , semester => VALUE(semesters)
                , subject_map => VALUE(subject_map)
                , przedmiot => VALUE(przedmioty)
                , matching_score => j.matching_score
            )
        FROM v2u_ko_matched_przedm_j j
        INNER JOIN v2u_ko_subjects subjects
            ON (subjects.id = j.subject_id AND
                subjects.job_uuid = j.job_uuid)
        INNER JOIN v2u_ko_specialties specialties
            ON (specialties.id = j.specialty_id AND
                specialties.job_uuid = j.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = j.semester_id AND
                semesters.job_uuid = j.job_uuid)
        INNER JOIN v2u_subject_map subject_map
            ON (subject_map.id = j.subject_map_id)
        INNER JOIN v2u_dz_przedmioty przedmioty
            ON (przedmioty.kod = j.prz_kod)
    )
SELECT * FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
