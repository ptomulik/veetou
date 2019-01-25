CREATE MATERIALIZED VIEW v2u_ko_mapped_subjects_mv
OF V2u_Ko_Mapped_Subject_t
BUILD DEFERRED
REFRESH COMPLETE
AS SELECT * FROM v2u_ko_mapped_subjects_dv;

ALTER TABLE v2u_ko_mapped_subjects_mv ADD (SCOPE FOR (subject_instance) IS v2u_ko_subject_instances_mv);
ALTER TABLE v2u_ko_mapped_subjects_mv ADD (SCOPE FOR (subject_mapping) IS v2u_subject_mappings);


-- vim: set ft=sql ts=4 sw=4 et:
