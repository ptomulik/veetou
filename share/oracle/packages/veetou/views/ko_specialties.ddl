CREATE OR REPLACE VIEW veetou_ko_specialties
AS SELECT
      job_uuid
    , v.specialty.university university
    , v.specialty.faculty faculty
    , v.specialty.studies_modetier studies_modetier
    , v.specialty.studies_field studies_field
    , v.specialty.studies_specialty studies_specialty
    , v.pages_count pages_count
    , v.sheets_count sheets_count
FROM veetou_ko_specialties_ov v;

-- vim: set ft=sql ts=4 sw=4 et:
