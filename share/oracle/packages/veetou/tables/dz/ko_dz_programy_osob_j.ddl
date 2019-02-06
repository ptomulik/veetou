CREATE TABLE v2u_ko_dz_programy_osob_j
    (
          v2u_job_uuid RAW(16)
        , v2u_thread_id NUMBER(38)
        , dz_programy_osob_id NUMBER(10)
        , CONSTRAINT v2u_dz_programy_osob_j_pk
            PRIMARY KEY (v2u_thread_id, v2u_job_uuid, dz_programy_osob_id)
        , CONSTRAINT v2u_dz_programy_osob_j_f0
            FOREIGN KEY (v2u_job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_dz_programy_osob_j_f1
            FOREIGN KEY (v2u_thread_id, v2u_job_uuid)
            REFERENCES v2u_ko_student_threads_j(id, job_uuid)
        , CONSTRAINT v2u_dz_programy_osob_j_f2
            FOREIGN KEY (dz_programy_osob_id)
            REFERENCES v2u_dz_programy_osob(id)
    );

-- vim: set ft=sql ts=4 sw=4 et:
