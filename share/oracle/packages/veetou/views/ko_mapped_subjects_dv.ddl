CREATE OR REPLACE VIEW v2u_ko_mapped_subjects_dv
OF V2u_Ko_Mapped_Subject_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS
WITH u AS
    (
        SELECT
              si.job_uuid
            , (SELECT V2u_Match.Expr_Fields(VALUE(sm), VALUE(si)) FROM dual)  matching_score
            , REF(si) subject_instance
            , REF(sm) subject_mapping
        FROM v2u_ko_subject_instances si
        LEFT JOIN v2u_subject_mappings sm
        ON sm.subj_code = si.subj_code
    )
SELECT
      job_uuid
    , ROWNUM
    , matching_score
    , subject_instance
    , subject_mapping
FROM u
WHERE matching_score > 0
ORDER BY DEREF(subject_instance);

-- vim: set ft=sql ts=4 sw=4 et:
