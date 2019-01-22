CREATE OR REPLACE VIEW v2u_ko_trs_ov
OF V2u_Ko_Tr_t
WITH OBJECT IDENTIFIER(job_uuid, id)
AS SELECT t.job_uuid
        , t.id
        , t.subj_code
        , t.subj_name
        , t.subj_hours_w
        , t.subj_hours_c
        , t.subj_hours_l
        , t.subj_hours_p
        , t.subj_hours_s
        , t.subj_credit_kind
        , t.subj_ects
        , t.subj_tutor
        , t.subj_grade
        , t.subj_grade_date
FROM v2u_ko_trs t;

-- vim: set ft=sql ts=4 sw=4 et:
