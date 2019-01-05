CREATE OR REPLACE VIEW v2u_ko_ambig_subject_map_v
OF V2u_Ko_Ambig_Subject_Map_V_t
WITH OBJECT IDENTIFIER (job_uuid, subject_id, specialty_id, semester_id)
AS WITH u AS
    (
        SELECT
              j.job_uuid job_uuid
            , j.subject_id subject_id
            , j.specialty_id specialty_id
            , j.semester_id semester_id
            , COUNT(*) map_count
            , CAST(COLLECT(j.map_id ORDER BY j.map_id) AS V2u_Ids_t) map_ids
            , CAST(COLLECT(j.matching_score ORDER BY j.map_id) AS V2u_Integers_t) matching_scores
        FROM v2u_ko_subject_map_j j
        WHERE j.selected = 0 AND j.reason = 'ambiguous'
        GROUP BY
              j.job_uuid
            , j.subject_id
            , j.specialty_id
            , j.semester_id
    )
    SELECT
        V2u_Ko_Ambig_Subject_Map_V_t(
              subject => (SELECT VALUE(s) FROM v2u_ko_subjects s WHERE s.id = u.subject_id AND s.job_uuid = u.job_uuid)
            , specialty => (SELECT VALUE(s) FROM v2u_ko_specialties s WHERE s.id = u.specialty_id AND s.job_uuid = u.job_uuid)
            , semester => (SELECT VALUE(s) FROM v2u_ko_semesters s WHERE s.id = u.semester_id AND s.job_uuid = u.job_uuid)
            , map_count => u.map_count
            , map_ids => u.map_ids
            , matching_scores => u.matching_scores
            , map_subj_codes => CAST(MULTISET(SELECT m.map_subj_code FROM v2u_subject_map m WHERE m.id IN (SELECT * FROM TABLE(u.map_ids))) AS V2u_Subj_Codes_t)
        )
    FROM u u
WITH READ ONLY;
-- vim: set ft=sql ts=4 sw=4 et:
