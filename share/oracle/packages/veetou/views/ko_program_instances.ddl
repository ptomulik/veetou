CREATE OR REPLACE VIEW veetou_ko_program_instances
AS SELECT
      job_uuid
    , v.program_instance.university university
    , v.program_instance.faculty faculty
    , v.program_instance.studies_modetier studies_modetier
    , v.program_instance.studies_field studies_field
    , v.program_instance.studies_specialty studies_specialty
    , v.program_instance.semester_code semester_code
    , v.pages_count pages_count
FROM veetou_ko_program_instances_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
