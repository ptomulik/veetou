CREATE VIEW veetou_ko_mapped_subjects_ov AS
    SELECT
          smv.id subject_mapping_id
        , siv.subject_instance subject_instance
        , smv.subject_mapping subject_mapping
FROM veetou_ko_subject_instances_ov siv
LEFT JOIN veetou_subject_mappings_ov smv
ON smv.subject_mapping.match_subject(siv.subject_instance) > 0;

-- vim: set ft=sql ts=4 sw=4 et:
