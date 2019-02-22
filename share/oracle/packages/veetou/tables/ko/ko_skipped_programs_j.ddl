CREATE TABLE v2u_ko_skipped_programs_j
OF V2u_Ko_Skipped_Program_J_t
    (
          CONSTRAINT v2u_ko_skipped_programs_j_pk
            PRIMARY KEY (job_uuid, semester_id, specialty_id, prg_kod)
        , CONSTRAINT v2u_ko_skipped_programs_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_skipped_programs_j_f1
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_skipped_programs_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY;
/
CREATE INDEX v2u_ko_skipped_programs_j_idx1
    ON v2u_ko_skipped_programs_j(job_uuid, semester_id, specialty_id);

-- vim: set ft=sql ts=4 sw=4 et:
