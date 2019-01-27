MERGE INTO v2u_ko_specialty_issues tgt
USING
    (
        WITH v AS
        (
            SELECT
                  V2u_To.Ko_Specialty_Issue(
                          job_uuid => u.job_uuid
                        , sheet => DEREF(u.sheet)
                        , header => DEREF(u.header)
                        , preamble => DEREF(u.preamble)
                  ) specialty
                , u.sheet.id sheet_id
            FROM v2u_ko_sh_hdr_preamb_h u
        )
        SELECT
              v.specialty.dup_with(
                  new_id_seq => 'v2u_ko_specialty_issues_sq1'
                , new_sheet_ids => CAST(COLLECT(v.sheet_id) AS V2u_Ko_Ids_t)
              ) specialty
        FROM v v
        GROUP BY v.specialty
    ) src
ON
    (       -- the ORDER member method was useless here... sorry
            DECODE(src.specialty.semester_number, tgt.semester_number, 1, 0) = 1
        AND DECODE(src.specialty.semester_code, tgt.semester_code, 1, 0) = 1
        AND DECODE(src.specialty.ects_mandatory, tgt.ects_mandatory, 1, 0) = 1
        AND DECODE(src.specialty.ects_other, tgt.ects_other, 1, 0) = 1
        AND DECODE(src.specialty.ects_total, tgt.ects_total, 1, 0) = 1
        AND DECODE(src.specialty.studies_specialty, tgt.studies_specialty, 1, 0) = 1
        AND DECODE(src.specialty.studies_field, tgt.studies_field, 1, 0) = 1
        AND DECODE(src.specialty.studies_modetier, tgt.studies_modetier, 1, 0) = 1
        AND DECODE(src.specialty.faculty, tgt.faculty, 1, 0) = 1
        AND DECODE(src.specialty.university, tgt.university, 1, 0) = 1
        AND DECODE(src.specialty.job_uuid, tgt.job_uuid, 1, 0) = 1
    )
WHEN NOT MATCHED THEN INSERT VALUES(src.specialty)
WHEN MATCHED THEN UPDATE SET tgt.sheet_ids = src.specialty.sheet_ids;

-- vim: set ft=sql ts=4 sw=4 et:
