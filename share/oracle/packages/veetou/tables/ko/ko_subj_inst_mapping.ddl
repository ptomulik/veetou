CREATE TABLE v2u_ko_subj_inst_mapping
    (
          job_uuid RAW(16)
        , subject_instance_id NUMBER(38)
        , subject_mapping_id NUMBER(38)
        , matching_score NUMBER(38)
        , CONSTRAINT v2u_ko_subj_inst_mapping_pk PRIMARY KEY (subject_mapping_id, subject_instance_id, job_uuid)
        , CONSTRAINT v2u_ko_subj_inst_mapping_fk0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_subj_inst_mapping_fk1 FOREIGN KEY (subject_mapping_id) REFERENCES v2u_subject_mappings(id)
        , CONSTRAINT v2u_ko_subj_inst_mapping_fk2 FOREIGN KEY (subject_instance_id, job_uuid) REFERENCES v2u_ko_subject_instances(id, job_uuid)
    );


-- vim: set ft=sql ts=4 sw=4 et:
