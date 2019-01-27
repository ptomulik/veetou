MERGE INTO v2u_ko_subject_issues tgt
USING
    (
        WITH u AS
        (
            SELECT
                  t.tr tr
                , V2u_To.Ko_Subject_Issue(
                      job_uuid => t.tr.job_uuid
                    , header => DEREF(t.header)
                    , preamble => DEREF(t.preamble)
                    , tr => DEREF(t.tr)
                  ) subj_issue
            FROM v2u_ko_tr_hdr_preamb_h t
        ),
        v AS
        (
            SELECT
                  u.subj_issue subj_issue
                , CAST(COLLECT(DEREF(u.tr)) AS V2u_Ko_Trs_t) trs
            FROM u u
            GROUP BY u.subj_issue
        )
        SELECT
            -- 1. COLLECT(DISTINCT...) seems to be broken ("DISTINCT" is ignored)
            -- 2. COLLECT(s) with s VARCHAR2 is unpredictable - it returns a
            --    collection of VARCHAR2(n) with "n" unknown.
            -- So, I decided to collect tr objects first into a table and then
            -- use SELECT on this table.
            v.subj_issue.dup_with(
                      new_id_seq => 'v2u_ko_subject_issues_sq1'
                    , new_tr_ids => CAST(MULTISET(
                            SELECT t.id FROM TABLE(v.trs) t
                      ) AS V2u_Ko_Ids_t)
                    , new_subj_grades => CAST(MULTISET(
                            SELECT DISTINCT t.subj_grade
                            FROM TABLE(v.trs) t
                            ORDER BY t.subj_grade
                      ) AS V2u_Subj_20Grades_t)
            ) subj_issue
        FROM v v
    ) src
ON
    (       -- our ORDER member function couldn't be used here.. :(
            DECODE(src.subj_issue.subj_code, tgt.subj_code, 1, 0) = 1
        AND DECODE(src.subj_issue.semester_code, tgt.semester_code, 1, 0) = 1
        AND DECODE(src.subj_issue.subj_hours_w, tgt.subj_hours_w, 1, 0) = 1
        AND DECODE(src.subj_issue.subj_hours_c, tgt.subj_hours_c, 1, 0) = 1
        AND DECODE(src.subj_issue.subj_hours_l, tgt.subj_hours_l, 1, 0) = 1
        AND DECODE(src.subj_issue.subj_hours_p, tgt.subj_hours_p, 1, 0) = 1
        AND DECODE(src.subj_issue.subj_hours_s, tgt.subj_hours_s, 1, 0) = 1
        AND DECODE(src.subj_issue.subj_tutor, tgt.subj_tutor, 1, 0) = 1
        AND DECODE(src.subj_issue.studies_specialty, tgt.studies_specialty, 1, 0) = 1
        AND DECODE(src.subj_issue.studies_field, tgt.studies_field, 1, 0) = 1
        AND DECODE(src.subj_issue.studies_modetier, tgt.studies_modetier, 1, 0) = 1
        AND DECODE(src.subj_issue.subj_credit_kind, tgt.subj_credit_kind, 1, 0) = 1
        AND DECODE(src.subj_issue.subj_ects, tgt.subj_ects, 1, 0) = 1
        AND DECODE(src.subj_issue.subj_name, tgt.subj_name, 1, 0) = 1
        AND DECODE(src.subj_issue.university, tgt.university, 1, 0) = 1
        AND DECODE(src.subj_issue.faculty, tgt.faculty, 1, 0) = 1
        AND DECODE(src.subj_issue.job_uuid, tgt.job_uuid, 1, 0) = 1
    )
WHEN NOT MATCHED THEN INSERT VALUES(src.subj_issue)
WHEN MATCHED THEN UPDATE SET tgt.subj_grades = src.subj_issue.subj_grades
                           , tgt.tr_ids = src.subj_issue.tr_ids;

-- vim: set ft=sql ts=4 sw=4 et:
