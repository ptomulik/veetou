CREATE TABLE v2u_ko_specialty_map_j
    (
          job_uuid RAW(16)
        , specsem_id NUMBER(38)
        , specmap_id NUMBER(38)
        , matching_score NUMBER(38)
        , CONSTRAINT v2u_ko_specialty_map_j_pk PRIMARY KEY (specmap_id, specsem_id, job_uuid)
        , CONSTRAINT v2u_ko_specialty_map_j_f0 FOREIGN KEY (job_uuid) REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_specialty_map_j_f1 FOREIGN KEY (specmap_id) REFERENCES v2u_specialty_map(id)
        , CONSTRAINT v2u_ko_specialty_map_j_f2 FOREIGN KEY (specsem_id, job_uuid) REFERENCES v2u_ko_specialty_semesters_j(id, job_uuid)
    );


-- vim: set ft=sql ts=4 sw=4 et:
