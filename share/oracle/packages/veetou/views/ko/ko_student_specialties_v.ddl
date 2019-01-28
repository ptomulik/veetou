CREATE OR REPLACE VIEW v2u_ko_student_specialties_v
AS SELECT
      st.job_uuid job_uuid
    , st.id student_id
    , st.student_index student_index
    , st.student_name student_name
    , st.first_name first_name
    , st.last_name last_name
    , se.id specialty_id
    , se.university university
    , se.faculty faculty
    , se.studies_modetier studies_modetier
    , se.studies_field studies_field
    , se.studies_specialty studies_specialty
    , se.semester_number semester_number
    , se.semester_code semester_code
    , se.ects_mandatory ects_mandatory
    , se.ects_other ects_other
    , se.ects_total ects_total
FROM v2u_ko_students st
INNER JOIN v2u_ko_student_specialties_j j
    ON (j.student_id = st.id AND j.job_uuid = st.job_uuid)
INNER JOIN v2u_ko_specialty_entities se
    ON (j.specialty_id = se.id AND j.job_uuid = se.job_uuid)
;

-- vim: set ft=sql ts=4 sw=4 et:
