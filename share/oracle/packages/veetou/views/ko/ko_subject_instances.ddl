CREATE OR REPLACE VIEW v2u_ko_subject_instances
AS SELECT *
FROM v2u_ko_subject_instances_mv
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
