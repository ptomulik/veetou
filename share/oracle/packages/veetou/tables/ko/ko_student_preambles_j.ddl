CREATE TABLE v2u_ko_student_preambles_j
    (
          job_uuid RAW(16)
        , student_id NUMBER(38)
        , preamble_id NUMBER(38)
        , CONSTRAINT v2u_ko_student_preambles_j_pk PRIMARY KEY (preamble_id, student_id, job_uuid)
        , CONSTRAINT v2u_ko_student_preambles_j_u1 UNIQUE (preamble_id, job_uuid)
        , CONSTRAINT v2u_ko_student_preambles_j_f0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_student_preambles_j_f1 FOREIGN KEY (preamble_id, job_uuid) REFERENCES v2u_ko_preambles(id, job_uuid)
        , CONSTRAINT v2u_ko_student_preambles_j_f2 FOREIGN KEY (student_id, job_uuid) REFERENCES v2u_ko_students(id, job_uuid)
    );

-- vim: set ft=sql ts=4 sw=4 et:
