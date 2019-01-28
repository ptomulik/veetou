CREATE TABLE v2u_ko_subject_trs_j
    (
          job_uuid RAW(16)
        , subject_entity_id NUMBER(38)
        , tr_id NUMBER(38)
        , CONSTRAINT v2u_ko_subj_entity_trs_pk PRIMARY KEY (tr_id, subject_entity_id, job_uuid)
        , CONSTRAINT v2u_ko_subj_entity_trs_u1 UNIQUE (tr_id, job_uuid)
        , CONSTRAINT v2u_ko_subj_entity_trs_f0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_subj_entity_trs_f1 FOREIGN KEY (tr_id, job_uuid) REFERENCES v2u_ko_trs(id, job_uuid)
        , CONSTRAINT v2u_ko_subj_entity_trs_f2 FOREIGN KEY (subject_entity_id, job_uuid) REFERENCES v2u_ko_subject_entities(id, job_uuid)
    );

-- vim: set ft=sql ts=4 sw=4 et:
