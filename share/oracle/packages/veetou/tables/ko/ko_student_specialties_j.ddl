CREATE TABLE v2u_ko_student_specialties_j
    (
          job_uuid RAW(16)
        , student_id NUMBER(38)
        , specialty_id NUMBER(38)
        , CONSTRAINT v2u_ko_student_specs_j_pk PRIMARY KEY (specialty_id, student_id, job_uuid)
        , CONSTRAINT v2u_ko_student_specs_j_f0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_student_specs_j_f1 FOREIGN KEY (specialty_id, job_uuid) REFERENCES v2u_ko_specialty_entities(id, job_uuid)
        , CONSTRAINT v2u_ko_student_specs_j_f2 FOREIGN KEY (student_id, job_uuid) REFERENCES v2u_ko_students(id, job_uuid)
    );

-- vim: set ft=sql ts=4 sw=4 et:
