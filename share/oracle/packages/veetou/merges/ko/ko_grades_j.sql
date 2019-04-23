MERGE INTO v2u_ko_grades_j tgt
USING
    (
        WITH u AS
        (
            SELECT
                  trs.*
                , REPLACE(
                      REGEXP_REPLACE(UPPER(trs.subj_grade), '([2-5]),0', '\1')
                    , 'ZW'
                    , 'ZWL'
                  ) ocena_opis
                , CASE
                    WHEN REGEXP_INSTR(trs.subj_grade, '[2-5]([,.](0|5))?$') = 1
                    THEN 'STD'
                    WHEN UPPER(trs.subj_grade) IN ('NZAL', 'ZAL', 'ZW')
                    THEN 'ZAL'
                    ELSE '?'
                  END toc_kod
            FROM v2u_ko_trs trs
        )
        SELECT
              u.job_uuid job_uuid
            , student_sheets.student_id student_id
            , subject_trs.subject_id subject_id
            , specialty_sheets.specialty_id specialty_id
            , semester_sheets.semester_id semester_id
            , u.subj_grade subj_grade
            , u.subj_grade_date subj_grade_date
            , u.id tr_id
            , u.ocena_opis
            , u.toc_kod

        FROM u u
        INNER JOIN v2u_ko_subject_trs_j subject_trs
            ON  (
                        subject_trs.tr_id = u.id
                    AND subject_trs.job_uuid = u.job_uuid
                )
        INNER JOIN v2u_ko_tbody_trs_j tbody_trs
            ON  (
                        tbody_trs.ko_tr_id = u.id
                    AND tbody_trs.job_uuid = u.job_uuid
                )
        INNER JOIN v2u_ko_page_tbody_j page_tbody
            ON  (
                        page_tbody.ko_tbody_id = tbody_trs.ko_tbody_id
                    AND page_tbody.job_uuid = u.job_uuid
                )
        INNER JOIN v2u_ko_sheet_pages_j sheet_pages
            ON  (
                        sheet_pages.ko_page_id = page_tbody.ko_page_id
                    AND sheet_pages.job_uuid = u.job_uuid
                )
        INNER JOIN v2u_ko_student_sheets_j student_sheets
            ON  (
                        student_sheets.sheet_id = sheet_pages.ko_sheet_id
                    AND student_sheets.job_uuid = u.job_uuid
                )
        INNER JOIN v2u_ko_specialty_sheets_j specialty_sheets
            ON  (       specialty_sheets.sheet_id = sheet_pages.ko_sheet_id
                    AND specialty_sheets.job_uuid = u.job_uuid
                )
        INNER JOIN v2u_ko_semester_sheets_j semester_sheets
            ON  (
                        semester_sheets.sheet_id = sheet_pages.ko_sheet_id
                    AND semester_sheets.job_uuid = u.job_uuid
                )
        GROUP BY
              u.job_uuid
            , student_sheets.student_id
            , subject_trs.subject_id
            , specialty_sheets.specialty_id
            , semester_sheets.semester_id
            , u.subj_grade
            , u.subj_grade_date
            , u.id
            , u.ocena_opis
            , u.toc_kod
    ) src
ON  (
            tgt.student_id = src.student_id
        AND tgt.subject_id = src.subject_id
        AND tgt.specialty_id = src.specialty_id
        AND tgt.semester_id = src.semester_id
        AND tgt.job_uuid = src.job_uuid
    )
WHEN NOT MATCHED THEN
    INSERT
        ( job_uuid
        , student_id
        , subject_id
        , specialty_id
        , semester_id
        , subj_grade
        , subj_grade_date
        , tr_id
        , ocena_opis
        , toc_kod
        )
    VALUES
        ( src.job_uuid
        , src.student_id
        , src.subject_id
        , src.specialty_id
        , src.semester_id
        , src.subj_grade
        , src.subj_grade_date
        , src.tr_id
        , src.ocena_opis
        , src.toc_kod
        )
WHEN MATCHED THEN
    UPDATE SET
          tgt.subj_grade = src.subj_grade
        , tgt.subj_grade_date = src.subj_grade_date
        , tgt.tr_id = src.tr_id
        , tgt.ocena_opis = src.ocena_opis
        , tgt.toc_kod = src.toc_kod
;

COMMIT;

-- vim: set ft=sql ts=4 sw=4 et:
