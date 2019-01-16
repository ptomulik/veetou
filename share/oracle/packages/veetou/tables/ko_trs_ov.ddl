CREATE OR REPLACE VIEW veetou_ko_trs_ov
    ( job_uuid
    , id
    , tr
    , CONSTRAINT veetou_ko_trs_ov_pk PRIMARY KEY (job_uuid, id)
        RELY DISABLE NOVALIDATE
    , CONSTRAINT veetou_ko_trs_ov_fk0 FOREIGN KEY (job_uuid)
        REFERENCES veetou_ko_jobs_ov(job_uuid)
        RELY DISABLE NOVALIDATE
    )
AS SELECT
      t.job_uuid job_uuid
    , t.id id
    , Veetou_Ko_Tr_Typ
        ( subj_code => t.subj_code
        , subj_name => t.subj_name
        , subj_hours_w => t.subj_hours_w
        , subj_hours_c => t.subj_hours_c
        , subj_hours_l => t.subj_hours_l
        , subj_hours_p => t.subj_hours_p
        , subj_hours_s => t.subj_hours_s
        , subj_credit_kind => t.subj_credit_kind
        , subj_ects => t.subj_ects
        , subj_tutor => t.subj_tutor
        , subj_grade => t.subj_grade
        , subj_grade_date => t.subj_grade_date
        ) tr
FROM veetou_ko_trs t;

-- vim: set ft=sql ts=4 sw=4 et:
