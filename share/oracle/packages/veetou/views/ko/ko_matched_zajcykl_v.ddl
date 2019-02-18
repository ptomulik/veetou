CREATE OR REPLACE VIEW v2u_ko_matched_zajcykl_v
OF V2u_Ko_Matched_Zajcykl_V_t
WITH OBJECT IDENTIFIER (id)
AS WITH u AS
    (
        SELECT
              V2u_Ko_Matched_Zajcykl_V_t(
                  id => j.id
                , subject => VALUE(subjects)
                , specialty => VALUE(specialties)
                , semester => VALUE(semesters)
                , subject_map => VALUE(subject_map)
                , classes_map => VALUE(classes_map)
                , zajecia_cyklu => VALUE(zajecia_cykli)
                , subject_matching_score => j.subject_matching_score
                , classes_matching_score => j.classes_matching_score
            )
        FROM v2u_ko_matched_zajcykl_j j
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
        INNER JOIN v2u_classes_map classes_map
            ON (classes_map.id = j.classes_map_id)
        INNER JOIN dz_zajecia_cykli zajecia_cykli
            ON (zajecia_cykli.prz_kod = j.prz_kod AND
                zajecia_cykli.cdyd_kod = j.cdyd_kod AND
                zajecia_cykli.tzaj_kod = j.tzaj_kod)
    )
SELECT * FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
