CREATE TABLE v2u_ko_subj_inst_trs
    (
          job_uuid RAW(16)
        , subject_instance_id NUMBER(38)
        , tr_id NUMBER(38)
        , CONSTRAINT v2u_ko_subj_instance_trs_pk PRIMARY KEY (tr_id, subject_instance_id, job_uuid)
        , CONSTRAINT v2u_ko_subj_instance_trs_uq1 UNIQUE (tr_id, job_uuid)
        , CONSTRAINT v2u_ko_subj_instance_trs_fk0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_subj_instance_trs_fk1 FOREIGN KEY (tr_id, job_uuid) REFERENCES v2u_ko_trs(id, job_uuid)
        , CONSTRAINT v2u_ko_subj_instance_trs_fk2 FOREIGN KEY (subject_instance_id, job_uuid) REFERENCES v2u_ko_subject_instances(id, job_uuid)
    );

-- vim: set ft=sql ts=4 sw=4 et:
