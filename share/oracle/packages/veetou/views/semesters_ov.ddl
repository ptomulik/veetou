CREATE OR REPLACE VIEW veetou_semesters_ov
    ( id
    , semester
    , CONSTRAINT veetou_semesters_ov_pk PRIMARY KEY (id)
        RELY DISABLE NOVALIDATE
    )
AS SELECT
      t.id id
    , Veetou_Semester_Typ
        ( code => t.code
        , start_date => t.start_date
        , end_date => t.end_date
        ) semester
FROM veetou_semesters t;

-- vim: set ft=sql ts=4 sw=4 et:
