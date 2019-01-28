MERGE INTO v2u_ko_subject_issues tgt
USING
    (
        WITH u AS
        (
            SELECT
                  t.tr tr
                , V2u_To.Ko_Subject_Issue(
                      job_uuid => t.tr.job_uuid
                    , header => t.header
                    , preamble => t.preamble
                    , tr => t.tr
                  ) subj_issue
            FROM v2u_ko_tr_hdr_preamb_h t
        ),
        v AS
        (
            SELECT
                  u.subj_issue subj_issue
                , CAST(COLLECT(u.tr) AS V2u_Ko_Trs_t) trs
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
                      ) AS V2u_Ids_t)
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
            ((src.subj_issue.subj_code = tgt.subj_code) OR (src.subj_issue.subj_code IS NULL AND tgt.subj_code IS NULL))
        AND ((src.subj_issue.semester_code = tgt.semester_code) OR (src.subj_issue.semester_code IS NULL AND tgt.semester_code IS NULL))
        AND ((src.subj_issue.subj_hours_w = tgt.subj_hours_w) OR (src.subj_issue.subj_hours_w IS NULL AND tgt.subj_hours_w IS NULL))
        AND ((src.subj_issue.subj_hours_c = tgt.subj_hours_c) OR (src.subj_issue.subj_hours_c IS NULL AND tgt.subj_hours_c IS NULL))
        AND ((src.subj_issue.subj_hours_l = tgt.subj_hours_l) OR (src.subj_issue.subj_hours_l IS NULL AND tgt.subj_hours_l IS NULL))
        AND ((src.subj_issue.subj_hours_p = tgt.subj_hours_p) OR (src.subj_issue.subj_hours_p IS NULL AND tgt.subj_hours_p IS NULL))
        AND ((src.subj_issue.subj_hours_s = tgt.subj_hours_s) OR (src.subj_issue.subj_hours_s IS NULL AND tgt.subj_hours_s IS NULL))
        AND ((src.subj_issue.subj_tutor = tgt.subj_tutor) OR (src.subj_issue.subj_tutor IS NULL AND tgt.subj_tutor IS NULL))
        AND ((src.subj_issue.studies_specialty = tgt.studies_specialty) OR (src.subj_issue.studies_specialty IS NULL AND tgt.studies_specialty IS NULL))
        AND ((src.subj_issue.studies_field = tgt.studies_field) OR (src.subj_issue.studies_field IS NULL AND tgt.studies_field IS NULL))
        AND ((src.subj_issue.studies_modetier = tgt.studies_modetier) OR (src.subj_issue.studies_modetier IS NULL AND tgt.studies_modetier IS NULL))
        AND ((src.subj_issue.subj_credit_kind = tgt.subj_credit_kind) OR (src.subj_issue.subj_credit_kind IS NULL AND tgt.subj_credit_kind IS NULL))
        AND ((src.subj_issue.subj_ects = tgt.subj_ects) OR (src.subj_issue.subj_ects IS NULL AND tgt.subj_ects IS NULL))
        AND ((src.subj_issue.subj_name = tgt.subj_name) OR (src.subj_issue.subj_name IS NULL AND tgt.subj_name IS NULL))
        AND ((src.subj_issue.university = tgt.university) OR (src.subj_issue.university IS NULL AND tgt.university IS NULL))
        AND ((src.subj_issue.faculty = tgt.faculty) OR (src.subj_issue.faculty IS NULL AND tgt.faculty IS NULL))
        AND ((src.subj_issue.job_uuid = tgt.job_uuid) OR (src.subj_issue.job_uuid IS NULL AND tgt.job_uuid IS NULL))
    )
WHEN NOT MATCHED THEN INSERT VALUES(src.subj_issue)
WHEN MATCHED THEN UPDATE SET tgt.subj_grades = src.subj_issue.subj_grades
                           , tgt.tr_ids = src.subj_issue.tr_ids;

-- vim: set ft=sql ts=4 sw=4 et:
