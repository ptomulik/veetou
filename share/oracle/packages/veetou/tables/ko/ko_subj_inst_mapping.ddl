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

MERGE INTO v2u_ko_subj_inst_mapping tgt
USING
    (
        WITH u AS
        (
            SELECT
                  VALUE(si).job_uuid job_uuid
                , si.id subject_instance_id
                , sm.id subject_mapping_id
                , V2U_Match.Attributes(VALUE(sm), VALUE(si)) matching_score
            FROM v2u_ko_subject_instances si
            LEFT JOIN v2u_subject_mappings sm
            ON sm.subj_code = si.subj_code
        )
        SELECT * FROM u
        WHERE u.matching_score > 0
        ORDER BY subject_instance_id
    ) src
ON (tgt.subject_mapping_id = src.subject_mapping_id AND
    tgt.subject_instance_id = src.subject_instance_id AND
    tgt.job_uuid = src.job_uuid)
WHEN NOT MATCHED THEN
    INSERT (job_uuid, subject_instance_id, subject_mapping_id, matching_score)
    VALUES (src.job_uuid, src.subject_instance_id, src.subject_mapping_id, src.matching_score);


-- vim: set ft=sql ts=4 sw=4 et:
