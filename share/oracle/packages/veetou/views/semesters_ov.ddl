CREATE OR REPLACE VIEW v2u_semesters_ov
    ( id
    , semester
    , CONSTRAINT v2u_semesters_ov_pk PRIMARY KEY (id)
        RELY DISABLE NOVALIDATE
    )
AS SELECT
      t.id id
    , V2u_Semester_t
        ( code => t.code
        , start_date => t.start_date
        , end_date => t.end_date
        ) semester
FROM v2u_semesters t;

-- vim: set ft=sql ts=4 sw=4 et:
