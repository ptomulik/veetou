CREATE OR REPLACE VIEW v2u_semesters_ov
OF V2u_Semester_t
WITH OBJECT IDENTIFIER(code)
AS SELECT t.code
        , t.start_date
        , t.end_date
FROM v2u_semesters t;

-- vim: set ft=sql ts=4 sw=4 et:
