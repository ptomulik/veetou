CREATE OR REPLACE VIEW veetou_ko_specialty_instances
AS SELECT
      job_uuid
    , v.specialty_instance.university university
    , v.specialty_instance.faculty faculty
    , v.specialty_instance.studies_modetier studies_modetier
    , v.specialty_instance.studies_field studies_field
    , v.specialty_instance.studies_specialty studies_specialty
    , v.specialty_instance.semester_code semester_code
    , v.pages_count pages_count
FROM veetou_ko_specialty_instances_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
