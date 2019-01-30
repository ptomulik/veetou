CREATE TABLE v2u_ko_specialty_semesters_j
    (
          job_uuid RAW(16)
        , specialty_id NUMBER(38)
        , semester_id NUMBER(38)
        , CONSTRAINT v2u_ko_spec_semesters_j_pk
            PRIMARY KEY (specialty_id, semester_id, job_uuid)
        /*, CONSTRAINT v2u_ko_spec_semesters_j_u1
            UNIQUE (semester_id, job_uuid)*/
        , CONSTRAINT v2u_ko_spec_semesters_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_spec_semesters_j_f1
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_spec_semesters_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
    );

-- vim: set ft=sql ts=4 sw=4 et:
