CREATE OR REPLACE VIEW v2u_ko_mapped_specialties_v
OF V2u_Ko_Mapped_Specialty_t
WITH OBJECT IDENTIFIER (job_uuid, specialty_entity_id, specialty_map_id)
AS SELECT
      se.job_uuid
    , se.id
    , sm.id
    , sim.matching_score
    , se.university
    , se.faculty
    , se.studies_modetier
    , se.studies_field
    , se.studies_specialty
    , se.semester_number
    , sm.expr_semester_number
    , se.semester_code
    , sm.expr_semester_code
    , se.ects_mandatory
    , sm.expr_ects_mandatory
    , se.ects_other
    , sm.expr_ects_other
    , se.ects_total
    , sm.expr_ects_total
FROM v2u_ko_specialty_entities se
LEFT JOIN v2u_ko_specialty_map_j sim
    ON (sim.specialty_entity_id = se.id AND
        sim.job_uuid = se.job_uuid)
LEFT JOIN v2u_specialty_map sm
    ON (sim.specialty_map_id = sm.id)
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
