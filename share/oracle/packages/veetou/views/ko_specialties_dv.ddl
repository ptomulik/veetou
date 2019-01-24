CREATE OR REPLACE VIEW v2u_ko_specialties_dv
OF V2u_Ko_Specialty_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS
WITH
    u AS
    (
        SELECT V2u_To.Ko_Specialty(job_uuid, NULL, VALUE(x)) sp, sheet
        FROM v2u_ko_x_sheets x
    ),
    v AS
    (
        SELECT sp, CAST(COLLECT(u.sheet.id) AS V2u_Ko_Ids_t) sheet_ids
        FROM u u
        GROUP BY sp
    )
SELECT
      v.sp.job_uuid
    , ROWNUM
    , v.sp.university
    , v.sp.faculty
    , v.sp.studies_modetier
    , v.sp.studies_field
    , v.sp.studies_specialty
    , v.sheet_ids
FROM v v;

-- vim: set ft=sql ts=4 sw=4 et:
