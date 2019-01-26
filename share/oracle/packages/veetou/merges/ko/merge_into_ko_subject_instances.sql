MERGE INTO v2u_ko_subject_instances tgt
USING
    (
        WITH u AS
        (
            SELECT
                  t.tr tr
                , V2u_To.Ko_Subject_Instance(
                      job_uuid => t.tr.job_uuid
                    , header => DEREF(t.header)
                    , preamble => DEREF(t.preamble)
                    , tr => DEREF(t.tr)
                  ) subj_instance
            FROM v2u_ko_tr_hdr_preamble_v t
        ),
        v AS
        (
            SELECT
                  u.subj_instance subj_instance
                , CAST(COLLECT(DEREF(u.tr)) AS V2u_Ko_Trs_t) trs
            FROM u u
            GROUP BY u.subj_instance
            ORDER BY u.subj_instance
        )
        SELECT
            -- 1. COLLECT(DISTINCT...) seems to be broken ("DISTINCT" is ignored)
            -- 2. COLLECT(s) with s VARCHAR2 is unpredictable - it returns a
            --    collection of VARCHAR2(n) with "n" unknown.
            -- So, I decided to collect tr objects first into a table and then
            -- use SELECT on this table.
            v.subj_instance.dup_with(
                      new_id_seq => 'v2u_ko_subject_instances_sq1'
                    , new_tr_ids => CAST(MULTISET(
                            SELECT t.id FROM TABLE(v.trs) t
                      ) AS V2u_Ko_Ids_t)
                    , new_subj_grades => CAST(MULTISET(
                            SELECT DISTINCT t.subj_grade
                            FROM TABLE(v.trs) t
                            ORDER BY t.subj_grade
                      ) AS V2u_Subj_20Grades_t)
            ) subj_instance
        FROM v v
    ) src
ON (VALUE(tgt) = src.subj_instance)
WHEN NOT MATCHED THEN INSERT VALUES(src.subj_instance);

-- vim: set ft=sql ts=4 sw=4 et:
