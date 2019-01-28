CREATE OR REPLACE VIEW v2u_ko_specialty_entities
AS SELECT
      job_uuid
    , v.specialty.university university
    , v.specialty.faculty faculty
    , v.specialty.studies_modetier studies_modetier
    , v.specialty.studies_field studies_field
    , v.specialty.studies_specialty studies_specialty
    , v.semester_code semester_code
    , v.pages_count pages_count
    , v.sheets_count sheets_count
FROM v2u_ko_specialty_entities_dv v;

-- vim: set ft=sql ts=4 sw=4 et:
