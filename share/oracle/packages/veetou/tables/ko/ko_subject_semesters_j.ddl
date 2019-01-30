CREATE TABLE v2u_ko_subject_semesters_j
    (
          job_uuid RAW(16)
        , subject_id NUMBER(38)
        , specialty_id NUMBER(38)
        , semester_id NUMBER(38)
        , CONSTRAINT v2u_ko_subject_semesters_j_pk PRIMARY KEY (subject_id, specialty_id, semester_id, job_uuid)
        , CONSTRAINT v2u_ko_subject_semesters_j_f0 FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_subject_semesters_j_f1 FOREIGN KEY (subject_id, job_uuid)
            REFERENCES v2u_ko_subjects(id, job_uuid)
        , CONSTRAINT v2u_ko_subject_semesters_j_f2 FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_subject_semesters_j_f3 FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_subject_semesters_j_f4 FOREIGN KEY (specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_specialty_semesters_j(specialty_id, semester_id, job_uuid)
    );

-- vim: set ft=sql ts=4 sw=4 et:
