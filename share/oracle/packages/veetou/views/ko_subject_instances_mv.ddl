CREATE MATERIALIZED VIEW v2u_ko_subject_instances_mv
BUILD IMMEDIATE
REFRESH COMPLETE ON DEMAND
AS WITH u AS (
    SELECT tr, V2u_Ko_Subject_Instance_t(
                        DEREF(tr).job_uuid,
                        ROWNUM,
                        DEREF(header),
                        DEREF(preamble),
                        DEREF(tr)) si
    FROM v2u_ko_x_trs_ov
)
SELECT  t.si subject_instance,
        CAST(COLLECT(t.tr ORDER BY DEREF(t.tr)) AS V2u_Ko_Tr_Refs_t) trs
FROM u t
GROUP BY si
ORDER BY si;


-- vim: set ft=sql ts=4 sw=4 et:
