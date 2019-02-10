CREATE TABLE v2u_ko_specialty_map_j
OF V2u_Ko_Specialty_Map_J_t
    (
          CONSTRAINT v2u_ko_specialty_map_j_pk
            PRIMARY KEY (specialty_id, semester_id, map_id, job_uuid)
        , CONSTRAINT v2u_ko_specialty_map_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_specialty_map_j_f1
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_specialty_map_j_f2
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_specialty_map_j_f3
            FOREIGN KEY (map_id)
            REFERENCES v2u_specialty_map(id)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
;
/
CREATE INDEX v2u_ko_specialty_map_j_idx1
    ON v2u_ko_specialty_map_j(specialty_id, semester_id, job_uuid);
-- vim: set ft=sql ts=4 sw=4 et:
