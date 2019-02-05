MERGE INTO v2u_ko_subject_map_grades_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  j.job_uuid job_uuid
                , j.subject_id subject_id
                , j.specialty_id specialty_id
                , j.map_id map_id
                , CAST(MULTISET(SELECT DISTINCT g.subj_grade FROM TABLE(grades) g) AS V2u_Subj_20Grades_t)
                --, CAST(COLLECT(grades.tr_id) AS V2u_Ids_t) trs_ids
            FROM v2u_ko_grades_j grades
            INNER JOIN v2u_ko_subject_map_j j
                ON (j.subject_id = grades.subject_id AND
                    j.specialty_id = grades.specialty_id AND
                    j.semester_id = grades.semester_id AND
                    j.job_uuid = grades.job_uuid)
            GROUP BY
                  j.job_uuid
                , j.subject_id
                , j.specialty_id
                , j.map_id
        )
        SELECT
            *
            FROM u u
    ) src
ON (tgt.subject_id = src.subject_id AND
    tgt.map_id = src.map_id AND
    tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     subject_id,     map_id,     subj_grades)
    VALUES (src.job_uuid, src.subject_id, src.map_id, src.subj_grades)
WHEN MATCHED THEN
    UPDATE SET tgt.subj_grades = src.subj_grades;

-- vim: set ft=sql ts=4 sw=4 et:
