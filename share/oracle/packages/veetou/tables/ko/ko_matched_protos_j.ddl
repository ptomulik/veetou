CREATE TABLE v2u_ko_matched_protos_j
OF V2u_Ko_Matched_Proto_J_t
    (
        -- PK
          CONSTRAINT v2u_ko_matched_protos_j_pk
            PRIMARY KEY (prot_id, subject_id, specialty_id, semester_id, job_uuid)
        -- FK
        , CONSTRAINT v2u_ko_matched_protos_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_matched_protos_j_f1
            FOREIGN KEY (subject_id, job_uuid)
            REFERENCES v2u_ko_subjects(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_protos_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_protos_j_f3
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_protos_j_f4
            FOREIGN KEY (subject_map_id)
            REFERENCES v2u_subject_map(id)
        , CONSTRAINT v2u_ko_matched_protos_j_f5
            FOREIGN KEY (subject_id, specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_subject_semesters_j(subject_id, specialty_id, semester_id, job_uuid)
        , CONSTRAINT v2u_ko_matched_protos_j_f6
            FOREIGN KEY (subject_id, specialty_id, semester_id, subject_map_id, job_uuid)
            REFERENCES v2u_ko_subject_map_j(subject_id, specialty_id, semester_id, map_id, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
;
/
CREATE INDEX v2u_ko_matched_protos_j_idx1
    ON v2u_ko_matched_protos_j(subject_id, specialty_id, semester_id, job_uuid);
/
CREATE INDEX v2u_ko_matched_protos_j_idx2
    ON v2u_ko_matched_protos_j(classes_type, subject_id, specialty_id, semester_id, job_uuid);

-- vim: set ft=sql ts=4 sw=4 et:
