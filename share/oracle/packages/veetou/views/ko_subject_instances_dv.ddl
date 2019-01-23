CREATE OR REPLACE VIEW v2u_ko_subject_instances_dv
OF V2u_Ko_Subject_Instance_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS
WITH
    u AS
    ( -- retrieving
        SELECT
              V2u_To.Ko_Subject_Instance(job_uuid, NULL, header, preamble, tr) si
            , tr
        FROM v2u_ko_x_trs
    ),
    v AS
    ( -- grouping by subject instance and collecting trs
        SELECT
              si
            , CAST(COLLECT(tr) AS V2u_Ko_Trs_t) trs
        FROM u u
        GROUP BY si
    ),
    w AS
    (
        SELECT
              si
            , CAST(MULTISET(
                    SELECT DISTINCT t.subj_grade FROM TABLE(trs) t
              ) AS V2u_Ko_Subj_Grades_t) subj_grades
            , CAST(MULTISET(
                    SELECT t.id FROM TABLE(trs) t
              ) AS V2u_Ko_Ids_t) tr_ids
        FROM v v
    )
SELECT
      w.si.job_uuid
    , ROWNUM
    , w.si.subj_code
    , w.si.subj_name
    , w.si.university
    , w.si.faculty
    , w.si.studies_modetier
    , w.si.studies_field
    , w.si.studies_specialty
    , w.si.semester_code
    , w.si.subj_hours_w
    , w.si.subj_hours_c
    , w.si.subj_hours_l
    , w.si.subj_hours_p
    , w.si.subj_hours_s
    , w.si.subj_credit_kind
    , w.si.subj_ects
    , w.si.subj_tutor
    , w.subj_grades
    , w.tr_ids
FROM w w;

-- vim: set ft=sql ts=4 sw=4 et:
