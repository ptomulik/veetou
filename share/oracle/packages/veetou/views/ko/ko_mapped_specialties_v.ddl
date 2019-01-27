CREATE OR REPLACE VIEW v2u_ko_mapped_specialties_v
OF V2u_Ko_Mapped_Specialty_t
WITH OBJECT IDENTIFIER (job_uuid, specialty_issue_id, specialty_map_id)
AS SELECT
      si.job_uuid
    , si.id
    , sm.id
    , sim.matching_score
    , si.university
    , si.faculty
    , si.studies_modetier
    , si.studies_field
    , si.studies_specialty
    , si.semester_number
    , sm.expr_semester_number
    , si.semester_code
    , sm.expr_semester_code
    , si.ects_mandatory
    , sm.expr_ects_mandatory
    , si.ects_other
    , sm.expr_ects_other
    , si.ects_total
    , sm.expr_ects_total
FROM v2u_ko_specialty_issues si
LEFT JOIN v2u_ko_specialty_map_j sim
    ON (sim.specialty_issue_id = si.id AND
        sim.job_uuid = si.job_uuid)
LEFT JOIN v2u_specialty_map sm
    ON (sim.specialty_map_id = sm.id)
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
