CREATE OR REPLACE VIEW veetou_ko_mapped_programs
AS SELECT
      pi.job_uuid job_uuid
    -- instance
    , pi.university university
    , pi.faculty faculty
    , pi.studies_modetier studies_modetier
    , pi.studies_field studies_field
    , pi.studies_specialty studies_specialty
    -- mapping
    , pm.id program_mapping_id
    , pm.mapped_program_code mapped_program_code
    , pm.mapped_modetier_code mapped_modetier_code
    , pm.mapped_field_code mapped_field_code
    , pm.expr_university expr_university
    , pm.expr_faculty expr_faculty
    , pm.expr_studies_modetier expr_studies_modetier
    , pm.expr_studies_field expr_studies_field
    , pm.expr_studies_specialty expr_studies_specialty
    -- count
    , pi.trs_count trs_count
FROM veetou_ko_program_instances pi
LEFT JOIN veetou_program_mappings pm ON (
            pi.university = pm.expr_university AND
            pi.faculty = pm.expr_faculty AND
            pi.studies_modetier = pm.expr_studies_modetier AND
            pi.studies_field = pm.expr_studies_field AND (
                pm.expr_studies_specialty IS NULL OR
                (pi.studies_specialty = pm.expr_studies_specialty)
            )
        )
ORDER BY
          pi.job_uuid
        , pi.university
        , pi.faculty
        , pi.studies_modetier
        , pi.studies_field
        , pi.studies_specialty
        ;

-- vim: set ft=sql ts=4 sw=4 et:
