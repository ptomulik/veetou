MERGE INTO v2u_ko_semesters tgt
USING
    (
        WITH u AS
        (
            SELECT
                  V2u_To.Ko_Semester(
                          job_uuid => h.job_uuid
                        , sheet => h.sheet
                        , preamble => h.preamble
                  ) semester
                , h.sheet.id sheet_id
            FROM v2u_ko_sh_hdr_preamb_h h
        )
        SELECT
            u.semester.dup(CAST(COLLECT(u.sheet_id) AS V2u_Ids_t)) semester
        FROM u u
        GROUP BY u.semester
    ) src
ON
    (
        -- we should use DECODE(...) for this, but it didn't seem to work here in the ON clause
            ((src.semester.semester_code = tgt.semester_code) OR (src.semester.semester_code IS NULL AND tgt.semester_code IS NULL))
        AND ((src.semester.semester_number = tgt.semester_number) OR (src.semester.semester_number IS NULL AND tgt.semester_number IS NULL))
        AND ((src.semester.ects_mandatory = tgt.ects_mandatory) OR (src.semester.ects_mandatory IS NULL AND tgt.ects_mandatory IS NULL))
        AND ((src.semester.ects_other = tgt.ects_other) OR (src.semester.ects_other IS NULL AND tgt.ects_other IS NULL))
        AND ((src.semester.ects_total = tgt.ects_total) OR (src.semester.ects_total IS NULL AND tgt.ects_total IS NULL))
        AND ((src.semester.job_uuid = tgt.job_uuid) OR (src.semester.job_uuid IS NULL AND tgt.job_uuid IS NULL))
    )
WHEN NOT MATCHED THEN INSERT VALUES(src.semester)
WHEN MATCHED THEN UPDATE SET tgt.sheet_ids = src.semester.sheet_ids;

-- vim: set ft=sql ts=4 sw=4 et:
