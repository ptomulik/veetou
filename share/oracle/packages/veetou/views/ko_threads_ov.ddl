CREATE OR REPLACE VIEW v2u_ko_threads_ov
AS SELECT
      s.job_uuid job_uuid
    , s.sheet_id sheet_id
    , t.student student
    , t.specialty specialty
    , t.thread_index
    , t.threads_count
    , t.max_admission_semester max_admission_semester
    , t.thread_semesters thread_semesters
FROM v2u_ko_x_sheets_ov s
LEFT JOIN v2u_ko_student_threads_ov t
ON  (
        s.job_uuid = t.job_uuid AND
        s.preamble.student_index = t.student.student_index
    )
WHERE
    (
        V2u_Ko_Specialty_t(s.header, s.preamble) = t.specialty AND
        s.sheet_id IN (SELECT sheet_id FROM TABLE(t.thread_semesters))
    );

-- vim: set ft=sql ts=4 sw=4 et:
