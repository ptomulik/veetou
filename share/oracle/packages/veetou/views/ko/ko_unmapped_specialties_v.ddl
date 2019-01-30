CREATE OR REPLACE VIEW v2u_ko_unmapped_specialties_v
OF V2u_Ko_Specialty_Map_t
WITH OBJECT IDENTIFIER (job_uuid, specsem_id, specmap_id)
AS SELECT
      v.job_uuid
    , v.specsem_id
    , v.specmap_id
    , v.matching_score
    , v.university
    , v.faculty
    , v.studies_modetier
    , v.studies_field
    , v.studies_specialty
    , v.mapped_program_code
    , v.mapped_modetier_code
    , v.mapped_field_code
    , v.semester_number
    , v.expr_semester_number
    , v.semester_code
    , v.expr_semester_code
    , v.ects_mandatory
    , v.expr_ects_mandatory
    , v.ects_other
    , v.expr_ects_other
    , v.ects_total
    , v.expr_ects_total
FROM v2u_ko_specialty_map_v v
WHERE v.specmap_id IS NULL OR
      v.matching_score < 1;

-- vim: set ft=sql ts=4 sw=4 et:
