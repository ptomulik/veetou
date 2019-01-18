CREATE OR REPLACE VIEW veetou_ko_subject_instances_ov
AS WITH ungrouped AS
    (
        SELECT
              v.job_uuid job_uuid
            , Veetou_Ko_Subject_Instance_Typ(v.refined) subject_instance
        FROM veetou_ko_refined_ov v
    )
SELECT
      job_uuid
    , subject_instance
    , COUNT(*) trs_count
FROM ungrouped
GROUP BY job_uuid, subject_instance
ORDER BY job_uuid, subject_instance;

-- vim: set ft=sql ts=4 sw=4 et:
