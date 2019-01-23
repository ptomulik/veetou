CREATE OR REPLACE VIEW v2u_ko_specialties_dv
OF V2u_Ko_Specialty_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS
WITH
    u AS
    (
        SELECT
              V2u_To.Ko_Specialty(job_uuid, NULL, header, preamble) sp
            , sheet
        FROM v2u_ko_x_sheets
    ),
    v AS
    (
        SELECT sp, CAST(COLLECT(sheet) AS V2u_Ko_Sheets_t) sheets
        FROM u
        GROUP BY sp
    ),
    w AS
    (
        SELECT
              sp
            /*, CAST(MULTISET(
                    SELECT id FROM TABLE(v.sheets)
              ) AS V2u_Ko_Ids_t) sheet_ids */
        FROM v
    )
SELECT
      w.sp.job_uuid
    , ROWNUM
    , w.sp.university
    , w.sp.faculty
    , w.sp.studies_modetier
    , w.sp.studies_field
    , w.sp.studies_specialty
    , NULL
    -- , w.sheet_ids
FROM w w;

-- vim: set ft=sql ts=4 sw=4 et:
