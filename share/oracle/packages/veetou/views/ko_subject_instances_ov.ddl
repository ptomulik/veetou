CREATE OR REPLACE VIEW veetou_ko_subject_instances_ov
AS SELECT
      v.job_uuid job_uuid
    , Veetou_Ko_Subject_Instance_Typ(v.refined) subject_instance
    , COUNT(*) trs_count
FROM veetou_ko_refined_ov v
GROUP BY job_uuid, Veetou_Ko_Subject_Instance_Typ(v.refined)
ORDER BY job_uuid, Veetou_Ko_Subject_Instance_Typ(v.refined);

-- vim: set ft=sql ts=4 sw=4 et:
