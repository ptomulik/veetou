CREATE TABLE v2u_ko_subject_map_grades_j
    (
          job_uuid RAW(16)
        , subject_id NUMBER(38)
        , specialty_id NUMBER(38)
        , map_id NUMBER(38)
        , subj_grades V2u_Subj_20Grades_t
        , CONSTRAINT v2u_ko_subject_map_grades_j_pk
            PRIMARY KEY (subject_id, specialty_id, map_id, job_uuid)
        , CONSTRAINT v2u_ko_subject_map_grades_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_subject_map_grades_j_f2
            FOREIGN KEY (subject_id, job_uuid)
            REFERENCES v2u_ko_subjects(id, job_uuid)
        , CONSTRAINT v2u_ko_subject_map_grades_j_f3
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_subject_map_grades_j_f4
            FOREIGN KEY (map_id)
            REFERENCES v2u_subject_map(id)
    );


-- vim: set ft=sql ts=4 sw=4 et:
