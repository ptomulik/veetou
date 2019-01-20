CREATE OR REPLACE VIEW veetou_ko_mapped_programs_ov
AS WITH joined AS (
    SELECT
          i.job_uuid job_uuid
        , m.id program_mapping_id
        , m.program_mapping.match_expr_fields(i.specialty, i.semester_code) matching_score
        , i.specialty specialty
        , i.semester_code semester_code
        , m.program_mapping program_mapping
        , i.pages_count pages_count
    FROM veetou_ko_specialty_instances_ov i
    LEFT JOIN veetou_program_mappings_ov m ON
        (
            i.specialty.university = m.program_mapping.university AND
            i.specialty.faculty = m.program_mapping.faculty AND
            i.specialty.studies_modetier = m.program_mapping.studies_modetier AND
            i.specialty.studies_field = m.program_mapping.studies_field AND (
                m.program_mapping.studies_specialty IS NULL OR (
                    i.specialty.studies_specialty = m.program_mapping.studies_specialty
                )
            )
        )
)
SELECT * FROM joined
WHERE matching_score > 0
ORDER BY specialty;

-- vim: set ft=sql ts=4 sw=4 et:
