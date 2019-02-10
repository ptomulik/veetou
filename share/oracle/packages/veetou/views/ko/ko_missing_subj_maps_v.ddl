CREATE OR REPLACE VIEW v2u_ko_missing_subj_maps_v
--OF V2u_Ko_Missing_Subj_Map_V_t
--WITH OBJECT IDENTIFIER (job_uuid, subject_id, specialty_id, semester_id)
AS WITH u AS
    (
        SELECT
              V2u_Ko_Missing_Subj_Map_V_t(
                  subject => VALUE(subjects)
                , specialty => VALUE(specialties)
                , semester => VALUE(semesters)
              ) m
        FROM v2u_ko_subject_semesters_j j1
        INNER JOIN v2u_ko_subjects subjects
            ON (subjects.id = j1.subject_id AND
                subjects.job_uuid = j1.job_uuid)
        INNER JOIN v2u_ko_specialties specialties
            ON (specialties.id = j1.specialty_id AND
                specialties.job_uuid = j1.job_uuid)
        INNER JOIN v2u_ko_semesters semesters
            ON (semesters.id = j1.semester_id AND
                semesters.job_uuid = j1.job_uuid)
        LEFT JOIN v2u_ko_subject_map_j j2
            ON (j2.subject_id = j1.subject_id AND
                j2.specialty_id = j1.specialty_id AND
                j2.semester_id = j1.semester_id AND
                j2.job_uuid = j1.job_uuid AND
                j2.selected = 1)
        WHERE j2.map_id IS NULL
    )
SELECT
      u.m.subj_code subj_code
    , u.m.map_subj_code map_subj_code
    , u.m.map_subj_lang map_subj_lang
    , u.m.map_org_unit map_org_unit
    , u.m.map_org_unit_recipient map_org_unit_recipient
    , u.m.expr_subj_name expr_subj_name
    , u.m.expr_subj_hours_w expr_subj_hours_w
    , u.m.expr_subj_hours_c expr_subj_hours_c
    , u.m.expr_subj_hours_l expr_subj_hours_l
    , u.m.expr_subj_hours_p expr_subj_hours_p
    , u.m.expr_subj_hours_s expr_subj_hours_s
    , u.m.expr_subj_credit_kind expr_subj_credit_kind
    , u.m.expr_subj_ects expr_subj_ects
    , u.m.expr_subj_tutor expr_subj_tutor
    , u.m.expr_university expr_university
    , u.m.expr_faculty expr_faculty
    , u.m.expr_studies_modetier expr_studies_modetier
    , u.m.expr_studies_field expr_studies_field
    , u.m.expr_studies_specialty expr_studies_specialty
    , u.m.expr_semester_code expr_semester_code
    , u.m.expr_semester_number expr_semester_number
    , u.m.expr_ects_mandatory expr_ects_mandatory
    , u.m.expr_ects_other expr_ects_other
    , u.m.expr_ects_total expr_ects_total
    , u.m.job_uuid job_uuid
FROM u u
WITH READ ONLY;

-- vim: set ft=sql ts=4 sw=4 et:
