CREATE OR REPLACE VIEW v2u_ko_mapped_programs_dv
AS WITH joined AS (
    SELECT
          i.job_uuid job_uuid
        , m.id specialty_map_id
        , m.specialty_map.match_expr_fields(i.specialty, i.semester_code) matching_score
        , i.specialty specialty
        , i.semester_code semester_code
        , m.specialty_map specialty_map
        , i.pages_count pages_count
    FROM v2u_ko_specialty_issues_dv i
    LEFT JOIN v2u_specialty_map m ON
        (
            i.specialty.university = m.specialty_map.university AND
            i.specialty.faculty = m.specialty_map.faculty AND
            i.specialty.studies_modetier = m.specialty_map.studies_modetier AND
            i.specialty.studies_field = m.specialty_map.studies_field AND (
                m.specialty_map.studies_specialty IS NULL OR (
                    i.specialty.studies_specialty = m.specialty_map.studies_specialty
                )
            )
        )
)
SELECT * FROM joined
WHERE matching_score > 0
ORDER BY specialty;

-- vim: set ft=sql ts=4 sw=4 et:
