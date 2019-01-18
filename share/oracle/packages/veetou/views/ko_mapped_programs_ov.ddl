CREATE OR REPLACE VIEW veetou_ko_mapped_programs_ov
AS WITH joined AS (
    SELECT
          pi.job_uuid job_uuid
        , pm.id program_mapping_id
        , pm.program_mapping.match_expr_fields(pi.program_instance) matching_score
        , pi.program_instance program_instance
        , pm.program_mapping program_mapping
        , pi.pages_count pages_count
    FROM veetou_ko_program_instances_ov pi
    LEFT JOIN veetou_program_mappings_ov pm ON
        (
            pi.program_instance.university = pm.program_mapping.university AND
            pi.program_instance.faculty = pm.program_mapping.faculty AND
            pi.program_instance.studies_modetier = pm.program_mapping.studies_modetier AND
            pi.program_instance.studies_field = pm.program_mapping.studies_field AND (
                pm.program_mapping.studies_specialty IS NULL OR (
                    pi.program_instance.studies_specialty = pm.program_mapping.studies_specialty
                )
            )
        )
)
SELECT * FROM joined
WHERE matching_score > 0
ORDER BY program_instance;

-- vim: set ft=sql ts=4 sw=4 et:
