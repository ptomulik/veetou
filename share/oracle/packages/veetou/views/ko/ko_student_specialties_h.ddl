CREATE OR REPLACE VIEW v2u_ko_student_specialties_h
OF V2u_Ko_Student_Specialty_H_t
WITH OBJECT IDENTIFIER (job_uuid, student_id, specent_id, specmap_id)
AS SELECT
      st.job_uuid
    , st.id
    , se.id
    , sm.id
    , j2.matching_score
    , VALUE(st)
    , VALUE(se)
    , VALUE(sm)
FROM v2u_ko_students st
INNER JOIN v2u_ko_student_specialties_j j1
    ON (j1.student_id = st.id AND j1.job_uuid = st.job_uuid)
INNER JOIN v2u_ko_specialty_entities se
    ON (j1.specent_id = se.id AND j1.job_uuid = se.job_uuid)
INNER JOIN v2u_ko_specialty_map_j j2
    ON (j2.specent_id = se.id AND j2.job_uuid = se.job_uuid)
INNER JOIN v2u_specialty_map sm
    ON (j2.specmap_id = sm.id);
;

-- vim: set ft=sql ts=4 sw=4 et:
