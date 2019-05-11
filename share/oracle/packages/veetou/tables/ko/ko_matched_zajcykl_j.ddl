CREATE TABLE v2u_ko_matched_zajcykl_j
OF V2u_Ko_Matched_Zajcykl_J_t
    (
        -- PK
          CONSTRAINT v2u_ko_matched_zajcykl_j_pk
            PRIMARY KEY (classes_type, subject_id, specialty_id, semester_id, job_uuid)
        -- FK
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f0
            FOREIGN KEY (job_uuid)
            REFERENCES v2u_ko_jobs(job_uuid)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f1
            FOREIGN KEY (subject_id, job_uuid)
            REFERENCES v2u_ko_subjects(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f2
            FOREIGN KEY (specialty_id, job_uuid)
            REFERENCES v2u_ko_specialties(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f3
            FOREIGN KEY (semester_id, job_uuid)
            REFERENCES v2u_ko_semesters(id, job_uuid)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f4
            FOREIGN KEY (subject_map_id)
            REFERENCES v2u_subject_map(id)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f5
            FOREIGN KEY (subject_id, specialty_id, semester_id, job_uuid)
            REFERENCES v2u_ko_subject_semesters_j(subject_id, specialty_id, semester_id, job_uuid)
        , CONSTRAINT v2u_ko_matched_zajcykl_j_f6
            FOREIGN KEY (subject_id, specialty_id, semester_id, subject_map_id, job_uuid)
            REFERENCES v2u_ko_subject_map_j(subject_id, specialty_id, semester_id, map_id, job_uuid)
    )
OBJECT IDENTIFIER IS PRIMARY KEY
;
/
CREATE INDEX v2u_ko_matched_zajcykl_j_idx1
    ON v2u_ko_matched_zajcykl_j(subject_id, specialty_id, semester_id, job_uuid);
/
-- vim: set ft=sql ts=4 sw=4 et:
