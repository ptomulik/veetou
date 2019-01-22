CREATE OR REPLACE VIEW v2u_ko_subject_instances_ov
OF V2u_Ko_Subject_Instance_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS WITH u AS
    (
        SELECT
              si
            , CAST(COLLECT(DISTINCT sg) AS V2u_Ko_Subj_Grades_t) sgs
        FROM
            (
                SELECT
                      V2u_To.Ko_Subject_Instance(job_uuid,NULL,header,preamble,tr) si
                    , x.tr.subj_grade sg
                FROM v2u_ko_x_trs_ov x
            ) y
        GROUP BY si
    )
SELECT
      v.si.job_uuid
    , ROWNUM
    , v.si.subj_code
    , v.si.subj_name
    , v.si.university
    , v.si.faculty
    , v.si.studies_modetier
    , v.si.studies_field
    , v.si.studies_specialty
    , v.si.semester_code
    , v.si.subj_hours_w
    , v.si.subj_hours_c
    , v.si.subj_hours_l
    , v.si.subj_hours_p
    , v.si.subj_hours_s
    , v.si.subj_credit_kind
    , v.si.subj_ects
    , v.si.subj_tutor
    , v.sgs
FROM u v;

-- vim: set ft=sql ts=4 sw=4 et:
