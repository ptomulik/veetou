CREATE OR REPLACE VIEW v2u_ko_mapped_subjects_dv
OF V2u_Ko_Mapped_Subject_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS SELECT
      VALUE(si).job_uuid
    , ROWNUM
    , V2U_Match.Attributes(VALUE(sm), VALUE(si))
    , REF(si)
    , REF(sm)
FROM v2u_ko_subject_instances_mv si
LEFT JOIN v2u_subject_mappings sm
ON sm.subj_code = si.subj_code
WHERE V2U_Match.Attributes(VALUE(sm), VALUE(si)) > 0
ORDER BY VALUE(si);

-- vim: set ft=sql ts=4 sw=4 et:
