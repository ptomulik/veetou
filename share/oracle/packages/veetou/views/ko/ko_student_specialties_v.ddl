CREATE OR REPLACE VIEW v2u_ko_student_specialties_v
AS SELECT
      h.student.job_uuid job_uuid
    , h.student.id student_id
    , h.specent_id specent_id
    , h.specmap_id specmap_id
    , h.matching_score matching_score
    , h.student.student_index student_index
    , h.student.student_name student_name
    , h.student.first_name first_name
    , h.student.last_name last_name
    , h.specialty_entity.university university
    , h.specialty_entity.faculty faculty
    , h.specialty_entity.studies_modetier studies_modetier
    , h.specialty_entity.studies_field studies_field
    , h.specialty_entity.studies_specialty studies_specialty
    , h.specialty_map.mapped_program_code mapped_program_code
    , h.specialty_map.mapped_modetier_code mapped_modetier_code
    , h.specialty_map.mapped_field_code mapped_field_code
    , h.specialty_entity.semester_number semester_number
    , h.specialty_map.expr_semester_number expr_semester_number
    , h.specialty_entity.semester_code semester_code
    , h.specialty_map.expr_semester_code expr_semester_code
    , h.specialty_entity.ects_mandatory ects_mandatory
    , h.specialty_map.expr_ects_mandatory expr_ects_mandatory
    , h.specialty_entity.ects_other ects_other
    , h.specialty_map.expr_ects_other expr_ects_other
    , h.specialty_entity.ects_total ects_total
    , h.specialty_map.expr_ects_total expr_ects_total

    FROM v2u_ko_student_specialties_h h
;

-- vim: set ft=sql ts=4 sw=4 et:
