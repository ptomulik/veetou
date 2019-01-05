MERGE INTO v2u_ko_subjects tgt
USING
    (
        WITH u AS
        (
            SELECT
                  V2u_Ko_Subject_t(
                      job_uuid =>  trs.job_uuid
                    , tr => VALUE(trs)
                  ) subject
                , trs.id tr_id
            FROM v2u_ko_trs trs
        )
        SELECT
              u.subject.dup(CAST(COLLECT(u.tr_id) AS V2u_Ids_t)) subject
        FROM u u
        GROUP BY u.subject
    ) src
ON
    (       -- our ORDER member function couldn't be used here.. :(
            ((src.subject.subj_code = tgt.subj_code) OR (src.subject.subj_code IS NULL AND tgt.subj_code IS NULL))
        AND ((src.subject.subj_hours_w = tgt.subj_hours_w) OR (src.subject.subj_hours_w IS NULL AND tgt.subj_hours_w IS NULL))
        AND ((src.subject.subj_hours_c = tgt.subj_hours_c) OR (src.subject.subj_hours_c IS NULL AND tgt.subj_hours_c IS NULL))
        AND ((src.subject.subj_hours_l = tgt.subj_hours_l) OR (src.subject.subj_hours_l IS NULL AND tgt.subj_hours_l IS NULL))
        AND ((src.subject.subj_hours_p = tgt.subj_hours_p) OR (src.subject.subj_hours_p IS NULL AND tgt.subj_hours_p IS NULL))
        AND ((src.subject.subj_hours_s = tgt.subj_hours_s) OR (src.subject.subj_hours_s IS NULL AND tgt.subj_hours_s IS NULL))
        AND ((src.subject.subj_tutor = tgt.subj_tutor) OR (src.subject.subj_tutor IS NULL AND tgt.subj_tutor IS NULL))
        AND ((src.subject.subj_credit_kind = tgt.subj_credit_kind) OR (src.subject.subj_credit_kind IS NULL AND tgt.subj_credit_kind IS NULL))
        AND ((src.subject.subj_ects = tgt.subj_ects) OR (src.subject.subj_ects IS NULL AND tgt.subj_ects IS NULL))
        AND ((src.subject.subj_name = tgt.subj_name) OR (src.subject.subj_name IS NULL AND tgt.subj_name IS NULL))
        AND ((src.subject.job_uuid = tgt.job_uuid) OR (src.subject.job_uuid IS NULL AND tgt.job_uuid IS NULL))
    )
WHEN NOT MATCHED THEN
    INSERT
          VALUES(src.subject)
WHEN MATCHED THEN
    UPDATE SET
          tgt.tr_ids = src.subject.tr_ids
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
