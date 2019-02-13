MERGE INTO v2u_ko_subject_semesters_j tgt
USING
    (
        SELECT
              subject_trs.job_uuid job_uuid
            , subject_trs.subject_id subject_id
            , specialty_sheets.specialty_id specialty_id
            , semester_sheets.semester_id semester_id
        FROM v2u_ko_subject_trs_j subject_trs
        INNER JOIN v2u_ko_tbody_trs_j tbody_trs
            ON (tbody_trs.ko_tr_id = subject_trs.tr_id AND
                tbody_trs.job_uuid = subject_trs.job_uuid)
        INNER JOIN v2u_ko_page_tbody_j page_tbody
            ON (page_tbody.ko_tbody_id = tbody_trs.ko_tbody_id AND
                page_tbody.job_uuid = subject_trs.job_uuid)
        INNER JOIN v2u_ko_sheet_pages_j sheet_pages
            ON (sheet_pages.ko_page_id = page_tbody.ko_page_id AND
                sheet_pages.job_uuid = subject_trs.job_uuid)
        INNER JOIN v2u_ko_specialty_sheets_j specialty_sheets
            ON (specialty_sheets.sheet_id = sheet_pages.ko_sheet_id AND
                specialty_sheets.job_uuid = subject_trs.job_uuid)
        INNER JOIN v2u_ko_semester_sheets_j semester_sheets
            ON (semester_sheets.sheet_id = sheet_pages.ko_sheet_id AND
                semester_sheets.job_uuid = subject_trs.job_uuid)
        GROUP BY
              subject_trs.job_uuid
            , subject_trs.subject_id
            , specialty_sheets.specialty_id
            , semester_sheets.semester_id
    ) src
ON (tgt.subject_id = src.subject_id AND
    tgt.specialty_id = src.specialty_id AND
    tgt.semester_id = src.semester_id AND
    tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT (    job_uuid,     subject_id,     specialty_id,     semester_id)
    VALUES (src.job_uuid, src.subject_id, src.specialty_id, src.semester_id);

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
