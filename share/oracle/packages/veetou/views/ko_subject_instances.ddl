CREATE MATERIALIZED VIEW v2u_ko_subject_instances
OF V2u_Ko_Subject_Instance_t
BUILD DEFERRED
REFRESH COMPLETE
AS SELECT * FROM v2u_ko_subject_instances_dv;

-- vim: set ft=sql ts=4 sw=4 et:
