CREATE TABLE v2u_ko_specialty_semesters_j
OF V2u_Ko_Specialty_Semester_J_t
    (
          CONSTRAINT v2u_ko_spec_semesters_j_pk
            PRIMARY KEY (job_uuid, semester_id, specialty_id)
        , CONSTRAINT v2u_ko_spec_semesters_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_spec_semesters_j_f1
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_spec_semesters_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;

-- vim: set ft=sql ts=4 sw=4 et:
